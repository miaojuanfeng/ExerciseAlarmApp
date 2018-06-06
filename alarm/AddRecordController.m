//
//  AddRecordController.m
//  alarm
//
//  Created by Michael.Miao on 6/6/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "AddRecordController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface AddRecordController ()
@property UITableView *tableView;
@property UIBarButtonItem *myButton;
@property NSMutableArray *soundArr;

@property AppDelegate *appDelegate;
@end

@implementation AddRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"新錄音";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
