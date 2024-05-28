import argparse
import subprocess

parser = argparse.ArgumentParser()
parser.add_argument("--type")
subparsers = parser.add_subparsers()
s3_parser = subparsers.add_parser('s3')
s3_parser.add_argument('--file')
s3_parser.add_argument('--bucket')
s3_parser.add_argument('--key')
args = parser.parse_args("--type 123 s3 --bucket new".split())

print(args)

print(subprocess.check_output(['fakljsdfhjkasdf']))
