import { Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm"
import { BaseEntity } from "./base-entity"
import { Marcas } from "./marca"
import { Vehiculo } from "./vehiculo"

@Entity()
export class Modelos extends BaseEntity {
  @PrimaryGeneratedColumn()
  id?: number
  @Column({type: 'varchar',nullable:false })
  nombre?: string
  @Column({  type: 'varchar',nullable:false })
  slug?: string
  @ManyToOne(() => Marcas)
  @JoinColumn({ name: 'marca_id' })
  marca?: Marcas


  @OneToMany(()=>Vehiculo,vehiculos=>vehiculos.modelo)
  Vehiculos?: Vehiculo[]
}
