#!/usr/bin/env python3
# Run a program and print the colorized backtrace.
import argparse
import re
import subprocess
import sys
from termcolor import colored


def ColourBacktraceLine(line):
    match = re.search(r'(.*?at\s*)(\S+)(\s*:\s*)(\d+)(.*)', line, flags=re.DOTALL)
    if (match):
        prefix, filename, colon, lineno, suffix = match.groups()
        return ''.join((prefix, colored(filename, 'green'), colon,
                        colored(lineno, 'yellow'), suffix))
    else:
        return line


def PrettyPrintBacktrace(stream):
    return ''.join(map(ColourBacktraceLine, stream))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Pretty-print the stack trace of a crashing program. "
                    "Creates a backtrace with GDB then colourizes it.")
    parser.add_argument('program', help='Program to run.', type=str)
    args = parser.parse_args()

    gdbArgs = ['gdb', '-batch', '-ex', 'run', '-ex', 'bt', args.program]
    with subprocess.Popen(
            gdbArgs, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
            universal_newlines=True) as p:
        sys.stdout.write(PrettyPrintBacktrace(p.stdout))
