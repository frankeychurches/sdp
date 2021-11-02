transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/Practica_FSM {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/Practica_FSM/Practica_FSM.v}

vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/Practica_FSM {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/Practica_FSM/test_fsm.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  test_fsm

add wave *
view structure
view signals
run -all
