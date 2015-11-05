//
//  GameStoreManager.m
//  VivaRealChallenge
//
//  Created by Roger Luan on 11/5/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "GameStoreManager.h"
#import "Game+CoreDataProperties.h"

static NSString * const entityName = @"Game";

@interface GameStoreManager()

@end

@implementation GameStoreManager

+ (void) saveGameList:(NSArray*)gameList completion:(GameListFetchCompletionBlock)completion {
	
	if (gameList.count > 0) {
		[self dropCurrentDatabase]; //so it always replaces instead of just creating more objects
	
		NSManagedObjectContext *moc = [self managedObjectContext];
		
		NSMutableArray *games = [NSMutableArray array];
		
		for (NSDictionary *gameDictionary in gameList) {
			Game *newGame = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:moc];
			newGame.title = [[gameDictionary objectForKey:@"game"] objectForKey:@"name"];
			newGame.posterURL = [[[gameDictionary objectForKey:@"game"] objectForKey:@"box"] objectForKey:@"large"];
			newGame.views = [gameDictionary objectForKey:@"viewers"];
			newGame.channels = [gameDictionary objectForKey:@"channels"];
			newGame.position = [NSNumber numberWithInteger:[gameList indexOfObject:gameDictionary]];
			
			
			NSError *error = nil;
			if(![moc save: &error]) {}
			
			[games addObject:newGame];
		}
		
//		NSLog(@"games: %@",games);
		
		NSError *error = nil;
		if(![moc save: &error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			completion(error,nil);
		}
		else {
			completion(nil,games);
		}
	}
}

+ (void) fetchLocalGameList:(GameListFetchCompletionBlock)completion {
	[self fetchGameAtIndex:-1 completion:^(NSError *error, NSArray *gameList) {
		if (!error) {
			completion(nil,gameList);
		}
		else {
			completion(error,nil);
		}
	}];
}

+ (void) fetchGameAtIndex:(NSInteger)index completion:(GameListFetchCompletionBlock)completion {
	
	NSManagedObjectContext *moc = [self managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:moc];
	[fetchRequest setEntity:entity];
	
	if (index > -1) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"position == %@", index];
		[fetchRequest setPredicate:predicate];
	}
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"position"
																   ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
	
	NSError *error = nil;
	NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
	if (error) {
		completion(error,nil);
	}
	else if (fetchedObjects == nil || fetchedObjects.count == 0){
		
		NSDictionary *userInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(@"No Games Found", nil),
								   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"There is nothing in the local storage. This is probably the first time you use this app.", nil),
								   NSLocalizedRecoveryOptionsErrorKey: NSLocalizedString(@"Please check your internet connection.", nil)
								   };
		NSError *errorMessage = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier]
													code:-1
												userInfo:userInfo];
		completion(errorMessage,nil);
	}
	else {
		completion(nil,fetchedObjects);
	}
}

#pragma mark - Helpers -

+ (void) dropCurrentDatabase {
	
	NSManagedObjectContext *moc = [self managedObjectContext];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:moc]];
	[fetchRequest setIncludesPropertyValues:NO];
	
	NSError *error = nil;
	NSArray *fetchedResults = [moc executeFetchRequest:fetchRequest error:&error];

	if (fetchedResults == nil || error) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		return;
	}
	
	for (NSManagedObject *game in fetchedResults) {
		[moc deleteObject:game];
	}
	
	error = nil;
	if(![moc save: &error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
}

+ (NSManagedObjectContext *) managedObjectContext {
	NSManagedObjectContext *context = nil;
	id delegate = [[UIApplication sharedApplication] delegate];
	if ([delegate performSelector:@selector(managedObjectContext)]) {
		context = [delegate managedObjectContext];
	}
	return context;
}


@end
