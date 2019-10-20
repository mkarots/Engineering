import uuid


class TrelloClientException(Exception):
    pass

class InvalidOperationException(TrelloClientException):
    pass


class NotAllowedException(TrelloClientException):
    pass



class TrelloClientInterface:

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

    def __init__(self, name, nodeType, parent=None, siblings=None):
        self.uid=uuid.uuid1()
        self.parent=parent
        self.name=name
        self.nodeType=nodeType
        self.siblings=siblings
    
    def __str__(self):
        return f'{self.__class__.__name__}(uid={self.uid!s}, name={self.name!s}, nodeType={self.nodeType!s}, parent={self.parent!s})'

    def __repr__(self):
        return f'{self.__class__.__name__}(uid={self.uid!r}, name={self.name!r}, nodeType={self.nodeType!r}, parent={self.parent!r})'

    def __eq__(self, other):
        return isinstance(self.__class__, other) and self.uid == other.uid

    def __hash__(self):
        return hash((self.uid))
    
    def move(self, source, target):
        raise NotImplementedError('Subclasses must implement the move functionality')
    
    def set_name(self, name):
        self.name=name
    
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
    
class Board(TrelloNode):
    
    def __init__(self, url, name, description, user, settings={}):
        self.url = url
        self.name = name
        self.description = description
        self.user = user
        self.settings = settings

    def __str__(self):
        return f'{self.__class__.__name__}(uid={self.uid!s}, url={url!s}, name={name!s}, description={description!s}, user={user!s}, settings={settings!s})'

    def __repr__(self):
        return f'{self.__class__.__name__}(uid={self.uid!r}, url={url!r}, name={name!r}, description={description!r}, user={user!r}, settings={settings!r})'


class Card(TrelloNode):
    pass

class List(TrelloNode):
    pass

class Bucket(TrelloNode):
    pass


