#!/bin/bash

tmp_file="rdf.ttl"
output_file="output.ttl"
jar_location="bin/realization-wrapper-hermit-jfact-1.1.jar"

# get the data from stdin
input=$(cat)

# save the data to a temp. file
echo "$input" > "$tmp_file"

# run the reasoner with hermit option, redirect stdout to stderr
java -jar $jar_location $tmp_file $output_file hermit >&2

# print the output
cat $output_file

rm "$tmp_file" "$output_file"

