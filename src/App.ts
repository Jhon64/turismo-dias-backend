import express, { Express } from 'express'
import cors from 'cors'
import process from 'process'
import bodyParsed from 'body-parser'
import console from 'console'
import morgan from 'morgan'
import _router from './routers/index.router'
import { TypeORMSource } from './database/typeorm'
import { ENVIRONMENT } from './Environment'
import "reflect-metadata"
export class App {
  private _app: Express
  constructor(private port?: number) {
    this._app = express()
    this.middlewares()
    this.settings()
    this.database()
    this.routers()
  }
  middlewares() {
    this._app.use(cors())
    this._app.use(bodyParsed.urlencoded({ extended: true }))
    this._app.use(bodyParsed.json())
    this._app.use(morgan('dev'))
  }
  settings() {
    this._app.set('port', process.env.PORT || this.port || 5000)
  }
  async database() {
    //*generar esquemas de tablas en la base de datos
    const conn = await TypeORMSource.getInstance.dbConnection
     if (conn) {
       console.log('Generando esquemas::',conn.isInitialized )

    }
  }

  routers() {
    for (let routers of _router) {
      this._app.use(routers)
    }
  }
  listen() {
    this._app.listen(this._app.get('port'), () => {
      console.log(
        'server  on line ::: http://localhost:' + this._app.get('port') + ' '
      )
    })
  }
}
