
"""Unit test file for app.py"""

import app
import unittest

class TestApp(unittest.TestCase):
    """Unit tests defined for app.py"""


    def test_response(self):
        tester = app.app.test_client(self)
        response = tester.get('/tree')
        statuscode = response.status_code
        self.assertEqual(statuscode, 200)


    def test_response_type(self):
        tester = app.app.test_client(self)
        response = tester.get('/tree')
        self.assertEqual(response.content_type,"application/json")



if __name__ == "__main__":
    unittest.main()

