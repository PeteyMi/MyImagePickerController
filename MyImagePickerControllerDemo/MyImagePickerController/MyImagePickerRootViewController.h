//
//  MyImagePickerRootViewController.h
//  MyImagePickerControllerDemo
//
//  Created by Petey on 5/24/14.
//  Copyright (c) 2014 Petey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyImagePickerRootViewController : UITableViewController

@property (nonatomic, copy) NSArray *groupTypes;
@property(nonatomic, assign) BOOL allowsMultipleSelection;
@end
