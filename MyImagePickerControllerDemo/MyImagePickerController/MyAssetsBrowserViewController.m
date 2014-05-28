//
//  MyAssetsBrowserViewController.m
//  MyImagePickerControllerDemo
//
//  Created by Petey on 5/25/14.
//  Copyright (c) 2014 Petey. All rights reserved.
//

#import "MyAssetsBrowserViewController.h"
#import "MyPhotoBrowser.h"
#import "MyPhotoPageView.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface MyAssetsBrowserViewController ()<MyPhotoBrowserDataSource, MyPhotoBrowserDelegate>
{
    MyPhotoBrowser* _photoBrowser;
}
@end

@implementation MyAssetsBrowserViewController
@synthesize currentIndexPath = _currentIndexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    _photoBrowser = [[MyPhotoBrowser alloc] initWithFrame:self.view.bounds];
    _photoBrowser.dataSource = self;
    _photoBrowser.delegate = self;
    [self.view addSubview:_photoBrowser];
    _photoBrowser.backgroundColor = [UIColor redColor];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.automaticallyAdjustsScrollViewInsets = NO;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath* currentIndexPath = self.currentIndexPath;
    [_photoBrowser reloadData];
    [_photoBrowser moveToPageAtIndexPath:currentIndexPath animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)photoBrowse:(MyPhotoBrowser*)photoBrowsef numberOfPagesInGroup:(NSInteger)group
{
    return self.assetsArray.count;
}
- (MyPhotoPageView*)photoBrowser:(MyPhotoBrowser *)photoBrowser photoAtIndexPath:(NSIndexPath*)indexPath
{
    MyPhotoPageView* pageView = [photoBrowser dequeueReusablePages];
    if (pageView == nil) {
        pageView = [[MyPhotoPageView alloc] init];
    }
    ALAsset* asset = [self.assetsArray objectAtIndex:indexPath.row];
    pageView.backgroundColor = [UIColor blueColor];
    pageView.imageView.image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage];
    
    return pageView;
}
-(void)photoBrowser:(MyPhotoBrowser*)photoBrowser didDisplayPhotoAtIndexPath:(NSIndexPath*)indexPath
{
    self.title = [NSString stringWithFormat:@"%d Of %d", indexPath.row + 1, self.assetsArray.count];
    self.currentIndexPath = indexPath;
}
@end
