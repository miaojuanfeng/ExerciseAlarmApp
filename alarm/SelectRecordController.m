//
//  SelectRecordController.m
//  alarm
//
//  Created by Michael.Miao on 6/6/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "SelectRecordController.h"
#import "AddRecordController.h"
#import <AVFoundation/AVFoundation.h>

@interface SelectRecordController () <UITableViewDataSource, UITableViewDelegate, AddRecordControllerDelegate>
@property UITableView *tableView;
@property UIBarButtonItem *myButton;
@property NSMutableArray *soundArr;

@property AppDelegate *appDelegate;

@property AVAudioSession *session;
@property AVAudioPlayer *player;
@end

@implementation SelectRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"錄音";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"確定" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveButton)];
    self.navigationItem.rightBarButtonItem = self.myButton;
    
    UIButton *recordingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, marginTop, self.view.frame.size.width, 55)];
    [recordingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [recordingButton setTitle:@"添加新錄音" forState:UIControlStateNormal];
    recordingButton.backgroundColor = RGBA_COLOR(244 ,106, 81, 1);
    recordingButton.titleLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    [recordingButton addTarget:self action:@selector(clickRecordButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordingButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, recordingButton.frame.origin.y+recordingButton.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-marginTop-self.tabBarController.tabBar.frame.size.height-recordingButton.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.soundArr = self.appDelegate.recordList;
    
    if( self.soundArr.count == 0 ){
        self.myButton.enabled = NO;
    }else{
        self.recordPath = [[self.soundArr objectAtIndex:0] objectForKey:@"path"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.soundArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    NSMutableDictionary *soundDic = [self.soundArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [soundDic objectForKey:@"name"]];
    cell.textLabel.font = DEFAULT_FONT(DEFAULT_FONT_SIZE);
    if( [soundDic objectForKey:@"path"] == self.recordPath ){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSArray *array = [tableView visibleCells];
    for (UITableViewCell *cell in array) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.textLabel.textColor=[UIColor blackColor];
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //
    if( [self.player isPlaying] ){
        [self.player stop];
    }else{
        NSMutableDictionary *soundDic = [self.soundArr objectAtIndex:indexPath.row];
        self.recordPath = [soundDic objectForKey:@"path"];
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], self.recordPath]] error:nil];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if (session == nil) {
            NSLog(@"Error creating session: %@",[sessionError description]);
        }else{
            [session setActive:YES error:nil];
        }
        self.session = session;
        [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
        [self.player play];
        NSLog(@"%@", self.recordPath);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)clickSaveButton {
//    AudioServicesDisposeSystemSoundID(self.soundId);
    [self.player stop];
    if(self.delegate && [self.delegate respondsToSelector:@selector(getRecordPath:)]){
        [self.delegate getRecordPath:self.recordPath];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRecordButton {
    AddRecordController *addRecordController = [[AddRecordController alloc] init];
    addRecordController.delegate = self;
    addRecordController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addRecordController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 刪除文件
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], [[self.appDelegate.recordList objectAtIndex:indexPath.row] objectForKey:@"path"]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:filePath];
    if (fileExists) {
        [fileManager removeItemAtPath:filePath error:nil];
    }
    // 删除模型
    [self.appDelegate.recordList removeObjectAtIndex:indexPath.row];
    [self.appDelegate saveRecordList];
    
    // 刷新
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    if( self.soundArr.count == 0 ){
        self.myButton.enabled = NO;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)getRecordPath:(NSString *)recordPath{
    self.recordPath = recordPath;
    self.myButton.enabled = YES;
    NSLog(@"ddd: %@", recordPath);
}
@end
