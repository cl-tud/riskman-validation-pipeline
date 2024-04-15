# Riskman validation pipeline


# Instal dependencies



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
```


## Update April 2nd, 2024

Basic usage:

```
cat test/corr.ttl ontology.ttl | ./prob_sev.sh -p 5 -s 5 | ./reasoner.sh | ./validator.sh shapes.ttl 
```

### Catching errors:
1.  Missing implementation manifest (file [1missing-im.ttl](test/1missing-im.ttl), violating `SDAShape`) 

      ```
      cat test/1missing-im.ttl ontology.ttl | ./prob_sev.sh -p 5 -s 5 | ./reasoner.sh | ./validator.sh shapes.ttl   
      ```

      Explanation: `ex:sda121` is a leaf SDA and has no implementation manifest.

2. Child of an AssuranceSDA not an AssuranceSDA (file [2assurance-sda.ttl](test/2assurance-sda.ttl), violating `AssuranceSDAShape`)
      ```
      cat test/2assurance-sda.ttl ontology.ttl | ./prob_sev.sh -p 5 -s 5 | ./reasoner.sh | ./validator.sh shapes.ttl   
      ```
      Explanation: `ex:sda991` is a child of an AssuranceSDA but is missing the safety assurance so it's itself not an AssuranceSDA. Therefore the requirement that subtree rooted at an AssuranceSDA must again be created from AssuranceSDAs is violated. 

3. Specifying all 3 probabilities, P != P1 x P2 (file [3probability-product.ttl](test/3probability-product.ttl), violating `RiskLevelShape`)
      ```
      cat test/3probability-product.ttl ontology.ttl | ./prob_sev.sh -p 5 -s 5 | ./reasoner.sh | ./validator.sh shapes.ttl   
      ```
      `initialRiskLevel2` specifies all 3 probabilities, i.e.:
         P=4,
         P1=4,
         P2=4.
        Inference gives product to be P=3, and this violates the constraint that each RiskLevel must have exactly one `hasProbability` successor.



4. Residual probability higher than initial. (file [4residual-prob.ttl](test/4residual-prob.ttl), violating `NonIncreasingProbabilityShape`)
      ```
      cat test/4residual-prob.ttl ontology.ttl | ./prob_sev.sh -p 5 -s 5 | ./reasoner.sh | ./validator.sh shapes.ttl   
      ```

      `initialRiskLevel1` specifies probability P as 2 whereas `residualRiskLevel1` specifies probability P as 3. The former is the initial probability of the (AnalyzedRisk of the) `controlledRisk1` and the latter is its residual risk level.






## Running the pipeline

Generally, the pipeline is run with the following chain of commands:

```
cat <HTML SUBMISSION FILE> | ./rdf_distiller.sh | cat - <ONTOLOGY FILE> | ./reasoner.sh | ./validator.sh <SHAPES FILE>
```

- `cat <SUBMISSION FILE>` echo the contents of the `<SUBMISSION FILE>` file, an HTML file with RDFa annotations
- `| ./rdf_distiller.sh` extract the RDF triples from the HTML file
- `| cat - <ONTOLOGY FILE>` combine the extracted triples with the appropriate riskman ontology `<ONTOLOGY FILE>`
- `| ./reasoner.sh` apply inference, realize the ontology
- `| ./validator.sh <SHAPES FILE>` validate against the shapes `<SHAPES FILE>`
``

## Two approaches

We investigate the two approaches to encoding submission file in RDFam which utilize two different reasoning tasks, i.e.:

1. A-Box encoding
2. Subclass encoding

Assume the scenario in which the following information has to be encoded:
- there is some `Controlled Risk` (let's name it `2`) for which (among other properties) the related Hazard is `electromagnetic energy`, the Event is `cable problem`, the Harm is `burns` and the SDA is to implement a `solvent monitoring system`.

#### Approach 1 - A-Box encoding

Here the information would be encoded using the following A-Box assertions:
```
# class assertions
ControlledRisk(2).
Hazard(electromagneticEnergy).
Event(cableProblem).
Harm(burns).
SDA(solventMonitoringSystem).

# role assertions
hasHazard(2, electromagneticEnergy).
hasEvent(2, cableProblem).
hasHarm(2, burns).
hasSDA(2, solventMonitoringSystem).
```

In this scenario, after extraction of triples from the encoding, the A-Box will be supplied with the Riskman T-Box and delegated to a reasoner for the task of **materialization** - asserting the type (class) of each individual.

The output will afterwards be verified against a set of SHACL constraints.

An encoding of a submission file using this approach can be found in [abox/submission.html](abox/submission.html). Same directory contains also a version of the ontology and shapes supporting this approach. To verify it using our pipeline, run:

```
cat abox/submission.html | ./rdf_distiller.sh | cat - abox/ontology.ttl | ./reasoner.sh | ./validator.sh abox/shapes.ttl 
```

The inference we are mostly insterested here that we get through materialization is:

```
UnnacceptableRisk(2)
```

The validation result should be `False`, as there is an unmitigated UnacceptableRisk (namely `2`). Expected output:
```
Validation Report
Conforms: False
Results (1):
Constraint Violation in MinCountConstraintComponent (http://www.w3.org/ns/shacl#MinCountConstraintComponent):
        Severity: sh:Violation
        Source Shape: [ sh:message Literal("Every unacceptable risk must have an SDA.") ; sh:minCount Literal("1", datatype=xsd:integer) ; sh:path riskman:hasSDA ]
        Focus Node: <http://example.org/controlledRisk2>
        Result Path: riskman:hasSDA
        Message: Every unacceptable risk must have an SDA.
```

In order to see a successful validation, uncomment the line 146 of the file [abox\submission.html](abox\submission.html), namely:

```html
<!-- <link property="riskman:hasSDA" href="sda2"/> -->
```

Then, the validation report should be:

```
Validation Report
Conforms: True
```

#### Approach 2 - (Sub)classes encoding

The 2nd approach encodes the above scenario using subclasses, as follows:

```
# subclasses
2 ⊑ ControlledRisk 
ElectromagneticEnergy ⊑ Hazard
CableProblem ⊑ Event
Burns ⊑ Harm
SolventMonitoringSystem ⊑ SDA


# role successors
2 ⊑ ∃hasHazard.ElectromagneticEnergy
2 ⊑ ∃hasEvent.CableProblem
2 ⊑ ∃hasHarm.Burns
2 ⊑ ∃hasSDA.SolventMonitoringSystem

# additional assertions
2(ctr2)
hasSDA(ctr2, sda2)
```

In this approach, the extracted triples are supplied with the Riskman T-Box and delegated to a reasoner for the task of **classification** - establishing if there exists a subclass/superclass relation between each pair of named classes. 

The inference we are interested here is:

```
2 ⊑ UnacceptableRisk
```

The output will afterwards be verified against a set of SHACL constraints. Since we do not materialize, we want to delegate the task of asserting that `ctr2` is an `UnacceptableRisk` and hence requires validation by SHACL validator.

```ttl
riskman:UnacceptableRiskShape 
    a sh:NodeShape ;
    sh:targetNode riskman:UnacceptableRisk ;
    sh:property [
        sh:path (
            [ sh:inversePath rdfs:subClassOf ]
            [ sh:inversePath rdf:type ]
        );
        sh:node riskman:SDARequiredShape ;
        sh:message "Every unacceptable risk must have an SDA." ;
    ] .

riskman:SDARequiredShape 
    a sh:NodeShape ;
    sh:property [
        sh:path riskman:hasSDA ;
        sh:minCount 1 ;
    ] .
```

Here, the target is the `UnacceptableRisk`. Using `sh:inversePath` we localize its subclasses and then in turn the instances of the subclasses. This way, because of the obtained result that `2 ⊑ UnacceptableRisk` and given the initial assertion `2(ctr2)` the node `ctr2` will be verified for the existence of an SDA.

An encoding of a submission file using this approach can be found in [classes/submission.html](classes/submission.html). Same directory contains also a version of the ontology and shapes supporting this approach. To verify it using our pipeline, run:

```
cat classes/submission.html | ./rdf_distiller.sh | cat - classes/ontology.ttl | ./reasoner.sh | ./validator.sh classes/shapes.ttl 
```

The expected output is again `False`:

```
Validation Report
Conforms: False
Results (1):
Constraint Violation in NodeConstraintComponent (http://www.w3.org/ns/shacl#NodeConstraintComponent):
        Severity: sh:Violation
        Source Shape: [ sh:message Literal("Every unacceptable risk must have an SDA.") ; sh:node riskman:SDARequiredShape ; sh:path ( [ sh:inversePath rdfs:subClassOf ] [ sh:inversePath rdf:type ] ) ]
        Focus Node: riskman:UnacceptableRisk
        Value Node: ex:ctr1
        Result Path: ( [ sh:inversePath rdfs:subClassOf ] [ sh:inversePath rdf:type ] )
        Message: Every unacceptable risk must have an SDA.
```


In order to see a successful validation, uncomment the line 247 of the file [classes\submission.html](classes\submission.html), namely:

```html
<!-- <link property="https://w3id.org/riskman/ontology#hasSDA" href="sda1" /> -->
```

Then, the validation report should be:

```
Validation Report
Conforms: True
```