//
//  MyMsgController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroDefine.h"
#import "AppDelegate.h"
#import "MyMsgController.h"
#import "MsgDetailController.h"
#import <AFNetworking/AFNetworking.h>

@interface MyMsgController () <UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableView;
@property AppDelegate *appDelegate;
@property NSMutableArray *discussList;
@end

@implementation MyMsgController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的問題";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.discussList = [[NSMutableArray alloc] init];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
    [self.navigationController pushViewController:msgDetailController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSDictionary *parameters=@{@"discuss_offset":@0,@"discuss_page_size":@20};
    HUD_WAITING_SHOW(@"Loading");
    [manager POST:[NSString stringWithFormat:@"%@%@", BASE_URL(@"discuss/select/user/"), [self.appDelegate.user objectForKey:@"user_id"]] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
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
        HUD_TOAST_SHOW(@"Network Error");
    }];
}

@end
