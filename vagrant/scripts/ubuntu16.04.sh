#!/bin/bash

if [ ! -e /home/vagrant/.provision.txt ] ; then
    apt-get update
    apt-get install --yes lsb-release
    touch /home/vagrant/.provision.txt
fi

