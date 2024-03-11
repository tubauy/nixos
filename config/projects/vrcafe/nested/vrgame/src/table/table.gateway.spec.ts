import { Test, TestingModule } from '@nestjs/testing';
import { TableGateway } from './table.gateway';

describe('TableGateway', () => {
  let gateway: TableGateway;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [TableGateway],
    }).compile();

    gateway = module.get<TableGateway>(TableGateway);
  });

  it('should be defined', () => {
    expect(gateway).toBeDefined();
  });
});
