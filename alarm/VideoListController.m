//
//  VideoListController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "VideoListController.h"
#import "VideoDetailController.h"
#import "SelectVideoController.h"

@interface VideoListController () <UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableView;
@property AppDelegate *appDelegate;
@end

@implementation VideoListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"視頻";
    
    UIBarButtonItem *editVideoButton = [[UIBarButtonItem alloc] initWithTitle:@"選擇視頻" style:UIBarButtonItemStylePlain target:self action:@selector(clickEditVideoButton)];
    self.navigationItem.rightBarButtonItem = editVideoButton;
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    NSLog(@"%f", self.navigationController.navigationBar.frame.size.height);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, self.view.frame.size.height-marginTop-self.tabBarController.tabBar.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    [self.view addSubview:self.tableView];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.appDelegate.selectVideoList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];

    UIFont *newFont = [UIFont fontWithName:@"AppleGothic" size:DEFAULT_FONT_SIZE];
    cell.textLabel.font = newFont;
    cell.textLabel.text = [[self.appDelegate.selectVideoList objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%ld", @"\n", indexPath.row ];
    cell.imageView.image = [UIImage imageNamed:@"V"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    VideoDetailController *videoDetailController = [[VideoDetailController alloc] init];
    [self.navigationController pushViewController:videoDetailController animated:YES];
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

- (void)clickEditVideoButton {
    SelectVideoController *selectVideoController = [[SelectVideoController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:selectVideoController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

@end
