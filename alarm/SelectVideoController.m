//
//  SelectVideoController.m
//  alarm
//
//  Created by USER on 27/3/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "SelectVideoController.h"

@interface SelectVideoController () <UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableView;
@property AppDelegate *appDelegate;
@end

@implementation SelectVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择视频";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"關閉" style:UIBarButtonItemStylePlain target:self action:@selector(clickCloseButton)];
    self.navigationItem.leftBarButtonItem = closeButton;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveButton)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    [self.view addSubview:self.tableView];
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickSaveButton {
    [self.appDelegate.selectVideoList removeAllObjects];
    for (int i=0; i<self.appDelegate.videoList.count; i++) {
        NSMutableDictionary *t = [self.appDelegate.videoList objectAtIndex:i];
        if( [[t objectForKey:@"isShow"] boolValue] ){
            [self.appDelegate.selectVideoList addObject:t];
        }
    }
    [self.appDelegate saveSelectVideoList];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.appDelegate.videoList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    UIFont *newFont = [UIFont fontWithName:@"AppleGothic" size:18.0];
    cell.textLabel.font = newFont;
    cell.textLabel.text = [[self.appDelegate.videoList objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%ld", @"\n", indexPath.row ];
    cell.imageView.image = [UIImage imageNamed:@"V"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect checkboxRect = CGRectMake(cell.frame.size.width, (cell.frame.size.height-30)/2+8, 30, 30);
    [checkbox setFrame:checkboxRect];

    [checkbox setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageNamed:@"select-fill"] forState:UIControlStateSelected];
    if( [[[self.appDelegate.videoList objectAtIndex:indexPath.row] objectForKey:@"isShow"] boolValue] ){
        checkbox.selected = YES;
    }
    [checkbox setTag:indexPath.row];
    [checkbox addTarget:self action:@selector(clickVideoCheckboxButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:checkbox];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self doClickCell:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}

- (void)clickVideoCheckboxButton:(UIButton *)btn {
    [self doClickCell:btn.tag];
}

- (void)doClickCell:(long) index{
    NSMutableDictionary *t = [self.appDelegate.videoList objectAtIndex:index];
    if( [[t objectForKey:@"isShow"] boolValue] ){
        [t setObject:[NSString stringWithFormat:@"%d", false] forKey:@"isShow"];
    }else{
        [t setObject:[NSString stringWithFormat:@"%d", true] forKey:@"isShow"];
    }
    [self.appDelegate.videoList replaceObjectAtIndex:index withObject:t];
    
    [self.tableView reloadData];
}

@end
