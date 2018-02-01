//
//  ListAlarmController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "ListAlarmController.h"
#import "AddAlarmController.h"

@interface ListAlarmController () <UITableViewDataSource>
@property UIBarButtonItem *myButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ListAlarmController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"添加鬧鐘" style:UIBarButtonItemStyleBordered target:self action:@selector(clickEvent)];
    self.navigationItem.rightBarButtonItem = self.myButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickEvent {
    AddAlarmController *addAlarmController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddAlarmController"];
    [self.navigationController pushViewController:addAlarmController animated:YES];
//    [self.myButton setAdjustsImageWhenHighlighted:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    UIFont *newFont = [UIFont fontWithName:@"AppleGothic" size:28.0];
    cell.textLabel.font = newFont;
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    switch( indexPath.row ){
        case 0:
            cell.textLabel.text = @"08:20";
            cell.detailTextLabel.text = @"鬧鐘";
            break;
        case 1:
            cell.textLabel.text = @"16:00";
            cell.detailTextLabel.text = @"鬧鐘";
            break;
        case 2:
            cell.textLabel.text = @"23:30";
            cell.detailTextLabel.text = @"鬧鐘";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
