//
//  StatusOneController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "StatusTwoController.h"
#import <AFNetworking/AFNetworking.h>

@interface StatusTwoController () <UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableView;

@property AppDelegate *appDelegate;

@property NSMutableArray *starList;
@property UILabel *titleRight;
@end

@implementation StatusTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"累積星星";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+10, self.view.frame.size.width-40, 50)];
    title.text = @"總共獲得";
    title.font = [UIFont fontWithName:@"AppleGothic" size:20.0];
    [self.view addSubview:title];
    
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+10+60, self.view.frame.size.width-40, 50)];
    num.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld 星", self.appDelegate.weekStarCount]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:46.0] range:NSMakeRange(0,str.length-1)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:18.0] range:NSMakeRange(str.length-1,1)];
    num.attributedText = str;
    
    [self.view addSubview:num];
    
    UIView *tableTitle = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop+10+126, self.view.frame.size.width, 44)];
    tableTitle.backgroundColor = RGBA_COLOR(166, 213, 75, 1);
    UILabel *titleLeft = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, tableTitle.frame.size.height)];
    titleLeft.text = @"本週排名";
    titleLeft.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [tableTitle addSubview:titleLeft];
    self.titleRight = [[UILabel alloc] initWithFrame:CGRectMake(tableTitle.frame.size.width-110, 0, 100, tableTitle.frame.size.height)];
//    self.titleRight.text = @"12/150";
    self.titleRight.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    self.titleRight.textAlignment = NSTextAlignmentRight;
    [tableTitle addSubview:self.titleRight];
    [self.view addSubview:tableTitle];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, marginTop+10+170, self.view.frame.size.width, self.view.frame.size.height-marginTop-10-170-49)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.starList = [[NSMutableArray alloc] init];
    [self uploadStar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.starList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    UIFont *newFont = [UIFont fontWithName:@"AppleGothic" size:16.0];
    UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 20, cell.frame.size.height)];
    num.font = newFont;
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 150, cell.frame.size.height)];
    name.font = newFont;
    UILabel *star = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-100, 0, 100, cell.frame.size.height)];
    star.font = newFont;
    star.textAlignment = NSTextAlignmentRight;
    
    UIView *starLikeView = [[UIView alloc] initWithFrame:CGRectMake(cell.frame.size.width+15, 0, 25, cell.frame.size.height)];
    UILabel *starLikeNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, starLikeView.frame.size.width, 25)];
    newFont = [UIFont fontWithName:@"AppleGothic" size:9.0];
    starLikeNum.font = newFont;
    starLikeNum.textAlignment = NSTextAlignmentCenter;
    [starLikeView addSubview:starLikeNum];
//    starLikeView.backgroundColor = [UIColor redColor];
    UIButton *starLikeImage = [[UIButton alloc] initWithFrame:CGRectMake((starLikeView.frame.size.width-15)/2, 22, 15, 15)];
    starLikeImage.titleLabel.font = ICON_FONT(16.0);
    starLikeImage.tag = indexPath.row;
//    [starLikeImage addTarget:self action:@selector(clickLikeButton:) forControlEvents:UIControlEventTouchUpInside];
    [starLikeView addSubview:starLikeImage];
    [cell addSubview:starLikeView];

    NSMutableAttributedString *str = nil;
    num.text = [NSString stringWithFormat:@"%ld", (long)(indexPath.row+1)];
    [cell addSubview:num];
    name.text = [[self.starList objectAtIndex:indexPath.row] objectForKey:@"user_nickname"];
    [cell addSubview:name];
    str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 星", [[self.starList objectAtIndex:indexPath.row] objectForKey:@"star_num"]]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleGothic" size:14.0] range:NSMakeRange(str.length-1, 1)];
    star.attributedText = str;
    [cell addSubview:star];
    starLikeNum.text = [[[self.starList objectAtIndex:indexPath.row] objectForKey:@"like_num"] stringValue];
    if( [[[self.starList objectAtIndex:indexPath.row] objectForKey:@"is_like"] boolValue] ){
        [starLikeImage setTitle:@"\U0000e707" forState:UIControlStateNormal];
        [starLikeImage setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else{
        [starLikeImage setTitle:@"\U0000e708" forState:UIControlStateNormal];
        [starLikeImage setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self uploadLike:indexPath.row withStarId:[[self.starList objectAtIndex:indexPath.row] objectForKey:@"id"]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)loadStar {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSDictionary *parameters=@{@"user_id":[self.appDelegate.user objectForKey:@"user_id"]};
    HUD_WAITING_SHOW(MSG_LOADING);
    [manager POST:BASE_URL(@"user/user_star") parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功.%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:NULL];
        NSLog(@"results: %@", dic);
        
        int status = [[dic objectForKey:@"status"] intValue];
        
        HUD_WAITING_HIDE;
        if( status == 1 ){
            self.starList = [[dic objectForKey:@"data"] objectForKey:@"star_list"];
            self.titleRight.text = [NSString stringWithFormat:@"%@/%ld", [[dic objectForKey:@"data"] objectForKey:@"user_no"], self.starList.count];
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

- (void)uploadStar {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSDictionary *parameters=@{@"user_id":[self.appDelegate.user objectForKey:@"user_id"], @"star_num":[NSString stringWithFormat:@"%ld", self.appDelegate.weekStarCount]};
    HUD_WAITING_SHOW(MSG_LOADING);
    [manager POST:BASE_URL(@"user/upload_star") parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功.%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:NULL];
        NSLog(@"results: %@", dic);
        
        int status = [[dic objectForKey:@"status"] intValue];
        
        HUD_WAITING_HIDE;
        if( status == 1 ){
            [self loadStar];
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

- (void)uploadLike:(int)indexPathRow withStarId:(NSString *)star_id {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSDictionary *parameters=@{@"star_id":star_id, @"user_id":[self.appDelegate.user objectForKey:@"user_id"]};
    HUD_WAITING_SHOW(MSG_LOADING);
    [manager POST:BASE_URL(@"user/user_like") parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功.%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:NULL];
        NSLog(@"results: %@", dic);
        
        int status = [[dic objectForKey:@"status"] intValue];
        
        HUD_WAITING_HIDE;
        if( status == 1 ){
            NSMutableDictionary *data = [dic objectForKey:@"data"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexPathRow inSection:0];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            NSArray<UIView*> *cellSubViews = [cell subviews];
            NSArray<UIView*> *starLikeView = [cellSubViews[1] subviews];
            NSLog(@"%@", starLikeView[0]);
            NSLog(@"%@", starLikeView[1]);
            UILabel *num = (UILabel*)starLikeView[0];
            UIButton *starLikeImage = (UIButton*)starLikeView[1];
            if( [[data objectForKey:@"is_like"] boolValue] ){
                num.text = [NSString stringWithFormat:@"%d", [num.text intValue]+1];
                [starLikeImage setTitle:@"\U0000e707" forState:UIControlStateNormal];
                [starLikeImage setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }else{
                num.text = [NSString stringWithFormat:@"%d", [num.text intValue]-1];
                [starLikeImage setTitle:@"\U0000e708" forState:UIControlStateNormal];
                [starLikeImage setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            }
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

//- (void)clickLikeButton:(UIButton *) btn{
//    NSLog(@"%ld", btn.tag);
//}
@end
