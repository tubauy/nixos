import { TableService } from './table.service';
import { TableRecord } from './table.entity';
export declare class TableDTO {
    name: string;
    start: string;
    end: string;
    sales: string[];
}
export declare class TableController {
    private tableService;
    constructor(tableService: TableService);
    addTableRecord(body: TableDTO): Promise<TableRecord>;
}
