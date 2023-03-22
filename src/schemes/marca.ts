import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm"
import { BaseEntity } from "./base-entity"
import { Modelos } from "./modelo"
import { Vehiculo } from "./vehiculo"

@Entity()
export class Marcas extends BaseEntity {
  @PrimaryGeneratedColumn()
  id?: number
  @Column({  type: 'varchar',nullable:false })
  nombre?: string
  @Column({  type: 'varchar',nullable:false })
  slug?: string
   
  @OneToMany(()=>Modelos,modelos=>modelos.marca)
  modelos?: Modelos[]

  @OneToMany(()=>Vehiculo,vehiculos=>vehiculos.marca)
  Vehiculos?: Vehiculo[]
}
