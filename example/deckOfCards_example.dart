import 'package:deckOfCards/deckOfCards.dart';

main() {


    //Card layout
    DeckOfCards d = DeckOfCards(); //..cardDeck = resourceManager.getTextureAtlas("playDeck");
    //if need jokers change here
   List<Card> deck = d.deck();
  
    deck.forEach((Card c){
      print(c.name);
    });
  }
