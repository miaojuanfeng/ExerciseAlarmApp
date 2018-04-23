//
//  MsgDetailController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MacroDefine.h"
#import "AppDelegate.h"
#import "MsgDetailController.h"
#import "NewCommentController.h"
#import <AFNetworking/AFNetworking.h>

@interface MsgDetailController ()
@property AppDelegate *appDelegate;
@end

@implementation MsgDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"問題詳情";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self loadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    NSDictionary *parameters=nil;
    HUD_WAITING_SHOW(@"Loading");
    [manager POST:[NSString stringWithFormat:@"%@/%d", BASE_URL(@"discuss/select/detail"), self.discussId] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功.%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:NULL];
        NSLog(@"results: %@", dic);
        
        int status = [[dic objectForKey:@"status"] intValue];
        
        HUD_WAITING_HIDE;
        if( status == 1 ){
            [self updateLayout:[dic objectForKey:@"data"]];
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

- (void)updateLayout:(NSMutableDictionary*)msg {
    self.navigationItem.title = [msg objectForKey:@"title"];
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, self.view.frame.size.height-marginTop)];
    //    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:scrollView];
    
    int contentSize = 0;
    int textMargin = 5;
    int lineHeight = 20;
    int titlePadding = 20;
    /*
     *  問題詳述
     */
    UILabel *descTitle= [[UILabel alloc] initWithFrame:CGRectMake(textMargin, textMargin, self.view.frame.size.width-textMargin*2, lineHeight)];
    descTitle.text = @"問題詳述：";
    descTitle.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, descTitle.frame.size.height+descTitle.frame.origin.y, self.view.frame.size.width-textMargin*2, lineHeight)];
    desc.text = [msg objectForKey:@"content"];
    desc.numberOfLines = 0;
    [desc sizeToFit];
    //    desc.backgroundColor = [UIColor yellowColor];
    desc.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    
    UIView *descView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, descTitle.frame.size.height+desc.frame.size.height+textMargin*1.2)];
    //        descView.backgroundColor = [UIColor blueColor];
    [descView addSubview:descTitle];
    [descView addSubview:desc];
    
    [scrollView addSubview:descView];
    
    int commentOriginY = descView.frame.origin.y + descView.frame.size.height;
    /*
     *  專家回復
     */
    if( [msg objectForKey:@"expert"] != nil && [[msg objectForKey:@"expert"] objectForKey:@"id"] != nil ){
        NSMutableDictionary *e = [msg objectForKey:@"expert"];
        UILabel *expertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, titlePadding/2, self.view.frame.size.width-textMargin*2, lineHeight)];
        expertTitleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
        expertTitleLabel.text = @"專家回復";
        expertTitleLabel.textColor = [UIColor whiteColor];
        
        UIView *expertView = [[UIView alloc] initWithFrame:CGRectMake(0, descView.frame.size.height+descView.frame.origin.y, self.view.frame.size.width, expertTitleLabel.frame.size.height+titlePadding)];
        expertView.backgroundColor = RGBA_COLOR(242, 134, 45, 1);
        [expertView addSubview:expertTitleLabel];
        
        [scrollView addSubview:expertView];
        
        UILabel *expertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, expertView.frame.size.height+expertView.frame.origin.y+textMargin, self.view.frame.size.width-textMargin*2, lineHeight)];
        expertContentLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
        expertContentLabel.text = [e objectForKey:@"content"];
        expertContentLabel.numberOfLines = 0;
        [expertContentLabel sizeToFit];
        [scrollView addSubview:expertContentLabel];
        
        NSDate *date               = [NSDate dateWithTimeIntervalSince1970:[[e objectForKey:@"create_date"] intValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        NSString *dateString       = [formatter stringFromDate: date];
        
        UILabel *expertContentLabelTime = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, expertContentLabel.frame.size.height+expertContentLabel.frame.origin.y+textMargin, self.view.frame.size.width-textMargin*2, lineHeight)];
        expertContentLabelTime.font = DEFAULT_FONT(12.0f);
        expertContentLabelTime.text = dateString;
        [scrollView addSubview:expertContentLabelTime];
        
        commentOriginY = expertContentLabelTime.frame.origin.y + expertContentLabelTime.frame.size.height;
    }
    /*
     *  添加评论
     */
    UIButton *newCommentButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-112, titlePadding/2, 100, lineHeight)];
    [newCommentButton setTitle:@"添加評論" forState:UIControlStateNormal];
    newCommentButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    newCommentButton.tag = [[msg objectForKey:@"id"] longValue];
    [newCommentButton addTarget:self action:@selector(clickNewComment:) forControlEvents:UIControlEventTouchUpInside];
    [newCommentButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e6e0", 20, [UIColor whiteColor])] forState:UIControlStateNormal];
    
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, titlePadding/2, 100, lineHeight)];
    commentLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    commentLabel.text = @"評論";
    commentLabel.textColor = [UIColor whiteColor];
    
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, commentOriginY+textMargin, self.view.frame.size.width, commentLabel.frame.size.height+titlePadding)];
    commentView.backgroundColor = RGBA_COLOR(40, 122, 72, 1);
    [commentView addSubview:commentLabel];
    [commentView addSubview:newCommentButton];
    [scrollView addSubview:commentView];
    /*
     *  评论列表
     */
    int lastY = commentView.frame.size.height+commentView.frame.origin.y+textMargin;
    for(NSMutableDictionary *c in [msg objectForKey:@"comment"]){
        UILabel *commentUser = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, 0, self.view.frame.size.width, lineHeight)];
        commentUser.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
        commentUser.text = [NSString stringWithFormat:@"%@：", [c objectForKey:@"user_nickname"]];
        
        UILabel *commentContent = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, commentUser.frame.size.height+commentUser.frame.origin.y+textMargin, self.view.frame.size.width-textMargin*2, lineHeight)];
        commentContent.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
        commentContent.text = [c objectForKey:@"content"];
        commentContent.numberOfLines = 0;
        [commentContent sizeToFit];
        
        NSDate *date               = [NSDate dateWithTimeIntervalSince1970:[[c objectForKey:@"create_date"] intValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        NSString *dateString       = [formatter stringFromDate: date];
        
        UILabel *commentLabelTime = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, commentContent.frame.size.height+commentContent.frame.origin.y+textMargin, self.view.frame.size.width-textMargin*2, lineHeight)];
        commentLabelTime.font = DEFAULT_FONT(12.0f);
        commentLabelTime.text = dateString;
        
        UIButton *commentReplyButton = [[UIButton alloc] initWithFrame:CGRectMake(commentLabelTime.frame.size.width-85, commentContent.frame.size.height+commentContent.frame.origin.y+textMargin, 100, lineHeight)];
        [commentReplyButton setTitle:@"回復" forState:UIControlStateNormal];
        commentReplyButton.titleLabel.font = DEFAULT_FONT(12.0f);
        commentReplyButton.tag = [[c objectForKey:@"id"] longValue];
        [commentReplyButton addTarget:self action:@selector(clickReplyComment:) forControlEvents:UIControlEventTouchUpInside];
        [commentReplyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [commentReplyButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e70c", 18, [UIColor grayColor])] forState:UIControlStateNormal];
        
        UIView *commentListView = [[UIView alloc] initWithFrame:CGRectMake(0, lastY, self.view.frame.size.width, commentContent.frame.size.height+commentLabelTime.frame.size.height+titlePadding*2)];
        CALayer *commentListBorder = [CALayer layer];
        commentListBorder.frame = CGRectMake(0.0f, commentListView.frame.size.height-1, commentListView.frame.size.width, BORDER_WIDTH);
        commentListBorder.backgroundColor = BORDER_COLOR;
        [commentListView.layer addSublayer:commentListBorder];
        [commentListView addSubview:commentContent];
        [commentListView addSubview:commentLabelTime];
        [commentListView addSubview:commentReplyButton];
        [commentListView addSubview:commentUser];
        
        [scrollView addSubview:commentListView];
        
        lastY = commentListView.frame.size.height+commentListView.frame.origin.y+textMargin*2;
        contentSize = commentListView.frame.size.height+commentListView.frame.origin.y;
    }
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, contentSize);
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
    
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}

- (void)clickNewComment:(UIButton *)btn {
    NSLog(@"id: %ld", btn.tag);
    NewCommentController *newCommentController = [[NewCommentController alloc] init];
    [self.navigationController pushViewController:newCommentController animated:YES];
}

- (void)clickReplyComment:(UIButton *)btn {
    NSLog(@"id: %ld", btn.tag);
    NewCommentController *newCommentController = [[NewCommentController alloc] init];
    [self.navigationController pushViewController:newCommentController animated:YES];
}

@end
