//
//  AveragePainController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "AveragePainController.h"
#import "ShowPainController.h"

@interface AveragePainController ()

@property AppDelegate *appDelegate;
@property UILabel *textLabel;

@property UIImageView *painImage;
@end

@implementation AveragePainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"平均疼痛等級";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.painImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-80)/2, marginTop+50, 80, 80)];
    [self.view addSubview:self.painImage];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.painImage.frame.origin.y+self.painImage.frame.size.height+20, self.view.frame.size.width-40, 80)];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.numberOfLines = 0;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.textLabel];
    
    UIButton *showPainButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-180)/2, self.textLabel.frame.origin.y+self.textLabel.frame.size.height+20, 180, 34)];
    [showPainButton setTitle:@"查看詳細痛感說明" forState:UIControlStateNormal];
    showPainButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
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
    int total = 0;
    long count = self.appDelegate.userPain.count;
    for (NSString *date in self.appDelegate.userPain) {
        int pain = [[self.appDelegate.userPain objectForKey:date] intValue];
        total += pain;
    }
    int average = 0;
    if( count > 0 ){
        average = (int)(total/count);
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:DEFAULT_FONT(DEFAULT_FONT_SIZE),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    self.textLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"您的平均疼痛等級為 %d 級，屬於 %@", average, [self.appDelegate.painList objectAtIndex:average]] attributes:attributes];
    self.painImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"Pain%d", average/2+1]];
}

@end
