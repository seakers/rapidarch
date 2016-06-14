#!/usr/bin/env python

# Copyright (c) 2015 Bernardo Carvalho Trindade <bct52@cornell.edu>
# License: MIT


import sys
import networkx as nx
import matplotlib.pyplot as plt
import csv
from operator import itemgetter
import argparse

# Create a new graph
def create_graph_from_csv(path):
	G = nx.DiGraph()
	
	# Import data from csv file. The data is comprised by the edges of the graph and their respective weights.
	nodes = []	
	print "Imported data from " + path + ":\n"
	with open(path, 'rb') as csvfile:
		data = csv.reader(csvfile, delimiter='\t')
		for r in data:
			print r
			G.add_edge(r[0],r[1], weight=float(r[2]))
			nodes.append(r[0])
			nodes.append(r[1])
	
	nodes = list(set(nodes))

	return G, nodes


# Get all cycles.
def get_cycles(G, project):
	C = nx.simple_cycles(G)
	cycles = []

	# Filter cycles, including only the ones that contain the system.
	for i in C:
		try:
			i.index(project)
			cycles.append(i)	
		except:
			i
	
	if len(cycles) == 0:
		status = 1
	else:
		status = 0


	return status, cycles


# Calculate the total weight of each cycle
def calculate_cycles_weights(G, cycles):
	print "\nTotal loop weights:\n"
	
	w = 0
	loopWeight = []
	for l in cycles:
		w = 0
		for i in range(len(l) - 1):
			w += G.get_edge_data(l[i],l[i+1])['weight']
		loopWeight.append(w)
		
		print str(l) + ":\t" + str(w)

	return loopWeight

# Calculate stakeholders sumWeights
def get_stakeholders_importances(loopWeight, cycles, nodes):
	print "\n\nTotal stakeholders weights:\n"
	sumWeights = sum(loopWeight)
	sumWeightNode = 0.0
	endAverages = []
	for n in nodes:
		sumWeightNode = 0.0
		for i in range(len(cycles)):
			try:
				cycles[i].index(n)
				sumWeightNode += loopWeight[i]
			except:
				i
			av = [n, sumWeightNode / sumWeights]
		endAverages.append(av)
		
	endAveragesSorted = sorted(endAverages, key=itemgetter(1), reverse=True)
	
	for a in endAveragesSorted:
		print str(a[0]) + ": " + str(a[1])
	print "\n"

	return endAveragesSorted


# Draw graph
def draw_graph(G, output):
	fig = plt.figure(figsize=(22, 11), dpi=300)
	pos=nx.spring_layout(G)
	nx.draw_networkx_nodes(G,pos,node_size=1400)
	nx.draw_networkx_edges(G,pos)
	nx.draw_networkx_labels(G,pos)
	plt.axis('off')
	plt.savefig(output)

	print "Graph exported to " + output + "\n"

def stakeholder_analysis(args):
	
	G, nodes = create_graph_from_csv((args.input_file)[0])
	print "\n\nAdjacency Matrix:\n"
	print nx.to_numpy_matrix(G)
	print "\n"
	status, cycles = get_cycles(G, (args.you_stakeholder)[0])

	if status == 1:
		print "No cycles found. Did you mispell the name of your system (" + (args.you_stakeholder)[0] + ")?\n"
	else:
		loopWeight = calculate_cycles_weights(G, cycles)
		endAveragesSorted = get_stakeholders_importances(loopWeight, cycles, nodes)
		if args.print_graph:
			draw_graph(G, "graph.png")
		

if __name__ == "__main__":
	
	parser = argparse.ArgumentParser(description='Stake holder analysis algorithms and graph plotting.')
	parser.add_argument('-i', action="store", nargs=1, help='Path to input file containing connections between stakeholders.', dest='input_file')
	parser.add_argument('-s', action="store", nargs=1, help='Name of stakeholder that represents you, as in the input file.', dest='you_stakeholder')
	parser.add_argument('-g', action="store_true", default=False, help='Export graph figure (./graph.png).', dest='print_graph')
	parser.set_defaults(func=stakeholder_analysis)
	
	args = parser.parse_args()
	
	args.func(args)

