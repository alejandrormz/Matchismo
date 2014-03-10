//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Alejandro Ramirez on 2/13/14.
//  Copyright (c) 2014 inerdtia. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

// INIT will contain everything necessary to initialize a
// Playing Card Deck.
// We override a method that Deck inherits from NSObject: init

// "instanceType" tells the compiler that this METHOD
// returns an OBJECT which will be the same type as the object
// that this message was sent to
// == ALWAYS USE THIS RETURN TYPE FOR YOUR init METHODS ==
-(instancetype)init {
    self = [super init];
    
    // Check if superclass can initialize itself
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    
    return self;
}


@end
