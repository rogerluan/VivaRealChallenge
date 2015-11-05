//
//  TwitchManager.h
//  VivaRealChallenge
//
//  Created by Roger Luan on 11/5/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "CompletionBlocks.h"

@interface TwitchManager : NSObject


/**
 *  @author Roger Oba
 *
 *  Returns a list of games objects sorted by number of current viewers on Twitch, most popular first.
 *
 *  @param limit      Maximum number of objects in array. Default is 10. Maximum is 100.
 *  @param completion The completion block to call when the request completes.
 */
- (void) fetchGameListWithLimit:(NSInteger)limit completion:(GameListFetchCompletionBlock)completion;


@end
