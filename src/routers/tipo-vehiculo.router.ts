import { NextFunction, Router, Request, Response } from 'express'
import { TipoVehiculoController } from '../controllers/tipo-vehiculo.controller';
import { Marcas } from '../schemes/marca';

const _router: Router = Router()
const _controller = new TipoVehiculoController()
const _path: string = '/tipo-vehiculos'

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
     const body:Partial<Marcas> = req.body
     if (!body.slug || !body.nombre ) {
     return  res.status(400).json({ message: 'los parámetros[slug,nombre] no se han pasado' })
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
