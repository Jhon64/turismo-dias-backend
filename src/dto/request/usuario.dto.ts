import { Usuario } from "../../schemes/seguridad/usuario";

export interface UsuarioDTO extends Partial<Usuario> {
personaID:number
}