//
//  CollectionViewController+Factory.m
//  VivaRealChallenge
//
//  Created by Roger Luan on 11/5/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "CollectionViewController+Factory.h"
#import "CollectionViewModel.h"
#import "TwitchManager.h"
#import "GameStoreManager.h"

@implementation CollectionViewController (Factory)

+ (instancetype) factoryInstance {
	CollectionViewModel *viewModel = [[CollectionViewModel alloc] initWithTwitchManager:[TwitchManager new] gameStoreManager:[GameStoreManager new]];
	CollectionViewController *viewController = [[CollectionViewController alloc] initWithModel:viewModel];
	viewController.title = NSLocalizedString(@"Top 50 Games", nil);
	return viewController;
}

@end
