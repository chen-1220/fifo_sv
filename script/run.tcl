quit -sim

vlib ./lib/ 
vlib ./lib/work/ 

vmap work ./lib/work/

vlog -work work ./../design/*.sv
vlog -work work ./../sim/sync_fifo_native_tb.sv

vsim -voptargs=+acc work.sync_fifo_native_tb 

add wave -divider sync_fifo_native_tb 

add wave sync_fifo_native_tb/*

add wave -divider {sync_fifo_native}
add wave sync_fifo_native_tb/u_sync_fifo_native/*

run 500ns