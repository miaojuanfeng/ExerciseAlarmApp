//
//  PlayVideoController.m
//  alarm
//
//  Created by USER on 26/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PlayVideoController.h"

@interface PlayVideoController ()

@property MPMoviePlayerController *moviePlayer;
@property (nonatomic,strong) MPMoviePlayerViewController *moviePlayerViewController;
@property NSURL *videoUrl;
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
    
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    /*NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//     NSURLRequest *request = [NSURLRequest requestWithURL:url];
//     [webView loadRequest:request];*/
//    CGFloat videoWidth = self.view.frame.size.width - 15;
//    CGFloat videoHeight = 498 * ( videoWidth / 810 );
//    NSString *htmlString = [NSString stringWithFormat:@"%@%d%@%d%@", @"<iframe height=", (int)floor(videoHeight), @" width=", (int)floor(videoWidth), @" src='http://player.youku.com/embed/XMzQxMzkzOTYzNg==' frameborder=0 'allowfullscreen'></iframe>"];
//    [webView loadHTMLString:htmlString baseURL:nil];
//    [self.view addSubview:webView];
    
//    NSURL *remoteURL = [NSURL URLWithString:@"http://v1.mukewang.com/57de8272-38a2-4cae-b734-ac55ab528aa8/L.mp4"];
//    self.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:remoteURL];
//    [self presentViewController:self.playerVC animated:YES completion:^{
//        [self.playerVC.moviePlayer play];
//    }];
    self.videoUrl = [NSURL URLWithString:@"http://104.236.150.123:8080/exercise-video.mp4"];
    [self.moviePlayer play];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  创建媒体播放控制器MPMoviePlayerControlle 可以控制尺寸
 *
 *  @return 媒体播放控制器
 */
-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSURL *url=[self getNetworkUrl];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame=self.view.bounds;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addNotification];
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

#pragma mark - 私有方法
//获取本地路径
-(NSURL *)getFileUrl{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"xxx.mp4" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getNetworkUrl{
    NSString *urlStr=@"http://104.236.150.123:8080/exercise-video.mp4";
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
}

/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
            break;
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}





////使用 MPMoviePlayerViewController，只能全屏
//
///**
// 
// *  视频播放控制器全屏
// 
// */
//
//
//
//
//-(MPMoviePlayerViewController *)moviePlayerViewController{
//    
//    if (!_moviePlayerViewController) {
//        
//        NSURL *url=self.videoUrl;
//        
//        _moviePlayerViewController=[[MPMoviePlayerViewController alloc]initWithContentURL:url];
//        
//        [self addNotification1];
//        
//    }
//    
//    return _moviePlayerViewController;
//    
//}
//
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//
//{
//    
//    //播放
//    
//    [self presentMoviePlayerViewControllerAnimated:self.moviePlayerViewController];
//    
//}
//
//
//
//-(void)addNotification1{
//    
//    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
//    
//    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange1:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayerViewController.moviePlayer];
//    
//    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished1:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerViewController.moviePlayer];
//    
//    
//    
//}
//
//
//
///**
// 
// *  播放状态改变，注意播放完成时的状态是暂停
// 
// *
// 
// *  @param notification 通知对象
// 
// */
//
//-(void)mediaPlayerPlaybackStateChange1:(NSNotification *)notification{
//    
//    switch (self.moviePlayerViewController.moviePlayer.playbackState) {
//            
//        case MPMoviePlaybackStatePlaying:
//            
//            NSLog(@"正在播放...");
//            
//            break;
//            
//        case MPMoviePlaybackStatePaused:
//            
//            NSLog(@"暂停播放.");
//            
//            break;
//            
//        case MPMoviePlaybackStateStopped:
//            
//            NSLog(@"停止播放.");
//            
//            self.moviePlayerViewController =nil;
//            
//            break;
//            
//        default:
//            
//            NSLog(@"播放状态:%li",self.moviePlayerViewController.moviePlayer.playbackState);
//            
//            break;
//            
//    }
//    
//}
//
//
//
///**
// 
// *  播放完成
// 
// *
// 
// *  @param notification 通知对象
// 
// */
//
//-(void)mediaPlayerPlaybackFinished1:(NSNotification *)notification{
//    
//    NSLog(@"播放完成.%li",self.moviePlayerViewController.moviePlayer.playbackState);
//    
//    self.moviePlayerViewController =nil;
//    
//}

@end
