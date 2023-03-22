import { Menu } from './../schemes/seguridad/menu';
import { MenuController } from './../controllers/menu.controller';
import { NextFunction, Router, Request, Response } from 'express'


const _router: Router = Router()
const _controller = new MenuController()
const _path: string = '/menus'

_router.get(
  _path,
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const resultLogin = await _controller.listar()
      res.status(resultLogin.statusCode).json(resultLogin)
    } catch (error) {
      res.status(500).send(error)
    }
  }
)


_router.post(
   _path + '/register',
   async (req: Request, res: Response, next: NextFunction) => {
     const body:Partial<Menu> = req.body
     if (!body.url || !body.nombre ) {
     return  res.status(400).json({ message: 'los parámetros[url,nombre] no se han pasado' })
     }
     try {
       const resultLogin = await _controller.register(body)
       res.status(resultLogin.statusCode).json(resultLogin)
     } catch (error) {
       res.status(500).send(error)
     }
   }
 )

export default _router
