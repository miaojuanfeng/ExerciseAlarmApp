//
//  CurrentPainController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "CurrentPainController.h"
#import "ShowPainController.h"

@interface CurrentPainController ()

@property AppDelegate *appDelegate;
@property UILabel *textLabel;
@property UIImageView *painImage;
@end

@implementation CurrentPainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"當前疼痛等級";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.painImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-80)/2, marginTop+20, 80, 80)];
    [self.view addSubview:self.painImage];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.painImage.frame.origin.y+self.painImage.frame.size.height, self.view.frame.size.width-40, 80)];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.numberOfLines = 0;
    self.textLabel.font =  [UIFont fontWithName:@"AppleGothic" size:16.0];
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.textLabel];
    
    UIButton *showPainButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-140)/2, self.textLabel.frame.origin.y+self.textLabel.frame.size.height, 140, 24)];
    [showPainButton setTitle:@"查看詳細痛感說明" forState:UIControlStateNormal];
    showPainButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    showPainButton.backgroundColor = RGBA_COLOR(253, 159, 81, 1);
    [showPainButton addTarget:self action:@selector(clickShowPainButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPainButton];
    
    [self showPain];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickShowPainButton {
    ShowPainController *showPainController = [[ShowPainController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:showPainController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)showPain {
    int lastPain = 0;
    int last2Pain = 0;
    for (NSString *date in self.appDelegate.userPain) {
        last2Pain = lastPain;
        lastPain = [[self.appDelegate.userPain objectForKey:date] intValue];
    }
    NSString *painText = nil;
    if( lastPain > last2Pain ){
        self.painImage.image = [UIImage imageNamed:@"PainUp"];
        painText = @"加劇";
    }else if( lastPain < last2Pain ){
        self.painImage.image = [UIImage imageNamed:@"PainDown"];
        painText = @"減輕";
    }else{
        self.painImage.image = [UIImage imageNamed:@"PainStable"];
        painText = @"平穩";
    }
    self.textLabel.text = [NSString stringWithFormat:@"您的當前疼痛等級為 %d 級，較上次有所 %@", lastPain, painText];
}

@end
