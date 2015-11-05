//
//  CollectionViewController+Factory.h
//  VivaRealChallenge
//
//  Created by Roger Luan on 11/5/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController (Factory)

/**
 *  @author Roger Oba
 *
 *  Instanciates a new collection view model with a new twitch manager and game store manager, and returns a CollectionViewController.
 *
 *  @return CollectionViewController A factored View Controller
 */
+ (instancetype) factoryInstance;


@end
