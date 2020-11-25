//
//  SecondViewController.h
//  TicketsApp
//
//  Created by Vit K on 25.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIView *searchBarPlaceholder;
@property (nonatomic, strong) NSArray<UIImage *> *images;
@property (nonatomic, strong) NSArray<UIImage *> *searchImages;
@property (nonatomic, strong) UISearchController *searchController;
@end


NS_ASSUME_NONNULL_END
