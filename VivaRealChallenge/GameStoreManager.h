//
//  GameStoreManager.h
//  VivaRealChallenge
//
//  Created by Roger Luan on 11/5/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CompletionBlocks.h"

@interface GameStoreManager : NSObject

+ (void) saveGameList:(NSArray*)gameList completion:(GameListFetchCompletionBlock)completion;
+ (void) fetchLocalGameList:(GameListFetchCompletionBlock)completion;
+ (void) fetchGameAtIndex:(NSInteger)index completion:(GameListFetchCompletionBlock)completion;

@end
