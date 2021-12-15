transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/tarea4_1 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/tarea4_1/adc_fsm.v}
vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/tarea4_1 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/tarea4_1/adc_dout_coord.v}
vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/tarea4_1 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/tarea4_1/adc_din_gen.v}
vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/tarea4_1 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/tarea4_1/ADC_CONTROL.v}
vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/tarea4_1 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/tarea4_1/n_counter.v}
vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/tarea4_1 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/tarea4_1/adc_dclk_cnt.v}

vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/tarea4_1 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/tarea4_1/EMULE_ADC.vo}
vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/tarea4_1 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/tarea4_1/tb_Touch_Control.v}
vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/tarea4_1 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/tarea4_1/MFB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_Touch_Control

add wave *
view structure
view signals
run -all
