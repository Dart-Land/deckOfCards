import 'dart:math';

import 'package:stagexl/stagexl.dart';

enum cards { king, queen, jack, c10, c09, c08, c07, c06, c05, c04, c03, c02, c01 }
enum Suit { hart, diamond, club, spade, joker, none }

class CardBase {
  int _value;
  String _name;
  Suit _suit;
  bool _hold;
  int _hand;
  int _dealt;
  CardBase();

  //value
  int get value => this._value;
  set value(int value) {
    this._value = value;
  }

  //name
  String get name => this._name;
  set name(String name) {
    this._name = name;
  }

  //suit
  Suit get suit => this._suit;
  set suit(Suit suit) {
    this._suit = suit;
  }

  //hold
  bool get hold => this._hold;
  set hold(bool hold) {
    if (hold == null) {
      this._hold = false;
    } else {
      this._hold = hold;
    }
  }

  //hand
  int get hand => this._hand;
  set hand(int hand) {
    this._hand = hand;
  }

  //dealt
  int get dealt => this._dealt;
  set dealt(int dealt) {
    if (dealt == null) {
      this.dealt = 0;
    } else {
      this._dealt = dealt;
    }
  }
}

class Card extends CardBase {
  Sprite _card;
  Card();

  //card
  Sprite get card => this._card;
  set card(Sprite card) {
    this._card = card;
  }

  CardSizeLocation getCardSize() {
    return CardSizeLocation()
      ..x = _card.x
      ..y = _card.y
      ..width = _card.width
      ..height = _card.height
      ..dealt = _dealt;
  }
}

class DeckOfCards {
  TextureAtlas _cardDeckAssets;

  //cardDeck Deck of cards Assets
  TextureAtlas get cardDeck => this._cardDeckAssets;
  set cardDeck(TextureAtlas cardDeck) {
    this._cardDeckAssets = cardDeck;
  }

  DeckOfCards();
  List<Card> deckJoker() {
    List<Card> cards = List<Card>();

    List<String> suits = List<String>();
    suits = ["club", "diamond", "hart", "spade", "joker"];
    int value = 0;
    suits.forEach((String name) {
      value = 0;
      _cardDeckAssets.getBitmapDatas(name).forEach((BitmapData c) {
        value++;
        Sprite s = Sprite();
        s.addChild(Bitmap(c));

        Card card = Card();
        card.card = s;
        card.suit = whatSuit(name);
        card.value = value;
        card.name = "$name-$value";
        cards.add(card);
      });
    });
    return cards;
  }

  List<Card> deck() {
    List<Card> cards = List<Card>();

    List<String> suits = List<String>();
    suits = ["club", "diamond", "hart", "spade"];
    int value = 0;
    suits.forEach((String name) {
      for (var b in _cardDeckAssets.getBitmapDatas(name)) {
        Card card = Card();
        Sprite s = Sprite();
        s.addChild(Bitmap(b));

        card.card = s;
        card.suit = whatSuit(name);
        card.value = value;
        card.name = "$name-$value";
        cards.add(card);
        value++;
      }
    });
    return cards;
  }

  List<CardBase> deckHandMatch() {
    List<CardBase> cards = List<CardBase>();

    List<String> suits = List<String>();
    suits = ["club", "diamond", "hart", "spade"];
    int value = 0;
    suits.forEach((String name) {
      for (var _ in _cardDeckAssets.getBitmapDatas(name)) {
        CardBase card = CardBase();
        card.suit = whatSuit(name);
        card.value = value;
        card.name = "$name-$value";
        cards.add(card);
        value++;
      }
    });
    return cards;
  }
}

class CardSizeLocation {
  double _x;
  double _y;
  double _width;
  double _height;
  int _dealt;
  CardSizeLocation();

  //x
  double get x => this._x;
  set x(double x) {
    this._x = x;
  }

  //y
  double get y => this._y;
  set y(double y) {
    this._y = y;
  }

  //width
  double get width => this._width;
  set width(double width) {
    this._width = width;
  }

  //height
  double get height => this._height;
  set height(double height) {
    this._height = height;
  }

  //dealt
  int get dealt => this._dealt;
  set dealt(int dealt) {
    this._dealt = dealt;
  }
}

Suit whatSuit(String name) {
  switch (name) {
    case "club":
      return Suit.club;
    case "diamond":
      return Suit.diamond;
    case "hart":
      return Suit.hart;
    case "spade":
      return Suit.spade;
    case "joker":
      return Suit.joker;
    case "none":
      return Suit.none;
    default:
      return null;
  }
}

int suitVal(Suit suit) {
  switch (suit) {
    case Suit.club:
      return 1;
    case Suit.diamond:
      return 14;
    case Suit.hart:
      return 27;
    case Suit.spade:
      return 40;
    case Suit.joker:
      return 53;
    default:
      return null;
  }
}

List<Card> transfer(List<Card> hand) {
  List<Card> x = List<Card>();
  for (Card c in hand) {
    x.add(c);
  }
  return x;
}

List<int> shuffle(int noCards) {
  Random rn = Random();
  List<int> data = List<int>();
  List<int> dataSupply = List<int>();
  int num = 0;
  for (int i = 0; i < noCards; i++) {
    dataSupply.add(i);
    num++;
  }
  for (int i = 0; i < num; i++) {
    int d = rn.nextInt(dataSupply.length);
    data.add(dataSupply[d]);
    dataSupply.removeAt(d);
  }
  return data;
}
