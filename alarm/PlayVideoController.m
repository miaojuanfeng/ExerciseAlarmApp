//
//  PlayVideoController.m
//  alarm
//
//  Created by USER on 26/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PlayVideoController.h"

@interface PlayVideoController ()

@end

@implementation PlayVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"影片示範";
    
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"關閉" style:UIBarButtonItemStyleBordered target:self action:@selector(clickCloseButton)];
    self.navigationItem.leftBarButtonItem = myButton;
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, self.view.frame.size.height)];
    /*NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     [webView loadRequest:request];*/
    CGFloat videoWidth = self.view.frame.size.width - 15;
    CGFloat videoHeight = 498 * ( videoWidth / 810 );
    NSString *htmlString = [NSString stringWithFormat:@"%@%d%@%d%@", @"<iframe height=", (int)floor(videoHeight), @" width=", (int)floor(videoWidth), @" src='http://player.youku.com/embed/XMzQxMzkzOTYzNg==' frameborder=0 'allowfullscreen'></iframe>"];
    [webView loadHTMLString:htmlString baseURL:nil];
    [self.view addSubview:webView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
