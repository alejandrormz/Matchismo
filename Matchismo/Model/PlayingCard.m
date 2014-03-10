//
//  PlayingCard.m
//  Matchismo
//
//  Created by Alejandro Ramirez on 2/13/14.
//  Copyright (c) 2014 inerdtia. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    // Only matches 1 card;
    // (will have to change this for assignment 2)
    if ([otherCards count] == 1) {
        // There should be only 1 card in the array...!
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            // Give 4 points for matching the rank
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            // Give 1 point for matching the suit only
            score = 1;
        }
    }
    
    return score;
}

// Override the getter to return a suitable NNString
-(NSString *)contents
{
    
    // To better represent card ranks:
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];

}

@synthesize suit = _suit; // because we provide getter and setter

+(NSArray *)validSuits {
    return @[@"♠️",@"♣️",@"♥️",@"♦️"];
}

-(void)setSuit:(NSString *)suit {
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

// Now let's override the Getter for SUIT to return a NIL suit
-(NSString *)suit {
    return _suit ? _suit : @"?";
}


+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank {
    return [[self rankStrings] count]-1;
}

// Ensure RANK is never set to an improper value
// SETTER
-(void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


@end
