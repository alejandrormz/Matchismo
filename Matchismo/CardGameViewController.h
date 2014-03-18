//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Alejandro Ramirez on 2/11/14.
//  Copyright (c) 2014 inerdtia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardGameViewController : UIViewController


@property NSString *cardName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardsToMatchSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *moveResultsLabel;

@end
