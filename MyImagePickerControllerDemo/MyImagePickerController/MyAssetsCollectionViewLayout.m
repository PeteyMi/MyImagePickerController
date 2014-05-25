//
//  MyAssetsCollectionViewLayout.m
//  MyImagePickerControllerDemo
//
//  Created by Petey on 5/24/14.
//  Copyright (c) 2014 Petey. All rights reserved.
//

#import "MyAssetsCollectionViewLayout.h"

@implementation MyAssetsCollectionViewLayout

+ (instancetype)layout
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.minimumLineSpacing = 2.0;
        self.minimumInteritemSpacing = 2.0;
    }
    
    return self;
}
@end
