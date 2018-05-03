//
//  SettingController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "SettingController.h"
#import "PwdController.h"
#import "HelpController.h"
#import "AboutController.h"
#import "VersionController.h"
#import "AppDelegate.h"
#import "LoginController.h"

@interface SettingController () <UITableViewDelegate, UITableViewDataSource>
@property UITableView *tableView;
@property AppDelegate *appDelegate;
@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"設置";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, self.view.frame.size.height-marginTop-self.tabBarController.tabBar.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = false;
    [self.view addSubview:self.tableView];
    
    UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height-200, self.view.frame.size.width-20, 44)];
    logoutButton.backgroundColor = [UIColor blueColor];
    logoutButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [logoutButton setTitle:@"登出這個賬戶" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(clickLogoutButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
    cell.textLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    if( indexPath.section == 0 ){
        switch( indexPath.row ){
            case 0:
                cell.textLabel.text = @"修改密碼";
                cell.imageView.image = [UIImage imageNamed:@"settings"];
                break;
            case 1:
                cell.textLabel.text = @"查看幫助";
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
    PwdController *pwdController = nil;
    HelpController *helpController = nil;
    AboutController *aboutController = nil;
    VersionController *versionController = nil;
    if( indexPath.section == 0 ){
        switch( indexPath.row ){
            case 0:
                pwdController = [[PwdController alloc] init];
                [self.navigationController pushViewController:pwdController animated:YES];
                break;
            case 1:
                helpController = [[HelpController alloc] init];
                [self.navigationController pushViewController:helpController animated:YES];
                break;
            case 2:
                aboutController = [[AboutController alloc] init];
                [self.navigationController pushViewController:aboutController animated:YES];
                break;
        }
    }else if( indexPath.section == 1 ){
        switch( indexPath.row ){
            case 0:
                versionController = [[VersionController alloc] init];
                [self.navigationController pushViewController:versionController animated:YES];
                break;
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)clickLogoutButton {
    [self.appDelegate deleteUser];
    [self.appDelegate clearNotification];
    LoginController *loginController = [[LoginController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginController];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
