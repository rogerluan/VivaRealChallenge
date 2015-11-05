//
//  DetailsViewController.m
//  VivaRealChallenge
//
//  Created by Roger Luan on 11/5/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "DetailsViewController.h"
#import "Game.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *gamePosterImageView;
@property (strong, nonatomic) IBOutlet UILabel *gameTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *gameChannelsLabel;
@property (strong, nonatomic) IBOutlet UILabel *gameViewsLabel;

@end

@implementation DetailsViewController

static NSString * const StoryboardIdentifier = @"Main";
static NSString * const CollectionViewControllerIdentifier = @"CollectionViewControllerIdentifier";

#pragma mark - Lifecycle

- (instancetype) init {
	
	self = [[UIStoryboard storyboardWithName:StoryboardIdentifier bundle:nil] instantiateViewControllerWithIdentifier:CollectionViewControllerIdentifier];
	
	if (!self) {
		return nil;
	}

	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupGameInformation];
	
	[self.view layoutIfNeeded];
}

- (void) setupGameInformation {
	
	self.title = [NSString stringWithFormat:@"#%ld",(long)[self.thisGame.position integerValue]+1];
	
	NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.thisGame.posterURL]
												  cachePolicy:NSURLRequestReturnCacheDataElseLoad
											  timeoutInterval:60];
	
	[self.gamePosterImageView setImageWithURLRequest:imageRequest placeholderImage:[UIImage imageNamed:@"loadingPosterPlaceholder"] success:nil failure:nil];
	self.gameTitleLabel.text = [NSString stringWithFormat:@"#%ld - %@",(long)[self.thisGame.position integerValue]+1,self.thisGame.title];
	self.gameChannelsLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%ld Channels", nil),(long)[self.thisGame.channels intValue]];
	self.gameViewsLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%ld Views", nil),(long)[self.thisGame.views intValue]];
}

@end
