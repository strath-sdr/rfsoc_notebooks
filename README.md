<img src="strathclyde_banner.png" width="100%">

# RFSoC Introductory Notebooks
A collection of RFSoC introductory notebooks. This repository is only compatible with [PYNQ images v2.6](https://github.com/Xilinx/PYNQ/releases) for the [ZCU111](https://www.xilinx.com/products/boards-and-kits/zcu111.html) and [RFSoC2x2](http://rfsoc-pynq.io/).

<img src="./nb_rf_data_converters.png" width="25%" align="left" />
<img src="./nb_rf_spectrum.png" width="25%" align="left" />
<img src="./nb_software_defined_radio.png" width="25%" />

## PYNQ Quick Start
The RFSoC notebooks can be installed on to your development board by running a simple line of code in a command terminal. **However, you will need to connect your board to the internet.** Follow the instructions below to install the notebooks now.
* Power on your RFSoC2x2 or ZCU111 development board with an SD Card containing a fresh PYNQ v2.6 image.
* Navigate to Jupyter Labs by opening a browser (preferably Chrome) and connecting to `http://<board_ip_address>:9090/lab`.
* We need to open a terminal in Jupyter Lab. Firstly, open a launcher window as shown in the figure below:

<p align="center">
  <img src="./open_jupyter_launcher.jpg" width="50%" height="50%" />
<p/>

* Now open a terminal in Jupyter as illustrated below:

<p align="center">
  <img src="./open_terminal_window.jpg" width="50%" height="50%" />
<p/>

* Now simply run the code below that will install the package to your system.

```sh
pip3 install git+https://github.com/strath-sdr/rfsoc_notebooks
```

Once installation has complete you will find the RFSoC notebooks in the Jupyter workspace directory. The folder will be named 'rfsoc-notebooks'.