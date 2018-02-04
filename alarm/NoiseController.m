//
//  NoiseController.m
//  alarm
//
//  Created by Dreamover Studio on 4/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "NoiseController.h"

@interface NoiseController ()

@end

@implementation NoiseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    view.backgroundColor = [UIColor redColor];
    imageView.image = [UIImage imageNamed:@"bg"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    UILabel *alarmTime = [[UILabel alloc] init];
    alarmTime.frame = CGRectMake(self.view.frame.size.width/2 - 150, 50, 300, 100);
    alarmTime.text = @"22:00";
    alarmTime.textColor = [UIColor whiteColor];
    alarmTime.font = [UIFont fontWithName:@"AppleGothic" size:38.0];
    alarmTime.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:alarmTime];
    
    UILabel *alarmTitle = [[UILabel alloc] init];
    alarmTitle.frame = CGRectMake(self.view.frame.size.width/2 - 100, 110, 200, 80);
    alarmTitle.text = @"瑜伽運動";
    alarmTitle.textColor = [UIColor whiteColor];
    alarmTitle.font = [UIFont fontWithName:@"AppleGothic" size:20.0];
    alarmTitle.textAlignment = NSTextAlignmentCenter;
    [imageView addSubview:alarmTitle];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitle:@"關閉" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(clickEvent) forControlEvents:UIControlEventTouchUpInside];
    closeButton.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height - 100, 100, 50);
    [imageView addSubview:closeButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)clickEvent {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
