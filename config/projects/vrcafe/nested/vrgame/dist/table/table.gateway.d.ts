export declare class TableGateway {
    private server;
    wsClients: any[];
    afterInit(): void;
    handleConnection(client: any): void;
    handleDisconnect(client: any): void;
    private broadcast;
    tables: any[];
    handlehi(): void;
    handleAdd(data: any): void;
    handleDel(): void;
}
