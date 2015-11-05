//
//  CollectionViewController.m
//  VivaRealChallenge
//
//  Created by Roger Luan on 11/5/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewModel.h"
#import "GameCardViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "Game.h"
#import <SVProgressHUD.h>
#import "DetailsViewController.h"

@interface CollectionViewController ()

@property (strong,nonatomic) CollectionViewModel *viewModel;
@property (strong,nonatomic) NSArray<Game*> *gameList;
@property (strong,nonatomic) UIRefreshControl *refreshControl;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"GameCardCell";
static NSString * const mainStoryboardIdentifier = @"Main";
static NSString * const collectionViewControllerIdentifier = @"CollectionViewControllerIdentifier";
static NSString * const gameDetailsSegueIdentifier = @"GameDetailsSegueIdentifier";

#pragma mark - Lifecycle -

- (instancetype) initWithModel:(CollectionViewModel *)viewModel {
	
	self = [[UIStoryboard storyboardWithName:mainStoryboardIdentifier bundle:nil] instantiateViewControllerWithIdentifier:collectionViewControllerIdentifier];
	
	if (!self) {
		return nil;
	}
	
	self.viewModel = viewModel;
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[SVProgressHUD showWithStatus:NSLocalizedString(@"Loading...", nil)];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	[self createRefreshControl];
	[self bindToModel];
	[self.viewModel fetchGameList];
	
	
    // Register cell classes
	[self.collectionView registerNib:[UINib nibWithNibName:@"GameCardViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - UICollectionViewDataSource Methods -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	if (self.gameList.count > 0) {
		return 1;
	}
	else {
		return 0;
	}
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.gameList.count;
}

- (GameCardViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GameCardViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
	[self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void) configureCell:(GameCardViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {
	
	Game *thisGame = [self.gameList objectAtIndex:indexPath.row];
	
	NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:thisGame.posterURL]
												  cachePolicy:NSURLRequestReturnCacheDataElseLoad
											  timeoutInterval:60];
	
	[cell.gamePosterImageView setImageWithURLRequest:imageRequest placeholderImage:[UIImage imageNamed:@"loadingPosterPlaceholder"] success:nil failure:nil];
	cell.gameTitleLabel.text = [NSString stringWithFormat:@"#%ld - %@",[thisGame.position integerValue]+1,thisGame.title];
}

#pragma mark - UICollectionViewDelegate Methods -

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	[self performSegueWithIdentifier:gameDetailsSegueIdentifier sender:self];
}

#pragma mark - Methods - 

- (void) createRefreshControl {
	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self.viewModel action:@selector(fetchGameList)forControlEvents:UIControlEventValueChanged];
	[self.collectionView addSubview:self.refreshControl];
	self.collectionView.alwaysBounceVertical = YES;
}

#pragma mark - View Model -

/**
 *  @author Roger Oba
 *
 *  Binds the View Model to the View Controller.
 */
- (void) bindToModel {
	self.viewModel.didFetchGameList = [self modelDidReturnGameList];
	self.viewModel.didError = [self modelDidReturnError];
}

- (didFetchGameListBlock) modelDidReturnGameList {
	return ^(NSArray *gameList) {
		self.gameList = gameList;
		[self.collectionView reloadData];
		[SVProgressHUD dismiss];
		[self.refreshControl endRefreshing];
	};
}

- (didReturnErrorBlock) modelDidReturnError {
	return ^(UIAlertController *alertController) {
		[SVProgressHUD dismiss];
		[self.refreshControl endRefreshing];
		[self presentViewController:alertController animated:YES completion:nil];
	};
}

#pragma mark - Navigation - 

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:gameDetailsSegueIdentifier]) {

		Game *selectedGame = [self.gameList objectAtIndex:[[self.collectionView indexPathsForSelectedItems] firstObject].row];
		
		DetailsViewController *viewController = (DetailsViewController*)segue.destinationViewController;
		viewController.thisGame = selectedGame;
	}
}

@end
