//
//  ViewController.m
//  Calendar
//
//  Created by 陈东芝 on 17/6/18.
//  Copyright © 2017年 陈东芝. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPickerViewDelegate,UIPickerViewDataSource > {
    NSMutableArray *arrayMonth;
    NSMutableArray *arrayDay;
    NSMutableArray *arrayYear;
    NSInteger nowYear;
    NSInteger nowMonth;
    NSInteger nowDay;
}
@property (weak, nonatomic) IBOutlet UIPickerView *PV_Year;
@property (weak, nonatomic) IBOutlet UIPickerView *PV_Month;
@property (weak, nonatomic) IBOutlet UIPickerView *PV_Day;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
    [self reloadNowDay];
}

- (void)reloadNowDay {
    NSInteger nowYearIndex = [arrayYear indexOfObject:@(nowYear)];
    [self.PV_Year selectRow:nowYearIndex inComponent:0 animated:YES];
    NSInteger nowMonthIndex = [arrayMonth indexOfObject:@(nowMonth)];
    [self.PV_Month selectRow:nowMonthIndex inComponent:0 animated:YES];
    NSInteger nowDayIndex = [arrayDay indexOfObject:@(nowDay)];
    [self.PV_Day selectRow:nowDayIndex inComponent:0 animated:YES];
}

- (void)setDays:(NSInteger)daysCount {
    [arrayDay removeAllObjects];
    for (int i = 1; i <= daysCount; i++) {
        [arrayDay addObject:@(i)];
    }
}

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
    
    NSInteger daysLength =  [self getNumberOfDaysInMonth:month year:year];
    [self setDays:daysLength];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.PV_Year) {
        return arrayYear.count;
    }else if (pickerView == self.PV_Month) {
        return arrayMonth.count;
    }else {
        return arrayDay.count;
    }
}

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
    if (pickerView == self.PV_Month) {
        NSInteger daysLength =  [self getNumberOfDaysInMonth:row+1 year:2017];
        [self setDays:daysLength];
        [self.PV_Day reloadComponent:0];
    }
}

- (NSInteger)getNumberOfDaysInMonth:(NSInteger)month year:(NSInteger)year
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-M"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld",year,month]];

    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:date];
    return range.length;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
