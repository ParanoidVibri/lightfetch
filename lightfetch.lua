#!/usr/bin/env lua

local username = os.getenv("USER")
local kernel_version = io.popen("uname -r", "r"):read("*a")
local operating_system = io.popen("lsb_release -sd", "r"):read("*a"):gsub("%\n", "")
local architecture = io.popen("uname -m", "r"):read("*a"):gsub("%\n", "")
local used_memory = io.popen("free -m | awk '/Mem/{printf(\"%.2f\", $3/1024)}'", "r"):read("*a")
local total_memory = io.popen("free -m | awk '/Mem/{printf(\"%.2f\", $2/1024)}'", "r"):read("*a")
local cpu_name = io.popen("lscpu | awk -F: '/Model name/ {gsub(/^ +/, \"\", $2); print $2}'", "r"):read("*a"):gsub("%\n", "")
local cpu_cores = io.popen("lscpu | grep \"Core(s) per socket\" | awk '{print $4}'", "r"):read("*a")
local cpu_threads = io.popen("nproc", "r"):read("*a")
local gpu_info = io.popen("nvidia-smi --query-gpu=gpu_name --format=csv,noheader 2>/dev/null || lspci | grep -i \"vga\" | awk '{ for(i=0; i<=NF; i++) { if($i ~ /^[0-9a-fA-F]{4}:[0-9a-fA-F]{2}:[0-9a-fA-F]{2}.[0-9a-fA-F]$/) { print $(i+1); exit } } }' | cut -d ' ' -f1", "r"):read("*a"):gsub("%\n", "")

print("\27[31mUsername:\27[0m            " .. username)
print("\27[31mKernel Version:\27[0m      " .. kernel_version)
print("\27[33mOperating System:\27[0m    " .. operating_system)
print("\27[33mArchitecture:\27[0m        " .. architecture)
print("\27[33mUsed Memory:\27[0m         " .. used_memory .. " GB")
print("\27[33mTotal Memory:\27[0m        " .. total_memory .. " GB")
print("\27[32mCPU Model:\27[0m           " .. cpu_name)
print("\27[36mCPU Cores:\27[0m           " .. cpu_cores)
print("\27[34mCPU Threads:\27[0m         " .. cpu_threads)
print("\27[34m\27[1mGPU:\27[0m \27[34m\27[22m                 " .. gpu_info)

