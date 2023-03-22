import { Client } from 'pg'
import {ENVIRONMENT} from '../Environment'

const Variables = {
    host: ENVIRONMENT.database?.typeorm?.host || 'localhost',
    user: ENVIRONMENT.database?.typeorm?.user || 'postgres',
    port: 5432,
    password: ENVIRONMENT.database?.typeorm?.password || 'sa',
    database: ENVIRONMENT.database?.typeorm.database || 'turismodiazdb',
    max: ENVIRONMENT.database?.typeorm?.max || 20,
    idleTimeoutMillis: ENVIRONMENT.database?.typeorm?.idleTimeoutMillis || 30000,
    connectionTimeoutMillis:
      ENVIRONMENT.database?.typeorm?.connectionTimeoutMillis || 2000,
}

export class PG {
   private readonly datasource: Client
   private static _pg: PG

   constructor() {
       this.datasource = new Client(Variables)
   }

   private connectionDB(): Promise<Client> {
       return new Promise((resolve, reject) => {
           let fulfilled = 0
           const timeout = setTimeout(() => {
               console.log('La BD superó los 10 segundos')
               if (!fulfilled) {
                   const err = 'El espera de conexión a BD superó los 10 segudos.'
                   console.error(err)
                   reject(err)
               }
               return null
           }, 10000)
           this.datasource
             .connect()
             .then(() => {
                 clearTimeout(timeout)
                 resolve(this.datasource)
             })
             .catch((error) => {
                 console.log('Hubo un error en la conexión...')
                 console.error(error)
                 clearTimeout(timeout)
                 reject(error)
             })
       })
   }
   get getConnection(): Promise<Client> {
       return this.connectionDB()
   }
}