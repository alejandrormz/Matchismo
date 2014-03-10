//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Alejandro Ramirez on 2/26/14.
//  Copyright (c) 2014 inerdtia. All rights reserved.
//

#import "CardMatchingGame.h"

// Class Extension - put private properties
@interface CardMatchingGame()
@property (nonatomic, readwrite)NSInteger score;
// Keep track of cards
@property (nonatomic, strong) NSMutableArray *cards; // of Cards
@end

@implementation CardMatchingGame

// Lazy Instantiation
-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

/*  ========================
 *  DESIGNATED INITIALIZER
 *  ========================
 *  Iterate through the passed COUNT of CARDS
 *  drawRandomCard from the passed DECK
 *  then addObject: to our NSMutableArray of CARDS each time
 */
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck
{
    // Super class initializes itself
    self = [super init];
    
    // Check for failure and act upon it
    if(self) {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}


-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    // Only allow unmatched cards to be chosen
    if(!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against other chosen cards
            // (iterate through all the cards in the game, looking for unmatched and already chosen
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    // if we find another chosen, unmatched card, check to see if it matches the just chosen card using match: method
                    int matchScore = [card match:@[otherCard]];
                    // If there's a match, bump score!
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        // if it's a match, mark both as MATCHED
                        otherCard.matched = YES;
                        card.matched = YES;
                    
                    } else {
                        // otherwise impose a penalty
                        self.score -= MISMATCH_PENALTY;
                        // In case of MISMATCH, "unchoose" the mismatching other card
                        otherCard.chosen = NO;
                    }
                    break; // can only choose 2 cards for now!
                    }
                }
            // Choosing cards will impose a "cost"
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
    }
}

@end
