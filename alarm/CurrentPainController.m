//
//  CurrentPainController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "CurrentPainController.h"
#import "ShowPainController.h"

@interface CurrentPainController ()

@end

@implementation CurrentPainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"當前疼痛等級";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UIImageView *painImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-80)/2, marginTop+20, 80, 80)];
    painImage.image = [UIImage imageNamed:@"PainUp"];
    [self.view addSubview:painImage];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, painImage.frame.origin.y+painImage.frame.size.height, self.view.frame.size.width-40, 80)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.numberOfLines = 0;
    textLabel.font =  [UIFont fontWithName:@"AppleGothic" size:16.0];
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textLabel.text = @"您的當前疼痛等級為 3 級，較上次有所 加劇";
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textLabel];
    
    UIButton *showPainButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-140)/2, textLabel.frame.origin.y+textLabel.frame.size.height, 140, 24)];
    [showPainButton setTitle:@"查看詳細痛感說明" forState:UIControlStateNormal];
    showPainButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    showPainButton.backgroundColor = RGBA_COLOR(253, 159, 81, 1);
    [showPainButton addTarget:self action:@selector(clickShowPainButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPainButton];
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

@end
