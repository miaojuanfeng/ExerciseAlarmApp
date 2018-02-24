//
//  VideoDetailController.m
//  alarm
//
//  Created by USER on 5/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VideoDetailController.h"

@interface VideoDetailController ()

@end

@implementation VideoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"視頻詳情";
    
    /*UILabel *alarmTime = [[UILabel alloc] init];
    alarmTime.frame = CGRectMake(self.view.frame.size.width/2 - 150, 50, 300, 100);
    alarmTime.text = @"視頻詳細頁";
    alarmTime.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:alarmTime];*/
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    /*NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];*/
    CGFloat videoWidth = self.view.frame.size.width - 15;
    CGFloat videoHeight = 498 * ( videoWidth / 810 );
    NSString *htmlString = [NSString stringWithFormat:@"%@%d%@%d%@", @"<iframe height=", (int)floor(videoHeight), @" width=", (int)floor(videoWidth), @" src='http://player.youku.com/embed/XMzQxMzkzOTYzNg==' frameborder=0 'allowfullscreen'></iframe>"];
    NSLog(htmlString);
    [webView loadHTMLString:htmlString baseURL:nil];
    [self.view addSubview:webView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
