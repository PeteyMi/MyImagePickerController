//
//  MyAssetsCollectionViewController.h
//  MyImagePickerControllerDemo
//
//  Created by Petey on 5/24/14.
//  Copyright (c) 2014 Petey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class MyAssetsCollectionViewController;

@protocol MyAssetsCollectionViewControllerDelegate <NSObject>

- (void)assetsCollectionViewController:(MyAssetsCollectionViewController *)assetsCollectionViewController didSelectAsset:(ALAsset *)asset;
- (void)assetsCollectionViewController:(MyAssetsCollectionViewController *)assetsCollectionViewController didDeselectAsset:(ALAsset *)asset;
- (void)assetsCollectionViewController:(MyAssetsCollectionViewController *)assetsCollectionViewController tapAsset:(ALAsset *)asset;
@end

@interface MyAssetsCollectionViewController : UICollectionViewController<UICollectionViewDelegateFlowLayout>

@property(nonatomic, assign) id<MyAssetsCollectionViewControllerDelegate> delegate;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property(nonatomic, assign) BOOL allowsMultipleSelection;

@end
