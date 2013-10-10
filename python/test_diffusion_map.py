#-*- coding: utf8 -*-
# Tests 

import unittest
from diffusion_map import diffusion_map
from pylab import *

class TestDiff(unittest.TestCase):

#    def setUp(self):

    def test_sanity0(self):
      data = empty(())
      self.assertRaises(Exception, diffusion_map, data)

#    def test_sanity1(self):

#      data = zeros((1,1), dtype=np.float32)
#      diff = diffusion_map(data)

#      data = zeros((2,1), dtype=np.float32)
#      diff = diffusion_map(data)

#      data = zeros((1,3), dtype=np.float32)
#      diff = diffusion_map(data)

#      data = zeros((2,3), dtype=np.float32)
#      diff = diffusion_map(data)


if __name__ == '__main__':
    unittest.main()
