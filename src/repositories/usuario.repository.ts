import { Bcrypt } from './../settings/bcrypt'
import { UsuarioDTO } from '../dto/request/usuario.dto'
import { IResponseRepository } from '../helpers/repository.helpers'
import { IUsuarioLogin } from '../interfaces/usuario.interface'
import { JWT } from '../settings/JWT'
import { BaseRepository } from './base.repository'

export class UsuarioRepository extends BaseRepository {
  constructor() {
    super()
  }
  async usuariosAll(): Promise<IResponseRepository> {
    let response = {} as IResponseRepository
    try {
      const data = await this.execProcedure('get_usuarios', [[]])
      const resultString = JSON.stringify(data.result)
      const result = JSON.parse(resultString)

      response.data = { ...result[0] }
      response.status = 'OK'
    } catch (error) {
      console.log(error)
      response.error = error
      response.status = 'ERROR'
    }
    return response
  }

  async validarUsuario(usuario: IUsuarioLogin): Promise<IResponseRepository> {
    let response = {} as IResponseRepository
    try {
      const params = JSON.stringify(usuario)
      const data = await this.execProcedure('login_usuario', [params])
      const resultString = JSON.stringify(data.result)
      const result = JSON.parse(resultString)
      console.log(result)
      if (result.length) {
        const user = { ...result[0], token: null }
        if (Bcrypt.compare(usuario.password, user.password)) {
          user.token = JWT.generateToken(user)
          response.data = user
          response.status = 'OK'
        } else {
          response.status = 'ERROR'
          response.error = 'Error al autenticar clave incorrecta'
        }
      } else {
        response.status = 'ERROR'
        response.error = 'Error al autenticar clave o usuario'
      }
    } catch (error) {
      console.log(error)
      response.error = error
      response.status = 'ERROR'
    }
    return response
  }

  async addUsuario(usuario: UsuarioDTO): Promise<IResponseRepository> {
    let response = {} as IResponseRepository
    try {
      const params = JSON.stringify(usuario)
      const data = await this.execProcedure('seguridad.post_add_usuario', [
        params,
      ])
      const resultString = JSON.stringify(data.result)
      const result = JSON.parse(resultString)
      if (result.length) {
        const user = { ...result[0] }
        response.data = user
        response.status = 'OK'
      } else {
        response.status = 'ERROR'
        response.error = 'Error al registrar usuario'
      }
    } catch (error) {
      console.log(error)
      response.error = error
      response.status = 'ERROR'
    }
    return response
  }
}
