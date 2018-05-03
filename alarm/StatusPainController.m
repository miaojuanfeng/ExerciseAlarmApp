//
//  StatusPainController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "StatusPainController.h"
#import "ShowPainController.h"
#import "StatusFourController.h"

@interface StatusPainController () <UIGestureRecognizerDelegate>
@property UITableView *tableView;

@property UITextField *numberField;

@property AppDelegate *appDelegate;
@end

@implementation StatusPainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = RGBA_COLOR(240, 240, 245, 1);
    self.navigationItem.title = @"痛感自我評分";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(clickSubmitButton)];
//    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIView *boxView = [[UIView alloc] initWithFrame:CGRectMake(20, marginTop+20, self.view.frame.size.width-40, 290)];
    boxView.backgroundColor = [UIColor whiteColor];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, boxView.frame.size.width-40, 140)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:DEFAULT_FONT(DEFAULT_FONT_SIZE),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textLabel.attributedText = [[NSAttributedString alloc] initWithString:@"請在以下空格輸入一個0-10的數字，表示您的痛感程度：0代表完全無痛，10代表極度劇痛，由0至10痛感依次遞增。" attributes:attributes];
    
    
    [boxView addSubview:textLabel];
    
    UIButton *showPainButton = [[UIButton alloc] initWithFrame:CGRectMake(20, textLabel.frame.origin.y+textLabel.frame.size.height+10, 180, 34)];
    [showPainButton setTitle:@"查看詳細痛感說明" forState:UIControlStateNormal];
    showPainButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    showPainButton.backgroundColor = RGBA_COLOR(253, 159, 81, 1);
    [showPainButton addTarget:self action:@selector(clickShowPainButton) forControlEvents:UIControlEventTouchUpInside];
    [boxView addSubview:showPainButton];
    
    self.numberField = [[UITextField alloc] initWithFrame:CGRectMake((boxView.frame.size.width-220)/2, showPainButton.frame.origin.y+showPainButton.frame.size.height+20, 220, 44)];
    self.numberField.placeholder = @"輸入一個0-10的整数";
    self.numberField.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    self.numberField.borderStyle = UITextBorderStyleRoundedRect;
    self.numberField.keyboardType = UIKeyboardTypeNumberPad;
    [boxView addSubview:self.numberField];
    
    [self.view addSubview:boxView];
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(250/2, boxView.frame.origin.y+boxView.frame.size.height+30, self.view.frame.size.width-250, 44)];
    submitButton.backgroundColor = RGBA_COLOR(49, 132, 225, 1);
    submitButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    submitButton.layer.cornerRadius = 15;
    submitButton.layer.masksToBounds = YES;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(clickSubmitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    singleTap.delegate = self;
    [self.view addGestureRecognizer:singleTap];
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

- (void)clickSubmitButton {
    [self.view endEditing:YES];
    
    int level = [self.numberField.text intValue];
    if( [self.numberField.text isEqualToString:@""] || level < 0 || level > 10 ){
        HUD_TOAST_SHOW(@"痛感等級不正確");
        return;
    }
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"確認痛感" message:[NSString stringWithFormat:@"您當前痛感等級為%d，屬於%@。\n是否提交?", level, [self.appDelegate.painList objectAtIndex:level]]  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //响应事件
        [self.appDelegate saveUserPain:level];
        
        StatusFourController *statusFourController = [[StatusFourController alloc] init];
        [self.navigationController pushViewController:statusFourController animated:YES];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //响应事件
//        NSLog(@"action = %@", action);
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

@end
