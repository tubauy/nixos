import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { TableRecord } from './table.entity';

@Injectable()
export class TableService {
    constructor(
        @InjectRepository(TableRecord)
        private tablesRepository: Repository<TableRecord>,
    ) {}

    addOne (name:string, start:string, end:string, sales: string[]): TableRecord {
        var tableRecord:TableRecord = new TableRecord;
        tableRecord.name = name;
        tableRecord.starts = start;
        tableRecord.ends = end;
        tableRecord.sales = sales;
        this.tablesRepository.save([tableRecord])
        return tableRecord;
    }
}
