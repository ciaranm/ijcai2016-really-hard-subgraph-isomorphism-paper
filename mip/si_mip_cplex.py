import itertools
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

	var_names = ["p{}t{}".format(i, j) for i in range(np) for j in range(nt)] 

	print "Maximize"
	print " obj: + " + " +  ".join(var_names)

	print
	print "Subject To"

	# Each pattern vertex maps to exactly one target vertex
	for i in range(np):
		print " p{}_to_at_most_1_vtx:".format(i), \
			" + ".join("p{}t{}".format(i, j) for j in range(nt)), \
			" = 1"

	# Each target vertex maps to at most one pattern vertex
	print
	for i in range(nt):
		print " t{}_to_at_most_1_vtx:".format(i), \
			" + ".join("p{}t{}".format(j, i) for j in range(np)), \
			" <= 1"

	# If v maps to w, then for every neighbour u of v,
	# u must map to a neighbour of w in T
	print
	for v in range(np):
		for w in range(nt):
			for u in range(np):
				if p[u][v]:
					print " c_{}_{}_{}: + p{}t{} ".format(v, w, u, v, w) \
						+ " ".join("-p{}t{}".format(u, x) for x in range(nt) if t[w][x]) \
						+ " <= 0"

	# Induced equivalent
	if induced:
		print
		for v in range(np):
			for w in range(nt):
				for u in range(np):
					if u!=v and not p[u][v]:
						print " ci_{}_{}_{}: + p{}t{} ".format(v, w, u, v, w) \
							+ " ".join("-p{}t{}".format(u, x) for x in range(nt) if not t[w][x]) \
							+ " <= 0"

	print 
	print "Binary"
	print " " + " ".join(var_names)
	print "End"

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
