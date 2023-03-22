import { NextFunction, Router, Request, Response } from 'express'
import { UsuarioController } from '../controllers/usuario.controller'
import { UsuarioDTO } from '../dto/request/usuario.dto'
import { IUsuarioLogin } from '../interfaces/usuario.interface'
import  {authMiddleware} from '../middleware/protected-routes'


const _router: Router = Router()
const _controller: UsuarioController = new UsuarioController()
const _path: string = '/usuario'

_router.get(_path,authMiddleware, async (req: Request, res: Response, next: NextFunction) => {
  try {
    console.log('listando datos .....')
    const result = await _controller.listarTodo()
    res.status(result.statusCode).json(result)
  } catch (error) {
    res.status(500).json(error)
  }
})
_router.post(
  _path + '/login',
  async (req: Request, res: Response, next: NextFunction) => {
    const body = req.body
    const usuario: IUsuarioLogin = {
      username: body?.username,
      password: body?.password,
    }
    if (!usuario.password || !usuario.username) {
      return res.status(401).json({ message: 'usuario y/o password no se han pasado' })
    }
    try {
      const resultLogin = await _controller.validarUsuario(usuario)
      res.status(resultLogin.statusCode).json(resultLogin)
    } catch (error) {
      res.status(500).send(error)
    }
  }
)

_router.post(
  _path + '/register',
  async (req: Request, res: Response, next: NextFunction) => {
    const body = req.body
    const usuario: UsuarioDTO = {
      password: body?.password,
      username: body?.username,
      personaID: body?.personaID,
    }
    if (!usuario.password || !usuario.username || !usuario.personaID) {
    return  res.status(400).json({ message: 'los parámetros[username,password,personaID] no se han pasado' })
    }
    try {
      const resultLogin = await _controller.addUsuario(usuario)
      res.status(resultLogin.statusCode).json(resultLogin)
    } catch (error) {
      res.status(500).send(error)
    }
  }
)


export default _router
