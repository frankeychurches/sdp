onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_count/CLK
add wave -noupdate /tb_count/RST_n
add wave -noupdate /tb_count/ENABLE
add wave -noupdate /tb_count/UP_DOWN
add wave -noupdate -radix unsigned -expand /tb_count/COUNT
add wave -noupdate /tb_count/TC
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {461753 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {588 ns}
