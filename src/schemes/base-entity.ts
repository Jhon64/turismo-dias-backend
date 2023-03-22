import {
  BeforeInsert,
  BeforeRemove,
  BeforeUpdate,
  Column,
  CreateDateColumn,
  Entity,
  UpdateDateColumn,
} from 'typeorm'
@Entity()
export class BaseEntity {
  @Column({ name: 'estado', default: true })
  estado?: boolean
  @Column({ name: 'deleted', default: false })
  deleted?: boolean
  @Column({ name: 'usuario_id', nullable: true, type: 'int' })
  usuarioID?: number
  @CreateDateColumn({ name: 'created_at', type: 'timestamp' })
  createdAt?: number
  @UpdateDateColumn({ name: 'updated_at', type: 'timestamp' })
  updatedAt?: number

  // @BeforeUpdate()
  // public setUpdatedAt() {
  //   this.updatedAt = Math.floor(Date.now() / 1000)
  // }

  // @BeforeInsert()
  // public setCreatedAt() {
  //   this.createdAt = Math.floor(Date.now() / 1000)
  // }

  // @BeforeRemove()
  // public setDeletedAt() {
  //   this.deleted_at = Math.floor(Date.now() / 1000);
  // }
}
