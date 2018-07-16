#!/usr/bin/python
import time
import os
import argparse
from subprocess import call

from joblib import Parallel, delayed
import multiprocessing

def bispatch(filename):
    if args.verbose:
        print("bspatch {} {} {}".format(args.orig + filename,\
                args.new + filename, args.patch + filename))
    call(['bspatch', args.orig + filename, args.new+ filename, args.patch + filename])
 
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
    Parallel(n_jobs=num_cores)(delayed(bispatch)(i) for i in os.listdir(args.orig))
    """
    pool = multiprocessing.Pool(num_cores)
    results = [] 
    for filename in os.listdir(args.orig):
        results.append(pool.apply_async(bisdiff, filename))
    """
     
