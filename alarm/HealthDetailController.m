//
//  HealthDetailController.m
//  alarm
//
//  Created by Dreamover Studio on 28/3/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "HealthDetailController.h"

@interface HealthDetailController ()

@end

@implementation HealthDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"常識詳情";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, marginTop+10, self.view.frame.size.width-20, 20)];
    titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE];
    titleLabel.text = @"這裡是常識標題";
    [self.view addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, titleLabel.frame.origin.y+titleLabel.frame.size.height+10, self.view.frame.size.width-20, 168)];
    imageView.backgroundColor = [UIColor blueColor];
    imageView.image = [UIImage imageNamed:@"bg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    [self.view addSubview:imageView];
    
    UITextView *descTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, imageView.frame.origin.y+imageView.frame.size.height+10, self.view.frame.size.width, 300)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont fontWithName:@"AppleGothic" size:DEFAULT_FONT_SIZE-2],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    descTextView.attributedText = [[NSAttributedString alloc] initWithString:@"這裡是常識內容\n這裡是常識內容\n這裡是常識內容\n這裡是常識內容" attributes:attributes];
    descTextView.editable = NO;
    [self.view addSubview:descTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

