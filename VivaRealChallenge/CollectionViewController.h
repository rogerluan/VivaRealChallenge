//
//  CollectionViewController.h
//  VivaRealChallenge
//
//  Created by Roger Luan on 11/5/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionViewModel;

@interface CollectionViewController : UICollectionViewController

- (instancetype) initWithModel:(CollectionViewModel*)viewModel;

@end
