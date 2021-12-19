#!/bin/bash


items=(
    256
    512
    1024
    2048
    4096
)

for msg in ${items[@]}; do
for ((i=10000;i<=100000;i+=10000)); do
PREFIX="${i}_${msg}"
step=0
while [ $step -lt 100 ]
do
    #tmp=`(time -f '%e' ./build/examples_rclcpp_minimal_publisher/publisher_counter)`
    #TIME=`(/usr/bin/time -f '%e' ./build/examples_rclcpp_minimal_publisher/publisher_counter 2>&1 1>/dev/null) 2>&1`
    TIME=`(/usr/bin/time -f '%e' ros2 run wasm_vm_node wasm_vm_node -f src/wasm_vm_node/rclwasm/nodes/counter/out/counter_${PREFIX}.wasm 2>&1 1>/dev/null) 2>&1`
    # time -f '%e' ./build/examples_rclcpp_minimal_publisher/publisher_counter
    if [[ $TIME =~ .*Command.* ]];then
        echo $TIME
    else
        step=`expr $step + 1`
        echo $TIME >> "wasm_${PREFIX}.log"
    fi
done
echo $PREFIX
done
done
