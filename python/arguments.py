import argparse
import re

# Init object
PARSER = argparse.ArgumentParser(description="Briefcam Benchamark cli tool")

# Add the parameters
# PARSER.add_argument("--value", "-v", default="OD", required=False)
# PARSER.add_argument("--check_db", type=bool, default=False)
# PARSER.add_argument("--number", "-n", type=int, default=10)
PARSER.add_argument("--activate", "-a", action="store_true", help="Number")


# Store all parameters into variable
args = PARSER.parse_args(["-a"])
print(args.activate)