ip:
	vitis_hls -f make_hls_fft_ip.tcl

bd:
	vivado -mode batch -source make_vivado_bd.tcl

all: ip bd
