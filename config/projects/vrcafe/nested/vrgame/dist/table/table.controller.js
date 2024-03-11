"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.TableController = exports.TableDTO = void 0;
const common_1 = require("@nestjs/common");
const table_service_1 = require("./table.service");
class TableDTO {
}
exports.TableDTO = TableDTO;
let TableController = class TableController {
    constructor(tableService) {
        this.tableService = tableService;
    }
    async addTableRecord(body) {
        const name = body.name;
        const start = body.start;
        const end = body.end;
        const sales = body.sales;
        return this.tableService.addOne(name, start, end, sales);
    }
};
exports.TableController = TableController;
__decorate([
    (0, common_1.Post)(),
    __param(0, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [TableDTO]),
    __metadata("design:returntype", Promise)
], TableController.prototype, "addTableRecord", null);
exports.TableController = TableController = __decorate([
    (0, common_1.Controller)('table'),
    __metadata("design:paramtypes", [table_service_1.TableService])
], TableController);
//# sourceMappingURL=table.controller.js.map