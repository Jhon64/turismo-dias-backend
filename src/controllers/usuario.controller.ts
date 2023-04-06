import { Bcrypt } from './../settings/bcrypt';
import { IResponseController } from './../helpers/controllers.helpers'
import { makeController } from '../helpers/controllers.helpers'
import { IUsuarioLogin } from '../interfaces/usuario.interface'
import { UsuarioRepository } from './../repositories/usuario.repository'
import { UsuarioDTO } from '../dto/request/usuario.dto'
export class UsuarioController {
  _repository = new UsuarioRepository()
  constructor() {}

  async listarTodo() {
    let data = {} as IResponseController
    try {
      const result = await this._repository.usuariosAll()
      if (result.status == 'OK') {
        data = makeController(200, result.data, 'Listando usuarios')
      } else {
        data = makeController(500, null, result.error || 'Error al listar usuarios')
      }
    } catch (error) {
      data = makeController(500, null, error, true)
    }
    return data
  }
  async validarUsuario(usuario: IUsuarioLogin) {
    let data = {} as IResponseController
    try {
      const result = await this._repository.validarUsuario(usuario)
      if (result.status == 'OK') {
        data = makeController(200, result.data, 'Usuario Autenticado')
      } else {
        data = makeController(401, null, result.error || 'Error al autenticar')
      }
    } catch (error) {
      data = makeController(500, null, error, true)
    }
    return data
  }

  async addUsuario(add:UsuarioDTO) {
    let data = {} as IResponseController
    try {
      if (add.password) {
        const hashPassword = Bcrypt.generateHash(add.password)
        add.password=hashPassword  
      } else {
        data = makeController(500, null,  'No se encontró password')
      }
      const result = await this._repository.addUsuario(add)
      if (result.status == 'OK') {
        data = makeController(200, result.data, 'Usuario Registrado')
      } else {
        data = makeController(500, null, result.error || 'Error al registrar')
      }
    } catch (error) {
      console.log(error)
      data = makeController(500, null, error, true)
    }
    return data
  }
}
