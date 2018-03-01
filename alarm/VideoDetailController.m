//
//  VideoDetailController.m
//  alarm
//
//  Created by USER on 5/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VideoDetailController.h"
#import "PlayVideoController.h"

@interface VideoDetailController ()

@end

@implementation VideoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"視頻詳情";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+10, self.view.frame.size.width-40, 50)];
    title.text = @"動作說明";
    title.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [self.view addSubview:title];
    
    UIImage *image1 = [UIImage imageNamed:@"action1.png"];
    int imageWidth = ( self.view.frame.size.width - 60 ) / 2;
    int imageHeight = image1.size.height / ( imageWidth / image1.size.width );
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, marginTop+10+60, imageWidth, imageHeight)];
    imageView1.image = image1;
    [self.view addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(imageWidth+40, marginTop+10+60, imageWidth, imageHeight)];
    imageView2.image = [UIImage imageNamed:@"action2.png"];
    [self.view addSubview:imageView2];
    
    UIButton *showVideoButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, marginTop+10+76+imageHeight, 100, 44)];
    [showVideoButton setTitle:@"影片示範" forState:UIControlStateNormal];
    showVideoButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    [showVideoButton addTarget:self action:@selector(clickShowVideo) forControlEvents:UIControlEventTouchUpInside];
    [showVideoButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:showVideoButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickShowVideo {
    PlayVideoController *playVideoController = [[PlayVideoController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:playVideoController];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
