#!/usr/bin/python
import os
import argparse
from subprocess import call
from joblib import Parallel, delayed
import multiprocessing

def xdelta_patch(args, filename):
    if args.verbose:
        print("xdelta patch {} {} {}".format(args.patch + filename,\
            args.orig + filename, args.new + filename))
    call(['xdelta', 'patch', args.patch + filename,\
        args.orig + filename, args.new + filename])
 
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
    Parallel(n_jobs=num_cores)(delayed(xdelta_patch)(args, i) for i in os.listdir(args.orig))
    #for f in os.listdir(args.orig):
    #    xdelta_patch(args, f)
     
