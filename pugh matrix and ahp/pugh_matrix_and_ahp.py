import numpy as np
def consistency_index(A):
    #% CR = consistency_index(A)
    #% this function computes the consistency index of a comparison matrix A
    #% CR(A) = CI(A)/RI(n) where n = dim(A)<=10 and
    #% CI(A)= (\lambda_max - n) / (n - 1), \lambda_max is the principal
    #% eigenvalue of the matrix A.
    #% 
    #% Daniel Selva <ds925@cornell.edu>
    #% 9/3/15
    #%
    A=np.array(A)
    n=A.size
    w,v=np.linalg.eig(A)
    lambda_max=np.max(np.real(v))
    CI=(lambda_max-n)/(n-1)
    RI=[0,0,0.58,0.9,1.12,1.24,1.32,1.41,1.45,1.49]
    CR=CI/RI[n]
    return CR
