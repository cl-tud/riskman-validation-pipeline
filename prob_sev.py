# import argparse
import sys


OUTPUT_FILE = 'prob_sev_onto.ttl'

BASE_PREFIX='rlevel'
BASE_IRI='<https://w3id.org/riskman/risk-level#>'
RISKMAN_PREFIX = 'riskman'
OWL_PREFIX = 'owl'

PREFIXES = f'''
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix {OWL_PREFIX}: <http://www.w3.org/2002/07/owl#> .
@prefix dcterms: <http://purl.org/dc/terms/> .
@prefix ex: <http://aaexample.org#> .
@prefix {RISKMAN_PREFIX}: <https://w3id.org/riskman/ontology#> .
@prefix schema: <https://schema.org/> .
@prefix {BASE_PREFIX}: {BASE_IRI} .
'''

NEWLINE = '\n'
TAB = '\t'


GT = f'{BASE_PREFIX}:gt'
SEQ = f'{BASE_PREFIX}:seq'
SEQ_PROPERTY = f'''{SEQ} rdf:type owl:ObjectProperty, owl:TransitiveProperty .'''
GT_PROPERTY = f'''{GT} rdf:type owl:ObjectProperty, owl:TransitiveProperty .'''

RISKMAN_PROBABILITY = f'{RISKMAN_PREFIX}:Probability'
RISKMAN_HAS_P1 = f'{RISKMAN_PREFIX}:hasProbability1'
RISKMAN_HAS_P2 = f'{RISKMAN_PREFIX}:hasProbability2'
RISKMAN_HAS_P = f'{RISKMAN_PREFIX}:hasProbability'
RISKMAN_SEVERITY = f'{RISKMAN_PREFIX}:Severity'

RISK_LEVEL = f'{RISKMAN_PREFIX}:RiskLevel'
OWL_THING = f'{OWL_PREFIX}:Thing'

PROBABILITY_NAME_BASE = 'p'
SEVERITY_NAME_BASE = 's'


 

def existential_restriction(predicate, object=OWL_THING):
    return f'''[ rdf:type owl:Restriction ;
    owl:onProperty {predicate} ;
    owl:someValuesFrom {object}
]'''


def individual(ordinal, base, prefix, type, gt_prev=True):
    full_name = get_individual_name(ordinal, base, prefix)
    prev_name = get_individual_name(ordinal-1, base, prefix)
    return f'''#{full_name}
{full_name} rdf:type owl:NamedIndividual , {type} ''' +  f"{ ' ;' + NEWLINE + ' ' + GT + ' ' + prev_name  if gt_prev else ''}" + ' .'


def get_individual_name(ordinal, base, prefix):
    return f'{prefix}:{base}{ordinal}'


def get_product_probability(p1, p2, prob_max):
    return max(1, p1+p2-prob_max)


def get_split_probability_axiom(p1, p2, prob_max):
    product = get_product_probability(p1,p2,prob_max)
    return f'''#{p1} x {p2} = {product}
[ owl:intersectionOf ( [ rdf:type owl:Restriction ;
                         owl:onProperty {RISKMAN_HAS_P1} ;
                         owl:someValuesFrom [ owl:oneOf ( {get_individual_name(p1, PROBABILITY_NAME_BASE, BASE_PREFIX)} ) ]
                       ]
                       [ rdf:type owl:Restriction ;
                         owl:onProperty {RISKMAN_HAS_P2} ;
                         owl:someValuesFrom [ owl:oneOf ( {get_individual_name(p2, PROBABILITY_NAME_BASE, BASE_PREFIX)} ) ]
                       ]
                     ) ;
                ]                     
  rdfs:subClassOf [ rdf:type owl:Restriction ;
                    owl:onProperty {RISKMAN_HAS_P} ;
                    owl:someValuesFrom [ owl:oneOf ( {get_individual_name(product, PROBABILITY_NAME_BASE, BASE_PREFIX)} ) ]
] .'''


if __name__ == '__main__':    

    # parser = argparse.ArgumentParser(description="Set probability and severity value.")
    # parser.add_argument('-p', '--probabilities', type=int, help='Probabilities')
    # parser.add_argument('-s', '--severities', type=int, help='Severities')
    # parser.add_argument('--split-prob', action='store_true', help='Split probabilities')


    # Parse arguments
    # args, _ = parser.parse_known_args()

    prob_max = int(sys.argv[1])
    # prob_max = args.probabilities
    sev_max = int(sys.argv[2])
    # sev_max = args.severities

    

    output_str = PREFIXES + NEWLINE*2 + GT_PROPERTY + NEWLINE*2

    for i in range(1, prob_max+1):
        output_str += individual(i, PROBABILITY_NAME_BASE, BASE_PREFIX, RISKMAN_PROBABILITY, i > 1) + '\n'

    output_str += NEWLINE*2

    for i in range(1, sev_max+1):
        output_str += individual(i, SEVERITY_NAME_BASE, BASE_PREFIX, RISKMAN_SEVERITY, i > 1) + '\n'

    output_str += NEWLINE*2

    for i in range(1, prob_max+1):
        for j in range(1, prob_max+1):
            output_str += get_split_probability_axiom(i, j, prob_max) + '\n\n'


    print(output_str)
