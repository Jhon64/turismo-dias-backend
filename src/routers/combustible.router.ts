import { Combustible } from './../schemes/combustible';
import { NextFunction, Router, Request, Response } from 'express'
import { CombustibleController } from "../controllers/combustible.controller"

const _router: Router = Router()
const _controller = new CombustibleController()
const _path: string = '/combustible'

_router.get(
  _path,
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const result = await _controller.listar()
      res.status(result.statusCode).json(result)
    } catch (error) {
      res.status(500).send(error)
    }
  }
)


_router.post(
   _path + '/register',
   async (req: Request, res: Response, next: NextFunction) => {
     const body:Partial<Combustible> = req.body
     if (!body.nombre ) {
     return  res.status(400).json({ message: 'los parámetros[nombre] no se han pasado' })
     }
     try {
       const result = await _controller.register(body)
       res.status(result.statusCode).json(result)
     } catch (error) {
       res.status(500).send(error)
     }
   }
 )

export default _router
