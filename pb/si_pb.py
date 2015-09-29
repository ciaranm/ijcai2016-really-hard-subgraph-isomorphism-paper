import itertools
from random import random
import sys

def read_graph(filename):
	i = -1
	for line in open(filename, "r"):
		if i == -1:
			n = int(line)
			g = [[False]*n for _ in range(n)]
		else:
			tokens = map(int, line.split())
			for j in range(1, tokens[0]+1):
				g[i][tokens[j]] = True
		i += 1
	return g

def show_graph(g):
       for row in g:
               print ["1 " if b else "0 " for b in row]

def si(p, t, induced=False):
	np = len(p)
	nt = len(t)

	constraints = []

	# Each pattern vertex maps to exactly one target vertex
	for i in range(np):
		constraints.append(
			" ".join("+1 x{}".format(i*nt + j + 1) for j in range(nt)) + \
			"= 1;")

	# Each target vertex maps to at most one pattern vertex
	for i in range(nt):
		constraints.append(
			" ".join("-1 x{}".format(j*nt + i + 1) for j in range(np)) + \
			">= -1;")

	# If v maps to w, then for every neighbour u of v,
	# u must map to a neighbour of w in T
	for v in range(np):
		for w in range(nt):
			for u in range(np):
				if p[u][v]:
					constraints.append("-1 x{} ".format(v*nt+w+1) \
						+ " ".join("+1 x{}".format(u*nt+x+1) for x in range(nt) if t[w][x]) \
						+ " >= 0;")

	# Induced equivalent
	if induced:
		for v in range(np):
			for w in range(nt):
				for u in range(np):
					if u!=v and not p[u][v]:
						constraints.append("-1 x{} ".format(v*nt+w+1) \
							+ " ".join("+1 x{}".format(u*nt+x+1) for x in range(nt) if not t[w][x]) \
							+ " >= 0;")

	constraints = set(constraints)
	print "* #variable= {} #constraint= {}".format(nt*np, len(constraints))
	for c in constraints:
		print c

if __name__=="__main__":
    if len(sys.argv) < 3:
        print "Usage: python {} pattern_file target_file [induced]".format(sys.argv[0])
    else:
        p_file = sys.argv[1]
        t_file = sys.argv[2]
        induced = len(sys.argv) > 3 and sys.argv[3][0].lower()=="i"
        p = read_graph(p_file)
        t = read_graph(t_file)
        si(p, t, induced)
