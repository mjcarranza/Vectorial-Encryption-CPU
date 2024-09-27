transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Vectorial-Encryption-CPU/InstructionFetch {C:/Users/mario/Documents/GitHub/Vectorial-Encryption-CPU/InstructionFetch/IF_ID_Reg.sv}

vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Vectorial-Encryption-CPU/testbench {C:/Users/mario/Documents/GitHub/Vectorial-Encryption-CPU/testbench/IF_ID_Reg_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  IF_ID_Reg_tb

add wave *
view structure
view signals
run -all
