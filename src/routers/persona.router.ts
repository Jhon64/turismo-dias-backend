import { Persona } from './../schemes/persona';
import { NextFunction, Router, Request, Response } from 'express'
import { PersonaController } from '../controllers/persona.controller'

const _router: Router = Router()
const _controller = new PersonaController()
const _path: string = '/persona'

_router.post(
  _path + '/register',
  async (req: Request, res: Response, next: NextFunction) => {
    const body = req.body
     const persona: Partial<Persona> = body
     console.log('body',body)
    if (!persona.nombre || !persona.paterno || !persona.materno ||!persona.dni) {
    return  res.status(400).json({ message: 'los parámetros[nombre,paterno,materno,dni] no se han pasado' })
    }
    try {
      const resultLogin = await _controller.addPersona(persona)
      res.status(resultLogin.statusCode).json(resultLogin)
    } catch (error) {
      res.status(500).send(error)
    }
  }
)


export default _router
