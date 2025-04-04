@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Mon Mar 10 16:12:02 +0530 2025
REM SW Build 2552052 on Fri May 24 14:49:42 MDT 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
echo "xsim Single_Cycle_Processor_tb_behav -key {Behavioral:sim_1:Functional:Single_Cycle_Processor_tb} -tclbatch Single_Cycle_Processor_tb.tcl -log simulate.log"
call xsim  Single_Cycle_Processor_tb_behav -key {Behavioral:sim_1:Functional:Single_Cycle_Processor_tb} -tclbatch Single_Cycle_Processor_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
