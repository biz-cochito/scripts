#!/usr/bin/python3

import psutil
import argparse
from itertools import groupby

parser = argparse.ArgumentParser()

parser.add_argument("-g", help="group memory usage by application", action="count")
parser.add_argument("-a", help="view all processes", action="count")
parser.add_argument("-f", help="print full program path", action="count")
parser.add_argument("-p", help="print grouped processes details", action="count")

args = parser.parse_args()

processes = psutil.process_iter()

# get info
memory_processes = []
for process in processes:
    if len(process.cmdline()) >= 1:
        memory_processes.append(
            [process.cmdline()[0], process.memory_info().rss / 1048576, process.pid]
        )

# process
if args.g:
    d = {}
    for [proc, mem, pid] in memory_processes:
        if proc not in d:
            d[proc] = [mem, [(pid, mem)], 1]
        else:
            i = d[proc]
            i[0] += mem
            i[1].append((pid, mem))
            i[2] += 1
    memory_processes = list(map(lambda x: [x] + d[x], d))

if not args.f:
    memory_processes = list(
        map(lambda x: [x[0].split("/")[-1]] + x[1:], memory_processes)
    )

memory_processes.sort(key=lambda x: x[1], reverse=True)

if not args.a:
    memory_processes = memory_processes[:10]

# output
sl_pad = len(str(len(memory_processes)))
for i, process in enumerate(memory_processes):
    sl_no = f"{i + 1:>{sl_pad}}."
    print(sl_no, end=" ")

    if not args.f and len(process[0]) > 30:
        process[0] = process[0][:27] + "..."

    print(f"{process[1]:.2f} MB", end="\t")

    if args.g:
        print(f"({str(process[3])})\t", end="")

    if not args.g:
        # single pid
        print(f"{process[2]}", end="\t")

    print(f"{process[0]:30}")

    if args.p and args.g:
        process[2].sort(key=lambda x: x[1], reverse=True)
        for pid, mem in process[2]:
            print(f"\t\t{pid}\t{mem:.2f} MB")
        print()
