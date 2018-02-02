//
//  VideoListController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "VideoListController.h"

@interface VideoListController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VideoListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = false;
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIFont *newFont = [UIFont fontWithName:@"AppleGothic" size:18.0];
    cell.textLabel.font = newFont;
//    switch( indexPath.row ){
//        case 0:
//            cell.textLabel.text = @"視頻1";
//            cell.detailTextLabel.text = @"視頻介紹1";
//            cell.imageView.image = [UIImage imageNamed:@"video"];
//            break;
//        case 1:
//            cell.textLabel.text = @"視頻2";
//            cell.detailTextLabel.text = @"視頻介紹2";
//            cell.imageView.image = [UIImage imageNamed:@"video"];
//            break;
//        case 2:
//            cell.textLabel.text = @"視頻3";
//            cell.detailTextLabel.text = @"視頻介紹3";
//            cell.imageView.image = [UIImage imageNamed:@"video"];
//            break;
//    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@%ld", @"視頻", indexPath.row ];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%ld", @"視頻介紹", indexPath.row ];
    cell.imageView.image = [UIImage imageNamed:@"video"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
