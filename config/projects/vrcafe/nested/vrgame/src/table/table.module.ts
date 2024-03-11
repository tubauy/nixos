import { Module } from '@nestjs/common';
import { TableController } from './table.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TableRecord } from './table.entity';
import { TableService } from './table.service';
import { TableGateway } from './table.gateway';

@Module({
  controllers: [TableController],
  imports: [TypeOrmModule.forFeature([TableRecord])],
  providers: [ TableService, TableGateway],

})
export class TableModule {}
