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
      # diff can actually increase dimension!
      data = zeros((2,1), dtype=np.float32)
      diff = diffusion_map(data,d=2)
      self.assertEqual(diff.size, 2)
      # output will be zeros since P will be constant 0.5
      # which has a non-empty null space
      self.assertEqual(diff[0,0], [0])
      self.assertEqual(diff[1,0], [0])

#      data = zeros((1,3), dtype=np.float32)
#      diff = diffusion_map(data)

#      data = zeros((2,3), dtype=np.float32)
#      diff = diffusion_map(data)


if __name__ == '__main__':
    unittest.main()
