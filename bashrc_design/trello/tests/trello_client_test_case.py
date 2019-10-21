import unittest

class TrelloClientTestCase(unittest.TestCase):
    pass


class TrelloClientInterfaceTestCase(TrelloClientTestCase):

    def test_fails(self):
        self.fail()


class TrelloNodeTestCase(TrelloClientTestCase):

    def test_fails(self):
        self.fail()


class BoardTestCase(TrelloClientTestCase):

    def test_fails(self):
        self.fail()


class CardTestCase(TrelloClientTestCase):
    
    def test_fails(self):
        self.fail()


class ListBucketTestCase(TrelloClientTestCase):
    
    def test_fails(self):
        self.fail()



if __name__=="__main__":
    unittest.main()
