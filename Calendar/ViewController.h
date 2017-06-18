//
//  ViewController.h
//  Calendar
//
//  Created by 陈东芝 on 17/6/18.
//  Copyright © 2017年 陈东芝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZCalendar : NSObject
@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger day;
@end

@interface ViewController : UIViewController
@property (nonatomic) DZCalendar *calendarDate;

@end

