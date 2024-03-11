import { Repository } from 'typeorm';
import { TableRecord } from './table.entity';
export declare class TableService {
    private tablesRepository;
    constructor(tablesRepository: Repository<TableRecord>);
    addOne(name: string, start: string, end: string, sales: string[]): TableRecord;
}
