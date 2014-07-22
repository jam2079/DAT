#!/bin/bash/

for r in {1..4}
	do
	for m in {1..4}
		do
		sh 1_rundist_parallel.sh $r $m
	done
done

for r in 5 {11..18} {21..23}
	do
	sh 1_rundist_parallel.sh $r 1
done

