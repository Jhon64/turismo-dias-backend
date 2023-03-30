import { ModeloDTO } from '../dto/request/modelo.dto'
import { IResponseRepository } from '../helpers/repository.helpers'
import { Modelos } from '../schemes/modelo'
import { BaseRepository } from './base.repository'

export class ModeloRepository extends BaseRepository {
  constructor() {
    super()
  }
  async listarTodo(): Promise<IResponseRepository> {
    let response = {} as IResponseRepository
    try {
      const _result = await this.execProcedure('get_modelos', [[]])
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

  async register(_add: ModeloDTO): Promise<IResponseRepository> {
    let response = {} as IResponseRepository
    try {
      const params = JSON.stringify(_add)
      const _result = await this.execProcedure('post_add_modelos', [params])
      const resultString = JSON.stringify(_result.result)
      const result = JSON.parse(resultString)
      if (result.length) {
        response.data = result[0]
        response.status = 'OK'
      } else {
        response.status = 'ERROR'
        response.error = 'Error al registrar modelos'
      }
    } catch (error) {
      console.log(error)
      response.error = error
      response.status = 'ERROR'
    }
    return response
  }
}
