import { Modelos } from "../../schemes/modelo";

export interface ModeloDTO extends Partial<Modelos> {
   marcaID:number
   }