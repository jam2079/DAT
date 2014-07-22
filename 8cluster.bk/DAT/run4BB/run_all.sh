#!/bin/bash/

for i in CA BB SC;
	do 
	#qsub -t 1-57 run_plot.sh 1$i
	qsub -t 1-57 run_plot.sh 2$i
	qsub -t 1-71 run_plot.sh 3$i
	qsub -t 1-39 run_plot.sh 4$i
done

	qsub -t 1-57 run_plot.sh 1
	qsub -t 1-57 run_plot.sh 2
	qsub -t 1-71 run_plot.sh 3
	qsub -t 1-39 run_plot.sh 4


