#!/bin/bash

# temporary files, to be removed 
tmp_file="tmp_file.html"
distilled_tmp_file="distilled_tmp_file.html"

# path to the python interpreter (TODO: modify, the venv is not in the root directory)
# python_path="kimeds_env/bin/python3"
python_path="kimeds_env/bin/python3.11"

# get the HTML (RDFa) from stdin
input=$(cat)


echo "$input" > "$tmp_file"
$python_path rdf_distiller.py $tmp_file $distilled_tmp_file
cat "$distilled_tmp_file"

# remove temporary files
rm "$tmp_file" "$distilled_tmp_file"

