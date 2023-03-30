import { GrupoRepository } from './../repositories/grupo.repository';
import { CombustibleRepository } from './../repositories/combustible.repository';
import { IResponseController } from './../helpers/controllers.helpers'
import { makeController } from '../helpers/controllers.helpers'
import { Combustible } from '../schemes/combustible';
import { Grupo } from '../schemes/grupo';

export class GrupoController {
  _repository = new GrupoRepository()
  constructor() {}
  async listar() {
    let data = {} as IResponseController
    try {
      const result = await this._repository.listarTodo()
      if (result.status == 'OK') {
        data = makeController(200, result.data, 'listando informacion')
      } else {
        data = makeController(500, null, result.error || 'Error al listar')
      }
    } catch (error) {
      data = makeController(500, null, error, true)
    }
    return data
  }

  async register(add:Partial<Grupo>) {
   let data = {} as IResponseController
   try {
     const result = await this._repository.register(add)
     if (result.status == 'OK') {
       data = makeController(200, result.data, 'Grupo Registrado')
     } else {
       data = makeController(500, null, result.error || 'Error al registrar')
     }
   } catch (error) {
     data = makeController(500, null, error, true)
   }
   return data
 }  
}
