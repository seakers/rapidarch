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

def rand_comp_mat(n):
    # cm = rand_comp_mat(n)
    # this function generates a random reciprocal comparison matrix of size n
    # inputs: n (size)
    # outputs: cm, an n x n reciprocal comparison matrix
    # Daniel Selva <ds925@cornell.edu>
    # 9/3/15
    #
    cm=np.random.random_integers(1,9,(n,n))
    for i in range(0,n):
        cm[i][i]=1
    for i in range(1,n):
        for j in range(0,i):
            cm[i][j]=1/(cm[i][j])
    return cm


def ahp(criteria_cm,alternative_cms):

    # scores = ahp(A)
    #% This function computes the scores given when applying the Analytic
    #% Hierarchy Process to the decision problem defined by a comparison matrix
    #% with the pairwise comparisons between the criteria, and a number of
    #% comparison matrices for the pairwise comparisons between the
    #% alternatives, namely one for each criterion
    #%
    #% Inputs:
    #% criteria_cm is an m x m reciprocal matrix, where m is the number of criteria
    #% alternative_cms is a cell array of m n x n reciprocal matrices, where n
    #% is the number of alternatives
    #%
    #% It is desirable that these matrices all be consistent, i.e. that
    #% a_ij*a_jk = a_ik for all i,j,k
    #% 
    #% Outputs:
    #% scores is a vector of size n containing the priorities of each
    #% alternative
    #% consistencies is a vector of size m containing the consistency of the
    #% decision maker for each of the criteria
    #% 
    #% For details on AHP, see for example: 
    #% 1 Saaty, T. L., “Decision Making With the Analytic Hierarchy Process,” International Journal of Services Sciences, vol. 1, 2008, pp. 83–98.
    #% 
    #% Daniel Selva <ds925@cornell.edu>
    #% 9/3/15
    #%
    
    alternative_cms=np.array(alternative_cms)
    criteria_cm=np.array(criteria_cm)
    N_alt=alternative_cms.size
    N_crit=criteria_cm.size
    
    
    

    
