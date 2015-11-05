//
//  CompletionBlocks.h
//  VivaRealChallenge
//
//  Created by Roger Luan on 11/5/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#ifndef CompletionBlocks_h
#define CompletionBlocks_h


/**
 *  @author Roger Oba
 *
 *  Completion block called when fetching the games list.
 *
 *  @param error    NSError containing any error that may occur.
 *  @param gameList NSArray containing the requested game list.
 */
typedef void(^GameListFetchCompletionBlock)(NSError *error,NSArray *gameList);

/**
 *  @author Roger Oba
 *
 *  Completion block called when configuring a collection view cell.
 *
 *  @param gamePoster UIImage containing the game poster.
 *  @param gameTitle  NSString containing the game title.
 */
typedef void(^CellConfigurationBlock)(UIImage *gamePoster,NSString *gameTitle);

/**
 *  @author Roger Oba
 *
 *  Completion block called when doing an image request on the web.
 *
 *  @param error      NSError containing any error that may occur.
 *  @param gamePoster UIImage containing the game poster.
 */
typedef void(^ImageRequestBlock)(UIImage *gamePoster);


typedef void(^didFetchGameListBlock)(NSArray *gameList);
typedef void(^didReturnErrorBlock)(UIAlertController *errorAlertController);


#endif /* CompletionBlocks_h */
