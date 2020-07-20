#!/bin/bash
# A series of tests to compare various 1D methods of computing
# nearest neighbor functions. Assumes one has already run run_tests.sh, but not necessarily
# the particle script or the long version of run_tests.sh

cd "./test"

# https://www.cyberciti.biz/faq/howto-check-if-a-directory-exists-in-a-bash-shellscript/
# https://stackoverflow.com/questions/13553173/whats-the-meaning-of-the-operator-in-linux-shell
# Also ubuntu default crontab

# 1D Poisson
# https://stackoverflow.com/questions/14612371/how-do-i-run-multiple-background-commands-in-bash-in-a-single-line
(
TESTDIR=1D_poisson
echo "running 1D poisson tests"

../compute_nn_exact -c 5.0 -n 500 -d 10 $TESTDIR/exact_gap_drop.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/exact_gap.dat
../finite_series -c 5.0 -n 500 -o 1 $TESTDIR/data/config{0..999}.dat > $TESTDIR/exact_finite_1.dat
../finite_series_brute_force -c 5.0 -n 500 -o 1 $TESTDIR/data/config{0..999}.dat > $TESTDIR/exact_finite_bf_1.dat
../finite_series -c 5.0 -n 500 -o 2 $TESTDIR/data/config{0..999}.dat > $TESTDIR/exact_finite_2.dat
../finite_series_brute_force -c 5.0 -n 500 -o 2 $TESTDIR/data/config{0..999}.dat > $TESTDIR/exact_finite_bf_2.dat
../finite_series -c 5.0 -n 500 -o 3 $TESTDIR/data/config{0..999}.dat > $TESTDIR/exact_finite_3.dat
../finite_series_brute_force -c 5.0 -n 500 -o 3 $TESTDIR/data/config{0..999}.dat > $TESTDIR/exact_finite_bf_3.dat
../finite_series -c 5.0 -n 500 $TESTDIR/data/config{0..999}.dat > $TESTDIR/exact_finite_all.dat

echo "finished 1D poisson tests"
) &

# 1D saturated RSA tests
(
TESTDIR=1D_RSA_SAT
echo "running 1D saturated RSA tests"
[ -d "$TESTDIR" ] || mkdir $TESTDIR
[ -d "$TESTDIR/data" ] || mkdir $TESTDIR/data

for i in {0..99}; do 
    ./1d_rsa_sat 10000 $TESTDIR/data/config$i
done

../compute_nn -n 100 -c 2.0 -s 1000000 --cycles 10 -d 10 $TESTDIR/sample_100bin_drop.dat $TESTDIR/data/config{0..99}.dat > $TESTDIR/sample_100bin.dat
../compute_nn -n 200 -c 2.0 -s 1000000 --cycles 10 -d 10 $TESTDIR/sample_200bin_drop.dat -b 2 $TESTDIR/sample_200bin_block.dat $TESTDIR/data/config{0..99}.dat > $TESTDIR/sample_200bin.dat
../compute_nn -n 400 -c 2.0 -s 1000000 --cycles 10 -d 10 $TESTDIR/sample_400bin_drop.dat -b 4 $TESTDIR/sample_400bin_block.dat $TESTDIR/data/config{0..99}.dat > $TESTDIR/sample_400bin.dat
../compute_nn_exact -c 2.0 -n 200 -d 10 $TESTDIR/exact_gap_drop.dat $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_gap.dat
../finite_series -c 2.0 -n 200 -o 1 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_1.dat
../finite_series_brute_force -c 2.0 -n 200 -o 1 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_bf_1.dat
../finite_series -c 2.0 -n 200 -o 2 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_2.dat
../finite_series_brute_force -c 2.0 -n 200 -o 2 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_bf_2.dat
../finite_series -c 2.0 -n 200 -o 3 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_3.dat
../finite_series_brute_force -c 2.0 -n 200 -o 3 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_bf_3.dat
../finite_series -c 2.0 -n 200 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_all.dat

echo "finished 1D saturated RSA tests"
) &

# 1D RSA phi = 0.6
# Runs on only part of data by design, to save time
(
TESTDIR=1D_RSA
echo "running 1D non-saturated RSA tests"

../compute_nn_exact -c "1.8e-4" -n 480 -d 10 $TESTDIR/exact_gap_drop.dat $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_gap.dat
../finite_series -c "1.8e-4" -n 480 -o 1 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_1.dat
../finite_series_brute_force -c "1.8e-4" -n 480 -o 1 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_bf_1.dat
../finite_series -c "1.8e-4" -n 480 -o 2 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_2.dat
../finite_series_brute_force -c "1.8e-4" -n 480 -o 2 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_bf_2.dat
../finite_series -c "1.8e-4" -n 480 -o 3 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_3.dat
../finite_series_brute_force -c "1.8e-4" -n 480 -o 3 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_bf_3.dat
../finite_series -c "1.8e-4" -n 480 $TESTDIR/data/config{0..99}.dat > $TESTDIR/exact_finite_all.dat

echo "finished 1D non-saturated RSA tests"
) &
