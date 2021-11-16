transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/Tarea3 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/Tarea3/lcd_sync.v}
vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/Tarea3 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/Tarea3/PLL_VGA.v}
vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/Tarea3 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/Tarea3/barras_lcd.v}
vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/Tarea3/db {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/Tarea3/db/pll_vga_altpll.v}
vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/Tarea3 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/Tarea3/n_counter.v}

vlog -vlog01compat -work work +incdir+D:/Juan/Escritorio/Master/Cuatrimestre\ A/Sistemas\ Digitales\ Programables/sdp/juan_sdp/Tarea3 {D:/Juan/Escritorio/Master/Cuatrimestre A/Sistemas Digitales Programables/sdp/juan_sdp/Tarea3/barras_lcd_test.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  barras_lcd_test

add wave *
view structure
view signals
run -all
