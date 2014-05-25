//
//  MyAssetsCollectionViewCell.h
//  MyImagePickerControllerDemo
//
//  Created by Petey on 5/24/14.
//  Copyright (c) 2014 Petey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef NS_ENUM(NSInteger, MyAssetsCollectionCheckmarkStation)
{
    MyAssetsCollectionCheckmarkLeftTop,
    MyAssetsCollectionCheckmarkRightTop,
    MyAssetsCollectionCheckmarkLeftBottom,
    MyAssetsCollectionCheckmarkRightBottom,
};

@interface MyAssetsCollectionViewCell : UICollectionViewCell

@property(nonatomic, assign) id delegate;
@property(nonatomic, strong) ALAsset* asset;
@property(nonatomic, assign) MyAssetsCollectionCheckmarkStation checkmarkStation; //Set checkmark view station, default is MyAssetsCollectionCheckmarkRightBottom;

@end

@interface MyAssetsCollectionCheckmarkView : UIView;

@property(nonatomic, copy) UIColor* normalColor;
@property(nonatomic, copy) UIColor* selectedColor;
@property(nonatomic, assign, getter = isSelected) BOOL selected;

@end

@protocol MyAssetsCollectionViewCellDelegate <NSObject>

-(void)assetsCollectionViewCell:(MyAssetsCollectionViewCell*)cell tapAtIndexPath:(NSIndexPath*)indexPath;

@end