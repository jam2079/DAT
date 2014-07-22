#!/bin/bash

qsub run.sh 1
sleep 5
qsub run.sh 2
sleep 5
qsub run.sh 3
sleep 5
qsub run.sh 4
sleep 5
qstat
