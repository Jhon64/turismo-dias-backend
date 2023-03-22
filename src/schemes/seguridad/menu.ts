import { BaseEntity } from '../base-entity';
import { Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { Rol, RolSubmenu } from './rol';
@Entity({"schema": "seguridad"})
export class Menu extends BaseEntity{ 
   @PrimaryGeneratedColumn()
   id?: number
   @Column({ nullable: false, type: 'varchar' })
   nombre?: string
   @Column({ nullable: false, type: 'varchar' })
   url?: string
   @Column({ nullable: false, type: 'varchar' })
   icono?: string
  
   @OneToMany(()=>Submenu,submenu=>submenu.menu)
   submenus?: Submenu[]
}

@Entity({"schema": "seguridad"})
export class Submenu  extends BaseEntity{ 
   @PrimaryGeneratedColumn()
   id?: number
   @Column({ nullable: false, type: 'varchar' })
   nombre?: string
   @Column({ nullable: false, type: 'varchar' })
   url?: string
   @Column({ nullable: false, type: 'varchar' })
   icono?: string

   @ManyToOne(() => Menu, (menu) => menu.submenus)
   @JoinColumn({name:'menu_id'})
   menu?: Menu

   @OneToMany(() => RolSubmenu, rolSubmenu => rolSubmenu.submenu)
   rolSubmenu?: RolSubmenu[];
}


 