//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Alejandro Ramirez on 2/11/14.
//  Copyright (c) 2014 inerdtia. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
// We need a property for our CARD MATCHING GAME MODEL
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardsToMatch;

@end

@implementation CardGameViewController

// Lazy instantiation of CARD MATCHING GAME MODEL property
-(CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]
                                           withHowManyMatchingCards:self.cardsToMatchSegmentedControl.selectedSegmentIndex];
    return _game;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.cardsToMatch.enabled = FALSE;
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

// ASSIGNMENT 2 - Add a button to redeal all the cards
// If time allows, add Dialog box to confirm...
- (IBAction)dealCards:(UIButton *)sender {
    // nil the game and reset status
    self.game = nil;
    self.scoreLabel.text = @"Score: 0";
    [self updateUI];
    self.cardsToMatch.enabled = YES;
}

- (IBAction)cardsToMatchChanged:(UISegmentedControl *)sender {
    [self.game setNumberOfCardsToMatch:self.cardsToMatchSegmentedControl.selectedSegmentIndex+2];
}


-(void)updateUI
{
    // Cycle through all the cardButtons and based on the corresponding card in our Model...
    // ...we'll set the title and BKG image of the cardBUtton
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];

        // If a card is matched, we can disable the cardButton
        cardButton.enabled = !card.isMatched;
        
        // Update the score (using the same code we used for Flips)
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        
        // Update the Move Results Label
        self.moveResultsLabel.text = self.game.moveResults;
    }
}

-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end