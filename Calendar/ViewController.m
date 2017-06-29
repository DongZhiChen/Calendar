//
//  ViewController.m
//  Calendar
//
//  Created by 陈东芝 on 17/6/18.
//  Copyright © 2017年 陈东芝. All rights reserved.
//

#import "ViewController.h"
#import "test.h"

@interface ViewController () <UIPickerViewDelegate,UIPickerViewDataSource > {
    NSMutableArray *arrayMonth;
    NSMutableArray *arrayDay;
    NSMutableArray *arrayYear;
    NSInteger nowYear;
    NSInteger nowMonth;
    NSInteger nowDay;
}
- (IBAction)bt:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *SV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)bt:(id)sender {
   dispatch_async(dispatch_get_main_queue(), ^{
       test *t = [[test alloc] init];
       [self presentViewController:t animated:YES completion:nil];
   });
}
@end
