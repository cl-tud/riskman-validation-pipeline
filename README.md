# Riskman validation pipeline

## Update 1.08.2024

A Docker container is provided for easier setup of the pipeline.

To build the container (provided that you have Docker installed), run:

```bash
docker build -t riskman-pipeline .
```

which will create the container with the pipeline. 

### Using the docker container directly

1) submission mode: html - submitted files are HTML files with RDFa encodings  (like [/test-cases/submission_correct.html](/test-cases/submission_correct.html))

```bash
docker run \
      -v <ABSOLUTE HTML FILE PATH>:/app/input/submission.html \
      -v <ABSOLUTE ONTOLOGY FILE PATH>:/app/input/ontology.ttl \
      -v <ABSOLUTE SHAPES FILE PATH>:/app/input/shapes.ttl \
      -t <CONTAINER NAME> -p <NUMBER PROB. CLASSES> -s <NUMBER SEV. CLASSES> -m html
```
e.g.
```bash
docker run \
      -v /home/piotr/Dresden/kimeds/riskman-reasoning-pipeline/riskman-validation-pipeline/test-cases/submission_correct.html:/app/input/submission.html  \
      -v /home/piotr/Dresden/kimeds/riskman-reasoning-pipeline/riskman-validation-pipeline/ontology.ttl:/app/input/ontology.ttl  \
      -v /home/piotr/Dresden/kimeds/riskman-reasoning-pipeline/riskman-validation-pipeline/shapes.ttl:/app/input/shapes.ttl      \
      -t riskman-pipeline:latest -p 5 -s 5 -m html
```

Expected output:
```
Classifying 25 elements
Classifying:  100% complete in 00:00
Classifying finished in 00:00
Realizing 25 elements

Realizing finished in 00:00
/app/kimeds_env/lib/python3.11/site-packages/rdflib_jsonld/__init__.py:9: DeprecationWarning: The rdflib-jsonld package has been integrated into rdflib as of rdflib==6.0.0.  Please remove rdflib-jsonld from your project's dependencies.
  warnings.warn(
[
  {
    "@id": "_:N692223071cb54bbcb2be04b8eddaf940",
    "@type": [
      "http://www.w3.org/ns/shacl#ValidationReport"
    ],
    "http://www.w3.org/ns/shacl#conforms": [
      {
        "@value": false
      }
    ],
    "http://www.w3.org/ns/shacl#result": [
      {
        "@id": "_:N2dcfe754a5e545f4a19cd62b9fbea12a"
      },
      {
        "@id": "_:N7bb7842d5cd44b5daf8c208746efa895"
      },
      {
        "@id": "_:N62604cc9062744f09b2b92b6b1129405"
      }
    ]
  },
  {
    "@id": "_:N2dcfe754a5e545f4a19cd62b9fbea12a",
    "@type": [
      "http://www.w3.org/ns/shacl#ValidationResult"
    ],
    "http://www.w3.org/ns/shacl#focusNode": [
      {
        "@id": "http://example.org/sda99"
      }
    ],
    "http://www.w3.org/ns/shacl#resultMessage": [
      {
        "@value": "Every SDA needs a final mitigation (which has the Implementation Manifest)"
      }
    ],
    "http://www.w3.org/ns/shacl#resultPath": [
      {
        "@id": "_:N47d0cb4d5b534a63a08bd72fabbee3da"
      }
    ],
    "http://www.w3.org/ns/shacl#resultSeverity": [
      {
        "@id": "http://www.w3.org/ns/shacl#Violation"
      }
    ],
    "http://www.w3.org/ns/shacl#sourceConstraintComponent": [
      {
        "@id": "http://www.w3.org/ns/shacl#QualifiedMinCountConstraintComponent"
      }
    ],
    "http://www.w3.org/ns/shacl#sourceShape": [
      {
        "@id": "_:N49ab24535e8a4ffd9d6c17cbbeb9a281"
      }
    ]
  },
  {
    "@id": "_:N47d0cb4d5b534a63a08bd72fabbee3da",
    "http://www.w3.org/ns/shacl#zeroOrMorePath": [
      {
        "@id": "https://w3id.org/riskman/ontology#hasSubSDA"
      }
    ]
  },
  {
    "@id": "_:N49ab24535e8a4ffd9d6c17cbbeb9a281",
    "http://www.w3.org/ns/shacl#message": [
      {
        "@value": "Every SDA needs a final mitigation (which has the Implementation Manifest)"
      }
    ],
    "http://www.w3.org/ns/shacl#path": [
      {
        "@id": "_:N8b190aca7e5d43d7b1d52d92be33496a"
      }
    ],
    "http://www.w3.org/ns/shacl#qualifiedMinCount": [
      {
        "@value": 1
      }
    ],
    "http://www.w3.org/ns/shacl#qualifiedValueShape": [
      {
        "@id": "_:N88086c92dbd24422867baf7d3601835c"
      }
    ]
  },
  {
    "@id": "_:N8b190aca7e5d43d7b1d52d92be33496a",
    "http://www.w3.org/ns/shacl#zeroOrMorePath": [
      {
        "@id": "https://w3id.org/riskman/ontology#hasSubSDA"
      }
    ]
  },
  {
    "@id": "_:N88086c92dbd24422867baf7d3601835c",
    "http://www.w3.org/ns/shacl#class": [
      {
        "@id": "https://w3id.org/riskman/ontology#SDAI"
      }
    ]
  },
  {
    "@id": "_:N7bb7842d5cd44b5daf8c208746efa895",
    "@type": [
      "http://www.w3.org/ns/shacl#ValidationResult"
    ],
    "http://www.w3.org/ns/shacl#focusNode": [
      {
        "@id": "http://example.org/sda1"
      }
    ],
    "http://www.w3.org/ns/shacl#resultMessage": [
      {
        "@value": "Every SDA needs a final mitigation (which has the Implementation Manifest)"
      }
    ],
    "http://www.w3.org/ns/shacl#resultPath": [
      {
        "@id": "_:N4c0449fed9d343858348b639fbb1737f"
      }
    ],
    "http://www.w3.org/ns/shacl#resultSeverity": [
      {
        "@id": "http://www.w3.org/ns/shacl#Violation"
      }
    ],
    "http://www.w3.org/ns/shacl#sourceConstraintComponent": [
      {
        "@id": "http://www.w3.org/ns/shacl#QualifiedMinCountConstraintComponent"
      }
    ],
    "http://www.w3.org/ns/shacl#sourceShape": [
      {
        "@id": "_:N198d7c79ba7149eaa69023f99c6266bf"
      }
    ]
  },
  {
    "@id": "_:N198d7c79ba7149eaa69023f99c6266bf",
    "http://www.w3.org/ns/shacl#message": [
      {
        "@value": "Every SDA needs a final mitigation (which has the Implementation Manifest)"
      }
    ],
    "http://www.w3.org/ns/shacl#path": [
      {
        "@id": "_:Ne91ad26f2e2d4f639a89c79e43b2d6f6"
      }
    ],
    "http://www.w3.org/ns/shacl#qualifiedMinCount": [
      {
        "@value": 1
      }
    ],
    "http://www.w3.org/ns/shacl#qualifiedValueShape": [
      {
        "@id": "_:N113d5e56ade9484c80ed1025f7032398"
      }
    ]
  },
  {
    "@id": "_:N113d5e56ade9484c80ed1025f7032398",
    "http://www.w3.org/ns/shacl#class": [
      {
        "@id": "https://w3id.org/riskman/ontology#SDAI"
      }
    ]
  },
  {
    "@id": "_:Ne91ad26f2e2d4f639a89c79e43b2d6f6",
    "http://www.w3.org/ns/shacl#zeroOrMorePath": [
      {
        "@id": "https://w3id.org/riskman/ontology#hasSubSDA"
      }
    ]
  },
  {
    "@id": "_:N4c0449fed9d343858348b639fbb1737f",
    "http://www.w3.org/ns/shacl#zeroOrMorePath": [
      {
        "@id": "https://w3id.org/riskman/ontology#hasSubSDA"
      }
    ]
  },
  {
    "@id": "_:N62604cc9062744f09b2b92b6b1129405",
    "@type": [
      "http://www.w3.org/ns/shacl#ValidationResult"
    ],
    "http://www.w3.org/ns/shacl#focusNode": [
      {
        "@id": "http://example.org/sda2"
      }
    ],
    "http://www.w3.org/ns/shacl#resultMessage": [
      {
        "@value": "Every SDA needs a final mitigation (which has the Implementation Manifest)"
      }
    ],
    "http://www.w3.org/ns/shacl#resultPath": [
      {
        "@id": "_:N0598cbc314ea4dcaa75db7083e8201f3"
      }
    ],
    "http://www.w3.org/ns/shacl#resultSeverity": [
      {
        "@id": "http://www.w3.org/ns/shacl#Violation"
      }
    ],
    "http://www.w3.org/ns/shacl#sourceConstraintComponent": [
      {
        "@id": "http://www.w3.org/ns/shacl#QualifiedMinCountConstraintComponent"
      }
    ],
    "http://www.w3.org/ns/shacl#sourceShape": [
      {
        "@id": "_:N3941807ff377449d948ba5e350527c87"
      }
    ]
  },
  {
    "@id": "_:N3941807ff377449d948ba5e350527c87",
    "http://www.w3.org/ns/shacl#message": [
      {
        "@value": "Every SDA needs a final mitigation (which has the Implementation Manifest)"
      }
    ],
    "http://www.w3.org/ns/shacl#path": [
      {
        "@id": "_:N488a003469b5403ea7c821275bb88c2b"
      }
    ],
    "http://www.w3.org/ns/shacl#qualifiedMinCount": [
      {
        "@value": 1
      }
    ],
    "http://www.w3.org/ns/shacl#qualifiedValueShape": [
      {
        "@id": "_:N2edcd245458e44a9aca2cdbe1d409fc2"
      }
    ]
  },
  {
    "@id": "_:N2edcd245458e44a9aca2cdbe1d409fc2",
    "http://www.w3.org/ns/shacl#class": [
      {
        "@id": "https://w3id.org/riskman/ontology#SDAI"
      }
    ]
  },
  {
    "@id": "_:N488a003469b5403ea7c821275bb88c2b",
    "http://www.w3.org/ns/shacl#zeroOrMorePath": [
      {
        "@id": "https://w3id.org/riskman/ontology#hasSubSDA"
      }
    ]
  },
  {
    "@id": "_:N0598cbc314ea4dcaa75db7083e8201f3",
    "http://www.w3.org/ns/shacl#zeroOrMorePath": [
      {
        "@id": "https://w3id.org/riskman/ontology#hasSubSDA"
      }
    ]
  }
]
```

The error messages are e.g.:
```
"http://www.w3.org/ns/shacl#message": [
      {
        "@value": "Every SDA needs a final mitigation (which has the Implementation Manifest)"
      }
]
```


2) submission mode: RDF abox - submitted files are directly RDF ABoxes (like [/test-cases/missing-im.ttl](/test-cases/1missing-im.ttl))

```bash
docker run \
      -v <ABSOLUTE ABOX FILE PATH>:/app/input/abox.ttl \
      -v <ABSOLUTE ONTOLOGY FILE PATH>:/app/input/ontology.ttl \
      -v <ABSOLUTE SHAPES FILE PATH>:/app/input/shapes.ttl \
      -t <CONTAINER NAME> -p <NUMBER PROB. CLASSES> -s <NUMBER SEV. CLASSES> -m abox
```
e.g.
```bash
docker run \
      -v /home/piotr/Dresden/kimeds/riskman-reasoning-pipeline/riskman-validation-pipeline/test-cases/1missing-im.ttl:/app/input/abox.ttl  \
      -v /home/piotr/Dresden/kimeds/riskman-reasoning-pipeline/riskman-validation-pipeline/ontology.ttl:/app/input/ontology.ttl            \
      -v /home/piotr/Dresden/kimeds/riskman-reasoning-pipeline/riskman-validation-pipeline/shapes.ttl:/app/input/shapes.ttl                \
      -t riskman-pipeline:latest -p 5 -s 5 -m abox
```

### Output format

By default, the output format is set to `json-ld`. It can alternatively be changed to `human`, `turtle`, `xml`, `json-ld`, `nt`, `n3`, to this end, modify the line 15 in the [./reasoner.sh](./reasoner.sh) accordingly.



### Alternatively, a bash (only on Linux) script cam make things slightly easier: 
To use it afterwards, run:

```bash
./pipeline.sh -h <HTML FILE> -o <ONTOLOGY FILE> -c <SHAPES FILE> -p <# PROBABILITY CLASSES> -s <# SEVERITY CLASSES> -m html
```
to run evaluate an RDFa enhanced HTML file, e.g.
```bash
./pipeline.sh -h test-cases/submission_giip.html -o ontology.ttl -c shapes.ttl -p 5 -s 5 -m html
```
To evaluate a turtle ABox, run:

```bash
./pipeline.sh -a <ABOX FILE> -o <ONTOLOGY FILE> -c <SHAPES FILE> -p <# PROBABILITY CLASSES> -s <# SEVERITY CLASSES> -m abox
```
where `-m abox` stands for the ABox (rather than HTML) mode, e.g.
```bash
./pipeline.sh -a test-cases/1missing-im.ttl -o ontology.ttl -c shapes.ttl -p 5 -s 5 -m abox
```

___

## (Legacy) Setup



```bash
# Create virtual environment named 'kimeds'
# IMPORTANT: make sure the python version is 3.11
python -m venv kimeds_env


# Activate the virtual environment (for macOS/Linux)
source kimeds_env/bin/activate

# Activate the virtual environment (for Windows)
# riskman\Scripts\activate

# Update pip
pip install --upgrade pip

# Install dependencies from requirements.txt
pip install -r requirements.txt

# Download latest ontology and shapes
wget -O ontology.ttl https://w3id.org/riskman/ontology
wget -O shapes.ttl https://w3id.org/riskman/shapes
```

![alt text](img/flow.png)


### RDFa distillation:

```
cat test-cases/submission_correct.html | ./rdf_distiller.sh 
```
e.g.
```
cat test-cases/submission_correct.html | ./rdf_distiller.sh | cat - ontology.ttl | ./prob_sev.sh -p 5 -s 5 | ./reasoner.sh | ./validator.sh shapes.ttl
```

![alt text](img/instance.png)


### Correct examples
1.  Correct GIIP example (file [giip.ttl](test-cases/giip.ttl)) 

      ```
      cat test-cases/giip.ttl ontology.ttl | ./prob_sev.sh -p 5 -s 5 | ./reasoner.sh | ./validator.sh shapes.ttl   
      ```

2. Another example (file [corr.ttl](test-cases/corr.ttl))
      ```
      cat test-cases/corr.ttl ontology.ttl | ./prob_sev.sh -p 5 -s 5 | ./reasoner.sh | ./validator.sh shapes.ttl   
      ```

### Incorrect examples:
1.  Missing implementation manifest (file [1missing-im.ttl](test-cases/1missing-im.ttl), violating `SDAShape`) 

      ```
      cat test-cases/1missing-im.ttl ontology.ttl | ./prob_sev.sh -p 5 -s 5 | ./reasoner.sh | ./validator.sh shapes.ttl   
      ```

      Explanation: `ex:sda121` is a leaf SDA and has no implementation manifest.

2. Child of an AssuranceSDA not an AssuranceSDA (file [2assurance-sda.ttl](test-cases/2assurance-sda.ttl), violating `AssuranceSDAShape`)
      ```
      cat test-cases/2assurance-sda.ttl ontology.ttl | ./prob_sev.sh -p 5 -s 5 | ./reasoner.sh | ./validator.sh shapes.ttl   
      ```
      Explanation: `ex:sda991` is a child of an AssuranceSDA but is missing the safety assurance so it's itself not an AssuranceSDA. Therefore the requirement that subtree rooted at an AssuranceSDA must again be created from AssuranceSDAs is violated. 

3. Specifying all 3 probabilities, P != P1 x P2 (file [3probability-product.ttl](test-cases/3probability-product.ttl), violating `RiskLevelShape`)
      ```
      cat test-cases/3probability-product.ttl ontology.ttl | ./prob_sev.sh -p 5 -s 5 | ./reasoner.sh | ./validator.sh shapes.ttl   
      ```
      `initialRiskLevel2` specifies all 3 probabilities, i.e.:
         P=4,
         P1=4,
         P2=4.
        Inference gives product to be P=3, and this violates the constraint that each RiskLevel must have exactly one `hasProbability` successor.



4. Residual probability higher than initial. (file [4residual-prob.ttl](test-cases/4residual-prob.ttl), violating `NonIncreasingProbabilityShape`)
      ```
      cat test-cases/4residual-prob.ttl ontology.ttl | ./prob_sev.sh -p 5 -s 5 | ./reasoner.sh | ./validator.sh shapes.ttl   
      ```

      `initialRiskLevel1` specifies probability P as 2 whereas `residualRiskLevel1` specifies probability P as 3. The former is the initial probability of the (AnalyzedRisk of the) `controlledRisk1` and the latter is its residual risk level.



## Running the pipeline

Generally, the pipeline is run with the following chain of commands:

```
cat <HTML SUBMISSION FILE> | ./rdf_distiller.sh | cat - <ONTOLOGY FILE> | ./prob_sev.sh -p <# PROB. CLASSES> -s <# SEV. CLASSES> | ./reasoner.sh | ./validator.sh <SHAPES FILE>
```

- `cat <SUBMISSION FILE>` echo the contents of the `<SUBMISSION FILE>` file, an HTML file with RDFa annotations
- `| ./rdf_distiller.sh` extract the RDF triples from the HTML file
- `| cat - <ONTOLOGY FILE>` combine the extracted triples with the appropriate riskman ontology `<ONTOLOGY FILE>`
- `| ./prob_sev.sh -p <# PROB. CLASSES> -s <# SEV. CLASSES>` (optional), supply the additional "Probability-Severity" ontology, with `<# PROB. CLASSES>` number of probability classes and `<# SEV. CLASSES>` number of severity classes (both integers)
- `| ./reasoner.sh` apply inference, realize the ontology
- `| ./validator.sh <SHAPES FILE>` validate against the shapes `<SHAPES FILE>`
``

Note that in the above examples we omitted the ditillation phase, and simply used already extracted ABoxes, i.e.:

```
cat <ABOX RDF FILE> <ONTOLOGY FILE> | ./prob_sev.sh -p <# PROB. CLASSES> -s <# SEV. CLASSES> | ./reasoner.sh | ./validator.sh <SHAPES FILE>
```