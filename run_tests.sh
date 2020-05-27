#!/bin/bash
# A script to run the basic ensemble tests
# Includes 1, 2, and 3D poisson, square lattice
# and 1D RSA at phi = 0.6 and phi = 0.72 (if --full passed)

cd "./test"

# https://www.cyberciti.biz/faq/howto-check-if-a-directory-exists-in-a-bash-shellscript/
# https://stackoverflow.com/questions/13553173/whats-the-meaning-of-the-operator-in-linux-shell
# Also ubuntu default crontab

# Square lattice
TESTDIR=2D_square_lattice
echo "running 2D square lattice tests"
[ -d "$TESTDIR" ] || mkdir $TESTDIR
[ -d "$TESTDIR/data" ] || mkdir $TESTDIR/data

for i in {0..9}; do
    ./gen_square_lat 5 > $TESTDIR/data/config$i.dat
done

../compute_nn -c 3.0 -n 30 -s 100000 --cycles 100 $TESTDIR/data/config{0..9}.dat > $TESTDIR/30bin.dat
../compute_nn -c 3.0 -n 120 -s 100000 --cycles 100 $TESTDIR/data/config{0..9}.dat > $TESTDIR/120bin.dat
../compute_nn -c 3.0 -n 480 -s 100000 -b 4 $TESTDIR/480bin_block.dat --cycles 100 $TESTDIR/data/config{0..9}.dat > $TESTDIR/480bin.dat
../compute_nn -c 3.0 -n 1920 -s 100000 -b 16 $TESTDIR/1920bin_block.dat --cycles 100 $TESTDIR/data/config{0..9}.dat > $TESTDIR/1920bin.dat

if [ "$1" = "--full" ]; then
    ../compute_nn -c 3.0 -n 7680 -s 10000 -b 64 $TESTDIR/7680bin_block.dat --cycles 1000 $TESTDIR/data/config{0..9}.dat > $TESTDIR/7680bin.dat
fi

echo "finished 2D square lattice tests"

# 1D poisson
TESTDIR=1D_poisson
echo "running 1D poisson tests"
[ -d "$TESTDIR" ] || mkdir $TESTDIR
[ -d "$TESTDIR/data" ] || mkdir $TESTDIR/data

for i in {0..999}; do 
    ./gen_poisson 1 10000 $TESTDIR/data/config$i &> /dev/null
done

../compute_nn -c 16.08495438637974 -n 30 -s 100000 $TESTDIR/data/config{0..999}.dat > $TESTDIR/30bin.dat
../compute_nn -c 16.08495438637974 -n 120 -s 100000 -b 4 $TESTDIR/120bin_block.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/120bin.dat
../compute_nn -c 16.08495438637974 -n 480 -s 100000 -b 16 $TESTDIR/480bin_block.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/480bin.dat
../compute_nn -c 16.08495438637974 -n 1920 -s 100000 -b 64 $TESTDIR/1920bin_block.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/1920bin.dat

../compute_nn -c 16.08495438637974 -n 480 -s 100000 -b 4 $TESTDIR/480bin_block2.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/480bin2.dat
../compute_nn -c 16.08495438637974 -n 1920 -s 100000 -b 16 $TESTDIR/1920bin_block2.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/1920bin2.dat

echo "finished 1D poisson tests"

# 2D poisson
TESTDIR=2D_poisson
echo "running 2D poisson tests"
[ -d "$TESTDIR" ] || mkdir $TESTDIR
[ -d "$TESTDIR/data" ] || mkdir $TESTDIR/data

for i in {0..999}; do 
    ./gen_poisson 2 10000 $TESTDIR/data/config$i &> /dev/null
done

../compute_nn -c 4.38178046004133 -n 30 -s 100000 $TESTDIR/data/config{0..999}.dat > $TESTDIR/30bin.dat
../compute_nn -c 4.38178046004133 -n 120 -s 100000 -b 4 $TESTDIR/120bin_block.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/120bin.dat
../compute_nn -c 4.38178046004133 -n 480 -s 100000 -b 16 $TESTDIR/480bin_block.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/480bin.dat
../compute_nn -c 4.38178046004133 -n 1920 -s 100000 -b 64 $TESTDIR/1920bin_block.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/1920bin.dat

../compute_nn -c 4.38178046004133 -n 480 -s 100000 -b 4 $TESTDIR/480bin_block2.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/480bin2.dat
../compute_nn -c 4.38178046004133 -n 1920 -s 100000 -b 16 $TESTDIR/1920bin_block2.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/1920bin2.dat

echo "finished 2D poisson tests"

# 3D poisson
TESTDIR=3D_poisson
echo "running 3D poisson tests"
[ -d "$TESTDIR" ] || mkdir $TESTDIR
[ -d "$TESTDIR/data" ] || mkdir $TESTDIR/data

for i in {0..999}; do 
    ./gen_poisson 3 10000 $TESTDIR/data/config$i &> /dev/null
done

../compute_nn -c 3.0 -n 30 -s 100000 $TESTDIR/data/config{0..999}.dat > $TESTDIR/30bin.dat
../compute_nn -c 3.0 -n 120 -s 100000 -b 4 $TESTDIR/120bin_block.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/120bin.dat
../compute_nn -c 3.0 -n 480 -s 100000 -b 16 $TESTDIR/480bin_block.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/480bin.dat
../compute_nn -c 3.0 -n 1920 -s 100000 -b 64 $TESTDIR/1920bin_block.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/1920bin.dat

../compute_nn -c 3.0 -n 480 -s 100000 -b 4 $TESTDIR/480bin_block2.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/480bin2.dat
../compute_nn -c 3.0 -n 1920 -s 100000 -b 16 $TESTDIR/1920bin_block2.dat $TESTDIR/data/config{0..999}.dat > $TESTDIR/1920bin2.dat

echo "finished poisson 3d tests"

# 1D RSA phi = 0.6
TESTDIR=1D_RSA
echo "running 1D RSA tests"
[ -d "$TESTDIR" ] || mkdir $TESTDIR
[ -d "$TESTDIR/data" ] || mkdir $TESTDIR/data

for i in {0..1999}; do 
    ./1d_rsa 10000 0.6 $TESTDIR/data/config$i &> /dev/null
done

../compute_nn -c "1.8e-4" -n 30 -s 100000 $TESTDIR/data/config{0..1999}.dat > $TESTDIR/30bin.dat
../compute_nn -c "1.8e-4" -n 120 -s 100000 $TESTDIR/data/config{0..1999}.dat > $TESTDIR/120bin.dat
../compute_nn -c "1.8e-4" -n 480 -s 100000 -b 4 $TESTDIR/480bin_block.dat $TESTDIR/data/config{0..1999}.dat > $TESTDIR/480bin.dat
../compute_nn -c "1.8e-4" -n 1920 -s 100000 -b 16 $TESTDIR/1920bin_block.dat $TESTDIR/data/config{0..1999}.dat > $TESTDIR/1920bin.dat


echo "finished 1D RSA tests"
TESTDIR=1D_RSA_long
# 1D RSA phi = 0.72
# https://stackoverflow.com/questions/2237080/how-to-compare-strings-in-bash
if [ "$1" == "--full" ]; then
    echo "running long 1D RSA tests"
    [ -d "$TESTDIR" ] || mkdir $TESTDIR
    [ -d "$TESTDIR/data" ] || mkdir $TESTDIR/data
    
    for i in {0..19999}; do 
        ./1d_rsa 10000 0.72 $TESTDIR/data/config$i &> /dev/null
    done

    ../compute_nn -c "2.16e-4" -n 30 -s 100000 $TESTDIR/data/config{0..19999}.dat > $TESTDIR/30bin.dat
    ../compute_nn -c "2.16e-4" -n 120 -s 100000 $TESTDIR/data/config{0..19999}.dat > $TESTDIR/120bin.dat
    ../compute_nn -c "2.16e-4" -n 480 -s 100000 -b 4 $TESTDIR/480bin_block.dat $TESTDIR/data/config{0..19999}.dat > $TESTDIR/480bin.dat
    ../compute_nn -c "2.16e-4" -n 1920 -s 100000 -b 16 $TESTDIR/1920bin_block.dat $TESTDIR/data/config{0..19999}.dat > $TESTDIR/1920bin.dat

    echo "finished long 1D_RSA tests"
fi

echo "Finished running all tests."
echo "Remember that this script DOES NOT check that the tests actually pass,"
echo "so plot the output and check for validity!"
