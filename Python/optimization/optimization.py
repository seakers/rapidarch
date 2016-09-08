from random import uniform
import numpy as np
def toDecimal( binaryNumber ):
    #bin2dec in python
    multiplier = 0
    number = 0
    for i in binaryNumber[ : : -1 ]:
        number += int( i ) * ( 2**multiplier )
        multiplier += 1
    return number

def bitstring2arch(bits):
    # bitstring2arch This function transforms a binary sequence into its
    # corresponding architecture
    # Input: bits = bitstring of length Nvars
    # Output: arch = integer vector of length Ndecisions
    # Usage: arch = bitstring2arch([0 1 1 0])
    # Assumption: Left-most bit (bit 1) corresponds to 1st decision, bits 2
    # and 3 correspond to the 2nd decision, and bit 4 corresponds to the
    # 3rd decision. For the 2nd decision, the combination 00 is forbidden
    # and must be repaired (e.g. assign randomly one of the valid
    # combinations).
    bits=np.array(bits)
    bits=(bits!=0)*1
    arch=[]
    arch.append(bits[0]+1)
    arch.append(toDecimal(bits[1:3]))
    arch.append(bits[3]+1)
    return arch

def repair_bits(bits):
    ## repair_bits 
    ## This function repairs an architecture expressed as a bit string in the
    ## test tradespace example. More precisely, if the architecture has the
    ## forbidden combination 00 for bits 2 and 3, it randomly selects one of the
    ## three valid combinations with equal probabilities.
    if ((bits[1] == 0) &(bits[2] == 0)):
        u=uniform(0,1)
        if u<1/3:
            bits[1]=1
        elif u<2/3:
            bits[2]=1
        else:
            bits[1]=1
            bits[2]=1
    return bits


