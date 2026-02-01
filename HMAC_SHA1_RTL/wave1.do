onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/rst_n
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/clk
add wave -noupdate -expand -group HMAC_TOP -radix unsigned /HMAC_SHA1_top/key
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/t_valid
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/t_last
add wave -noupdate -expand -group HMAC_TOP -radix unsigned /HMAC_SHA1_top/t_data
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/t_ready
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/sha_ready
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/sha_valid
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/auth_done
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/auth_error
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/i
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/t_valid_pipe
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/sel
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/data_2_sha_stg1
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/out_2_sha_stg2
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/out_to_sha
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/sha_stg1_done
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/hash_out_stg1
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/hash_out_stg2
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/last
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/sah_start
add wave -noupdate -expand -group HMAC_TOP /HMAC_SHA1_top/valid
add wave -noupdate -group ctrl /HMAC_SHA1_top/C0/rst_n
add wave -noupdate -group ctrl /HMAC_SHA1_top/C0/clk
add wave -noupdate -group ctrl /HMAC_SHA1_top/C0/t_last
add wave -noupdate -group ctrl /HMAC_SHA1_top/C0/last_padd
add wave -noupdate -group ctrl /HMAC_SHA1_top/C0/sel
add wave -noupdate -group IPADD /HMAC_SHA1_top/U0/rst_n
add wave -noupdate -group IPADD /HMAC_SHA1_top/U0/clk
add wave -noupdate -group IPADD /HMAC_SHA1_top/U0/key
add wave -noupdate -group IPADD /HMAC_SHA1_top/U0/start
add wave -noupdate -group IPADD /HMAC_SHA1_top/U0/out_to_sha
add wave -noupdate -group IPADD /HMAC_SHA1_top/U0/last
add wave -noupdate -group IPADD /HMAC_SHA1_top/U0/i
add wave -noupdate -group IPADD /HMAC_SHA1_top/U0/output_index
add wave -noupdate -group IPADD /HMAC_SHA1_top/U0/cs
add wave -noupdate -group IPADD /HMAC_SHA1_top/U0/ns
add wave -noupdate -group IPADD /HMAC_SHA1_top/U0/count_en
add wave -noupdate -group MUX /HMAC_SHA1_top/M0/sel
add wave -noupdate -group MUX /HMAC_SHA1_top/M0/A
add wave -noupdate -group MUX /HMAC_SHA1_top/M0/B
add wave -noupdate -group MUX /HMAC_SHA1_top/M0/O
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/clk
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/rst_n
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/t_data
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/t_valid
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/t_last
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/t_ready
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/sha_done
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/hash_out
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/sha_ready
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/padded_data_out
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/start
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/restart
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/sha_valid
add wave -noupdate -expand -group SHA0 /HMAC_SHA1_top/SHA0/sha_done_tmp
add wave -noupdate -group OPADD /HMAC_SHA1_top/O0/rst_n
add wave -noupdate -group OPADD /HMAC_SHA1_top/O0/clk
add wave -noupdate -group OPADD /HMAC_SHA1_top/O0/sha_in
add wave -noupdate -group OPADD /HMAC_SHA1_top/O0/key
add wave -noupdate -group OPADD /HMAC_SHA1_top/O0/start
add wave -noupdate -group OPADD /HMAC_SHA1_top/O0/out_to_sha
add wave -noupdate -group OPADD /HMAC_SHA1_top/O0/sah_start
add wave -noupdate -group OPADD /HMAC_SHA1_top/O0/i
add wave -noupdate -group OPADD /HMAC_SHA1_top/O0/output_index
add wave -noupdate -group OPADD /HMAC_SHA1_top/O0/cs
add wave -noupdate -group OPADD /HMAC_SHA1_top/O0/ns
add wave -noupdate -group OPADD /HMAC_SHA1_top/O0/count_en
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/clk
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/rst_n
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/data_in
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/restart
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/read_req
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/valid
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/sha_ready
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/hash_out
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/i
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/j
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/valid_r
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/word_index
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/word_to_be_generated
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/a
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/b
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/c
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/d
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/e
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/block_id
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/f0
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/f1
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/f2
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/f3
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/temp
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/done_reg
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/start_gen
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/output_index
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/H0_next
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/H1_next
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/H2_next
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/H3_next
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/H4_next
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/current_state
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/next_state
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/next_worgen0
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/round
add wave -noupdate -group SHA1 /HMAC_SHA1_top/SHA1/w_tmp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1299 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 232
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
WaveRestoreZoom {869 ns} {3332 ns}
