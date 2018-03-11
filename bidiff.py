#!/usr/bin/python
import time
import os
import argparse
from subprocess import call

from joblib import Parallel, delayed
import multiprocessing

def bisdiff(filename):
    if args.verbose:
        print("bsdiff {} {} {}".format(args.orig + filename,\
                args.new + filename, args.patch + filename))
    call(['bsdiff', args.orig + filename, args.new + filename, args.patch + filename])
 
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--orig',
        type=str,
        help="Original directory")
    parser.add_argument(
        '--new',
        type=str,
        help="Latest directory")
    parser.add_argument(
        '--patch',
        type=str,
        help="Patched directory")
    parser.add_argument('--verbose', action='store_true')
    global args
    args = parser.parse_args()

    num_cores = multiprocessing.cpu_count()
    Parallel(n_jobs=num_cores)(delayed(bisdiff)(i) for i in os.listdir(args.orig))
     
