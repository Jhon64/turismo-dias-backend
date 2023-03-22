import { Organizacion } from './organizacion';
import {
   Entity,
   PrimaryGeneratedColumn,
   Column,
   OneToMany,
   ManyToOne,
   JoinColumn,
 } from 'typeorm'
 import {BaseEntity} from './base-entity'
 @Entity('sucursal')
 export class Sucursal extends BaseEntity {
   @PrimaryGeneratedColumn()
   id?: number
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
    

   @ManyToOne(()=>Organizacion,organizacion=>organizacion.sucursales)
   @JoinColumn({name:'organizacion_id'})
   organizacion?:Organizacion[]
 }
 