import { IResponseRepository } from '../helpers/repository.helpers'
import { Marcas } from '../schemes/marca'
import { BaseRepository } from './base.repository'

export class MarcaRepository extends BaseRepository {
  constructor() {
    super()
  }
  async listarTodo(): Promise<IResponseRepository> {
    let response = {} as IResponseRepository
    try {
      const _result = await this.execProcedure('get_marcas', [[]])
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

  async register(_add: Partial<Marcas>): Promise<IResponseRepository> {
    let response = {} as IResponseRepository
    try {
      const params = JSON.stringify(_add)
      const _result = await this.execProcedure('post_add_marcas', [params])
      const resultString = JSON.stringify(_result.result)
      const result = JSON.parse(resultString)
      if (result.length) {
        response.data = result[0]
        response.status = 'OK'
      } else {
        response.status = 'ERROR'
        response.error = 'Error al registrar marca'
      }
    } catch (error) {
      console.log(error)
      response.error = error
      response.status = 'ERROR'
    }
    return response
  }
}
