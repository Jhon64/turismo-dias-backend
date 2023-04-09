import { VehiculoDTO } from '../dto/request/vehiculo.dto'
import { IResponseRepository } from '../helpers/repository.helpers'
import { Combustible } from '../schemes/combustible'
import { Marcas } from '../schemes/marca'
import { BaseRepository } from './base.repository'
export class VehiculoRepository extends BaseRepository {
  constructor() {
    super()
  }
  async listarTodo(id?: number): Promise<IResponseRepository> {
    let response = {} as IResponseRepository
    try {
      const args = { id }
      console.log('args a enviar ', args)
      const _result = await this.execProcedure('get_vehiculos', [args])
      const resultString = JSON.stringify(_result.result)
      const result = JSON.parse(resultString)
      response.data = result
      response.status = 'OK'
    } catch (error) {
      console.log(error)
      response.error = error
      response.status = 'ERROR'
    }
    return response
  }

  async register(_add: VehiculoDTO): Promise<IResponseRepository> {
    let response = {} as IResponseRepository
    try {
      const params = JSON.stringify(_add)
      console.log('req a enviar ::', params)
      const _result = await this.execProcedure('post_add_vehiculo', [params])

      const resultString = JSON.stringify(_result.result)
      const result = JSON.parse(resultString)
      if (result.length) {
        response.data = result[0]
        response.status = 'OK'
      } else {
        response.status = 'ERROR'
        response.error = 'Error al registrar Vehiculo'
      }
    } catch (error) {
      console.log(error)
      response.error = error
      response.status = 'ERROR'
    }
    return response
  }

  async addDocumentos(_add: any): Promise<IResponseRepository> {
    let response = {} as IResponseRepository
    try {
      const params = JSON.stringify(_add)
      console.log('req a enviar ::', params)
      const _result = await this.execProcedure('post_add_documentos', [params])

      const resultString = JSON.stringify(_result.result)
      const result = JSON.parse(resultString)
      if (result.length) {
        response.data = result[0]
        response.status = 'OK'
      } else {
        response.status = 'ERROR'
        response.error = 'Error al registrar Vehiculo'
      }
    } catch (error) {
      console.log(error)
      response.error = error
      response.status = 'ERROR'
    }
    return response
  }
}
