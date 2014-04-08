//
//  SetCard.h
//  Matchismo
//
//  Created by Alejandro Ramirez on 3/28/14.
//  Copyright (c) 2014 inerdtia. All rights reserved.
//

#import "Card.h"

/*
 *  Each card in the Set Game has the following features:
 *  NUMBER:  1, 2, 3
 *  SYMBOL:  Diamond, Squiggle, Oval
 *  SHADING:    Solid, Stripes, Clear
 *  COLOR:   Red, Green, Purple
 */

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic,strong) NSString *shading;
@property (nonatomic,strong) NSString *color;

+(NSArray *)validSymbols;
+(NSArray *)validShadings;
+(NSArray *)validColors;

@end