from operator import itemgetter
from SALib.sample import saltelli
from SALib.sample import latin
from SALib.util import read_param_file
from tempfile import NamedTemporaryFile
import argparse
 
DEBUG = False # like the built-in __debug__
 
# Enumerate all permutations
def permutations(args):
    n = args.n
    
    sign = 1
    p = [[i, 0 if i == 0 else -1] # [num, direction]
         for i in range(n)]
 
    if DEBUG: print ' #', p
    yield tuple(pp[0] for pp in p), sign
 
    while any(pp[1] for pp in p): # moving
        i1, (n1, d1) = max(((i, pp) for i, pp in enumerate(p) if pp[1]),
                           key=itemgetter(1))
        sign *= -1
        if d1 == -1:
            # Swap down
            i2 = i1 - 1
            p[i1], p[i2] = p[i2], p[i1]
            if i2 == 0 or p[i2 - 1][0] > n1:
                # The direction of the chosen element is set to zero
                p[i2][1] = 0
        elif d1 == 1:
            # Swap up
            i2 = i1 + 1
            p[i1], p[i2] = p[i2], p[i1]
            if i2 == n - 1 or p[i2 + 1][0] > n1:
                # The direction of the chosen element is set to zero
                p[i2][1] = 0
        if DEBUG: print ' #', p
        yield tuple(pp[0] for pp in p), sign
 
        for i3, pp in enumerate(p):
            n3, d3 = pp
            if n3 > n1:
                pp[1] = 1 if i3 < i2 else -1
                if DEBUG: print ' # Set Moving'
                

# Full factorial enumeration
def full_factorial(args):
	
	dimensions = args.dimensions
	elements = []
	
	for i in range(len(dimensions)):
		elements.append(range(dimensions[i]))
		
	elements_vectors = reversed(elements)
	
	r = [[]]
	for ev in elements_vectors:
		t = []
		for d in ev:
			for i in r:
				t.append([d] + i)
		r = t

	for i in r:
		print i


# This function generates a latin hypercube sample and rounds the numbers to integers
def random_sample(args):
	
	items = args.dimensions
	n = args.n
	
	f = NamedTemporaryFile(delete=False)
	
	for i in range(len(items)):
		f.write(str(i) + " 0.501 " + str(items[i] + 0.499) + "\n")
		
	f.close()

	# Read the parameter range file and generate samples
	problem = read_param_file(f.name)

	# Generate samples
	param_values = latin.sample(problem, n)
	
	param_rounded = []
	for l in param_values:
		param_rounded.append([int(round(n, 0)) for n in l])
	
	for i in param_rounded:
		print i


if __name__ == '__main__':
	
	parser = argparse.ArgumentParser(description='Full and partial enumerations.')
	subparsers = parser.add_subparsers()
	
	parser_random_sample = subparsers.add_parser('rs', help='Random sampling based on the latin hypercube method.')
	parser_random_sample.add_argument('-d', action="store", type=int, nargs='+', help='Array with number of possibilities per choice.', dest='dimensions')
	parser_random_sample.add_argument('-n', action="store", type=int, help='Number of items to be enumerated.', dest='n')
	parser_random_sample.set_defaults(func=random_sample)
	
	parser_full_factorial = subparsers.add_parser('ff', help='Full factorial enumeration.')
	parser_full_factorial.add_argument('-d', action="store", type=int, nargs='+', help='Array with number of possibilities per choice. E.g. -d 3 3 2', dest='dimensions')
	parser_full_factorial.set_defaults(func=full_factorial)
	
	parser_permutation = subparsers.add_parser('pe', help='Enumerate all permutations.')
	parser_permutation.add_argument('-n', action="store", type=int, help='Number of items to be in the permutations.', dest='n')
	parser_permutation.set_defaults(func=permutations)
	
	args = parser.parse_args()
	args.func(args)



