#!/bin/bash
# A script to run the basic ensemble tests
# Includes 1, 2, and 3D poisson, square lattice
# and 1D RSA at phi = 0.6 and phi = 0.72 (if --full passed)

cd "./test"

# https://www.cyberciti.biz/faq/howto-check-if-a-directory-exists-in-a-bash-shellscript/
# https://stackoverflow.com/questions/13553173/whats-the-meaning-of-the-operator-in-linux-shell
# Also ubuntu default crontab

# Square lattice
echo "running 2D square lattice tests"
[ -d "2D_square_lattice" ] || mkdir 2D_square_lattice
[ -d "2D_square_lattice/data" ] || mkdir 2D_square_lattice/data

for i in {0..9}; do
    ./gen_square_lat 5 > 2D_square_lattice/data/config$i.dat
done

../compute_nn -c 3.0 -n 30 -s 100000 --cycles 100 2D_square_lattice/data/config{0..9}.dat > 2D_square_lattice/30bin.dat
../compute_nn -c 3.0 -n 120 -s 100000 --cycles 100 2D_square_lattice/data/config{0..9}.dat > 2D_square_lattice/120bin.dat
../compute_nn -c 3.0 -n 480 -s 100000 -b 4 2D_square_lattice/480bin_block.dat --cycles 100 2D_square_lattice/data/config{0..9}.dat > 2D_square_lattice/480bin.dat
../compute_nn -c 3.0 -n 1920 -s 100000 -b 16 2D_square_lattice/1920bin_block.dat --cycles 100 2D_square_lattice/data/config{0..9}.dat > 2D_square_lattice/1920bin.dat

if [ "$1" = "--full" ]; then
    ../compute_nn -c 3.0 -n 7680 -s 10000 -b 64 2D_square_lattice/7680bin_block.dat --cycles 1000 2D_square_lattice/data/config{0..9}.dat > 2D_square_lattice/7680bin.dat
fi

echo "finished 2D square lattice tests"

# 1D poisson
echo "running 1D poisson tests"
[ -d "1D_poisson" ] || mkdir 1D_poisson
[ -d "1D_poisson/data" ] || mkdir 1D_poisson/data

for i in {0..999}; do 
    ./gen_poisson 1 10000 1D_poisson/data/config$i &> /dev/null
done

../compute_nn -c 16.08495438637974 -n 30 -s 100000 1D_poisson/data/config{0..999}.dat > 1D_poisson/30bin.dat
../compute_nn -c 16.08495438637974 -n 120 -s 100000 -b 4 1D_poisson/120bin_block.dat 1D_poisson/data/config{0..999}.dat > 1D_poisson/120bin.dat
../compute_nn -c 16.08495438637974 -n 480 -s 100000 -b 16 1D_poisson/480bin_block.dat 1D_poisson/data/config{0..999}.dat > 1D_poisson/480bin.dat
../compute_nn -c 16.08495438637974 -n 1920 -s 100000 -b 64 1D_poisson/1920bin_block.dat 1D_poisson/data/config{0..999}.dat > 1D_poisson/1920bin.dat

../compute_nn -c 16.08495438637974 -n 480 -s 100000 -b 4 1D_poisson/480bin_block2.dat 1D_poisson/data/config{0..999}.dat > 1D_poisson/480bin2.dat
../compute_nn -c 16.08495438637974 -n 1920 -s 100000 -b 16 1D_poisson/1920bin_block2.dat 1D_poisson/data/config{0..999}.dat > 1D_poisson/1920bin2.dat

echo "finished 1D poisson tests"

# 2D poisson
echo "running 2D poisson tests"
[ -d "2D_poisson" ] || mkdir 2D_poisson
[ -d "2D_poisson/data" ] || mkdir 2D_poisson/data

for i in {0..999}; do 
    ./gen_poisson 2 10000 2D_poisson/data/config$i &> /dev/null
done

../compute_nn -c 4.38178046004133 -n 30 -s 100000 2D_poisson/data/config{0..999}.dat > 2D_poisson/30bin.dat
../compute_nn -c 4.38178046004133 -n 120 -s 100000 -b 4 2D_poisson/120bin_block.dat 2D_poisson/data/config{0..999}.dat > 2D_poisson/120bin.dat
../compute_nn -c 4.38178046004133 -n 480 -s 100000 -b 16 2D_poisson/480bin_block.dat 2D_poisson/data/config{0..999}.dat > 2D_poisson/480bin.dat
../compute_nn -c 4.38178046004133 -n 1920 -s 100000 -b 64 2D_poisson/1920bin_block.dat 2D_poisson/data/config{0..999}.dat > 2D_poisson/1920bin.dat

../compute_nn -c 4.38178046004133 -n 480 -s 100000 -b 4 2D_poisson/480bin_block2.dat 2D_poisson/data/config{0..999}.dat > 2D_poisson/480bin2.dat
../compute_nn -c 4.38178046004133 -n 1920 -s 100000 -b 16 2D_poisson/1920bin_block2.dat 2D_poisson/data/config{0..999}.dat > 2D_poisson/1920bin2.dat

echo "finished 2D poisson tests"

# 3D poisson
echo "running 3D poisson tests"
[ -d "3D_poisson" ] || mkdir 3D_poisson
[ -d "3D_poisson/data" ] || mkdir 3D_poisson/data

for i in {0..999}; do 
    ./gen_poisson 3 10000 3D_poisson/data/config$i &> /dev/null
done

../compute_nn -c 3.0 -n 30 -s 100000 3D_poisson/data/config{0..999}.dat > 3D_poisson/30bin.dat
../compute_nn -c 3.0 -n 120 -s 100000 -b 4 3D_poisson/120bin_block.dat 3D_poisson/data/config{0..999}.dat > 3D_poisson/120bin.dat
../compute_nn -c 3.0 -n 480 -s 100000 -b 16 3D_poisson/480bin_block.dat 3D_poisson/data/config{0..999}.dat > 3D_poisson/480bin.dat
../compute_nn -c 3.0 -n 1920 -s 100000 -b 64 3D_poisson/1920bin_block.dat 3D_poisson/data/config{0..999}.dat > 3D_poisson/1920bin.dat

../compute_nn -c 3.0 -n 480 -s 100000 -b 4 3D_poisson/480bin_block2.dat 3D_poisson/data/config{0..999}.dat > 3D_poisson/480bin2.dat
../compute_nn -c 3.0 -n 1920 -s 100000 -b 16 3D_poisson/1920bin_block2.dat 3D_poisson/data/config{0..999}.dat > 3D_poisson/1920bin2.dat

echo "finished poisson 3d tests"

# 1D RSA phi = 0.6
echo "running 1D RSA tests"
[ -d "1D_RSA" ] || mkdir 1D_RSA
[ -d "1D_RSA/data" ] || mkdir 1D_RSA/data

for i in {0..1999}; do 
    ./1d_rsa 10000 0.6 1D_RSA/data/config$i &> /dev/null
done

../compute_nn -c "1.8e-4" -n 30 -s 100000 1D_RSA/data/config{0..1999}.dat > 1D_RSA/30bin.dat
../compute_nn -c "1.8e-4" -n 120 -s 100000 1D_RSA/data/config{0..1999}.dat > 1D_RSA/120bin.dat
../compute_nn -c "1.8e-4" -n 480 -s 100000 -b 4 1D_RSA/480bin_block.dat 1D_RSA/data/config{0..1999}.dat > 1D_RSA/480bin.dat
../compute_nn -c "1.8e-4" -n 1920 -s 100000 -b 16 1D_RSA/1920bin_block.dat 1D_RSA/data/config{0..1999}.dat > 1D_RSA/1920bin.dat


echo "finished 1D RSA tests"
# 1D RSA phi = 0.72
# https://stackoverflow.com/questions/2237080/how-to-compare-strings-in-bash
if [ "$1" == "--full" ]; then
    echo "running long 1D_RSA tests"
    [ -d "1D_RSA_long" ] || mkdir 1D_RSA_long
    [ -d "1D_RSA_long/data" ] || mkdir 1D_RSA_long/data
    
    for i in {0..19999}; do 
        ./1d_rsa 10000 0.72 1D_RSA_long/data/config$i &> /dev/null
    done

    ../compute_nn -c "2.16e-4" -n 30 -s 100000 1D_RSA_long/data/config{0..19999}.dat > 1D_RSA_long/30bin.dat
    ../compute_nn -c "2.16e-4" -n 120 -s 100000 1D_RSA_long/data/config{0..19999}.dat > 1D_RSA_long/120bin.dat
    ../compute_nn -c "2.16e-4" -n 480 -s 100000 -b 4 1D_RSA_long/480bin_block.dat 1D_RSA_long/data/config{0..19999}.dat > 1D_RSA_long/480bin.dat
    ../compute_nn -c "2.16e-4" -n 1920 -s 100000 -b 16 1D_RSA_long/1920bin_block.dat 1D_RSA_long/data/config{0..19999}.dat > 1D_RSA_long/1920bin.dat

    echo "finished long 1D_RSA tests"
fi

echo "Finished running all tests."
echo "Remember that this script DOES NOT check that the tests actually pass,"
echo "so plot the output and check for validity!"
