//
//  aaaa.m
//  Calendar
//
//  Created by 陈东芝 on 17/6/30.
//  Copyright © 2017年 陈东芝. All rights reserved.
//

#import "aaaa.h"

@implementation aaaa

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"aaaa" owner:nil options:nil][0];
        self.frame = frame;
    }
    return self;
}

@end
