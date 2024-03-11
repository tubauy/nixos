import { MessageBody, SubscribeMessage, WebSocketGateway, WsResponse, WebSocketServer } from '@nestjs/websockets';
import { JsonContains } from 'typeorm';

    class Table {
      constructor(nm) {
          this.name = nm;
          this.start = Date.now();
      }
      setEnd (date) {
          this.end = date;
      }
      name = "";
      start;
      end;
      sales = []
  }


@WebSocketGateway()
export class TableGateway {

  @WebSocketServer() private server: any;
  wsClients=[];
  afterInit() {
    this.server.emit('testing', { do: 'stuff' });
  }

  handleConnection(client: any) {
    this.wsClients.push(client);
  }

  handleDisconnect(client) {
    for (let i = 0; i < this.wsClients.length; i++) {
      if (this.wsClients[i].id === client.id) {
        this.wsClients.splice(i, 1);
        break;
      }
    }
    this.broadcast('disconnected',{});
  }

  private broadcast(event, message: any) {
    const broadCastMessage = JSON.stringify(message);
    for (let c of this.wsClients) {
      c.emit(event, broadCastMessage);
    }
  }

  tables = []

  @SubscribeMessage('hi')
  handlehi(){
    this.broadcast('updated', JSON.stringify(this.tables))
  }
  @SubscribeMessage('add')
  handleAdd(@MessageBody() data) {
    this.tables.push(data);
    console.log(data);
    console.log(JSON.stringify(this.tables))
    this.broadcast('updated', JSON.stringify(this.tables));
  }
  @SubscribeMessage('end')
  handleDel() {
      
  }
}
