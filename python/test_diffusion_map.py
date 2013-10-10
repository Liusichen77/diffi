#-*- coding: utf8 -*-
# Tests 

import unittest
import diff

class TestDiff(unittest.TestCase):

#    def setUp(self):

    def test_sanity(self):
      data = empty(())
      raises = False
      self.assertRaises(Exception, diffusion_map, data)

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
