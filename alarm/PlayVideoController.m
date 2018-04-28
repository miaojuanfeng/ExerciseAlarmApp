//
//  PlayVideoController.m
//  alarm
//
//  Created by USER on 26/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PlayVideoController.h"

@interface PlayVideoController ()
@property AppDelegate *appDelegate;

@property UIView *starView;

@property MPMoviePlayerController *moviePlayer;
@property (nonatomic,strong) MPMoviePlayerViewController *moviePlayerViewController;
@property NSURL *videoUrl;

@property NSTimer *timer;
@property int scd;

@property UIView *starButtonView;
@property long star;
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
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
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
    
    self.starView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-250)/2, (self.view.frame.size.height-marginTop-250)/2, 250, 250)];
    self.starView.layer.masksToBounds = YES;
    self.starView.backgroundColor = [UIColor whiteColor];
    self.starView.hidden = YES;
    
    UILabel *starTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.starView.frame.size.width-40, 30)];
    starTitle.text = @"恭喜你完成鍛煉！";
    starTitle.font = DEFAULT_FONT(22.0f);
    [self.starView addSubview:starTitle];
    
    UILabel *starDesc = [[UILabel alloc] initWithFrame:CGRectMake(20, starTitle.frame.origin.y+starTitle.frame.size.height+20, self.starView.frame.size.width-40, 30)];
    starDesc.text = @"給自己的表現一個分數吧！";
    starDesc.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [self.starView addSubview:starDesc];
    
    self.starButtonView = [[UIView alloc] initWithFrame:CGRectMake(20, starDesc.frame.origin.y+starDesc.frame.size.height+20, self.starView.frame.size.width-40, 40)];
//    starButtonView.backgroundColor = [UIColor blueColor];
    for (int i=1; i<=5; i++) {
        UIButton *starButton = [[UIButton alloc] initWithFrame:CGRectMake((i-1)*(2+40), 0, 40, 40)];
//        starButton.backgroundColor = [UIColor redColor];
        [starButton setTitle:@"\U0000e6eb" forState:UIControlStateNormal];
        [starButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        starButton.titleLabel.font = ICON_FONT(34);
        starButton.tag = i;
        [starButton addTarget:self action:@selector(clickStarButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.starButtonView addSubview:starButton];
    }
    [self.starView addSubview:self.starButtonView];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(-1, self.starView.frame.size.height-44+1, self.starView.frame.size.width/2+1, 44)];
    [leftButton setTitle:@"確認" forState:UIControlStateNormal];
    [leftButton setTitleColor:RGBA_COLOR(85, 172, 243, 1) forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
    [leftButton.layer setBorderColor:BORDER_COLOR];
    [leftButton.layer setBorderWidth:BORDER_WIDTH];
    [self.starView addSubview:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(self.starView.frame.size.width/2-1, self.starView.frame.size.height-44+1, self.starView.frame.size.width/2+2, 44)];
    [rightButton setTitle:@"不用了" forState:UIControlStateNormal];
    [rightButton setTitleColor:RGBA_COLOR(85, 172, 243, 1) forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    [rightButton.layer setBorderColor:BORDER_COLOR];
    [rightButton.layer setBorderWidth:BORDER_WIDTH];
    [self.starView addSubview:rightButton];
    
    self.star = 0;
    [self.view addSubview:self.starView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickCloseButton {
    [self invalidateTimer];
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
    if ( self.moviePlayer.playbackState == MPMoviePlaybackStatePlaying ) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            self.scd++;
            NSLog(@"%d", self.scd);
        }];
        NSLog(@"正在播放...");
    }else if( self.moviePlayer.playbackState == MPMoviePlaybackStatePaused ){
        [self invalidateTimer];
        NSLog(@"暂停播放.");
    }else if( self.moviePlayer.playbackState == MPMoviePlaybackStateStopped ){
        [self invalidateTimer];
        NSLog(@"停止播放.");
    }else{
        NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
    }
}

/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    self.starView.hidden = NO;
    [self invalidateTimer];
    NSLog(@"播放完成.%li",self.moviePlayer.playbackState);
}

- (void)invalidateTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)clickStarButton:(UIButton*)btn {
    self.star = btn.tag;
    for(UIButton *starButton in self.starButtonView.subviews){
        if(starButton.tag <= btn.tag ){
            [starButton setTitle:@"\U0000e6ea" forState:UIControlStateNormal];
            [starButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            [starButton setTitle:@"\U0000e6eb" forState:UIControlStateNormal];
            [starButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
}

- (void)clickLeftButton {
    [self.appDelegate saveExerciseTime:self.scd];
    if(self.star>0){
        [self.appDelegate saveWeekStar:self.star];
    }
    self.starView.hidden = YES;
}

- (void)clickRightButton {
    self.starView.hidden = YES;
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
