//
//  test.m
//  Calendar
//
//  Created by 陈东芝 on 17/6/30.
//  Copyright © 2017年 陈东芝. All rights reserved.
//

#import "test.h"
#import "DZCalendar_Date.h"
#import "TMMuiLazyScrollView.h"
@interface test ()<TMMuiLazyScrollViewDataSource> {
 NSMutableArray * rectArray;
    NSDate* tmpStartData;
}
@property (nonatomic, retain) TMMuiLazyScrollView *SV;

@end

@implementation test
- (TMMuiLazyScrollView *)SV {
    if(_SV == nil) {
        _SV = [[TMMuiLazyScrollView alloc] init];
        _SV.backgroundColor = [UIColor whiteColor];
        _SV.frame = self.view.bounds;
        _SV.dataSource  =self;
    }
    return _SV;
}
//STEP 2 implement datasource delegate.
- (NSUInteger)numberOfItemInScrollView:(TMMuiLazyScrollView *)scrollView
{
    return rectArray.count;
}

- (TMMuiRectModel *)scrollView:(TMMuiLazyScrollView *)scrollView rectModelAtIndex:(NSUInteger)index
{
    CGRect rect = [(NSValue *)[rectArray objectAtIndex:index]CGRectValue];
    TMMuiRectModel *rectModel = [[TMMuiRectModel alloc]init];
    rectModel.absoluteRect = rect;
    rectModel.muiID = [NSString stringWithFormat:@"%ld",index];
    return rectModel;
}

- (UIView *)scrollView:(TMMuiLazyScrollView *)scrollView itemByMuiID:(NSString *)muiID
{
      DZCalendar_Date *view = (DZCalendar_Date *)[scrollView dequeueReusableItemWithIdentifier:@"testView"];
    NSInteger index = [muiID integerValue];
    if (!view) {
        view = [[DZCalendar_Date alloc] initWithFrame:[(NSValue *)[rectArray objectAtIndex:index]CGRectValue]];
            view.reuseIdentifier = @"testView";
    }
    view.frame = [(NSValue *)[rectArray objectAtIndex:index]CGRectValue];
    view.LB.text = @"2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>";

    [scrollView addSubview:view];
    view.backgroundColor = [UIColor colorWithRed:[self RBG] green:[self RBG] blue:[self RBG] alpha:1];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = 3;
    return view;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
     tmpStartData = [NSDate date];
    [self.view addSubview:self.SV];
   
  rectArray  = [[NSMutableArray alloc] init];
        [self createView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@"cost time = %f", deltaTime);
}
- (void)createView {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIView *lastView;
        for (int  i =0; i < 100; i++) {
            CGRect frame = CGRectMake(0, 0, 414, 0);
            DZCalendar_Date* view = [[DZCalendar_Date alloc] initWithFrame:frame];
            view.LB.text = @"2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>2017-06-29 21:44:37.284265 Calendar[18827:5824913] <UIView: 0x10041eee0; frame = (0 3000; 320 300); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x17002ac20>>!!!";
            [view layoutIfNeeded];
            NSLog(@"%@",view.LB);
            frame.size.height = CGRectGetMaxY(view.LB.frame);
            frame.origin.y = lastView? CGRectGetMaxY(lastView.frame):0;
            view.frame = frame;
            lastView = view;
            [rectArray addObject:[NSValue valueWithCGRect:frame]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.SV.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetMaxY(lastView.frame));
            [self.SV reloadData];
        });
       

    });
   }

- (CGFloat)RBG {
    int r = rand()%256;
    return r/256.0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
