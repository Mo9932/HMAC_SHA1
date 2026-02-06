vlib work
vlog *.*v

vsim -debugdb -fsmdebug HMAC_SHA_tb


add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/rst_n
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/clk
add wave -noupdate -expand -group HMAC_TOP -radix unsigned /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/key
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/t_valid
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/t_last
add wave -noupdate -expand -group HMAC_TOP -radix unsigned /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/t_data
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/t_ready
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/auth_done
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/auth_error
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/i
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/sel
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/data_2_sha_stg1
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/tag_pipe1
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/out_2_sha_stg2
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/out_to_sha
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/sha_stg1_done
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/hash_out_stg1
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/hash_out_stg2
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/sah_start
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/valid

add wave -noupdate -group ctrl /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/C0/rst_n
add wave -noupdate -group ctrl /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/C0/clk
add wave -noupdate -group ctrl /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/C0/t_last
add wave -noupdate -group ctrl /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/C0/sel

add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/U0/rst_n
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/U0/clk
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/U0/key
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/U0/start
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/U0/out_to_sha
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/U0/i
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/U0/cs
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/U0/ns
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/U0/count_en

add wave -noupdate -group MUX /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/M0/sel
add wave -noupdate -group MUX /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/M0/A
add wave -noupdate -group MUX /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/M0/B
add wave -noupdate -group MUX /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/M0/O

add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/clk
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/rst_n
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/t_data
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/t_valid
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/t_last
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/t_ready
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/sha_done
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/hash_out
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/sha_ready
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/padded_data_out
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/start
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/restart
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/sha_valid
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA0/sha_done_tmp

add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/O0/rst_n
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/O0/clk
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/O0/sha_in
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/O0/key
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/O0/start
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/O0/out_to_sha
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/O0/sah_start
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/O0/i
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/O0/output_index

add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/clk
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/rst_n
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/data_in
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/restart
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/valid
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/sha_ready
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/hash_out
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/i
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/valid_r
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/word_to_be_generated
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/a
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/b
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/c
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/d
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/e
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/block_id
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/f0
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/f1
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/f2
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/f3
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/temp
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/start_gen
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/H0_next
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/H1_next
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/H2_next
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/H3_next
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/H4_next
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/current_state
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/next_state
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/next_worgen0
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/UNIT_HMAC_SHA1/SHA1/round

TreeUpdate [SetDefaultTree]

update

#run -all