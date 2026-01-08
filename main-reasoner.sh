#!/bin/bash

#
html="input/submission.html"
abox="input/abox.ttl"
ontology="input/ontology.ttl"
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
# STOPS AFTER REASONING - outputs inferred RDF
modeHtml() {
    cat $html | ./rdf_distiller.sh | cat - $ontology | ./prob_sev.sh -p $prob -s $sev | ./reasoner.sh
}

# option 2
# directly providing ABox
# STOPS AFTER REASONING - outputs inferred RDF
modeAbox() {
    cat $abox $ontology | ./prob_sev.sh -p $prob -s $sev | ./reasoner.sh
}

if [ "$mode" == "html" ]; then
    modeHtml
elif [ "$mode" == "abox" ]; then
    modeAbox
fi
