import sys

from rdflib import Graph

FORMAT = 'turtle'
PUBLIC_ID = 'http://example.org#'


if __name__ == '__main__':    

    rdfa_string_path = sys.argv[1]
    distilled_tmp_file = sys.argv[2]

    g = Graph()
    
    g.parse(rdfa_string_path, format='html', publicID=PUBLIC_ID)
    g.serialize(format=FORMAT, destination=distilled_tmp_file)
