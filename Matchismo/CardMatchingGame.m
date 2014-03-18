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

@property (nonatomic, readwrite) NSString *moveResults;

@end

@implementation CardMatchingGame

@synthesize numberOfCardsToMatch;

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
        withHowManyMatchingCards:(int)matchMode
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
        self.numberOfCardsToMatch = (matchMode ==0) ? 2 : 3;
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
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *otherMatchableCards = [[NSMutableArray alloc] init];
            NSMutableArray *otherMatchableCardsContents = [[NSMutableArray alloc] init];
            
            // Look for PLAYABLE cards (faceUp)
            for (Card *matchableCard in self.cards) {
                if (matchableCard.isChosen && !matchableCard.isMatched) {
                    // Populate an array of comparable cards
                    [otherMatchableCards addObject:matchableCard];
                    [otherMatchableCardsContents addObject:matchableCard.contents];
                }
            }
        
            NSLog(@"================================================================");
            int counter = 0;
            for (Card *myCard in self.cards) {
                NSLog(@"Card # %d %@ : isChosen: %d : isMatched: %d", counter, myCard.contents, myCard.isChosen, myCard.isMatched);
                counter++;
            }
        
            NSLog(@"NUMBER OF CARDS TO MATCH: %d", self.numberOfCardsToMatch);
            
            // TODO: Add a text label somewhere which desribes the results of the last consideration by the CardMatchingGame of a card choice by the user.
            // Examples:
            // 1) “Matched J♥ J♠ for 4 points.” or
            // 2) “6♦ J♣ don’t match! 2 point penalty!”
            // 3) “8♦” if only one card is chosen or even blank if no cards are chosen.
            
            // MATCHING HAPPENS HERE
            if ([otherMatchableCards count] > 0) {
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        // If we find another chosen, unmatched card, check to see if it matches using the score
                        int matchScore = [card match:otherMatchableCards];
                        if (matchScore) {
                            self.moveResults = [NSString stringWithFormat:@"%@, %@", card.contents, otherCard.contents];
                            self.score += matchScore * MATCH_BONUS;
                            // if it's a match mark all matched cards as MATCHED
                            if ([otherMatchableCards count] == numberOfCardsToMatch - 1) {
                                self.moveResults = [NSString stringWithFormat:@"Matched %@ for %d points!", [[[otherMatchableCardsContents componentsJoinedByString:@", "] stringByAppendingString:@" and "] stringByAppendingString:card.contents], matchScore * MATCH_BONUS];
                                card.matched = YES;
                                for (Card *myCard in self.cards ){
                                    if (myCard.isChosen && !myCard.isMatched) {
                                        myCard.matched = YES;
                                    }
                                }
                            }
                        } else {
                            // Impose PENALTY for NO_MATCH
                            self.score -= MISMATCH_PENALTY;
                            self.moveResults = [NSString stringWithFormat:@"%@ don't match! %d point penalty!", [[[otherMatchableCardsContents componentsJoinedByString:@", "] stringByAppendingString:@" and "] stringByAppendingString:card.contents], MISMATCH_PENALTY];
                            
                            // Unselect card(s)
                            for (Card *myCard in self.cards ){
                                if (myCard.isChosen && !myCard.isMatched) {
                                    myCard.chosen = NO;
                                }
                            }
                        }
                    }
                }
            } else {
                self.moveResults = card.contents;
            }
            card.chosen = YES;
        }
        // Choosing cards ALWAYS imposes a COSR
        self.score -= COST_TO_CHOOSE;
        self.moveResults = [NSString stringWithFormat:@"Flipped up %@", card.contents];
    }
}

@end
