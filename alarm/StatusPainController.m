//
//  StatusPainController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "StatusPainController.h"
#import "ShowPainController.h"

@interface StatusPainController ()
@property UITableView *tableView;
@end

@implementation StatusPainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"痛感自我評分";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(clickSubmitButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+20, self.view.frame.size.width-40, 80)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.numberOfLines = 0;
    textLabel.font =  [UIFont fontWithName:@"AppleGothic" size:16.0];
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textLabel.text = @"請在以下空格輸入一個0-10的數字，表示您的痛感程度：0代表完全無痛，10代表極度劇痛，由0至10痛感依次遞增。";
    [self.view addSubview:textLabel];
    
    UIButton *showPainButton = [[UIButton alloc] initWithFrame:CGRectMake(20, textLabel.frame.origin.y+textLabel.frame.size.height, 140, 24)];
    [showPainButton setTitle:@"查看詳細痛感說明" forState:UIControlStateNormal];
    showPainButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:16.0];
    showPainButton.backgroundColor = [UIColor redColor];
    [showPainButton addTarget:self action:@selector(clickShowPainButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showPainButton];
    
    UITextField *numberField = [[UITextField alloc] initWithFrame:CGRectMake(20, showPainButton.frame.origin.y+showPainButton.frame.size.height+15, self.view.frame.size.width-40, 34)];
    numberField.borderStyle = UITextBorderStyleRoundedRect;
    numberField.clearButtonMode = UITextFieldViewModeWhileEditing;
    numberField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:numberField];
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
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"確認痛感" message:@"您當前痛感等級為3，屬於中度疼痛。\n是否提交?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //响应事件
        NSLog(@"action = %@", action);
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //响应事件
//        NSLog(@"action = %@", action);
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
