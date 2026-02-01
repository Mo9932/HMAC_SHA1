vlib work
vlog *.*v

vsim -debugdb -fsmdebug HMAC_SHA_tb

add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/rst_n
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/clk
add wave -noupdate -expand -group HMAC_TOP -radix unsigned /HMAC_SHA_tb/DUT/key
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/t_valid
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/t_last
add wave -noupdate -expand -group HMAC_TOP -radix unsigned /HMAC_SHA_tb/DUT/t_data
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/t_ready
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/auth_done
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/auth_error
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/i
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/sel
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/data_2_sha_stg1
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/tag_pipe1
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/out_2_sha_stg2
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/out_to_sha
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/sha_stg1_done
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/hash_out_stg1
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/hash_out_stg2
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/sah_start
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA_tb/DUT/valid

add wave -noupdate -group ctrl /HMAC_SHA_tb/DUT/C0/rst_n
add wave -noupdate -group ctrl /HMAC_SHA_tb/DUT/C0/clk
add wave -noupdate -group ctrl /HMAC_SHA_tb/DUT/C0/t_last
add wave -noupdate -group ctrl /HMAC_SHA_tb/DUT/C0/sel

add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/U0/rst_n
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/U0/clk
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/U0/key
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/U0/start
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/U0/out_to_sha
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/U0/i
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/U0/cs
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/U0/ns
add wave -noupdate -group IPADD /HMAC_SHA_tb/DUT/U0/count_en

add wave -noupdate -group MUX /HMAC_SHA_tb/DUT/M0/sel
add wave -noupdate -group MUX /HMAC_SHA_tb/DUT/M0/A
add wave -noupdate -group MUX /HMAC_SHA_tb/DUT/M0/B
add wave -noupdate -group MUX /HMAC_SHA_tb/DUT/M0/O

add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/clk
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/rst_n
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/t_data
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/t_valid
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/t_last
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/t_ready
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/sha_done
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/hash_out
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/sha_ready
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/padded_data_out
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/start
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/restart
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/sha_valid
add wave -noupdate -group SHA0 /HMAC_SHA_tb/DUT/SHA0/sha_done_tmp

add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/O0/rst_n
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/O0/clk
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/O0/sha_in
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/O0/key
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/O0/start
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/O0/out_to_sha
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/O0/sah_start
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/O0/i
add wave -noupdate -group OPADD /HMAC_SHA_tb/DUT/O0/output_index

add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/clk
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/rst_n
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/data_in
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/restart
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/valid
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/sha_ready
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/hash_out
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/i
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/valid_r
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/word_to_be_generated
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/a
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/b
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/c
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/d
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/e
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/block_id
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/f0
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/f1
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/f2
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/f3
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/temp
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/start_gen
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/H0_next
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/H1_next
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/H2_next
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/H3_next
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/H4_next
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/current_state
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/next_state
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/next_worgen0
add wave -noupdate -group SHA1 /HMAC_SHA_tb/DUT/SHA1/round

TreeUpdate [SetDefaultTree]

update

#run -all