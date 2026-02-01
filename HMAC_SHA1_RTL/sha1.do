vlib work
vmap work work

vlog *.v +cover

vsim -voptargs=+acc work.sha1_core_tb -cover 

coverage save sha1.ucdb -onexit -du sha_1_top

add wave -noupdate /sha1_core_tb/clk
add wave -noupdate /sha1_core_tb/rst_n
add wave -noupdate /sha1_core_tb/data_in
add wave -noupdate /sha1_core_tb/t_valid
add wave -noupdate /sha1_core_tb/t_last
add wave -noupdate /sha1_core_tb/t_ready
add wave -noupdate /sha1_core_tb/DUT/sha_done
add wave -noupdate /sha1_core_tb/input_vec
add wave -noupdate /sha1_core_tb/i
add wave -noupdate -expand -group padd -radix hexadecimal /sha1_core_tb/DUT/u_padding_add/padded_data_out
add wave -noupdate -expand -group padd /sha1_core_tb/DUT/u_padding_add/data_len_words
add wave -noupdate -expand -group padd /sha1_core_tb/DUT/u_padding_add/current_state
add wave -noupdate -expand -group sha_core /sha1_core_tb/DUT/u_sha1_core/hash_out
add wave -noupdate -expand -group sha_core /sha1_core_tb/DUT/u_sha1_core/hash_state
add wave -noupdate -expand -group sha_core /sha1_core_tb/DUT/u_sha1_core/round
add wave -noupdate -expand -group sha_core /sha1_core_tb/DUT/u_sha1_core/current_state
add wave -noupdate -expand -group sha_core /sha1_core_tb/DUT/u_sha1_core/output_index
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4385 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 218
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update

#run -all



