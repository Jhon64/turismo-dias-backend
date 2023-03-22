import { Persona } from './../schemes/persona';
import { IResponseController } from './../helpers/controllers.helpers'
import { makeController } from '../helpers/controllers.helpers'
import { PersonaRepository } from '../repositories/persona.repository'
export class PersonaController {
  _repository = new PersonaRepository()
  constructor() {}
  async addPersona(add:Partial<Persona>) {
    let data = {} as IResponseController
    try {
      const result = await this._repository.addPersona(add)
      if (result.status == 'OK') {
        data = makeController(200, result.data, 'persona Registrado')
      } else {
        data = makeController(500, null, result.error || 'Error al registrar')
      }
    } catch (error) {
      data = makeController(500, null, error, true)
    }
    return data
  }
}
