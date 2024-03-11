import { Controller, Post , Get, Req, Body} from '@nestjs/common';
import { TableService } from './table.service';
import { Request } from 'express';
import { TableRecord } from './table.entity';

export class TableDTO {
    name : string
    start: string
    end: string
    sales: string[]
}

@Controller('table')
export class TableController {
    constructor(private tableService: TableService) {}

    @Post()
    async addTableRecord(@Body() body: TableDTO) {
        const name = body.name;
        const start = body.start;
        const end = body.end;
        const sales = body.sales;
        return this.tableService.addOne(name, start, end, sales);
    }
}
