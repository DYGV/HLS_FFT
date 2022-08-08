# HLS_FFT
## Overview
This repository contains HLS code that calls the [Xilinx FFT IP core](https://www.xilinx.com/products/intellectual-property/fft.html) from the [FFT library](https://docs.xilinx.com/r/en-US/ug1399-vitis-hls/FFT-IP-Library) and a `Python` program to handle it.  
The following environments were tested:
- Vivado 2022.1
- Vitis HLS 2022.1
- PYNQ-Z1 (PYNQ 2.5)
## HLS design
Data input/output is mainly as follows:  
- The top function 
    ```C
    void hls_fft(fft_stream &input, fft_stream &output, unsigned size)
    ```
- The circuit is driven by the `CTRL` register(offset 0x00)  

- The `size` register(offset 0x10) can be set to a value of 3\~10 ( $2^3$ ~ $2^{10}$-Point FFT )  
    If you want to set more than that, change `TWO_TO_THE_POWER_OF_N_MAX` in the header file. The [Xilinx FFT IP core](https://www.xilinx.com/products/intellectual-property/fft.html) allows $2^3$ ~ $2^{16}$-Point FFT.
- Data is transferred by `DMA` using the `AXI4-Stream` interface  
- The FPGA logic input/output types can be [`numpy.csingle(float complex)`](https://numpy.org/doc/stable/reference/arrays.scalars.html#numpy.csingle) or [`numpy.single(float)`](https://numpy.org/doc/stable/reference/arrays.scalars.html#numpy.single)  
    The default input/output is a `float complex`. You can switch between them by manipulating the `#define` directive in the header file.  
    **Xilinx FFT IP core performs inputs and outputs with `float complex` types. Therefore, note that using `float` for inputs and outputs in FPGA logic (Uncomment `USE_FLOAT` in header file) requires type conversion in the FPGA logic, which may result in performance degradation.**  

![io](https://user-images.githubusercontent.com/8480644/183457008-fcb3c22d-aea1-4291-a0e7-748091fe721e.PNG)


## Vivado Block Design
After high-level synthesis, the block design is as follows:
![block](https://user-images.githubusercontent.com/8480644/183441207-d22848ae-bcbf-4800-b742-3c119c09491a.PNG)

## Hardware Driver
You can see how it works from [this notebook](./jupyter_notebook/FFT_from_PYNQ_library.ipynb).
