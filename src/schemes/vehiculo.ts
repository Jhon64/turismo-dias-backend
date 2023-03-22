import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  UpdateDateColumn,
  OneToMany,
} from 'typeorm'
import { BaseEntity } from './base-entity'
import { Documentos } from './documentos'
import { Marcas } from './marca'
import { Modelos } from './modelo'
import { TipoVehiculo } from './tipo-vehiculo'

@Entity()
export class Vehiculo {
  @PrimaryGeneratedColumn()
  id?: number
  @Column({ nullable: false, type: 'varchar' })
  nombre?: string
  @Column({ nullable: false, type: 'varchar' })
  placa?: string
  @Column({ nullable: false, type: 'int' })
  año?: number

  @Column({ name: 'estado', default: 1 })
  estado?: number
  @Column({ name: 'estado_descripcion',nullable:true })
  estadoDescripcion?: string

  @Column({ name: 'provincia_registro', nullable: false, type: 'varchar' })
  provinciaRegistro?: string
  @Column({ nullable: false, type: 'varchar' })
  fotografia?: string
  @Column({ name: 'tarjeta_circulacion', nullable: false, type: 'varchar' })
  tarjetaCirculacion?: string
  @Column({
    name: 'fech_venc_tarjeta_circulacion',
    nullable: false,
    type: 'int',
  })
  fechaVencTarjetaCirculacion?: number
  @Column({ name: 'tarjeta_propiedad', nullable: false, type: 'varchar' })
  tarjetaPropiedad?: string
  @Column({ name: 'fech_venc_tarjeta_propiedad', nullable: false, type: 'int' })
  fechaVencTarjetaPropiedad?: number

  @Column({ name: 'deleted', default: false })
  deleted?: boolean
  @Column({ name: 'usuario_id', nullable: true, type: 'int' })
  usuarioID?: number
  @CreateDateColumn({ name: 'created_at', type: 'timestamp' })
  createdAt?: number
  @UpdateDateColumn({ name: 'updated_at', type: 'timestamp' })
  updatedAt?: number

  //*ESPECIFICACIONES
  @Column({ nullable: false, type: 'varchar' })
  color?: string
  @Column({ nullable: false, type: 'varchar' })
  motor?: string
  @Column({ nullable: false, type: 'int' })
  cilindros?: number
  @Column({ nullable: false, type: 'varchar' })
  cilindrada?: string
  @Column({ nullable: false, type: 'varchar' })
  combustible?: string

  @ManyToOne(() => TipoVehiculo)
  @JoinColumn({ name: 'tipo_vehiculo_id' })
  tipoVehiculo?: TipoVehiculo
  @ManyToOne(() => Marcas)
  @JoinColumn({ name: 'marca_id' })
  marca?: Marcas
  @ManyToOne(() => Marcas)
  @JoinColumn({ name: 'modelo_id' })
  modelo?: Modelos
   
  @OneToMany(()=>Documentos,documentos=>documentos.vehiculo)
  documentos?: Documentos[]
}
