#!/bin/bash

mount_memory() {
    if ! [ $# -eq 2 ]; then
        echo 'in this function, there will be two parameters, which are:'
        echo '1. the path of to mount'
        echo '2. the amount of memory'
        exit 1
    fi

    sudo mkdir $1
    sudo mount -t tmpfs -o size=$2 tmpfs $1
}

unmount_memory() {
    if ! [ $# -eq 1 ]; then
        echo 'in this function, there will be one parameters, which are:'
        echo '1. the path of to mount'
        exit 1
    fi

    sudo umount $1
}
