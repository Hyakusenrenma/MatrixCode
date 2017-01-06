//
//  CSLightLayer.m
//  HelloText
//
//  Created by Avalon on 2017/1/6.
//  Copyright © 2017年 Avalon. All rights reserved.
//

#import "CSLightLayer.h"

@implementation CSLightLayer{
    NSTimer *_timer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor].CGColor;
        self.frame = frame;
        self.contentsScale = 1.3;
    }
    return self;
}

- (void)light {
    
    //    NSAttributedString *str = _textLayer.string;
    //    _textLayer.string = [[NSAttributedString alloc]initWithString:str.string attributes:@{NSForegroundColorAttributeName:[UIColor greenColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
    _currentColor = [UIColor greenColor];
    
    self.string = [[NSAttributedString alloc]initWithString:_charArray[arc4random()%36] attributes:@{NSForegroundColorAttributeName:[UIColor greenColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
    
    [self lightoff];
}

- (void)lightoff {
    
    [self performSelector:@selector(black) withObject:self afterDelay:1];
}


- (void)black {
    _timer = [NSTimer timerWithTimeInterval:.3f repeats:true block:^(NSTimer * _Nonnull timer) {
        
        const CGFloat *components = CGColorGetComponents(_currentColor.CGColor);
        CGFloat G = components[1];
        if (G<=0) {
            [timer invalidate];
            return ;
        }
        _currentColor = [UIColor colorWithRed:0 green:G-.2f blue:0 alpha:1];
        
        NSAttributedString *str = self.string;
        self.string = [[NSAttributedString alloc]initWithString:str.string attributes:@{NSForegroundColorAttributeName:_currentColor,NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
    }];
    
    [_timer fire];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}


@end
