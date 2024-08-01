containerPath="/app/input"
containerName="riskman-pipeline:latest"

#
htmlTarget="submission.html"
aboxTarget="abox.ttl"
ontologyTarget="ontology.ttl"
shapesTarget="shapes.ttl"
#
html=""
abox=""
ontology=""
shapes=""
#
prob=5
sev=5

mode="html" # html or abox, default html

# ./pipeline.sh -h /home/piotr/Dresden/kimeds/riskman-reasoning-pipeline/riskman-validation-pipeline/test-cases/submission_giip.html -o /home/piotr/Dresden/kimeds/riskman-reasoning-pipeline/riskman-validation-pipeline/ontology.ttl -c /home/piotr/Dresden/kimeds/riskman-reasoning-pipeline/riskman-validation-pipeline/shapes.ttl -p 5 -s 5 -m html

# ./pipeline.sh -h test-cases/submission_giip.html -o ontology.ttl -c shapes.ttl -p 5 -s 5 -m html

# ./pipeline.sh -a /home/piotr/Dresden/kimeds/riskman-reasoning-pipeline/riskman-validation-pipeline/test-cases/1missing-im.ttl -o /home/piotr/Dresden/kimeds/riskman-reasoning-pipeline/riskman-validation-pipeline/ontology.ttl -c /home/piotr/Dresden/kimeds/riskman-reasoning-pipeline/riskman-validation-pipeline/shapes.ttl -p 5 -s 5 -m abox

# ./pipeline.sh -a test-cases/1missing-im.ttl -o ontology.ttl -c shapes.ttl -p 5 -s 5 -m abox



while getopts "h:a:o:c:p:s:m:" opt; do
    case "$opt" in
        h) html="$OPTARG" ;;
        a) abox="$OPTARG" ;;
        o) ontology="$OPTARG" ;;
        c) shapes="$OPTARG" ;;
        p) prob="$OPTARG" ;;
        s) sev="$OPTARG" ;;
        m) mode="$OPTARG" ;;
        # *) usage ;;
    esac
done


# option 1 
# HTML file with RDF encoding
modeHtml() {
    docker run \
        -v $(realpath "$html"):$containerPath/$htmlTarget \
        -v $(realpath "$ontology"):$containerPath/$ontologyTarget \
        -v $(realpath "$shapes"):$containerPath/$shapesTarget \
        -t $containerName -p $prob -s $sev -m html
}

# option 2
# directly providing ABox 
modeAbox() {
    docker run \
        -v $(realpath "$abox"):$containerPath/$aboxTarget \
        -v $(realpath "$ontology"):$containerPath/$ontologyTarget \
        -v $(realpath "$shapes"):$containerPath/$shapesTarget \
        -t $containerName -p $prob -s $sev -m abox
}

if [ "$mode" == "html" ]; then
    modeHtml
elif [ "$mode" == "abox" ]; then
    modeAbox
fi