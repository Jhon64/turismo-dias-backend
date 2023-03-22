import { Modelos } from './../schemes/modelo';
import { ModeloRepository } from './../repositories/modelo.repository';
import { IResponseController } from './../helpers/controllers.helpers'
import { makeController } from '../helpers/controllers.helpers'
import { ModeloDTO } from '../dto/request/modelo.dto';


export class ModeloController {
  _repository = new ModeloRepository()
   constructor() { }
   async register(add:ModeloDTO) {
      let data = {} as IResponseController
      try {
        const result = await this._repository.register(add)
        if (result.status == 'OK') {
          data = makeController(200, result.data, 'modelos Registrada')
        } else {
          data = makeController(500, null, result.error || 'Error al registrar')
        }
      } catch (error) {
        data = makeController(500, null, error, true)
      }
      return data
    }  
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
}
