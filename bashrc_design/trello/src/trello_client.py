import uuid
import os


class TrelloClientException(Exception):
    pass

class InvalidOperationException(TrelloClientException):
    pass


class NotAllowedException(TrelloClientException):
    pass

class TrelloClientInterface:
    
    def __init__(self):
        self.apiKey = os.environ.get("TRELLO_API_KEY")

    def get_boards(self):
        raise NotImplementedError("This is the interface of the client")

    def get_board(self, boardId):
        raise NotImplementedError("This is the interface of the client")

    def get_cards(self, boardId):
        raise NotImplementedError("This is the interface of the client")

    def get_card(self, cardId):
        raise NotImplementedError("This is the interface of the client")

    def move_card(self, source, target):
        raise NotImplementedError("This is the interface of the client")
    
    def update_card(self, cardId):
        raise NotImplementedError("This is the interface of the client")

    def add_card_to_board(self, cardId, boardId):
        raise NotImplementedError("This is the interface of the client")
    
    def create_new_board(self, boardObject):
        raise NotImplementedError("This is the interface of the client")



class TrelloNode:

    def __init__(self, name, nodeType, nextNode=None, previousNode=None):
        self.uid = uuid.uuid1()
        self._name = name
        self.nodeType = nodeType
        self.nextNode = nextNode
        self.previousNode = previousNode
    
    def __str__(self):
        return f'{self.__class__.__name__}(uid={self.uid!s}, name={self._name!s}, nodeType={self.nodeType!s}, nextNode={self.nextNode!s}, previousNode={self.previousNode!s})'

    def __repr__(self):
        return f'{self.__class__.__name__}(uid={self.uid!r}, name={self._name!r}, nodeType={self.nodeType!r}, nextNode={self.nextNode!r}, previousNode={self.previousNode!r})'

    def __eq__(self, other):
        return isinstance(self.__class__, other) and self.uid == other.uid

    def __hash__(self):
        return hash((self.uid))
    
    @property
    def name(self):
        return self.name

    def set_name(self, name):
        self.name = name
    
    def set_sibling(self, node=None):
        if not node:
            raise InvalidOperationException("Node should not be None.")
        self.siblings.append(node)

    def set_parent(self, node, force=False):
        if not node:
            raise InvalidOperationException("Node should not be None.")
        if not self.parent:
            self.parent=node
        if self.parent and force == True:
            self.parent=node
        else:
            raise NotAllowedException(f"Node {self} already has a parent {self.parent}")
    
    def move(self, target):
        raise NotImplementedError("Subclasses should implement this interface")



class Board(TrelloNode):
    
    def __init__(self, name, url, description, user, settings={}):
        self.name = name
        self.url = url
        self.description = description
        self.user = user
        self.settings = settings

    def __str__(self):
        return f'{self.__class__.__name__}(uid={self.uid!s}, url={url!s}, name={name!s}, description={description!s}, user={user!s}, settings={settings!s})'

    def __repr__(self):
        return f'{self.__class__.__name__}(uid={self.uid!r}, url={url!r}, name={name!r}, description={description!r}, user={user!r}, settings={settings!r})'


class Card(TrelloNode):
    
    def __init__(self, board=None, bucket=None, checklist=None):
        self.board = board
        self.bucket = bucket
        self.checklist = checklist
    
    def __repr__(self):
        return f'{self.__class__.__name__}()'

    def __str__(self):
        return f'{self.__class__.__name__}()'

    @property
    def name(self):
        return self._name


class ListBucket(TrelloNode):
    
    def __init__(self):
        pass

    def __repr__(self):
        return f'{self.__class__.__name__}()'

    def __str__(self):
        return f'{self.__class__.__name__}()'
