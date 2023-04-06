import { IResponseRepository } from '../helpers/repository.helpers'
import { Persona } from '../schemes/persona'
import { BaseRepository } from './base.repository'

export class PersonaRepository extends BaseRepository {
  constructor() {
    super()
  }
  async addPersona(persona: Partial<Persona>): Promise<IResponseRepository> {
    let response = {} as IResponseRepository
    try {
      const params = JSON.stringify(persona)
      const _result = await this.execProcedure('post_add_persona', [params])
      const resultString = JSON.stringify(_result.result)
      const result = JSON.parse(resultString)
      if (result.length) {
        response.data = result[0]
        response.status = 'OK'
      } else {
        response.status = 'ERROR'
        response.error = 'Error al registrar persona'
      }
    } catch (error) {
      console.log(error)
      response.error = error
      response.status = 'ERROR'
    }
    return response
  }
}
