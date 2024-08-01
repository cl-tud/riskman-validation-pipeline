#!/bin/bash

#
html="input/submission.html"
abox="input/abox.ttl"
ontology="input/ontology.ttl"
shapes="input/shapes.ttl"
#
prob=5
sev=5

mode="html" # html or abox, default html


while getopts "p:s:m:" opt; do
    case "$opt" in
        p) prob="$OPTARG" ;;
        s) sev="$OPTARG" ;;
        m) mode="$OPTARG" ;;
    esac
done


#(?)
# Shift off the options and optional --
shift $((OPTIND-1))


# option 1 
# HTML file with RDF encoding
modeHtml() {
    cat $html | ./rdf_distiller.sh | cat - $ontology | ./prob_sev.sh -p $prob -s $sev | ./reasoner.sh | ./validator.sh $shapes
}

# option 2
# directly providing ABox 
modeAbox() {
    cat $abox $ontology | ./prob_sev.sh -p $prob -s $sev | ./reasoner.sh | ./validator.sh $shapes
}

if [ "$mode" == "html" ]; then
    modeHtml
elif [ "$mode" == "abox" ]; then
    modeAbox
fi