import { ENVIRONMENT } from './../Environment'
import bcrypt from 'bcrypt'
export const Bcrypt = {
  generateHash: (password: string) => {
    const saltRounds = ENVIRONMENT.bcrypt.salto
    const salt = bcrypt.genSaltSync(saltRounds)
    const hash = bcrypt.hashSync(password, salt)
    return hash
  },
  compare: (password: string, hash: string) => {
    return bcrypt.compareSync(password, hash)
  },
}
