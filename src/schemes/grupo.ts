import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm"
import { BaseEntity } from "./base-entity"

@Entity()
export class Grupo extends BaseEntity {
  @PrimaryGeneratedColumn()
  id?: number
  @Column({  type: 'varchar',nullable:false })
  nombre?: string
}
