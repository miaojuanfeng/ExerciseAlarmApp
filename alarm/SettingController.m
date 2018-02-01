//
//  SettingController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "SettingController.h"

@interface SettingController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
     self.automaticallyAdjustsScrollViewInsets = false;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch( section ){
        case 0:
            return 3;
            break;
        default:
            return 1;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch( section ){
        case 0:
            return @"通用設置";
            break;
        default:
            return @"系統設置";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if( indexPath.section == 0 ){
        switch( indexPath.row ){
            case 0:
                cell.textLabel.text = @"修改密碼";
                cell.imageView.image = [UIImage imageNamed:@"settings"];
                break;
            case 1:
                cell.textLabel.text = @"使用幫助";
                cell.imageView.image = [UIImage imageNamed:@"settings"];
                break;
            case 2:
                cell.textLabel.text = @"關於我們";
                cell.imageView.image = [UIImage imageNamed:@"settings"];
                break;
        }
    }else if( indexPath.section == 1 ){
        switch( indexPath.row ){
            case 0:
                cell.textLabel.text = @"版本更新";
                cell.imageView.image = [UIImage imageNamed:@"settings"];
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
