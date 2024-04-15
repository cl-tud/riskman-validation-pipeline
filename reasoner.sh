#!/bin/bash

tmp_file="rdf.ttl"
jar_location="bin/owl-cli-snapshot.jar"

# get the data from stdin
input=$(cat)

# save the data to a temp. file
echo "$input" > "$tmp_file"

# run the reasoner
output="$(java -jar $jar_location infer $tmp_file)"

# print the output, remove the 1st line about debugging
echo -e "$output" | tail -n +2

rm "$tmp_file"

