//
//  Card.h
//  Matchismo
//
//  Created by Alejandro Ramirez on 2/13/14.
//  Copyright (c) 2014 inerdtia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards;

@end
