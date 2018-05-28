//
//  VideoDetailController.m
//  alarm
//
//  Created by USER on 5/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "VideoDetailController.h"
#import "PlayVideoController.h"

@interface VideoDetailController ()
@property MPMoviePlayerViewController *playerVC;

@property AppDelegate *appDelegate;
@end

@implementation VideoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"視頻詳情";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+10, self.view.frame.size.width-40, 50)];
    title.text = @"動作說明";
    title.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
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
    showVideoButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
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
/*    NSURL *remoteURL = [NSURL URLWithString:@"http://104.236.150.123:8080/exercise-video.mp4"];
    self.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:remoteURL];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self.playerVC name:MPMoviePlayerPlaybackDidFinishNotification object:self.playerVC.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.playerVC.moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieStateChangeCallback:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.playerVC.moviePlayer];
    
    [self presentViewController:self.playerVC animated:YES completion:^{
        [self.playerVC.moviePlayer play];
    }];*/
//    [self presentMoviePlayerViewControllerAnimated:self.playerVC];
}

//-(void)movieStateChangeCallback:(NSNotification*)notify  {
//
//    //点击播放器中的播放/ 暂停按钮响应的通知
//    NSLog(@"pause");
//
//
//
//}
//
//-(void)videoFinished:(NSNotification*)notification{
//     NSLog(@"pause");
//    int value = [[notification.userInfo valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
//    if (value == MPMovieFinishReasonUserExited) {
////        [self dismissMoviePlayerViewControllerAnimated];
//        [self dismissViewControllerAnimated:self.playerVC completion:nil];
//    }
//}

@end
