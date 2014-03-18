//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Alejandro Ramirez on 2/26/14.
//  Copyright (c) 2014 inerdtia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck
        withHowManyMatchingCards:(int)matchMode;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)NSInteger score;

@property (nonatomic) NSInteger numberOfCardsToMatch;

@property (nonatomic, readonly) NSString *moveResults;

@end
