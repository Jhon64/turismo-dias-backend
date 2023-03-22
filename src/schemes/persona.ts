import { Usuario } from './seguridad/usuario';
import {  Column, Entity, OneToMany, OneToOne, PrimaryGeneratedColumn } from 'typeorm'
import { BaseEntity } from './base-entity'


@Entity()
export class Persona extends BaseEntity {
  @PrimaryGeneratedColumn()
  id?: number
  @Column({ nullable: false, type: 'varchar' })
  nombre?: string
  @Column({ nullable: false, type: 'varchar' })
  paterno?: string
  @Column({ nullable: false, type: 'varchar' })
   materno?: string
  @Column({ name: 'full_name', nullable: false, type: 'varchar' })
  fullname?: string
  @Column({ nullable: false, type: 'varchar' ,unique:true})
  dni?: string
  @Column({ type: 'varchar', nullable: true })
  direccion?: string
  @Column({ type: 'varchar', nullable: true })
  celular?: string
  @Column({name:'fecha_nacimiento', nullable: true })
  fechaNacimiento?: number
  @Column({ nullable: true })
  sexo?: string
   
  @OneToOne(() => Usuario)
  usuario?:Usuario
}
