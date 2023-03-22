import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm"
import { BaseEntity } from "./base-entity"
import { Vehiculo } from "./vehiculo"

@Entity()
export class TipoVehiculo extends BaseEntity {
  @PrimaryGeneratedColumn()
  id?: number
  @Column({ nullable: false, type: 'varchar' })
  nombre?: string
  @Column({ nullable: false, type: 'varchar' })
  slug?: string
   
  @OneToMany(()=>Vehiculo,vehiculos=>vehiculos.tipoVehiculo)
  Vehiculos?: Vehiculo[]
}
