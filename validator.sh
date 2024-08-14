#!/bin/bash

data_graph_file="data_graph.ttl"
pyshacl_location="kimeds_env/bin/pyshacl"

# input from stdin
input=$(cat)

# shapes location is the 1st parameter
shapes_location="$1"

echo "$input" > "$data_graph_file"

# run the validator
output="$($pyshacl_location -s $shapes_location $data_graph_file -f json-ld)" # "json-ld by" default. Other alternatives: human,turtle,xml,json-ld,nt,n3
echo -e "$output"

# remove temp. file
rm "$data_graph_file"

