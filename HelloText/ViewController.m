//
//  ViewController.m
//  HelloText
//
//  Created by Avalon on 2017/1/5.
//  Copyright © 2017年 Avalon. All rights reserved.
//

#import "ViewController.h"
//#import "CSLightLabel.h"
//#import "CSLightView.h"
#import "CSLightLayer.h"

#define SCREEN_WIDTH                [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT               [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@end

@implementation ViewController{
    NSMutableArray<NSMutableArray *> *labelArray;
    NSMutableDictionary  *labelDic;
    CSLightLayer * lastLabel;
    NSMutableSet<NSNumber *>  *numberSet;
    NSTimer * _timer;
    int y ;
    int x ;
    int w ;
    int h ;
    NSDate *firstDate;
    NSArray<NSString *> *charArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    firstDate = [NSDate date];
    
    x = 0;
    y = 0;
    w = 0;
    h = 0;
    self.view.backgroundColor = [UIColor blackColor];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    labelDic = [NSMutableDictionary dictionary];
    labelArray = [NSMutableArray array];
    charArray = [NSArray array];
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (int i = 0; i < 26; i++) {
        [tmpArray addObject:[NSString stringWithFormat:@"%c",'A' + i]];
    }
    for (int i = 0; i < 10; i++) {
        [tmpArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    charArray = tmpArray.copy;
    
    for (int i = 0;i < ((SCREEN_WIDTH/20)+5); i++) {
        [labelDic setObject:@[].mutableCopy forKey:[NSString stringWithFormat:@"%d",i]];
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:.005f
                                              target:self
                                            selector:@selector(createLabel)
                                            userInfo:nil
                                             repeats:YES];
    [_timer fire];
}

- (void)createLabel {
    if (lastLabel) {
        [lastLabel lightoff];
    }
    
    if (x < SCREEN_WIDTH) {
        CSLightLayer *textLabel = [[CSLightLayer alloc]initWithFrame:CGRectMake(x, y, 20, 20)];
        x = x+20;
        
        textLabel.charArray = charArray;
        [textLabel light];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view.layer addSublayer:textLabel];
        });
        w++;
        
        NSMutableArray *lineArray = labelDic[[NSString stringWithFormat:@"%d",x/20]];
        [lineArray addObject:textLabel];
        lastLabel = textLabel;
        
        return;
    }
    
    if (y < SCREEN_HEIGHT) {
        h++;
        y=y+20;
        x = 0;
        w = 0;
        [self createLabel];
        return;
    }
    
    NSLog(@"finish");
    numberSet = [NSMutableSet set];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self startTimer];
    });
}

- (void)startTimer {
    [_timer invalidate];
    
    NSLog(@"time -> %f",[[NSDate date] timeIntervalSinceDate:firstDate]);
    _timer = [NSTimer scheduledTimerWithTimeInterval:.4f
                                              target:self
                                            selector:@selector(changeLabel)
                                            userInfo:nil
                                             repeats:YES];
    [_timer fire];
}

- (void)changeLabel {
    
    __block int y1 = 0;
    __block NSInteger x1 = (arc4random()%w) +1;
    
    if ([numberSet containsObject:[NSNumber numberWithInteger:x1]]) {
        [self changeLabel];
        return;
    }
    
    NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:.1f repeats:true block:^(NSTimer * _Nonnull timer) {
        [numberSet addObject:[NSNumber numberWithInteger:x1]];
        NSMutableArray *lineArray = labelDic[[NSString stringWithFormat:@"%ld",x1]];
        CSLightLayer *label = lineArray[y1];
        [label light];
        
        if (y1<((y/20)-1)) {
            y1++;
        }else {
            [numberSet removeObject:[NSNumber numberWithInteger:x1]];
            [timer invalidate];
        }
    }];
    
    [aTimer fire];
}

@end
