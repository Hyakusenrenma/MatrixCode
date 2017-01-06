//
//  CSLightLabel.m
//  HelloText
//
//  Created by Avalon on 2017/1/5.
//  Copyright © 2017年 Avalon. All rights reserved.
//

#import "CSLightLabel.h"

@implementation CSLightLabel{
    NSTimer *timer;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = [UIColor blackColor];
        self.textColor = [UIColor greenColor];
    }
    return self;
}
- (void)light {
    self.textColor = [UIColor greenColor];

}

- (void)lightoff {
    
    [self performSelector:@selector(black) withObject:self afterDelay:1];
}

- (void)black {
    timer = [NSTimer timerWithTimeInterval:.3f repeats:true block:^(NSTimer * _Nonnull timer) {
        CGColorRef color = [self.textColor CGColor];
        
        size_t numComponents = CGColorGetNumberOfComponents(color);
        CGFloat G;
        if (numComponents == 4)
        {
            const CGFloat *components = CGColorGetComponents(color);
            G = components[1];
        }
        if (G<=0) {
            [self closeTimer];
            return ;
        }
        self.textColor = [UIColor colorWithRed:0 green:G-.2f blue:0 alpha:1];
    }];
    
        [timer fire];
    if (timer) {
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    }
}

-(void)closeTimer {
    
    [timer invalidate];
    timer = nil;
}

@end
