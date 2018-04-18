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

@interface MsgDetailController ()
@property AppDelegate *appDelegate;
@end

@implementation MsgDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"每天什麽時間鍛煉最合適？";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, self.view.frame.size.height-marginTop-self.tabBarController.tabBar.frame.size.height)];
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
            desc.text = @"我經常傍晚鍛煉，不知道什麽時間鍛煉效果最好呢？知道什麽時間鍛煉效果最好呢知道什麽時間鍛煉效果最好呢我經常傍晚鍛煉，不知道什麽時間鍛煉效果最好呢？知道什麽時間鍛煉效果最好呢知道什麽時間鍛煉效果最好呢我經常v傍晚鍛煉，不知道什麽時間鍛煉效果最好呢？g知道什d麽時間鍛煉效果最好呢知道什麽時間鍛煉效果最好呢我經常傍晚鍛煉，不知道什麽時間鍛煉效果最好呢？知道什麽時間鍛煉效果最.好呢知道什麽時間鍛煉,效果最好呢我經常傍v晚鍛煉，不知道什麽時間鍛煉效果最好呢？知道什麽時間鍛煉效果最好呢知道什麽時間鍛煉效果最好呢我經常傍晚鍛煉，不知道什麽時間鍛煉效果最好呢？知道什麽時間鍛煉效果最好呢知道什麽時間鍛煉效果最間鍛煉效果最好呢知道什麽時間鍛煉效果最間鍛煉效果最好呢知道什麽時間鍛煉效果最間鍛煉效果最好呢知道什麽時間鍛煉效果最好呢";
            desc.numberOfLines = 0;
            [desc sizeToFit];
//    desc.backgroundColor = [UIColor yellowColor];
            desc.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    
        UIView *descView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, descTitle.frame.size.height+desc.frame.size.height+textMargin*1.2)];
//        descView.backgroundColor = [UIColor blueColor];
        [descView addSubview:descTitle];
        [descView addSubview:desc];
    
        [scrollView addSubview:descView];
        /*
         *  專家回復
         */
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
        expertContentLabel.text = @"健康界人士比較支持早上運動，研究表明，早上運動可以最好地抑制血糖血脂的過度上升。但也有人認爲下午4點至6點之間運動較好。其實，選擇自己最為方便、并且能堅持下去的時間就是最合適的。健康界人士比較支持早上運動，研究表明，早上運動可以最好地抑制血糖血脂的過度上升。但也有人認爲下午4點至6點之間運動較好。其實，選擇自己最為方便、并且能堅持下去的時間就是最合適的。健康界人士比較支持早上運動，研究表明，早上運動可以最好地抑制血糖血脂的過度上升。但也有人認爲下午4點至6點之間運動較好。其實，選擇自己最為方便、并且能堅持下去的時間就是最合適的。健康界人士比較支持早上運動，研究表明，早上運動可以最好地抑制血糖血脂的過度上升。但也有人認爲下午4點至6點之間運動較好。其實，選擇自己最為方便、并且能堅持下去的時間就是最合適的。健康界人士比較支持早上運動，研究表明，早上運動可以最好地抑制血糖血脂的過度上升。但也有人認爲下午4點至6點之間運動較好。其實，選擇自己最為方便、并且能堅持下去的時間就是最合適的。健康界人士比較支持早上運動，研究表明，早上運動可以最好地抑制血糖血脂的過度上升。但也有人認爲下午4點至6點之間運動較好。其實，選擇自己最為方便、并且能堅持下去的時間就是最合適的。健康界人士比較支持早上運動，研究表明，早上運動可以最好地抑制血糖血脂的過度上升。但也有人認爲下午4點至6點之間運動較好。其實，選擇自己最為方便、并且能堅持下去的時間就是最合適的。健康界人士比較支持早上運動，研究表明，早上運動可以最好地抑制血糖血脂的過度上升。但也有人認爲下午4點至6點之間運動較好。其實，選擇自己最為方便、并且能堅持下去的時間就是最合適的。";
        expertContentLabel.numberOfLines = 0;
        [expertContentLabel sizeToFit];
        [scrollView addSubview:expertContentLabel];

        UILabel *expertContentLabelTime = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, expertContentLabel.frame.size.height+expertContentLabel.frame.origin.y+textMargin, self.view.frame.size.width-textMargin*2, lineHeight)];
        expertContentLabelTime.font = DEFAULT_FONT(12.0f);
        expertContentLabelTime.text = @"2018/02/06";
        [scrollView addSubview:expertContentLabelTime];
        /*
         *  添加评论
         */
            UIButton *newCommentButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-112, titlePadding/2, 100, lineHeight)];
            [newCommentButton setTitle:@"添加評論" forState:UIControlStateNormal];
            newCommentButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
            [newCommentButton addTarget:self action:@selector(clickNewComment) forControlEvents:UIControlEventTouchUpInside];
            [newCommentButton setImage:[UIImage imageNamed:@"addition"] forState:UIControlStateNormal];
    
            UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, titlePadding/2, 100, lineHeight)];
            commentLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
            commentLabel.text = @"評論";
            commentLabel.textColor = [UIColor whiteColor];
    
        UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, expertContentLabelTime.frame.size.height+expertContentLabelTime.frame.origin.y+textMargin, self.view.frame.size.width, commentLabel.frame.size.height+titlePadding)];
        commentView.backgroundColor = RGBA_COLOR(40, 122, 72, 1);
        [commentView addSubview:commentLabel];
        [commentView addSubview:newCommentButton];
        [scrollView addSubview:commentView];
        /*
         *  评论列表
         */
        int lastY = commentView.frame.size.height+commentView.frame.origin.y+textMargin;
        for(int i=0;i<3;i++){
            UILabel *commentUser = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, 0, self.view.frame.size.width, lineHeight)];
            commentUser.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
            commentUser.text = @"匿名用戶：";
            
            UILabel *commentContent = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, commentUser.frame.size.height+commentUser.frame.origin.y+textMargin, self.view.frame.size.width-textMargin*2, lineHeight)];
            commentContent.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
            commentContent.text = @"我最喜歡早晨鍛煉一刻鐘！我最喜歡早晨鍛煉一刻鐘！我最喜歡早晨鍛煉一刻鐘！我最喜歡早晨鍛煉一刻鐘！我最喜歡早晨鍛煉一刻鐘！我最喜歡早晨鍛煉一刻鐘！我最喜歡早晨鍛煉一刻鐘！我最喜歡早晨鍛煉一刻鐘！我ae最喜歡早晨鍛煉一刻鐘！s我最喜歡早晨鍛煉一刻鐘cd！我最喜歡早晨鍛煉d,一d刻鐘！我最喜歡早晨dc鍛煉一刻鐘！我最喜歡早晨鍛煉一刻鐘！我最喜歡早晨鍛煉一刻鐘！我最喜歡早晨鍛煉一刻鐘！我最喜歡dss最喜歡早晨鍛歡早晨鍛煉一刻鐘！";
            commentContent.numberOfLines = 0;
            [commentContent sizeToFit];

            UILabel *commentLabelTime = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, commentContent.frame.size.height+commentContent.frame.origin.y+textMargin, self.view.frame.size.width-textMargin*2, lineHeight)];
            commentLabelTime.font = DEFAULT_FONT(12.0f);
            commentLabelTime.text = @"2018/02/06";

            UIButton *commentReplyButton = [[UIButton alloc] initWithFrame:CGRectMake(commentLabelTime.frame.size.width-85, commentContent.frame.size.height+commentContent.frame.origin.y+textMargin, 100, lineHeight)];
            [commentReplyButton setTitle:@"回復" forState:UIControlStateNormal];
            commentReplyButton.titleLabel.font = DEFAULT_FONT(12.0f);
            [commentReplyButton addTarget:self action:@selector(clickReplyComment) forControlEvents:UIControlEventTouchUpInside];
            [commentReplyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [commentReplyButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
        
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)clickNewComment {
    NewCommentController *newCommentController = [[NewCommentController alloc] init];
    [self.navigationController pushViewController:newCommentController animated:YES];
}

- (void)clickReplyComment {
    NewCommentController *newCommentController = [[NewCommentController alloc] init];
    [self.navigationController pushViewController:newCommentController animated:YES];
}

@end
