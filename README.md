# FIFO设计

## 同步FIFO

### native FIFO
- 使用 `native` 接口，读写使能、读写数据、读写空闲、读写满状态
- 可配置宽度、深度、输出缓冲
- 在 `Xlinx` 平台可设置采用 `BRAM` 或者 `LUTRAM` 实现
- 写满和读空时，写入和读取操作会被阻塞

仿真结果：
![仿真结果](./doc/sync_fifo_native.png)