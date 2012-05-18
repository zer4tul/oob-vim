#!/usr/bin/env python

import unittest
import sys
import os

sys.path.append(os.curdir)
sys.path.append(os.pardir)
sys.path.append(os.path.join(os.curdir, 'tests'))

tests = os.listdir(os.curdir)
tests = [n[:-3] for n in tests if n.startswith('test') and n.endswith('.py')]

teststests = os.path.join(os.curdir, 'tests')
if os.path.isdir(teststests):
    teststests = os.listdir(teststests)
    teststests = [n[:-3] for n in teststests if n.startswith('test') \
            and n.endswith('.py')]
    modules_to_test = tests + teststests
else:
    modules_to_test = tests

def suite():
    alltests = unittest.TestSuite()
    for module in map(__import__, modules_to_test):
        alltests.addTest(unittest.findTestCases(module))
    return alltests

if __name__ == '__main__':
    unittest.main(defaultTest='suite')

