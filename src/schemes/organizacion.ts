import { Sucursal } from './sucursal';
import { Entity, PrimaryGeneratedColumn, Column, OneToMany } from 'typeorm'
import { BaseEntity } from './base-entity'
@Entity('organizacion')
export class Organizacion extends BaseEntity {
  @PrimaryGeneratedColumn()
  id?: number
  @Column({ nullable: false, type: 'varchar' })
  ruc?: string
  @Column({ nullable: false, type: 'varchar' })
  nombre?: string
  @Column({ name: 'razon_social', nullable: false, type: 'varchar' })
  razonSocial?: string
  @Column({ nullable: true, type: 'varchar' })
  direccion?: string
  @Column({ nullable: true, type: 'varchar' })
  email?: string
  @Column({ nullable: true, type: 'varchar' })
  celular?: string
  @Column({ type: 'varchar' })
  logo?: string

  @OneToMany(()=>Sucursal,sucursal=>sucursal.organizacion)
  sucursales?: Sucursal[]
}
