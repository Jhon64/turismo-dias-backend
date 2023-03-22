import { Vehiculo } from './vehiculo';
import { Modelos } from './modelo';
import { Menu, Submenu } from './seguridad/menu'
import { Rol, RolSubmenu } from './seguridad/rol'
import { Organizacion } from './organizacion'
import { Persona } from './persona'
import { Sucursal } from './sucursal'
import { Usuario } from './seguridad/usuario'
import { Marcas } from './marca'
import { TipoVehiculo } from './tipo-vehiculo';
import { Documentos } from './documentos';

export default [
  Organizacion,
  Sucursal,
  Usuario,
  Persona,
  Rol,
  RolSubmenu,
  Menu,
  Submenu,
  Marcas,
  Modelos,
  Vehiculo,
  TipoVehiculo,
  Documentos
]
