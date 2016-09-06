import numpy as np
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
