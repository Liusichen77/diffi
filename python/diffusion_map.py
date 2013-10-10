#-*- coding: utf8 -*-
#
# Authors: Ricardo Fabbri <rfabbri@iprj.uerj.br>
#
# Partly based on code by Lucia Pinto and Mauro Amorim
# Licence: GPLv3
# Start Date: October 9 2013

from pylab import *


def diffusion_map(data, epsilon=1, t=2, d=2):
  """
  Computes Diffusion Maps by Zucker, Coiffman, Lafon, et. al.
   Input: 
      - data matrix:  data(i,j) corresponds to data point i, feature dimension j
      - epsilon = controls neighborhood radius.
      - t: controls diffusion radius
      - d: number of desired dimensions to reduce/change to. Constraint: d <= #datapoints-1

   Output: 
      - reduced data matrix with the same number of data points, and d columns or
      feature dimensions
  """

  dist = pairwise_row_distance(data)
  p = exp(-dist*dist / epsilon)

  r = p.shape[0]
  for i in range(r):
    p[i] /= sum(p[i])
    
  # eigendecomposition --------
  lamb, psi = eigh(p)

  idx = lamb.argsort()
  lamb = lamb[idx]
  psi = psi[:,idx]

  lamb = lamb[::-1]
  psi = psi[:,::-1]

  # reduce dimensions
  lamb = lamb[1:d]
  psi = psi[:,1:d]

  # build map -----------------
  diff = dot(psi, diag(lamb**t))
  return diff

def pairwise_row_distance(data):
  """pairwise distance between data matrix rows"""
  r = data.shape[0]
  w = zeros((r,r), dtype=np.float32)
  for i in range(r):
    for j in range(i+1,r):
      w[i,j] = norm(data[i]-data[j])
      w[j,i] = w[i,j]
  return w