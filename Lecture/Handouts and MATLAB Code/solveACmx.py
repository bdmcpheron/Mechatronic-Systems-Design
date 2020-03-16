from numpy import *
from scipy.linalg import *
# -----------------#
# Here you need to enter your matrix A using the format np.array([a,b,c],[d,e,f],[g,h,i]])
# Should be n x n
A = [[1, -1], [4j, 1-2j]] # <<<<<<modify as needed for your problem

# -----------------#
# here you need to enter your B matrix
# Should be n x 1
B = [.707*16+.707*16j,32] # <<<<<<modify as needed for your problem
# -----------------#
# Transpose B
B = transpose(B)
# -----------------#
# Calculate the inverse and solve the system
X = matmul(inv(A),B) # matrix multiplication
print("In rectangular form, X is equal to")
print(X)
print(" ")
print("In polar form, the magnitude of X is")
print(abs(X)) # magnitude
print("with an angle")
print(angle(X,1)) # angle in degrees