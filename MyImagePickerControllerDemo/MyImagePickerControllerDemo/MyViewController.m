//
//  MyViewController.m
//  MyImagePickerControllerDemo
//
//  Created by Petey on 5/24/14.
//  Copyright (c) 2014 Petey. All rights reserved.
//

#import "MyViewController.h"
#import "MyImagePickerViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btPress:(id)sender
{
//    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    imagePickerController.allowsEditing = YES;
////    imagePickerController.allowsImageEditing=YES;
//    [self presentViewController:imagePickerController animated:YES completion:NULL];
    MyImagePickerViewController* imagePickerController = [[MyImagePickerViewController alloc] init];
    [self presentViewController:imagePickerController animated:YES completion:NULL];
}
@end
