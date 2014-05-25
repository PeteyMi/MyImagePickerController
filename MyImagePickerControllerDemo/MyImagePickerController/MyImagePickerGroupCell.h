//
//  MyImagePickerGroupCell.h
//  MyImagePickerControllerDemo
//
//  Created by Petey on 5/25/14.
//  Copyright (c) 2014 Petey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MyImagePickerThumbnailView : UIView

@property(nonatomic, copy) NSArray* thumbnailImages;

@end

@interface MyImagePickerGroupCell : UITableViewCell

@property(nonatomic, readonly) MyImagePickerThumbnailView*  thumbnailView;
@property(nonatomic, readonly) UILabel* nameLabel;
@property(nonatomic, readonly) UILabel* countLabel;
@property(nonatomic, strong) ALAssetsGroup* asstsGroup;


@end
