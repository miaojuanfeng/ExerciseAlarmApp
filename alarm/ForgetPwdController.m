//
//  ForgetPwdController.m
//  alarm
//
//  Created by Dreamover Studio on 18/3/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "ForgetPwdController.h"
#import "AppDelegate.h"

@interface ForgetPwdController ()
@property AppDelegate *appDelegate;
@end

@implementation ForgetPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"幫助";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIImage *shoolImage = [UIImage imageNamed:@"ShoolLogo"];
    float imageWidth = self.view.frame.size.width-50;
    float imageHeight = imageWidth/shoolImage.size.width*shoolImage.size.height;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50/2, marginTop+10, imageWidth, imageHeight)];
    imageView.image = shoolImage;
    [self.view addSubview:imageView];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(50/2, imageView.frame.origin.y+imageView.frame.size.height+20, self.view.frame.size.width-50, 135)];
    textView.backgroundColor = RGBA_COLOR(158, 218, 182, 1);
    textView.editable = NO;
    textView.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    textView.text = @"請通過下述方式聯絡我們，以找回手機號或密碼。\n\n電話：1122-3344\n電郵：imse@hku.hk";
    
    [self.view addSubview:textView];
    
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(200/2, textView.frame.origin.y+textView.frame.size.height+50, self.view.frame.size.width-200, 44)];
    submitButton.backgroundColor = RGBA_COLOR(49, 132, 225, 1);
    submitButton.layer.cornerRadius = 15;
    submitButton.layer.masksToBounds = YES;
    submitButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [submitButton setTitle:@"退出應用程式" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(clickQuitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)clickQuitButton {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:1.0f animations:^{
        
        window.alpha = 0;
        
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
        
    } completion:^(BOOL finished) {
        
        exit(0);
        
    }];
    
    //exit(0);
}


@end
