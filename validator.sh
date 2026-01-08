#!/bin/bash

data_graph_file="data_graph.ttl"
python_bin="kimeds_env/bin/python"

# input from stdin
input=$(cat)

# shapes location is the 1st parameter
shapes_location="$1"

echo "$input" > "$data_graph_file"

# run the validator
output="$($python_bin -m pyshacl -s $shapes_location $data_graph_file -f json-ld)" # "json-ld by" default. Other alternatives: human,turtle,xml,json-ld,nt,n3
echo -e "$output"

# remove temp. file
rm "$data_graph_file"

