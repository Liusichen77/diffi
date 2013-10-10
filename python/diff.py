#-*- coding: utf8 -*-
# Computes Diffusion Maps by Zucker, Coiffman, Lafon, et. al.
#
# Authors: Ricardo Fabbri <rfabbri@iprj.uerj.br>
#
# Partly based on code by Lucia Pinto and Mauro Amorim
# Licence: GPLv3
# Start Date: October 9 2013

# def diffmaps()

# Input: 
#    - data matrix:  data(i,j) corresponds to data point i, feature dimension j
#    - n: number of desired dimensions to reduce/change to. Constraint: n <= data points
#    - sigma = controls neighborhood radius. The epsilon of the paper equals 2*sigma**2
#    - t: controls diffusion radius
#
# Output: 
#    - reduced data matrix with the same number of data points, and n columns or
#    feature dimensions


#pts = matrix(data)


from pylab import *


# Simple test input

data = zeros((2,2), dtype=np.float32)
data[0,1] = 1


def pairwise_row_distance(data):
# pairwise distance between mydata rows
  
  r = data.shape[0]
  w = zeros((r,r), dtype=np.float32)
  for i in range(r):
    for j in range(i+1,r):
      w[i,j] = norm(data[i]-data[j])
      w[j,i] = w[i,j]

  return w


# default parameters ---------
#sigma = 1
sigma = 0.5 
t = 2


epsilon = 2*sigma*sigma  # XXX  redo this since Gaussian is not normalized

d = pairwise_row_distance(data)
w = exp(-d*d/epsilon)
#np.linalg.eigh(p)
