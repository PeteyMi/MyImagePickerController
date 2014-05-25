//
//  MyImagePickerGroupCell.m
//  MyImagePickerControllerDemo
//
//  Created by Petey on 5/25/14.
//  Copyright (c) 2014 Petey. All rights reserved.
//

#import "MyImagePickerGroupCell.h"

@implementation MyImagePickerGroupCell
@synthesize thumbnailView = _thumbnailView;
@synthesize nameLabel = _nameLabel;
@synthesize countLabel = _countLabel;
@synthesize asstsGroup = _asstsGroup;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

-(MyImagePickerThumbnailView*)thumbnailView
{
    if (_thumbnailView == nil) {
        _thumbnailView = [[MyImagePickerThumbnailView alloc] initWithFrame:CGRectMake(8, 4, 70, 74)];
        _thumbnailView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self.contentView addSubview:_thumbnailView];
    }
    return _thumbnailView;
}
-(UILabel*)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8 + 70 + 18, 22, 180, 21)];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}
-(UILabel*)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(8 + 70 + 18, 46, 180, 15)];
        _countLabel.font = [UIFont systemFontOfSize:12];
        _countLabel.textColor = [UIColor blackColor];
        _countLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_countLabel];
    }
    return _countLabel;
}

-(void)setAsstsGroup:(ALAssetsGroup *)asstsGroup
{
    _asstsGroup = asstsGroup;
    
    // Extract three thumbnail image
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(3, asstsGroup.numberOfAssets))];
    NSMutableArray* thumbnailImages = [[NSMutableArray alloc] init];
    [asstsGroup enumerateAssetsAtIndexes:indexes
                                 options:0
                              usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                  if (result) {
                                      UIImage* thumbnailImage = [UIImage imageWithCGImage:result.thumbnail];
                                      [thumbnailImages addObject:thumbnailImage];
                                  }
                              }];
    self.thumbnailView.thumbnailImages = [thumbnailImages copy];
    self.nameLabel.text = [self.asstsGroup valueForProperty:ALAssetsGroupPropertyName];
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.asstsGroup.numberOfAssets];
}
@end


@implementation MyImagePickerThumbnailView
@synthesize thumbnailImages = _thumbnailImages;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)setThumbnailImages:(NSArray *)thumbnailImages
{
    _thumbnailImages = thumbnailImages;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    
    if (_thumbnailImages.count == 3) {
        UIImage *thumbnailImage = [_thumbnailImages objectAtIndex:2];
        
        CGRect thumbnailImageRect = CGRectMake(4.0, 0, 62.0, 62.0);
        CGContextFillRect(context, thumbnailImageRect);
        [thumbnailImage drawInRect:CGRectInset(thumbnailImageRect, 0.5, 0.5)];
    }
    
    if (self.thumbnailImages.count >= 2) {
        UIImage *thumbnailImage = [self.thumbnailImages objectAtIndex:1];
        
        CGRect thumbnailImageRect = CGRectMake(2.0, 2.0, 66.0, 66.0);
        CGContextFillRect(context, thumbnailImageRect);
        [thumbnailImage drawInRect:CGRectInset(thumbnailImageRect, 0.5, 0.5)];
    }
    
    UIImage *thumbnailImage = [self.thumbnailImages objectAtIndex:0];
    
    CGRect thumbnailImageRect = CGRectMake(0, 4.0, 70.0, 70.0);
    CGContextFillRect(context, thumbnailImageRect);
    [thumbnailImage drawInRect:CGRectInset(thumbnailImageRect, 0.5, 0.5)];
}

@end
