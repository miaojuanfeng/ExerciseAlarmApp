//
//  DiscussController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroDefine.h"
#import "AppDelegate.h"
#import "DiscussController.h"
#import "NewQuestionController.h"
#import "MyMsgController.h"
#import "MsgListController.h"

@interface DiscussController () <UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableView;
@property AppDelegate *appDelegate;
@end

@implementation DiscussController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"討論";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
//    UIView *topButton = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, 44)];
//    topButton.backgroundColor = [UIColor orangeColor];
//    UIButton *topButtonLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, topButton.frame.size.width/2, topButton.frame.size.height)];
//    [topButtonLeft setTitle:@"我要提問" forState:UIControlStateNormal];
//    [topButtonLeft addTarget:self action:@selector(clickButtonLeft) forControlEvents:UIControlEventTouchUpInside];
//    [topButton addSubview:topButtonLeft];
//    //
//    UIButton *topButtonRight = [[UIButton alloc] initWithFrame:CGRectMake(topButton.frame.size.width/2, 0, topButton.frame.size.width/2, topButton.frame.size.height)];
//    [topButtonRight setTitle:@"我的訊息" forState:UIControlStateNormal];
//    [topButtonRight addTarget:self action:@selector(clickButtonRight) forControlEvents:UIControlEventTouchUpInside];
//    [topButton addSubview:topButtonRight];
    
//    CALayer *topButtonBorder = [CALayer layer];
//    topButtonBorder.frame = CGRectMake(0, 0, 1, topButtonRight.frame.size.height);
//    topButtonBorder.backgroundColor = [UIColor whiteColor].CGColor;
//    [topButtonRight.layer addSublayer:topButtonBorder];
//    //
//    [self.view addSubview:topButton];
    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, marginTop+topButton.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-marginTop-topButton.frame.size.height-self.tabBarController.tabBar.frame.size.height)];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"...";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0){
        return CGFLOAT_MIN;
    }else{
        return tableView.sectionHeaderHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    UILabel *unreadView = nil;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"我的問題";
            cell.imageView.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6fa", 34, [UIColor lightGrayColor])];
            if( [[self.appDelegate.user objectForKey:@"user_unread"] intValue] > 0 ){
                unreadView = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width, (cell.frame.size.height-20)/2, 20, 20)];
                unreadView.backgroundColor = [UIColor redColor];
                unreadView.layer.cornerRadius = unreadView.frame.size.width/2;
                unreadView.layer.masksToBounds = YES;
                unreadView.textColor = [UIColor whiteColor];
                unreadView.text = [[self.appDelegate.user objectForKey:@"user_unread"] stringValue];
                unreadView.textAlignment = NSTextAlignmentCenter;
                [cell.contentView addSubview:unreadView];
            }
            break;
        case 1:
            cell.textLabel.text = @"常見問題";
            cell.imageView.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6fa", 34, [UIColor lightGrayColor])];
            break;
        case 2:
            cell.textLabel.text = @"我要提問";
            cell.imageView.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6fa", 34, [UIColor lightGrayColor])];
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MsgListController *msgListController;
    NewQuestionController *newQuestionController;
    MyMsgController *myMsgController;
    switch (indexPath.row) {
        case 0:
            myMsgController = [[MyMsgController alloc] init];
            [self.navigationController pushViewController:myMsgController animated:YES];
            break;
        case 1:
            msgListController = [[MsgListController alloc] init];
            [self.navigationController pushViewController:msgListController animated:YES];
            break;
        case 2:
            newQuestionController = [[NewQuestionController alloc] init];
            [self.navigationController pushViewController:newQuestionController animated:YES];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (void)clickButtonLeft {
//    NewQuestionController *newQuestionController = [[NewQuestionController alloc] init];
//    [self.navigationController pushViewController:newQuestionController animated:YES];
//}
//
//- (void)clickButtonRight {
//    MyMsgController *myMsgController = [[MyMsgController alloc] init];
//    [self.navigationController pushViewController:myMsgController animated:YES];
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
