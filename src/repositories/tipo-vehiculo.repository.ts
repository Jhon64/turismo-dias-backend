import { TipoVehiculo } from './../schemes/tipo-vehiculo'

import { IResponseRepository } from '../helpers/repository.helpers'
import { Marcas } from '../schemes/marca'
import { BaseRepository } from './base.repository'

export class TipoVehiculoRepository extends BaseRepository {
  constructor() {
    super()
  }
  async listarTodo(): Promise<IResponseRepository> {
    let response = {} as IResponseRepository
    try {
      const _result = await this.execProcedure('get_tipo_vehiculos', [[]])
      console.log('result query', _result.result)
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

  async register(_add: Partial<TipoVehiculo>): Promise<IResponseRepository> {
    let response = {} as IResponseRepository
    try {
      const params = JSON.stringify(_add)
      const _result = await this.execProcedure('post_add_tipo_vehiculos', [
        params,
      ])
      console.log('result query', _result)
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
}
