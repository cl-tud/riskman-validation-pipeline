#!/bin/bash

# path to the python interpreter (TODO: modify, the venv is not in the root directory)
# python_path="kimeds_env/bin/python3"
# python_path="kimeds_env/bin/python3.11"
python_path="kimeds_env/bin/python"

prob=""
sev=""

while getopts ":p:s:" opt; do
  case ${opt} in
    p )
      prob=$OPTARG
      ;;
    s )
      sev=$OPTARG
      ;;
  esac
done
shift $((OPTIND -1))


# distilled RDF from stdin
input_triples=$(cat)

# output="$($python_path prob_sev.py $prob $sev)"
output="$($python_path prob_sev.py $prob $sev)"


echo -e "$input_triples\n\n$output"
