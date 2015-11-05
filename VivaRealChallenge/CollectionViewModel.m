//
//  CollectionViewModel.m
//  VivaRealChallenge
//
//  Created by Roger Luan on 11/5/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "CollectionViewModel.h"
#import "TwitchManager.h"
#import "GameStoreManager.h"
#import "GameCardViewCell.h"
#import "Game.h"
#import "UIImageView+AFNetworking.h"

#define CHALLENGE_REQUIRED_LIMIT 50

@interface CollectionViewModel()

@property (strong,nonatomic) TwitchManager *twitchManager;
@property (strong,nonatomic) GameStoreManager *gameStoreManager;

@property (strong,nonatomic) NSArray *gameList;

@end

@implementation CollectionViewModel

- (instancetype) initWithTwitchManager:(TwitchManager*)twitchManager gameStoreManager:(GameStoreManager*)gameStoryManager {
	
	if (!(self = [super init])) return nil; //if can't init, quit.
	
	self.twitchManager = twitchManager;
	self.gameStoreManager = gameStoryManager;
	return self;
}

#pragma mark - Methods -

- (void) fetchGameList {
	[self.twitchManager fetchGameListWithLimit:CHALLENGE_REQUIRED_LIMIT completion:^(NSError *error, NSArray *gameList) {
		if (!error) {
			[self sendGameList:gameList];
		}
		else {
			[self sendError:error];
		}
	}];
}

#pragma mark - Block Data Refresh -

/**
 *  @author Roger Oba
 *
 *  Notifies the View Controller when the game list is fetched.
 *
 *  @param selfie UIImage instance that represents a Selfie.
 */
- (void) sendGameList:(NSArray*)gameList {
	if (self.didFetchGameList == nil) return;
	
	dispatch_async(dispatch_get_main_queue(), ^{
		self.didFetchGameList(gameList);
	});
}

/**
 *  @author Roger Oba
 *
 *  Notifies the View Controller when an error occurs, composes an UIAlertController to display the error on, and sends it to the View Controller.
 *
 *  @param error NSError instance that represents the occurred error.
 */
- (void) sendError:(NSError*)error {
	if (self.didError == nil) return;
	
	UIAlertController *alert;
	
	if (error.code == 503) {
		alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Service Unavailable", @"nil") message:NSLocalizedString(@"503 - Service Unavailable. Please try again later.", @"nil") preferredStyle:UIAlertControllerStyleAlert];
	}
	else {
		alert = [UIAlertController alertControllerWithTitle:error.localizedDescription message:[NSString stringWithFormat:@"%@\n%@",error.localizedFailureReason,error.localizedRecoveryOptions] preferredStyle:UIAlertControllerStyleAlert];
	}
	
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK") style:UIAlertActionStyleCancel handler:nil];
	[alert addAction:cancelAction];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		self.didError(alert);
	});
}

@end
