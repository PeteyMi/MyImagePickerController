//
//  MyAssetsCollectionViewCell.m
//  MyImagePickerControllerDemo
//
//  Created by Petey on 5/24/14.
//  Copyright (c) 2014 Petey. All rights reserved.
//

#import "MyAssetsCollectionViewCell.h"

#define CHECK_MARK_VIEW_WIDTH   24.0
#define CHECK_MARK_VIEW_HEIGHT   24.0
#define CHECK_MARK_VIEW_GAP     4.0

@interface MyAssetsCollectionViewCell ()
{
//    MyAssetsCollectionCheckmarkView* checkmarkView;
}
@property(nonatomic, strong) UIImageView* imageView;
@property(nonatomic, readonly) MyAssetsCollectionCheckmarkView* checkmarkView;
@end

@implementation MyAssetsCollectionViewCell
@synthesize asset = _asset;
@synthesize checkmarkView = _checkmarkView;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.contentView addSubview:self.imageView];
        
        self.checkmarkStation = MyAssetsCollectionCheckmarkRightBottom;
        
//        checkmarkView = [[MyAssetsCollectionCheckmarkView alloc] initWithFrame:CGRectMake(self.bounds.size.width - (4.0 + 24.0), self.bounds.size.height - (4.0 + 24.0), 24.0, 24.0)];
        
    }
    return self;
}

-(MyAssetsCollectionCheckmarkView*)checkmarkView
{
    if (_checkmarkView == nil) {
        _checkmarkView = [[MyAssetsCollectionCheckmarkView alloc] init];
        _checkmarkView.autoresizingMask = UIViewAutoresizingNone;
        _checkmarkView.layer.shadowColor = [[UIColor grayColor] CGColor];
        _checkmarkView.layer.shadowOffset = CGSizeMake(0, 0);
        _checkmarkView.layer.shadowOpacity = 0.6;
        _checkmarkView.layer.shadowRadius = 2.0;
        [self addSubview:_checkmarkView];
    }
    return _checkmarkView;
}
-(void)setSelected:(BOOL)selected
{
    if (!selected) {
        _checkmarkView.selected = selected;
    } else {
        _checkmarkView.selected = selected;
        [UIView animateWithDuration:0.1
                         animations:^{
                             [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                             _checkmarkView.transform =  CGAffineTransformMakeScale(1.2, 1.2);
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.1
                                              animations:^{
                                                  [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                                                  _checkmarkView.transform =  CGAffineTransformMakeScale(0.9, 0.9);
                                              } completion:^(BOOL finished) {
                                                  [UIView animateWithDuration:0.2
                                                                   animations:^{
                                                                       [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                                                                       _checkmarkView.transform =  CGAffineTransformMakeScale(1.0, 1.0);
                                                                   }];
                                                  
                                              }];
                             
                         }];
    }
    [super setSelected:selected];
    
}
-(void)setAsset:(ALAsset *)asset
{
    _asset = asset;
    
    self.imageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
}

-(void)setCheckmarkStation:(MyAssetsCollectionCheckmarkStation)checkmarkStation
{
    switch (checkmarkStation) {
        case MyAssetsCollectionCheckmarkLeftTop:
            self.checkmarkView.frame = CGRectMake(CHECK_MARK_VIEW_GAP , self.bounds.size.height - (CHECK_MARK_VIEW_GAP + CHECK_MARK_VIEW_HEIGHT), CHECK_MARK_VIEW_WIDTH, CHECK_MARK_VIEW_HEIGHT);
            break;
        case MyAssetsCollectionCheckmarkRightTop:
            self.checkmarkView.frame = CGRectMake(self.bounds.size.width - (CHECK_MARK_VIEW_GAP + CHECK_MARK_VIEW_WIDTH) ,  CHECK_MARK_VIEW_GAP, CHECK_MARK_VIEW_WIDTH, CHECK_MARK_VIEW_HEIGHT);
            break;
        case MyAssetsCollectionCheckmarkLeftBottom:
            self.checkmarkView.frame = CGRectMake(CHECK_MARK_VIEW_GAP , self.bounds.size.height - (CHECK_MARK_VIEW_GAP + CHECK_MARK_VIEW_HEIGHT), CHECK_MARK_VIEW_WIDTH, CHECK_MARK_VIEW_HEIGHT);
            break;
        case MyAssetsCollectionCheckmarkRightBottom:
            self.checkmarkView.frame = CGRectMake(self.bounds.size.width - (CHECK_MARK_VIEW_GAP + CHECK_MARK_VIEW_WIDTH) , self.bounds.size.height - (CHECK_MARK_VIEW_GAP + CHECK_MARK_VIEW_HEIGHT), CHECK_MARK_VIEW_WIDTH, CHECK_MARK_VIEW_HEIGHT);
            break;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(_checkmarkView.frame, point)) {
        [self.nextResponder touchesEnded:touches withEvent:event];
    } else {
        if ([self.superview isKindOfClass:[UICollectionView class]]) {
            NSIndexPath* indexPath = [(UICollectionView*)self.superview indexPathForCell:self];
            if (_delegate != nil && [_delegate respondsToSelector:@selector(assetsCollectionViewCell: tapAtIndexPath:)]) {
                [_delegate performSelector:@selector(assetsCollectionViewCell:tapAtIndexPath:) withObject:self withObject:indexPath];
            }
        }
    }
}

@end


@implementation MyAssetsCollectionCheckmarkView
@synthesize selected = _selected;
@synthesize normalColor = _normalColor;
@synthesize selectedColor = _selectedColor;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.normalColor = [UIColor clearColor];
        self.selectedColor = [UIColor colorWithRed:20.0/255.0 green:111.0/255.0 blue:223.0/255.0 alpha:1.0];
        _selected = NO;
    }
    return self;
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef content = UIGraphicsGetCurrentContext();
    
    // Border
    CGContextSetRGBStrokeColor(content, 1.0, 1.0, 1.0, 1.0);
    CGContextAddArc(content, self.bounds.size.width / 2, self.bounds.size.height / 2, self.bounds.size.width / 2 -2, 0, 2 * M_PI, 0);
    CGContextDrawPath(content, kCGPathStroke);

    
    // Body
    if (_selected) {
        const CGFloat *components = CGColorGetComponents(_selectedColor.CGColor);
        CGContextSetRGBFillColor(content, components[0], components[1], components[2], components[3]);
    } else {
        const CGFloat *components = CGColorGetComponents(_normalColor.CGColor);
        CGContextSetRGBFillColor(content, components[0], components[1], components[2], components[3]);
    }
    CGContextFillEllipseInRect(content, CGRectInset(self.bounds, 1.0, 1.0));
    
    // Checkmark
    CGContextSetRGBStrokeColor(content, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(content, 1.2);
    
    CGContextMoveToPoint(content, 6.0, 12.0);
    CGContextAddLineToPoint(content, 10.0, 16.0);
    CGContextAddLineToPoint(content, 18.0, 8.0);
    
    CGContextStrokePath(content);
}

@end