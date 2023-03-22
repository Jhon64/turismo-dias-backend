export interface IUsuarioLogin {
  username: string
  password: string
}

export interface IUsuarioLoginResult {
  id: number
  username: string
  roles_ids?: number[]
  filiales_ids?: number[]
  full_name?: string
  nombre?: string
  materno?: string
  paterno?: string
}
