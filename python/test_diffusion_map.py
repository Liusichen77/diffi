#-*- coding: utf8 -*-
# Tests 

import unittest
from diffusion_map import diffusion_map
from pylab import *

class TestDiff(unittest.TestCase):

  def test_sanity0(self):
    data = empty(())
    self.assertRaises(Exception, diffusion_map, data)

  def test_sanity1(self):
    data = zeros((1,1), dtype=np.float32)
    diff = diffusion_map(data)
    self.assertEqual(diff.size, 0)

  def test_dimension_augmentation(self):
    """"diff can actually increase dimension!"""
    data = zeros((2,1), dtype=np.float32)
    diff = diffusion_map(data, d=1)
    self.assertEqual(diff.size, 2)
    # output will be zeros since P will be constant 0.5
    # which has a non-empty null space
    # moreover, even though we specified d=2, it forces 1D since its all we
    # have after discarding the higest eigenvalue dimension
    self.assertEqual(diff[0,0], [0])
    self.assertEqual(diff[1,0], [0])
    # picking the right #dims does same
    diff = diffusion_map(data, d=1)
    self.assertEqual(diff.size, 2)
    self.assertEqual(diff[0,0], [0])
    self.assertEqual(diff[1,0], [0])
    # picking #dims zero gives empty
    diff = diffusion_map(data, d=0)
    self.assertEqual(diff.size, 0)

  def test_single_3D_point(self):
    """ one point is always reduced to zero dimensions since we always throw
    away the first eigenvector 
    """
    data = zeros((1,3), dtype=np.float32)
    diff = diffusion_map(data,d=1)
    self.assertEqual(diff.size, 0)

  def test_repeated_points_still_map_together(self):
   # for i in range(10000):
      data = 10*rand(3,5)
      # diff = diffusion_map(data,d=2,t=1)
      data = vstack((data, data[1]))
      data = vstack((data, data[1]))
      diff_repeat = diffusion_map(data,d=2,t=1)
      # result gets altered by repeating point
      # np.testing.assert_not_almost_equal(diff[0],diff_repeat[0],10)
      # but at least repeated point still maps to same so. In theory only one
      # dimension could have been better used though
      # 
      # Also note how the precision is very bad in absolute numbers!
      # If you use equality up to 2 decimal places, this test sometimes fails.
      np.testing.assert_almost_equal(diff_repeat[1],diff_repeat[3],1)
      np.testing.assert_almost_equal(diff_repeat[1],diff_repeat[4],1)

if __name__ == '__main__':
  suite = unittest.TestLoader().loadTestsFromTestCase(TestSequenceFunctions)
  unittest.TextTestRunner(verbosity=2).run(suite)
