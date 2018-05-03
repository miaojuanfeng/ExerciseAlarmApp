//
//  MsgListController.m
//  alarm
//
//  Created by Dreamover Studio on 29/3/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroDefine.h"
#import "AppDelegate.h"
#import <AFNetworking/AFNetworking.h>
#import "MsgListController.h"
#import "NewQuestionController.h"
#import "MyMsgController.h"
#import "MsgDetailController.h"

@interface MsgListController () <UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableView;
@property AppDelegate *appDelegate;
@property NSMutableArray *discussList;
@end

@implementation MsgListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"常見問題";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.discussList = [[NSMutableArray alloc] init];
    
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.discussList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    cell.textLabel.text = [[self.discussList objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.imageView.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6fa", 34, [UIColor lightGrayColor])];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MsgDetailController *msgDetailController = [[MsgDetailController alloc] init];
    msgDetailController.discussId = [[[self.discussList objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
    [self.navigationController pushViewController:msgDetailController animated:YES];
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

- (void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSDictionary *parameters=@{@"discuss_offset":@0,@"discuss_page_size":@20};
    HUD_WAITING_SHOW(MSG_LOADING);
    [manager POST:BASE_URL(@"discuss/select/all") parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功.%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:NULL];
        NSLog(@"results: %@", dic);
        
        int status = [[dic objectForKey:@"status"] intValue];
        
        HUD_WAITING_HIDE;
        if( status == 1 ){
            self.discussList = [dic objectForKey:@"data"];
            [self.tableView reloadData];
        }else{
            NSString *msg = [dic objectForKey:@"msg"];
            HUD_TOAST_SHOW(msg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败.%@",error);
        NSLog(@"%@",[[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
        
        HUD_WAITING_HIDE;
        HUD_TOAST_SHOW(MSG_ERROR_NETWORK);
    }];
}

@end
