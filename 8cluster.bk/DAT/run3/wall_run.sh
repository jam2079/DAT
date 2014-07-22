#!/bin/bash

qsub wrun.sh 1
sleep 5
qsub wrun.sh 2
sleep 5
qsub wrun.sh 3
sleep 5
qsub wrun.sh 4
sleep 5
qstat
