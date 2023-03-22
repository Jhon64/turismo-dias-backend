import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm'
import { Menu, Submenu } from './menu'
import { BaseEntity } from '../base-entity'
@Entity( {"schema": "seguridad"})
export class Rol extends BaseEntity {
  @PrimaryGeneratedColumn()
  id?: number
  @Column({ nullable: false, type: 'varchar' })
  nombre?: string
  @Column('int', { name: 'filiales_ids', array: true,nullable:true })
  filialesIDS?: number[]

  @OneToMany(() => RolSubmenu, (rolSubmenu) => rolSubmenu.rol)
  rolSubmenus?: RolSubmenu[]
}

@Entity('rol_submenu', {"schema": "seguridad"})
export class RolSubmenu extends BaseEntity {
  @PrimaryGeneratedColumn()
  id?: number

  @ManyToOne(() => Rol, (rol) => rol.rolSubmenus)
  @JoinColumn({ name: 'rol_id' })
  rol?: Rol

  @ManyToOne(() => Submenu, (category) => category.rolSubmenu)
  @JoinColumn({ name: 'submenu_id' })
  submenu?: Submenu
}
