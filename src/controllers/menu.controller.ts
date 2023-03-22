import { Menu } from './../schemes/seguridad/menu';
import { IResponseController } from './../helpers/controllers.helpers'
import { makeController } from '../helpers/controllers.helpers'
import { MenuRepository } from '../repositories/menu.repository'

export class MenuController {
  _repository = new MenuRepository()
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

  async register(add:Partial<Menu>) {
   let data = {} as IResponseController
   try {
     const result = await this._repository.register(add)
     if (result.status == 'OK') {
       data = makeController(200, result.data, 'menu Registrada')
     } else {
       data = makeController(500, null, result.error || 'Error al registrar')
     }
   } catch (error) {
     data = makeController(500, null, error, true)
   }
   return data
 }  
}
