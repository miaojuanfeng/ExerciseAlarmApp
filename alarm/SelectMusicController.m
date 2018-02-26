//
//  SelectMusicController.m
//  alarm
//
//  Created by Dreamover Studio on 22/1/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import "SelectMusicController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SelectMusicController () <UITableViewDataSource, UITableViewDelegate>
@property UITableView *tableView;
@property UIBarButtonItem *myButton;
@property NSMutableArray *soundArr;
@end

@implementation SelectMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"鈴聲";
    
    self.myButton = [[UIBarButtonItem alloc] initWithTitle:@"確定" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveButton)];
    self.navigationItem.rightBarButtonItem = self.myButton;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    
    self.soundArr = [[NSMutableArray alloc] init];
    NSMutableDictionary *soundDic;
    
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"new-mail" forKey:@"name"]; [soundDic setObject:@"1000" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"mail-sent" forKey:@"name"]; [soundDic setObject:@"1001" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Voicemail" forKey:@"name"]; [soundDic setObject:@"1002" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"ReceivedMessage" forKey:@"name"]; [soundDic setObject:@"1003" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"SentMessage" forKey:@"name"]; [soundDic setObject:@"1004" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"alarm" forKey:@"name"]; [soundDic setObject:@"1005" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"low_power" forKey:@"name"]; [soundDic setObject:@"1006" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received1" forKey:@"name"]; [soundDic setObject:@"1007" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received2" forKey:@"name"]; [soundDic setObject:@"1008" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received3" forKey:@"name"]; [soundDic setObject:@"1009" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received4" forKey:@"name"]; [soundDic setObject:@"1010" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received1" forKey:@"name"]; [soundDic setObject:@"1012" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received5" forKey:@"name"]; [soundDic setObject:@"1013" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received6" forKey:@"name"]; [soundDic setObject:@"1014" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Voicemail" forKey:@"name"]; [soundDic setObject:@"1015" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"tweet_sent" forKey:@"name"]; [soundDic setObject:@"1016" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Anticipate" forKey:@"name"]; [soundDic setObject:@"1020" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Bloom" forKey:@"name"]; [soundDic setObject:@"1021" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Calypso" forKey:@"name"]; [soundDic setObject:@"1022" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Choo_Choo" forKey:@"name"]; [soundDic setObject:@"1023" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Descent" forKey:@"name"]; [soundDic setObject:@"1024" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Fanfare" forKey:@"name"]; [soundDic setObject:@"1025" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Ladder" forKey:@"name"]; [soundDic setObject:@"1026" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Minuet" forKey:@"name"]; [soundDic setObject:@"1027" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"News_Flash" forKey:@"name"]; [soundDic setObject:@"1028" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Noir" forKey:@"name"]; [soundDic setObject:@"1029" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Sherwood_Forest" forKey:@"name"]; [soundDic setObject:@"1030" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Spell" forKey:@"name"]; [soundDic setObject:@"1031" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Suspense" forKey:@"name"]; [soundDic setObject:@"1032" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Telegraph" forKey:@"name"]; [soundDic setObject:@"1033" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Tiptoes" forKey:@"name"]; [soundDic setObject:@"1034" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Typewriters" forKey:@"name"]; [soundDic setObject:@"1035" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Update" forKey:@"name"]; [soundDic setObject:@"1036" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"ussd" forKey:@"name"]; [soundDic setObject:@"1050" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"SIMToolkitCallDropped" forKey:@"name"]; [soundDic setObject:@"1051" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"SIMToolkitGeneralBeep" forKey:@"name"]; [soundDic setObject:@"1052" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"SIMToolkitNegativeACK" forKey:@"name"]; [soundDic setObject:@"1053" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"SIMToolkitPositiveACK" forKey:@"name"]; [soundDic setObject:@"1054" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"SIMToolkitSMS" forKey:@"name"]; [soundDic setObject:@"1055" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Tink" forKey:@"name"]; [soundDic setObject:@"1057" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"ct-busy" forKey:@"name"]; [soundDic setObject:@"1070" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"ct-congestion" forKey:@"name"]; [soundDic setObject:@"1071" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"ct-path-ack" forKey:@"name"]; [soundDic setObject:@"1072" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"ct-error" forKey:@"name"]; [soundDic setObject:@"1073" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"ct-call-waiting" forKey:@"name"]; [soundDic setObject:@"1074" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"ct-keytone2" forKey:@"name"]; [soundDic setObject:@"1075" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"lock" forKey:@"name"]; [soundDic setObject:@"1100" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"unlock" forKey:@"name"]; [soundDic setObject:@"1101" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Tink" forKey:@"name"]; [soundDic setObject:@"1103" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Tock" forKey:@"name"]; [soundDic setObject:@"1104" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Tock" forKey:@"name"]; [soundDic setObject:@"1105" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"beep-beep" forKey:@"name"]; [soundDic setObject:@"1106" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"RingerChanged" forKey:@"name"]; [soundDic setObject:@"1107" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"photoShutter" forKey:@"name"]; [soundDic setObject:@"1108" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"shake" forKey:@"name"]; [soundDic setObject:@"1109" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"jbl_begin" forKey:@"name"]; [soundDic setObject:@"1110" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"jbl_confirm" forKey:@"name"]; [soundDic setObject:@"1111" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"jbl_cancel" forKey:@"name"]; [soundDic setObject:@"1112" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"begin_record" forKey:@"name"]; [soundDic setObject:@"1113" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"end_record" forKey:@"name"]; [soundDic setObject:@"1114" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"jbl_ambiguous" forKey:@"name"]; [soundDic setObject:@"1115" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"jbl_no_match" forKey:@"name"]; [soundDic setObject:@"1116" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"begin_video_record" forKey:@"name"]; [soundDic setObject:@"1117" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"end_video_record" forKey:@"name"]; [soundDic setObject:@"1118" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"vc~invitation-accepted" forKey:@"name"]; [soundDic setObject:@"1150" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"vc~ringing" forKey:@"name"]; [soundDic setObject:@"1151" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"vc~ended" forKey:@"name"]; [soundDic setObject:@"1152" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"ct-call-waiting" forKey:@"name"]; [soundDic setObject:@"1153" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"vc~ringing" forKey:@"name"]; [soundDic setObject:@"1154" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"dtmf-0" forKey:@"name"]; [soundDic setObject:@"1200" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"dtmf-1" forKey:@"name"]; [soundDic setObject:@"1201" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"dtmf-2" forKey:@"name"]; [soundDic setObject:@"1202" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"dtmf-3" forKey:@"name"]; [soundDic setObject:@"1203" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"dtmf-4" forKey:@"name"]; [soundDic setObject:@"1204" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"dtmf-5" forKey:@"name"]; [soundDic setObject:@"1205" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"dtmf-6" forKey:@"name"]; [soundDic setObject:@"1206" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"dtmf-7" forKey:@"name"]; [soundDic setObject:@"1207" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"dtmf-8" forKey:@"name"]; [soundDic setObject:@"1208" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"dtmf-9" forKey:@"name"]; [soundDic setObject:@"1209" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"dtmf-star" forKey:@"name"]; [soundDic setObject:@"1210" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"dtmf-pound" forKey:@"name"]; [soundDic setObject:@"1211" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"long_low_short_high" forKey:@"name"]; [soundDic setObject:@"1254" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"short_double_high" forKey:@"name"]; [soundDic setObject:@"1255" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"short_low_high" forKey:@"name"]; [soundDic setObject:@"1256" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"short_double_low" forKey:@"name"]; [soundDic setObject:@"1257" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"short_double_low" forKey:@"name"]; [soundDic setObject:@"1258" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"middle_9_short_double_low" forKey:@"name"]; [soundDic setObject:@"1259" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Voicemail" forKey:@"name"]; [soundDic setObject:@"1300" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"ReceivedMessage" forKey:@"name"]; [soundDic setObject:@"1301" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"new-mail" forKey:@"name"]; [soundDic setObject:@"1302" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"mail-sent" forKey:@"name"]; [soundDic setObject:@"1303" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"alarm" forKey:@"name"]; [soundDic setObject:@"1304" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"lock" forKey:@"name"]; [soundDic setObject:@"1305" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Tock" forKey:@"name"]; [soundDic setObject:@"1306" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received1" forKey:@"name"]; [soundDic setObject:@"1307" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received2" forKey:@"name"]; [soundDic setObject:@"1308" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received3" forKey:@"name"]; [soundDic setObject:@"1309" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received4" forKey:@"name"]; [soundDic setObject:@"1310" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received1" forKey:@"name"]; [soundDic setObject:@"1312" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received5" forKey:@"name"]; [soundDic setObject:@"1313" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"sms-received6" forKey:@"name"]; [soundDic setObject:@"1314" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Voicemail" forKey:@"name"]; [soundDic setObject:@"1315" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Anticipate" forKey:@"name"]; [soundDic setObject:@"1320" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Bloom" forKey:@"name"]; [soundDic setObject:@"1321" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Calypso" forKey:@"name"]; [soundDic setObject:@"1322" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Choo_Choo" forKey:@"name"]; [soundDic setObject:@"1323" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Descent" forKey:@"name"]; [soundDic setObject:@"1324" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Fanfare" forKey:@"name"]; [soundDic setObject:@"1325" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Ladder" forKey:@"name"]; [soundDic setObject:@"1326" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Minuet" forKey:@"name"]; [soundDic setObject:@"1327" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"News_Flash" forKey:@"name"]; [soundDic setObject:@"1328" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Noir" forKey:@"name"]; [soundDic setObject:@"1329" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Sherwood_Forest" forKey:@"name"]; [soundDic setObject:@"1330" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Spell" forKey:@"name"]; [soundDic setObject:@"1331" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Suspense" forKey:@"name"]; [soundDic setObject:@"1332" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Telegraph" forKey:@"name"]; [soundDic setObject:@"1333" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Tiptoes" forKey:@"name"]; [soundDic setObject:@"1334" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Typewriters" forKey:@"name"]; [soundDic setObject:@"1335" forKey:@"id"];
    [self.soundArr addObject:soundDic];
    soundDic = [NSMutableDictionary dictionary];
    [soundDic setObject:@"Update" forKey:@"name"]; [soundDic setObject:@"1336" forKey:@"id"];
    [self.soundArr addObject:soundDic];
//    NSLog(@"%@", self.soundArr);
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
    NSMutableDictionary *soundDic = [self.soundArr objectAtIndex:indexPath.row];
    SystemSoundID sound = [[soundDic objectForKey:@"id"] intValue];
    AudioServicesPlaySystemSound(sound);
    NSLog(@"%d", sound);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)clickSaveButton {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
