//
//  Deck.m
//  Matchismo
//
//  Created by Alejandro Ramirez on 2/13/14.
//  Copyright (c) 2014 inerdtia. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

// The getter from the private variable "cards"
-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

-(void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}


// HOMEWORK
-(Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    
    // Protect against zero on an empty array
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    } // Otherwise returns NIL (see above)
    
    return randomCard;
}


@end
