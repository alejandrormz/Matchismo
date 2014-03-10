//
//  PlayingCard.h
//  Matchismo
//
//  Created by Alejandro Ramirez on 2/13/14.
//  Copyright (c) 2014 inerdtia. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit; // ♠︎,♣︎,♥︎,♦︎
@property (nonatomic) NSUInteger rank; // 0 - 13 (No rank - King)

+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
