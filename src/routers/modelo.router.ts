import { Modelos } from './../schemes/modelo';

import { NextFunction, Router, Request, Response } from 'express'
import { ModeloController } from '../controllers/modelo.controller';
import { ModeloDTO } from '../dto/request/modelo.dto';

const _router: Router = Router()
const _controller = new ModeloController()
const _path: string = '/modelos'

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
     const body:ModeloDTO = req.body
     if (!body.slug || !body.nombre ||!body.marcaID ) {
     return  res.status(400).json({ message: 'los parámetros[slug,nombre,marcaID] no se han pasado' })
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
