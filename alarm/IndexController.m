//
//  ViewController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "IndexController.h"
#import "ViewController.h"

@interface IndexController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation IndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch( indexPath.row ){
        case 0:
            cell.textLabel.text = @"Page1";
            break;
        case 1:
            cell.textLabel.text = @"Page2";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // 在storyboard中设置secondViewController的identifier为123
    ViewController *viewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"viewCtrl"];
    // 进行跳转
//    [self presentViewController:viewCtrl animated:YES completion:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
    NSLog(@"Jump");
}

@end
