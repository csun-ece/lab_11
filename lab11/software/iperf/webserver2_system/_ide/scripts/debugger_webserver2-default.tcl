# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/danny/class/labs/lab11/software/iperf/webserver2_system/_ide/scripts/debugger_webserver2-default.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/danny/class/labs/lab11/software/iperf/webserver2_system/_ide/scripts/debugger_webserver2-default.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo Z7 210351AF24E5A" && level==0 && jtag_device_ctx=="jsn-Zybo Z7-210351AF24E5A-13722093-0"}
fpga -file /home/danny/class/labs/lab11/software/iperf/webserver2/_ide/bitstream/webserver_fwm_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/danny/class/labs/lab11/software/iperf/webserver_fwm_wrapper/export/webserver_fwm_wrapper/hw/webserver_fwm_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source /home/danny/class/labs/lab11/software/iperf/webserver2/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow /home/danny/class/labs/lab11/software/iperf/webserver2/Debug/webserver2.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
