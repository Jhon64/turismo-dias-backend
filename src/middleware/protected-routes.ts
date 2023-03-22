import { JWT } from './../settings/JWT'
import { Request, Response, NextFunction } from 'express'

export const authMiddleware = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
   const authHeader = req.headers["authorization"];
   const token = authHeader && authHeader.split(" ")[1];
   // console.log('token recibido ::',token)
   if (!token) return res.status(401).json({ message: 'Acceso denegado' })
   try {
      const verified = JWT.decodeToken(token)
      //@ts-ignore
     req.user = verified
     next() // continuamos
   } catch (error) {
   //   console.log('ERROR AUTH JWT',error)
     return res.status(401).json({ message: 'token no es válido' })
   }
}
