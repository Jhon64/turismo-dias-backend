import { DataSource, DataSourceOptions } from 'typeorm'
import indexSchemes from '../schemes/index'
import { ENVIRONMENT } from '../Environment'

export const configuracionDBTypeORM: () => DataSourceOptions = () => {
  return {
    type: ENVIRONMENT.database?.typeorm.type || 'postgres',
    host: ENVIRONMENT.database?.typeorm.host || 'localhost',
    port: 5432,
    username: ENVIRONMENT.database?.typeorm.username || 'postgres',
    password: ENVIRONMENT.database?.typeorm.password || 'sa',
    database: ENVIRONMENT.database?.typeorm.database || 'turismodiazdb',
    logging: ENVIRONMENT.database?.typeorm.logging || false,
    synchronize: ENVIRONMENT.database?.typeorm.synchronize || false,
    entities: indexSchemes,
  }
}

export class TypeORMSource {
  private readonly dataSource: DataSource
  private static instance: TypeORMSource

  private constructor() {
    this.dataSource = new DataSource((configuracionDBTypeORM()))
  }

  async inicializarConexion() {
    console.log('inicianando conexion por TYPEORM ::')
    if (!this.dataSource.isInitialized) {
      const resultConnect = await this.dataSource.initialize()
      if (resultConnect.isInitialized) return this.dataSource
      else {
        console.log('error al conectar la bd typeorm')
        throw 'error al conectar la bd typeorm'
      }
    } else {
      console.log('ya existe una conexion DB:: TYPEORM')
      return this.dataSource
    }
  }

  public static get getInstance(): TypeORMSource {
    if (!TypeORMSource.instance) {
      TypeORMSource.instance = new TypeORMSource()
    }
    return TypeORMSource.instance
  }

  get dbConnection() {
    try {
      console.log(
        'llamando a la conexion Status->',
        this.dataSource.isInitialized
      )
      if (this.dataSource.isInitialized) {
        console.log(
          'ya existe una conexion DB::',
          this.dataSource.isInitialized
        )
        return this.dataSource
      } else {
        return this.inicializarConexion()
      }
    } catch (e) {
      throw e
    }
  }
}
