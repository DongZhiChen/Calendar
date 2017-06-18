//
//  DZCalendar_Date.m
//  Calendar
//
//  Created by 陈东芝 on 17/6/18.
//  Copyright © 2017年 陈东芝. All rights reserved.
//

#import "DZCalendar_Date.h"

typedef NS_ENUM(NSInteger, LoadNowDayType) {
    LoadNowDayTypeAll = 0,
    LoadNowDayTypeYear,
    LoadNowDayTypeMonth,
    LoadNowDayTypeDay
};
@implementation DZCalendar_Date

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initXIB];
        [self initData];
    }
    return self;
}

#pragma mark -
- (void)initXIB {
    UINib *nib = [UINib nibWithNibName:@"DZCalendar_Date" bundle:[NSBundle bundleForClass:[self class]]];
    self.contentView = [nib instantiateWithOwner:self options:nil][0];
    self.contentView.frame = self.bounds;
    [self addSubview:self.contentView];
}

- (void)initData {
    self.calendarDate = [DZCalendar new];
    arrayMonth = [NSMutableArray new];
    arrayDay = [NSMutableArray new];
    arrayYear = [NSMutableArray new];
    self.PV_Day.delegate = self;
    self.PV_Day.dataSource = self;
    self.PV_Year.delegate = self;
    self.PV_Year.dataSource = self;
    self.PV_Month.delegate = self;
    self.PV_Month.dataSource = self;
    
    for (int i = 1; i <= 12; i++) {
        [arrayMonth addObject:@(i)];
    }
    [self setNowCalendarData];
    [self loadNowDay:LoadNowDayTypeAll];
}

///滚到当天数据
- (void)loadNowDay:(LoadNowDayType)type {
    if (type == LoadNowDayTypeYear || type == LoadNowDayTypeAll ) {
        NSInteger nowYearIndex = [arrayYear indexOfObject:@(nowYear)];
        [self.PV_Year selectRow:nowYearIndex inComponent:0 animated:YES];
        self.calendarDate.year = nowYear;
    }
    if (type == LoadNowDayTypeMonth || type == LoadNowDayTypeAll ) {
        NSInteger nowMonthIndex = [arrayMonth indexOfObject:@(nowMonth)];
        [self.PV_Month selectRow:nowMonthIndex inComponent:0 animated:YES];
        self.calendarDate.month = nowMonth;
    }
    if (type == LoadNowDayTypeDay || type == LoadNowDayTypeAll ) {
        NSInteger nowDayIndex = [arrayDay indexOfObject:@(nowDay)];
        [self.PV_Day selectRow:nowDayIndex inComponent:0 animated:YES];
        self.calendarDate.day = nowDay;
    }
}

///获取当前时间的年月日
- (void)setNowCalendarData {
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int year =(int) [dateComponent year];
    int month = (int)[dateComponent month];
    int day = (int)[dateComponent day];
    self.calendarDate.year = year;
    self.calendarDate.month = month;
    self.calendarDate.day = day;
    nowYear = year;
    nowMonth = month;
    nowDay = day;
    int totalYear = 4;
    for (int i = year-(totalYear/2); i < year+totalYear-1; i++) {
        [arrayYear addObject:@(i)];
    }
    
    [self setDaysWithMonth:month year:year];
}

///设置天数数据
- (void)setDaysWithMonth:(NSInteger)month year:(NSInteger)year{
    NSInteger daysLength =  [self getNumberOfDaysInMonth:month year:year];
    [arrayDay removeAllObjects];
    for (int i = 1; i <= daysLength; i++) {
        [arrayDay addObject:@(i)];
    }
}

///获取year 的某个month 的天数
- (NSInteger)getNumberOfDaysInMonth:(NSInteger)month year:(NSInteger)year {
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-M"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld",year,month]];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:date];
    return range.length;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.PV_Year) {
        return arrayYear.count;
    }else if (pickerView == self.PV_Month) {
        return arrayMonth.count;
    }else {
        return arrayDay.count;
    }
}

#pragma mark - UIPickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.PV_Month) {
        return [NSString stringWithFormat:@"%ld月",[arrayMonth[row] integerValue]];
    }else if (pickerView == self.PV_Day){
        return [NSString stringWithFormat:@"%ld日",[arrayDay[row] integerValue]];
    }else {
        return [NSString stringWithFormat:@"%ld年",[arrayYear[row] integerValue]];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.PV_Year) {
        NSInteger year = [arrayYear[row] integerValue];
        if (!self.isChoosePastTime) {
            if (year < nowYear ) {///滚到到过去时间
                [self loadNowDay:LoadNowDayTypeYear];
                return;
            }else if (year == nowYear) {///年份回滚，月日是过去时间就回滚到本月日
                if (self.calendarDate.month < nowMonth) {
                    [self loadNowDay:LoadNowDayTypeMonth];
                }
                if (self.calendarDate.day < nowDay) {
                    [self loadNowDay:LoadNowDayTypeDay];
                }
            }
        }
        self.calendarDate.year = year;
        ///滚到年份，2月可能变
        if ( self.calendarDate.month == 2) {
            [self setDaysWithMonth:self.calendarDate.month year:year];
        }
        [self.PV_Month reloadComponent:0];
        [self.PV_Day reloadComponent:0];
    }if (pickerView == self.PV_Month) {
        NSInteger month = [arrayMonth[row] integerValue];
        if (!self.isChoosePastTime) {
            if (self.calendarDate.year == nowYear) {
                if (month < nowMonth) {
                    [self loadNowDay:LoadNowDayTypeMonth];
                    return;
                }else if (month == nowMonth) {
                    if (self.calendarDate.day < nowDay) {
                        [self loadNowDay:LoadNowDayTypeDay];
                    }
                }
            }
        }
        self.calendarDate.month = month;
        [self setDaysWithMonth:month year:self.calendarDate.year];
        [self.PV_Day reloadComponent:0];
    }else if (pickerView == self.PV_Day){
        NSInteger day = [arrayDay[row] integerValue];
        if (!self.isChoosePastTime) {
            if (self.calendarDate.year == nowYear && self.calendarDate.month == nowMonth && day < nowDay) {
                [self loadNowDay:LoadNowDayTypeDay];
                return;
            }
        }
        self.calendarDate.day = day;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setFont:[UIFont systemFontOfSize:17]];
    }
    [pickerLabel setTextColor:[UIColor blackColor]];

    if (!self.isChoosePastTime) {
        if (pickerView == self.PV_Year) {
            NSInteger year = [arrayYear[row] integerValue];
            if (year < nowYear) {
                [pickerLabel setTextColor:[UIColor grayColor]];
            }
        }else if (pickerView == self.PV_Month) {
            NSInteger month = [arrayMonth[row] integerValue];
            ///本年月份文字颜色修改
            if (self.calendarDate.year == nowYear) {
                if (month < nowMonth) {
                    [pickerLabel setTextColor:[UIColor grayColor]];
                }
            }
        }else {
                NSInteger day = [arrayDay[row] integerValue];
                if (self.calendarDate.year == nowYear && self.calendarDate.month == nowMonth) {///本月
                    if (day < nowDay) {
                        [pickerLabel setTextColor:[UIColor grayColor]];
                    }
                }
            }
        }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

@end

@implementation DZCalendar

- (void)setYear:(NSInteger)year {
    _year = year;
    [self convertDate];
}

- (void)setMonth:(NSInteger)month {
    _month = month;
    [self convertDate];

}

- (void)setDay:(NSInteger)day {
    _day = day;
    [self convertDate];
}

- (void)convertDate {
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",_year,_month,_day];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setTimeZone:GTMzone];
    [formatter setDateFormat:@"yyyy-M-d"];
    _date = [formatter dateFromString:dateStr];
}

@end


