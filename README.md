# nn_scripts

Author: Claire Middlemas

A script to compute nearest-neighbor functions and a collection
of scripts to help test the output

I heavily used Ge Zhang's C++ code and many previous Torquato
group papers in designing this code. This code was developed during my
time at Princeton University in the Torquato Group.

The script run_tests.sh will make a bunch of simple ensembles
and run compute_nn for four different bin sizes on each, for comparison
to analytical results computed in Mathematica for all but the rsa case,
which you will have to consult the original literature to check. Passing
the --full flag will also run the phi = 0.72 rsa case and a fifth
bin size on the square lattice case, which takes more time. You can
find the analytical results in the test/analytical directory,
and all the files in there were computed by the analytical_nn.nb
Mathematica notebook. The script run_tests_particle.sh does the same, but
for the particle quantities.

For the square lattice case, see the paper Torquato, PRE 82, 056109 (2010).
For the rsa case, see the paper by Rintoul, Torquato, and Tarjus, PRE 53, 450 (1996).

You are responsible for checking these and plotting them to ensure they
make sense, as it would be somewhat time consuming to make these
tests fully automated. The purpose is just to reduce the boilerplate needed
for a new user to get a testing workflow set up.
