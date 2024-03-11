
import { Entity, Column, PrimaryGeneratedColumn, Timestamp } from 'typeorm';

@Entity()
export class TableRecord {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column()
  starts: string;

  @Column()
  ends: string;

  @Column('text' ,{array:true})
  sales: string[];
}