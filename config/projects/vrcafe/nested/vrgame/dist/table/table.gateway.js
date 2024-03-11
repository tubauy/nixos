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
exports.TableGateway = void 0;
const websockets_1 = require("@nestjs/websockets");
class Table {
    constructor(nm) {
        this.name = "";
        this.sales = [];
        this.name = nm;
        this.start = Date.now();
    }
    setEnd(date) {
        this.end = date;
    }
}
let TableGateway = class TableGateway {
    constructor() {
        this.wsClients = [];
        this.tables = [];
    }
    afterInit() {
        this.server.emit('testing', { do: 'stuff' });
    }
    handleConnection(client) {
        this.wsClients.push(client);
    }
    handleDisconnect(client) {
        for (let i = 0; i < this.wsClients.length; i++) {
            if (this.wsClients[i].id === client.id) {
                this.wsClients.splice(i, 1);
                break;
            }
        }
        this.broadcast('disconnected', {});
    }
    broadcast(event, message) {
        const broadCastMessage = JSON.stringify(message);
        for (let c of this.wsClients) {
            c.emit(event, broadCastMessage);
        }
    }
    handlehi() {
        this.broadcast('updated', JSON.stringify(this.tables));
    }
    handleAdd(data) {
        this.tables.push(data);
        console.log(data);
        console.log(JSON.stringify(this.tables));
        this.broadcast('updated', JSON.stringify(this.tables));
    }
    handleDel() {
    }
};
exports.TableGateway = TableGateway;
__decorate([
    (0, websockets_1.WebSocketServer)(),
    __metadata("design:type", Object)
], TableGateway.prototype, "server", void 0);
__decorate([
    (0, websockets_1.SubscribeMessage)('hi'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], TableGateway.prototype, "handlehi", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('add'),
    __param(0, (0, websockets_1.MessageBody)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], TableGateway.prototype, "handleAdd", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('end'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], TableGateway.prototype, "handleDel", null);
exports.TableGateway = TableGateway = __decorate([
    (0, websockets_1.WebSocketGateway)()
], TableGateway);
//# sourceMappingURL=table.gateway.js.map