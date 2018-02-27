//
//  ShowPhotoController.m
//  alarm
//
//  Created by USER on 27/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "ShowPhotoController.h"

@interface ShowPhotoController ()

@end

@implementation ShowPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    // 读取沙盒路径图片
    NSString *photoPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), self.photoName];
    // 拿到沙盒路径图片
    UIImage *imgFromUrl = [[UIImage alloc]initWithContentsOfFile:photoPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageView.image = imgFromUrl;
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitle:@"關閉" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(clickCloseButton) forControlEvents:UIControlEventTouchUpInside];
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

- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
