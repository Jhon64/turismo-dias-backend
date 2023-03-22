import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from "typeorm"
import { BaseEntity } from "./base-entity"
import { Vehiculo } from "./vehiculo"

@Entity()
export class Documentos  extends BaseEntity {
  @PrimaryGeneratedColumn()
  id?: number
  @Column({type: 'varchar',nullable:false })
  nombre?: string
  @Column({  type: 'varchar',nullable:false })
  path?: string
   
   
  @ManyToOne(() => Vehiculo)
  @JoinColumn({ name: 'vehiculo_id' })
  vehiculo?: Vehiculo
  
}
