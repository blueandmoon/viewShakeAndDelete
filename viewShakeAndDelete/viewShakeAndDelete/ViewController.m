//
//  ViewController.m
//  viewShakeAndDelete
//
//  Created by 李根 on 16/10/8.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong)UIView *testView;
@property(nonatomic, assign)NSInteger i;
@property(nonatomic, strong)NSTimer *timer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _testView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:_testView];
    _testView.backgroundColor = [UIColor orangeColor];
    
    UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPressGes.allowableMovement = 30.0;
    
    [_testView addGestureRecognizer:longPressGes];
    
    
}
- (IBAction)stopWobbleClick:(id)sender {
    NSLog(@"%s, %d", __FUNCTION__, __LINE__);
//    [UIView setAnimationDidStopSelector:@selector(wobble)];
    _testView.transform = CGAffineTransformIdentity;
    [_timer invalidate];
    
    
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress {
    NSLog(@"文件名:%s\n方法名: %s\n行号: %d", __FILE__, __FUNCTION__, __LINE__);
    
    [self wobble];
    
}

- (void)wobble {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (1) {
            CGFloat rotation = (1 * M_PI) / 180;
//            CGAffineTransform wobbleLeft = CGAffineTransformMakeRotation(rotation);
//            CGAffineTransform wobbleRight = CGAffineTransformMakeRotation(-rotation);
            
            //        [UIView beginAnimations:nil context:nil];
            NSLog(@"_____旋转之______");
            _i = 0;
            //        NSInteger noWobbleBtns = 0;
            
            [UIView animateWithDuration:5.0 animations:^{
                
                _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(rotate:) userInfo:nil repeats:YES];
                
            } completion:^(BOOL finished) {
                NSLog(@"抖完了吗%d", finished);
            }];
            
        }
        
    });
    
    
    
}

- (void)rotate:(id)sender {
    _i++;
    
    CGFloat rotation = (5 * M_PI) / 180;
    CGAffineTransform wobbleLeft = CGAffineTransformMakeRotation(rotation);
    CGAffineTransform wobbleRight = CGAffineTransformMakeRotation(-rotation);
    
    [UIView animateWithDuration:0.1 animations:^{
        if (_i % 2 == 0) {
            _testView.transform = wobbleLeft;
        } else {
            _testView.transform = wobbleRight;
        }
        
        
//        _testView.transform = wobbleLeft;
    } completion:^(BOOL finished) {
//        _testView.transform = wobbleRight;
        _testView.transform = CGAffineTransformIdentity;
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
