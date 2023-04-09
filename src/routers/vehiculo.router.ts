import { VehiculoDTO } from './../dto/request/vehiculo.dto';
import { Combustible } from './../schemes/combustible';
import { NextFunction, Router, Request, Response } from 'express'
import { CombustibleController } from "../controllers/combustible.controller"
import { VehiculoController } from '../controllers/vehiculo.controller';
import { uploadMulter } from '../settings/multer'
const _router: Router = Router()
const _controller = new VehiculoController()
const _path: string = '/vehiculos'

_router.get(
  _path,
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const { id } = req.query
      const result = await _controller.listar(id ? +id : undefined)
      res.status(result.statusCode).json(result)
    } catch (error) {
      res.status(500).send(error)
    }
  }
)


_router.post(
  _path + '/register',
  uploadMulter('storage/vehiculos').single('fotografiaFile'),
  async (req: Request, res: Response, next: NextFunction) => {

    const body: VehiculoDTO = req.body
    const files = req.file
    if (files) {
      const path = files.path
      const filename = files.filename
      const originalname = files.originalname
      body.fotografia = path
    }
    console.log('req::', body)
    console.log('archivos::', files)
    if (!body.nombre || !body.combustibleID || !body.grupoID || !body.marcaID || !body.modeloID || !body.tipoVehiculoID) {
      return res.status(400).json({ message: 'los parámetros[nombre, combustibleID,grupoID,marcaID,modeloID,tipoVehiculoID] no se han pasado' })
    }
    try {
      const result = await _controller.register(body)
      res.status(result.statusCode).json(result)
    } catch (error) {
      res.status(500).send(error)
    }
  }
)


_router.post(
  _path + '/documentos',
  uploadMulter('storage/documentos').array('documentos'),
  async (req: Request, res: Response, next: NextFunction) => {

    const body: any = req.body
    const files = req.files
    console.log(files)
    let resultFiles: { path: string, filename: string, originalname: string, vehiculo: number }[] = []
    if (files?.length) {
      if (Array.isArray(files))
        files.forEach((file: any) => {
          const path = file.path
          const filename = file.filename
          const originalname = file.originalname
          resultFiles.push({ path, filename, originalname, vehiculo: +body.id })
        })

    }
    body.files = resultFiles
    if (!body.id) {
      return res.status(400).json({ message: 'los parámetros[vehiculo ID] no se han pasado' })
    }
    try {
      const result = await _controller.addDocumentos(body)
      res.status(result.statusCode).json(result)
    } catch (error) {
      res.status(500).send(error)
    }
  }
)

export default _router
