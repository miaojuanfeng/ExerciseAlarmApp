//
//  TBCityIconFont.h
//  alarm
//
//  Created by USER on 12/4/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "UIImage+TBCityIconFont.h"
#import "TBCityIconInfo.h"

#define TBCityIconInfoMake(text, imageSize, imageColor) [TBCityIconInfo iconInfoWithText:text size:imageSize color:imageColor]

@interface TBCityIconFont : NSObject

+ (UIFont *)fontWithSize: (CGFloat)size;
+ (void)setFontName:(NSString *)fontName;

@end
