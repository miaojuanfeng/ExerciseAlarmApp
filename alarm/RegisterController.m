//
//  RegisterController.m
//  alarm
//
//  Created by USER on 13/4/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "MacroDefine.h"
#import "AppDelegate.h"
#import "RegisterController.h"
#import "ValidateController.h"

@interface RegisterController () <UIPickerViewDelegate>

@property AppDelegate *appDelegate;

@property UIPickerView *codePicker;
@property UITextField *phoneField;
@property NSString *codeField;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"註冊";
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    float marginTop = rectStatus.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, marginTop+100, self.view.frame.size.width-40, 30)];
    phoneLabel.text = @"請輸入您的手機號";
    phoneLabel.font = [UIFont systemFontOfSize:18.0f];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:phoneLabel];
    
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(80/2, phoneLabel.frame.origin.y+phoneLabel.frame.size.height+50, self.view.frame.size.width-80, 40)];
//    textView.backgroundColor = RGBA_COLOR(44, 106, 81, 1);
    
    self.codePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];
    self.codePicker.backgroundColor = [UIColor redColor];
    self.codePicker.delegate = self;
    self.codePicker.tintAdjustmentMode = NSTextAlignmentLeft;
    CALayer *codeFieldBorder = [CALayer layer];
    codeFieldBorder.frame = CGRectMake(0, self.codePicker.frame.size.height-1, self.codePicker.frame.size.width, BORDER_WIDTH);
    codeFieldBorder.backgroundColor = BORDER_COLOR;
    [self.codePicker.layer addSublayer:codeFieldBorder];
    [textView addSubview:self.codePicker];

    self.phoneField = [[UITextField alloc] initWithFrame:CGRectMake(self.codePicker.frame.origin.x+self.codePicker.frame.size.width+10, 0, textView.frame.size.width-self.codePicker.frame.size.width-10, textView.frame.size.height)];
    self.phoneField.backgroundColor = [UIColor whiteColor];
    self.phoneField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneField.placeholder = @"請輸入您的手機號";
    CALayer *phoneFieldBorder = [CALayer layer];
    phoneFieldBorder.frame = CGRectMake(0.0f, self.phoneField.frame.size.height-1, self.phoneField.frame.size.width, BORDER_WIDTH);
    phoneFieldBorder.backgroundColor = BORDER_COLOR;
    [self.phoneField.layer addSublayer:phoneFieldBorder];
    [textView addSubview:self.phoneField];
    
    
    [self.view addSubview:textView];
    
    
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(200/2, textView.frame.origin.y+textView.frame.size.height+50, self.view.frame.size.width-200, 44)];
    submitButton.backgroundColor = RGBA_COLOR(244, 106, 81, 1);
    submitButton.layer.cornerRadius = 15;
    submitButton.layer.masksToBounds = YES;
    [submitButton setTitle:@"下一步" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(clickNextButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// 返回每列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (row) {
        case 0:
            return @"+852";
            break;
        case 1:
            return @"+86";
            break;
    }
    return @"";
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentLeft];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:18]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)clickNextButton {
    [self.view endEditing:YES];
    
    if( [self.phoneField.text isEqualToString:@""] || self.phoneField.text.length != 11 ){
        HUD_TOAST_SHOW(@"手機號碼不正確");
        return;
    }
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"即將發送驗證碼到以下手機號：" message:[NSString stringWithFormat:@"%@ %@", self.codeField, self.phoneField.text]  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        ValidateController *validateController = [[ValidateController alloc] init];
        [self.navigationController pushViewController:validateController animated:YES];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end

