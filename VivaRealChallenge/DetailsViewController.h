//
//  DetailsViewController.h
//  VivaRealChallenge
//
//  Created by Roger Luan on 11/5/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailsViewModel;
@class Game;

@interface DetailsViewController : UIViewController

@property (strong,nonatomic) Game* thisGame;

- (instancetype) init;

@end
