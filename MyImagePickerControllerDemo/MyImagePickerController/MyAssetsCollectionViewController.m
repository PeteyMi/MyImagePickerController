//
//  MyAssetsCollectionViewController.m
//  MyImagePickerControllerDemo
//
//  Created by Petey on 5/24/14.
//  Copyright (c) 2014 Petey. All rights reserved.
//

#import "MyAssetsCollectionViewController.h"
#import "MyAssetsCollectionViewCell.h"
#import "MyAssetsBrowserViewController.h"

NSString* assetsCellIdentifier = @"assetsCellIdentifier";

@interface MyAssetsCollectionViewController ()

@property(nonatomic, strong) NSMutableArray*    assets;

@end

@implementation MyAssetsCollectionViewController
@synthesize assetsGroup = _assetsGroup;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithCollectionViewLayout:layout]) {
        // Register cell class
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        [self.collectionView registerClass:[MyAssetsCollectionViewCell class]
                forCellWithReuseIdentifier:assetsCellIdentifier];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAssetsGroup:(ALAssetsGroup *)assetsGroup
{
    _assetsGroup = assetsGroup;
    
    self.assets = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [weakSelf.assets addObject:result];
        }
    }];
    [self.collectionView reloadData];
}
-(void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection
{
    self.collectionView.allowsMultipleSelection = allowsMultipleSelection;
    
}
-(BOOL)allowsMultipleSelection
{
    return self.collectionView.allowsMultipleSelection;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetsGroup.numberOfAssets;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyAssetsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:assetsCellIdentifier forIndexPath:indexPath];

    cell.delegate = self;
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    cell.asset = asset;
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(77.5, 77.5);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset* asset = [self.assets objectAtIndex:indexPath.row];
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(assetsCollectionViewController:didSelectAsset:)]) {
        [_delegate performSelector:@selector(assetsCollectionViewController:didSelectAsset:) withObject:self withObject:asset];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset* asset = [self.assets objectAtIndex:indexPath.row];
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(assetsCollectionViewController:didDeselectAsset:)]) {
        [_delegate assetsCollectionViewController:self didDeselectAsset:asset];
    }
}
-(void)assetsCollectionViewCell:(id)cell tapAtIndexPath:(NSIndexPath*)indexPath
{
    MyAssetsBrowserViewController* assetsBrowserViewController = [[MyAssetsBrowserViewController alloc] init];
    
    [self.navigationController pushViewController:assetsBrowserViewController animated:YES];
}
@end
