//
//  ShowPainController.m
//  alarm
//
//  Created by Dreamover Studio on 25/2/2018.
//  Copyright © 2018年 Dreamover Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MacroDefine.h"
#import "ShowPainController.h"

@interface ShowPainController ()
@property UITableView *tableView;
@end

@implementation ShowPainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.]
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"細痛感等級說明";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"關閉" style:UIBarButtonItemStylePlain target:self action:@selector(clickCloseButton)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIView *painView = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-210)/2, marginTop+50, 210, self.view.frame.size.height-marginTop-120)];
//    painView.backgroundColor = [UIColor yellowColor];
    
    int imageWidth = 50;
    int imageHeight = 50;
    int paddingLeft = 0;
    int imageGap = 18;
    
    UIImageView *painNumber = [[UIImageView alloc] initWithFrame:CGRectMake(paddingLeft*2+imageWidth-10, 0, imageWidth*2, (imageHeight+10)*7)];
    painNumber.image = [UIImage imageNamed:@"PainNumber"];
    [painView addSubview:painNumber];
    
    UIImageView *painImage6 = [[UIImageView alloc] initWithFrame:CGRectMake(paddingLeft, 0, imageWidth, imageHeight)];
    painImage6.image = [UIImage imageNamed:@"Pain6"];
    [painView addSubview:painImage6];
    
    UIImageView *painImage5 = [[UIImageView alloc] initWithFrame:CGRectMake(paddingLeft, painImage6.frame.origin.y+painImage6.frame.size.height+imageGap, imageWidth, imageHeight)];
    painImage5.image = [UIImage imageNamed:@"Pain5"];
    [painView addSubview:painImage5];
    
    UIImageView *painImage4 = [[UIImageView alloc] initWithFrame:CGRectMake(paddingLeft, painImage5.frame.origin.y+painImage5.frame.size.height+imageGap, imageWidth, imageHeight)];
    painImage4.image = [UIImage imageNamed:@"Pain4"];
    [painView addSubview:painImage4];
    
    UIImageView *painImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(paddingLeft, painImage4.frame.origin.y+painImage4.frame.size.height+imageGap, imageWidth, imageHeight)];
    painImage3.image = [UIImage imageNamed:@"Pain3"];
    [painView addSubview:painImage3];
    
    UIImageView *painImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(paddingLeft, painImage3.frame.origin.y+painImage3.frame.size.height+imageGap, imageWidth, imageHeight)];
    painImage2.image = [UIImage imageNamed:@"Pain2"];
    [painView addSubview:painImage2];
    
    UIImageView *painImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(paddingLeft, painImage2.frame.origin.y+painImage2.frame.size.height+imageGap, imageWidth, imageHeight)];
    painImage1.image = [UIImage imageNamed:@"Pain1"];
    [painView addSubview:painImage1];
    
    UILabel *painLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(painNumber.frame.origin.x+painNumber.frame.size.width, 0, imageWidth*3, imageHeight)];
    painLabel6.text = @"極度劇痛";
    [painView addSubview:painLabel6];
    
    UILabel *painLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(painNumber.frame.origin.x+painNumber.frame.size.width, painImage6.frame.origin.y+painImage6.frame.size.height+imageGap, imageWidth*3, imageHeight)];
    painLabel5.text = @"劇烈疼痛";
    [painView addSubview:painLabel5];
    
    UILabel *painLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(painNumber.frame.origin.x+painNumber.frame.size.width, painImage5.frame.origin.y+painImage5.frame.size.height+imageGap, imageWidth*3, imageHeight)];
    painLabel4.text = @"重度疼痛";
    [painView addSubview:painLabel4];
    
    UILabel *painLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(painNumber.frame.origin.x+painNumber.frame.size.width, painImage4.frame.origin.y+painImage4.frame.size.height+imageGap, imageWidth*3, imageHeight)];
    painLabel3.text = @"中度疼痛";
    [painView addSubview:painLabel3];
    
    UILabel *painLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(painNumber.frame.origin.x+painNumber.frame.size.width, painImage3.frame.origin.y+painImage3.frame.size.height+imageGap, imageWidth*3, imageHeight)];
    painLabel2.text = @"輕微疼痛";
    [painView addSubview:painLabel2];
    
    UILabel *painLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(painNumber.frame.origin.x+painNumber.frame.size.width, painImage2.frame.origin.y+painImage2.frame.size.height+imageGap, imageWidth*3, imageHeight)];
    painLabel1.text = @"完全無痛";
    [painView addSubview:painLabel1];
    
    [self.view addSubview:painView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickCloseButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
