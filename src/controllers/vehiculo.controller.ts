import { VehiculoDTO } from './../dto/request/vehiculo.dto';
import { MarcaRepository } from './../repositories/marca.repository'
import { IResponseController } from './../helpers/controllers.helpers'
import { makeController } from '../helpers/controllers.helpers'
import { Marcas } from '../schemes/marca'
import { VehiculoRepository } from '../repositories/vehiculo.repository';

export class VehiculoController {
  _repository = new VehiculoRepository()
  constructor() {}
  async listar(id?:number) {
    let data = {} as IResponseController
    try {
      const result = await this._repository.listarTodo(id)
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

  async register(add:VehiculoDTO) {
   let data = {} as IResponseController
   try {
     const result = await this._repository.register(add)
     if (result.status == 'OK') {
       data = makeController(200, result.data, 'vehiculo Registrado')
     } else {
       data = makeController(500, null, result.error || 'Error al registrar')
     }
   } catch (error) {
     data = makeController(500, null, error, true)
   }
   return data
 }  

 async addDocumentos(add:any) {
  let data = {} as IResponseController
  try {
    const result = await this._repository.addDocumentos(add)
    if (result.status == 'OK') {
      data = makeController(200, result.data, ' Registrada')
    } else {
      data = makeController(500, null, result.error || 'Error al registrar')
    }
  } catch (error) {
    data = makeController(500, null, error, true)
  }
  return data
}  
}
