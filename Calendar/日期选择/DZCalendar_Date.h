//
//  DZCalendar_Date.h
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
@property (nonatomic, readonly) NSDate *date;
@end

@interface DZCalendar_Date : UIView <UIPickerViewDelegate,UIPickerViewDataSource> {
    NSMutableArray *arrayMonth;
    NSMutableArray *arrayDay;
    NSMutableArray *arrayYear;
    NSInteger nowYear;
    NSInteger nowMonth;
    NSInteger nowDay;
}
///记录选择的时间
@property (nonatomic) DZCalendar *calendarDate;
@property (weak, nonatomic) IBOutlet UILabel *LB;

///是否能选择过去时间
@property (nonatomic, assign) BOOL isChoosePastTime;

@end
