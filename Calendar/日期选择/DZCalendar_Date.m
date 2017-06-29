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
        self = [[NSBundle mainBundle] loadNibNamed:@"DZCalendar_Date" owner:nil options:nil][0];
        self.frame = frame;
    }
    return self;
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


