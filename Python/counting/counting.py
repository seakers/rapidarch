import numpy as np
import math
class problem:
  type=""
  class parameters:
    N=0
    M=0
    self_connections=True
    directed=True
    alternative_sets=0
    


def Bell(n,nargout=1):
# b = Bell(N)
# N integer
# Compute the Bell's number. It is the number of all possible partitions
# of the set {1:N}.
# [b B] = Bell(N) returns in column vector B all Bell's numbers from 1 to N
#
# Author: Bruno Luong <brunoluong@yahoo.com>
# History
#   Original: 17-May-2009
#   Last update: 18-May-2009, cosmetic changes

  if n==0:
    b=1
    B=np.zeros((0,1))
    return (b,B)

  A=np.zeros((n,n))
  A[0,0]=1

  for i in range(1,n):
    A[i,0]=A[i-1,i-1]
    for j in range(1,n):
      A[i,j]=A[i,j-1]+A[i-1,j-1]

  b=A[n-1,n-1]
  if nargout>=2:
    B=np.diag(A)
    return(b,B)
  return(b)
def factorial(n):return reduce(lambda x,y:x*y,[1]+range(1,n+1))
def count_archs(problem):
#function n = count_archs(problem)
#
# Counts the number of architectures in a given architecture problem. 
# problem is a structure with the following fields: 'type' and 'parameters'
# The following combinations of types and parameters are allowed:
#
# type = 'SUBSET-SELECTION': This is a binary selection problem over a set
# of elements of size given by problem.parameters.N
#
# type = 'DISJOINT-SELECTION': This is a disjoint selection problem given
# by a number of decisions, each with its own sets of alternatives. The 
# alternative sets are given in problem.parameters.alternative_sets as a
# cell array of cell arrays
# 
# type = 'PARTITIONING': This is a set partitioning problem over a set
# of elements of size given by problem.parameters.N
# 
# type = 'ASSIGNMENT': This is an assignment problem over two sets of
# elements of sizes given by problem.parameters.N and problem.parameters.M
# 
# type = 'CONNECTING': This is a connecting problem over a set
# of elements of size given by parameters.N. The problem can be directed 
# or undirected as controlled by the boolean problem.parameters.directed
# and self-connections may or may not be allowed as controlled by boolean
# parameter problem.parameters.self_connections
# 
# type = 'PERMUTING': This is a permuting problem over a set
# of elements of size given by problem.parameters.N
# 
# Author: Daniel Selva <ds925@cornell.edu> 8/17/2015
  N = 0
  n = 0
  if problem.type=="SUBSET-SELECTION":
    N = problem.parameters.N
    n = 2**N
  elif problem.type=="PARTITIONING":
    N = problem.parameters.N
    n = Bell(N)
  elif problem.type=="ASSIGNING":
    N = problem.parameters.N
    M = problem.parameters.M
    n = 2**(N*M)
  elif problem.type=="CONNECTION":
    N = problem.parameters.N
    if problem.parameters.self_connections:
      m = 1 # self connections allowed
    else:
      m = 0 # self connections not allowed
    if problem.parameters.directed:
      k = 1 #directed graph
    else:
      k = 2 #undirected graph
    n = 2**(N*(N-1)/k+m*N)
  elif problem.type=="PERMUTING":
    N = problem.parameters.N
    n = math.factorial(N)
  elif problem.type=="DISJOINT-SELECTION":
    nu=problem.parameters.alternative_sets.shape
    arr=np.zeros(nu)
    for i in range(0,nu[0]):
      arr[i]=problem.parameters.alternative_sets[i].shape[0]
    n = np.prod(arr)

  else:
    print('Unsupported decision type')
  return n
  
def stirling(n,k):
#function S=stirling(n,k)
#
# The number of ways of partitioning a set of n elements 
# into k nonempty sets iscalled 
# a Stirling set number. For example, the set {1,2,3} can 
# be partitioned into three subsets in one way: 
# {{1},{2},{3}}; into two subsets in three ways: 
# {{1,2},{3}}, {{1,3},{2}}, and {{1},{2,3}}; and into 
# one subset in one way: {{1,2,3}}.

  S=0
  for i in range(0,k+1):
    S=S+(-1)**i*math.factorial(k)/(math.factorial(i)*math.factorial(k-i))*(k-i)**n
  S=S/(math.factorial(k))
  return S
