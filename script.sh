#!/bin/bash

g++ -fPIC -c one.cpp
g++ -shared -o one.so one.o

swig -python -c++ -I. one.i
python-config --cflags
g++ -fPIC -c one_wrap.cxx $(python-config --cflags)
g++ -shared -o _one.so one_wrap.o -L. -lone
mkdir -p one
mv one.py one_wrap.cxx one_wrap.h _one.so one.h one.cpp one.i one/
touch one/__init__.py
cp setup.py one/
tar czvf one.tar.gz one/
rm -rf one
python setup.py sdist
