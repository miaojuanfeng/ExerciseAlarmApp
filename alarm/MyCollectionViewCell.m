//
//  MyCollectionViewCell.m
//  alarm
//
//  Created by USER on 1/2/2018.
//  Copyright © 2018 Dreamover Studio. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 110, 110)];
//        _topImage.backgroundColor = [UIColor redColor];
        _topImage.image = [UIImage imageNamed:@"pic_demo"];
        [self.contentView addSubview:_topImage];
        
//        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 70, 30)];
//        _botlabel.textAlignment = NSTextAlignmentCenter;
//        _botlabel.textColor = [UIColor blueColor];
//        _botlabel.font = [UIFont systemFontOfSize:15];
//        _botlabel.backgroundColor = [UIColor purpleColor];
//        [self.contentView addSubview:_botlabel];
    }
    
    return self;
}

@end
