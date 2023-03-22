import JsonWebToken from 'jsonwebtoken'
import { ENVIRONMENT } from './../Environment';
export const JWT = {
   generateToken: (usuario: any) => {
      const secret = ENVIRONMENT.jwt.secretKey || 'miKey'
      const expiresIn=ENVIRONMENT.jwt.expiresIn||Math.floor(Date.now() / 1000) + (24*60 * 60)//*24Horas
      try {
         const token = JsonWebToken.sign(usuario, secret,
            // { expiresIn: expiresIn }
         )   
         return token
      } catch (error) {
         throw error
      }
   },
   decodeToken: (token: string) => {
      const secret = ENVIRONMENT.jwt.secretKey || 'miKey'
      try {
         const decode = JsonWebToken.verify(token, secret)
         return decode
      } catch (error) {
         throw error
      }
   }
}