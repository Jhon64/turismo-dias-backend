import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
  OneToOne,
} from 'typeorm'
import { BaseEntity } from '../base-entity'
import { Persona } from '../persona'

@Entity({"schema": "seguridad"})
export class Usuario extends BaseEntity {
  @PrimaryGeneratedColumn()
  id?: number
  @Column({ nullable: false, type: 'varchar',unique:true })
  username?: string
  @Column({ nullable: false, type: 'varchar' })
  password?: string
  @Column('int', { name: 'filiales_ids', array: true,nullable:true })
  filialesIDS?: number[]
  @Column('int', { name: 'roles_ids', array: true,nullable:true })
  rolesIDS?: number[]

  @OneToOne(() => Persona)
  @JoinColumn({ name: 'persona_id' })
  persona?: Persona
}
