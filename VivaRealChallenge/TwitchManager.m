//
//  TwitchManager.m
//  VivaRealChallenge
//
//  Created by Roger Luan on 11/5/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "TwitchManager.h"
#import <AFNetworking.h>
#import "GameStoreManager.h"

@implementation TwitchManager

static NSString * const BaseURLString = @"https://api.twitch.tv/kraken/games/top";

- (void) fetchGameListWithLimit:(NSInteger)limit completion:(GameListFetchCompletionBlock)completion {
	
	if (!limit || (limit < 1) || (limit > 100)) {
		limit = 10;
	}
	
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	
	NSDictionary *parameters = @{@"limit":[NSString stringWithFormat:@"%ld",(long)limit]};
	
	[manager GET:BaseURLString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
		[GameStoreManager saveGameList:[responseObject objectForKey:@"top"] completion:^(NSError *error, NSArray *gameList) {
			completion(nil,gameList);
		}];
		
	} failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
		NSLog(@"Game list fetch failed with error: %@",error.localizedDescription);
		NSLog(@"Trying to fetch from local storage now.");
		[GameStoreManager fetchLocalGameList:^(NSError *error, NSArray *gameList) {
			if (!error) {
				NSLog(@"Successfully fetched from local storage.");
				completion(nil,gameList);
			}
			else {
				NSLog(@"Couldn't fetch from local storage. Probably this is the first time you're using this app.");
				completion(error,nil);
			}
		}];
	}];
}

@end
