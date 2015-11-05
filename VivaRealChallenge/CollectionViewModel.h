//
//  CollectionViewModel.h
//  VivaRealChallenge
//
//  Created by Roger Luan on 11/5/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CompletionBlocks.h"

@class TwitchManager;
@class GameStoreManager;
@class GameCardViewCell;

@interface CollectionViewModel : NSObject

@property (nonatomic, copy) didFetchGameListBlock didFetchGameList;
@property (nonatomic, copy) didReturnErrorBlock didError;

/**
 *  @author Roger Oba
 *
 *  Initializes a new instance of the collection view model with a twitch manager and a game store manager.
 *
 *  @param twitchManager Twitch manager used to initialize the collection view model.
 *  @param gameStoreManager  Game story manager used to initialize the collection view model.
 *
 *  @return Returns the initialized Collection View Model.
 */
- (instancetype) initWithTwitchManager:(TwitchManager*)twitchManager gameStoreManager:(GameStoreManager*)gameStoreManager;

/**
 *  @author Roger Oba
 *
 *  Sends a request to fetch the games list.
 */
- (void) fetchGameList;
@end
