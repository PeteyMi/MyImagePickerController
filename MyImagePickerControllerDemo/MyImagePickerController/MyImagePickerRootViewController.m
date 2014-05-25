//
//  MyImagePickerRootViewController.m
//  MyImagePickerControllerDemo
//
//  Created by Petey on 5/24/14.
//  Copyright (c) 2014 Petey. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

#import "MyImagePickerRootViewController.h"
#import "MyAssetsCollectionViewController.h"
#import "MyAssetsCollectionViewLayout.h"
#import "MyImagePickerGroupCell.h"

NSString* groupCellIdentifier = @"groupCellIdentifier";

#define IMAGE_PICKER_GROUP_CELL_HEIGHT  86.0

@interface MyImagePickerRootViewController ()

@property(nonatomic, retain) ALAssetsLibrary*   assetsLibrary;
@property (nonatomic, copy) NSArray *assetsGroups;
@end

@implementation MyImagePickerRootViewController
@synthesize allowsMultipleSelection = _allowsMultipleSelection;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        self.groupTypes = @[@(ALAssetsGroupLibrary),
                            @(ALAssetsGroupAlbum),
                            @(ALAssetsGroupSavedPhotos),
                            @(ALAssetsGroupPhotoStream)];
        self.assetsLibrary = [[ALAssetsLibrary alloc] init];
        self.allowsMultipleSelection = YES;
        [self.tableView registerClass:[MyImagePickerGroupCell class] forCellReuseIdentifier:groupCellIdentifier];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Load assets groups
    [self loadAssetsGroupsWithTypes:self.groupTypes
                         completion:^(NSArray *assetsGroups) {
                             self.assetsGroups = assetsGroups;
                             
                             [self.tableView reloadData];
                         }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection
{
    _allowsMultipleSelection = allowsMultipleSelection;
    
}

#pragma mark Managing Assets
- (void)loadAssetsGroupsWithTypes:(NSArray *)types completion:(void (^)(NSArray *assetsGroups))completion
{
    __block NSMutableArray* assetsGroups = [[NSMutableArray alloc] init];
    __block NSUInteger numberOfFinishedTypes = 0;
    for (NSNumber* type in types) {
        [self.assetsLibrary enumerateGroupsWithTypes:[type unsignedIntegerValue]
                                          usingBlock:^(ALAssetsGroup *assetsGroup, BOOL *stop) {
                                              if (assetsGroup) {
                                                  if (assetsGroup.numberOfAssets > 0) {
                                                      [assetsGroups addObject:assetsGroup];
                                                  }
                                              } else {
                                                  numberOfFinishedTypes++;
                                              }
                                              
                                              //Check if the loading finished
                                              if (numberOfFinishedTypes == types.count) {
                                                  if (completion) {
                                                      completion(assetsGroups);
                                                  }
                                              }
                                          } failureBlock:^(NSError *error) {
                                              NSLog(@"Error: %@",[error localizedDescription]);
                                          }];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.assetsGroups.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyImagePickerGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:groupCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    ALAssetsGroup* assetsGroup = [self.assetsGroups objectAtIndex:indexPath.row];
    cell.asstsGroup = assetsGroup;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAssetsCollectionViewController* assetsCollectionViewController = [[MyAssetsCollectionViewController alloc] initWithCollectionViewLayout:[MyAssetsCollectionViewLayout layout]];
    ALAssetsGroup *assetsGroup = [self.assetsGroups objectAtIndex:indexPath.row];
    assetsCollectionViewController.assetsGroup = assetsGroup;
    assetsCollectionViewController.allowsMultipleSelection = self.allowsMultipleSelection;
    [self.navigationController pushViewController:assetsCollectionViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return IMAGE_PICKER_GROUP_CELL_HEIGHT;
}


@end
