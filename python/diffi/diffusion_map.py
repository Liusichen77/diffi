#-*- coding: utf8 -*-
#
# Authors: Ricardo Fabbri <rfabbri@iprj.uerj.br>
#
# Partly based on code by Lucia Pinto and Mauro Amorim
# Licence: GPLv3
# Start Date: October 9 2013

from pylab import *

import sklearn.metrics.pairwise as pw


import time

def diffusion_map(data, epsilon=1, t=2, d=-1):
  """
  Computes Diffusion Maps by Zucker, Coiffman, Lafon, et. al.
   Input: 
      - data matrix:  data[i,j] corresponds to data point i, dimension j
      - epsilon = controls neighborhood radius.
          epsilon = -1 means automatic determination by max radius
      - t: controls diffusion radius
      - d: number of desired dimensions to reduce/change to. Constraint: d <= #datapoints-1
        Note that the dimension may be increased to the number of datapoints in
        case this is greater than the number of input dimensions.
        d = -1 means maximum dimension.

   Output: 
      - reduced data matrix with the same number of data points, and d columns or
      feature dimensions
  """
  r = data.shape[0]

  if d == -1:
    d = r-1
  elif d >= r :
    print("warning: d=%d is beyond max dimensions %d = #rows - 1" % (d, r-1))
    d = r-1

  time0 = time.time()
  print 'computing pairwise distances'
  #dist = pairwise_row_distance_sq(data)
  dist = pw.pairwise_distances(data)
  print 'pairwise distances executed in %g seconds...' % (time.time() - time0)
  

  if epsilon == -1:
    epsilon = -dist.max()
  else:
    epsilon *= -1

  p = exp(dist*dist / epsilon)

  for i in range(r):
    p[i] /= sum(p[i])
    
  # eigendecomposition --------
  time0 = time.time()
  print 'computing eigendecomposition'
  lamb, psi = eigh(p)
  print 'eigendecomposition executed in %g seconds...' % (time.time() - time0)

  idx = lamb.argsort()
  lamb = lamb[idx]
  psi = psi[:,idx]

  lamb = lamb[::-1]
  psi = psi[:,::-1]

  # reduce dimensions
  lamb = lamb[1:(d+1)]
  psi = psi[:,1:(d+1)]

  # build map -----------------
  diff = dot(psi, diag(lamb**t))
  return diff

def pairwise_row_distance_sq(data):
  """pairwise distance between data matrix rows"""
  r = data.shape[0]
  w = zeros((r,r), dtype=np.float32)
  for i in range(r):
    for j in range(i+1,r):
      d = data[i]-data[j]
      w[i,j] = dot(d,d)
      w[j,i] = w[i,j]
  return w
