//
//  MacroDefine.h
//  alarm
//
//  Created by USER on 15/3/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#ifndef MacroDefine_h
#define MacroDefine_h

#define RGBA_COLOR(r,g,b,a) [UIColor colorWithRed: r/255.0 green: g/255.0 blue: b/255.0 alpha: a]
#define BORDER_COLOR [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor
#define BORDER_WIDTH 1.0f

#define BASE_URL(url) [NSString stringWithFormat:@"http://104.236.150.123:8080/ExerciseAlarmCMS/api/%@", url]

#define HUD_WAITING_SHOW(t) do{ \
                                [MBProgressHUD hideAllHUDsForView:self.view animated:YES]; \
                                self.appDelegate.hudWaiting = [MBProgressHUD showHUDAddedTo:self.view animated:YES]; \
                                self.appDelegate.hudWaiting.mode = MBProgressHUDModeIndeterminate;\
                                self.appDelegate.hudWaiting.removeFromSuperViewOnHide = YES;\
                                self.appDelegate.hudWaiting.bezelView.backgroundColor = [UIColor blackColor];\
                                self.appDelegate.hudWaiting.contentColor = [UIColor whiteColor];\
                                self.appDelegate.hudWaiting.label.text = t; \
                                [self.appDelegate.hudWaiting showAnimated:YES]; \
                            }while(0)

#define HUD_WAITING_HIDE    do{ \
                                [self.appDelegate.hudWaiting hideAnimated:YES]; \
                            }while(0)

#define HIDE_TOAST(t) do{   \
                            [MBProgressHUD hideAllHUDsForView:self.view animated:YES]; \
                            self.appDelegate.hudToast = [MBProgressHUD showHUDAddedTo:self.view animated:YES]; \
                            self.appDelegate.hudToast.mode = MBProgressHUDModeText; \
                            self.appDelegate.hudToast.removeFromSuperViewOnHide = YES; \
                            self.appDelegate.hudToast.label.text = t; \
                            self.appDelegate.hudToast.bezelView.backgroundColor = [UIColor blackColor]; \
                            self.appDelegate.hudToast.contentColor = [UIColor whiteColor]; \
                        }while(0)

#define HUD_TOAST_SHOW(t) do{ \
                                HIDE_TOAST(t); \
                                [self.appDelegate.hudToast showAnimated:YES whileExecutingBlock:^{ \
                                    sleep(2); \
                                } \
                                completionBlock:^{ \
                                    [self.appDelegate.hudToast removeFromSuperview]; \
                                    self.appDelegate.hudToast = nil; \
                                }]; \
                            }while(0)

#define HUD_TOAST_POP_SHOW(t,c) do{ \
                                    HIDE_TOAST(t); \
                                    [self.appDelegate.hudToast showAnimated:YES whileExecutingBlock:^{ \
                                        sleep(2); \
                                    } \
                                    completionBlock:^{ \
                                        [self.appDelegate.hudToast removeFromSuperview]; \
                                        self.appDelegate.hudToast = nil; \
                                        if( c == nil ){ \
                                            [self.navigationController popViewControllerAnimated:YES]; \
                                        }else{  \
                                            [self.navigationController popToViewController:c animated:YES]; \
                                        }   \
                                    }]; \
                                }while(0)

#define DEFAULT_FONT_SIZE 20.0f
#define DEFAULT_FONT(s) [UIFont fontWithName:@"AppleGothic" size:[self.appDelegate getScreenPercent]*s]
#define ICON_FONT(s) [UIFont fontWithName:@"iconfont" size:[self.appDelegate getScreenPercent]*s]

#define MSG_ERROR_NETWORK @"鏈接不上服務器，請稍後再試"

#endif /* MacroDefine_h */
