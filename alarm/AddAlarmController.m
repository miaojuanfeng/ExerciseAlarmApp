//
//  ViewController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "AddAlarmController.h"
#import "SelectPhotoController.h"
#import "SelectMusicController.h"

@interface AddAlarmController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AddAlarmController

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"更多設置";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch ( indexPath.row ) {
        case 0:
            cell.textLabel.text = @"圖片";
            cell.imageView.image = [UIImage imageNamed:@"gallery"];
            break;
        case 1:
            cell.textLabel.text = @"鈴聲";
            cell.imageView.image = [UIImage imageNamed:@"music"];
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SelectPhotoController *selectPhotoController = nil;
    SelectMusicController *selectMusicController = nil;
    switch (indexPath.row) {
        case 0:
            selectPhotoController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectPhotoController"];
            [self.navigationController pushViewController:selectPhotoController animated:YES];
            break;
        case 1:
            selectMusicController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectMusicController"];
            [self.navigationController pushViewController:selectMusicController animated:YES];
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
