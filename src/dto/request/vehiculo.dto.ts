import { Vehiculo } from "../../schemes/vehiculo";

export interface VehiculoDTO extends Partial<Vehiculo>{
   marcaID: number
   modeloID: number
   tipoVehiculoID: number
   grupoID: number
   combustibleID:number
 }