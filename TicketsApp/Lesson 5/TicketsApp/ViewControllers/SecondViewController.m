//
//  SecondViewController.m
//  TicketsApp
//
//  Created by Vit K on 25.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "SecondViewController.h"


@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.obscuresBackgroundDuringPresentation = NO;
    _searchController.searchResultsUpdater = self;
    
    _searchImages = [NSArray new];
    self.navigationItem.searchController = _searchController;
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 2 - 1, [UIScreen mainScreen].bounds.size.width / 2 - 1);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGRect frameView = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    
    _searchBarPlaceholder = [[UIView alloc] initWithFrame:frameView];
    [_searchController.searchBar sizeToFit];
    [_searchBarPlaceholder addSubview:_searchController.searchBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.definesPresentationContext = YES;
    [self.view addSubview:_searchBarPlaceholder];
    
    CGRect frame = CGRectMake(self.view.bounds.origin.x, 100, self.view.bounds.size.width, self.view.bounds.size.height - 100);
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    _collectionView.bounds = frame;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ReuseIdentifier"];
    
    [self.view addSubview:_collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_searchImages.count > 0) {
        return _searchImages.count;
    }
    return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"ReuseIdentifier" forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:_images[indexPath.row]];
    return cell;
}

#pragma mark - Поиск просто по description у UIImage

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.description CONTAINS[cd] %@", searchController.searchBar.text];
        _searchImages = [_images filteredArrayUsingPredicate: predicate];
        [_collectionView reloadData];
    }
}


@end
