//
//  CSLightView.m
//  HelloText
//
//  Created by Avalon on 2017/1/5.
//  Copyright © 2017年 Avalon. All rights reserved.
//

#import "CSLightView.h"

@implementation CSLightView{
    NSTimer *_timer;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.backgroundColor = [UIColor blackColor].CGColor;
        _textLayer = [CATextLayer layer];
        _textLayer.frame = CGRectMake(0, 0, 20, 20);
        _textLayer.contentsScale = 1.3;
        [self.layer addSublayer:_textLayer];
        
    }
    return self;
}


- (void)light {
    _color = [UIColor greenColor];
    
    //    NSAttributedString *str = _textLayer.string;
    //    _textLayer.string = [[NSAttributedString alloc]initWithString:str.string attributes:@{NSForegroundColorAttributeName:[UIColor greenColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
    
    _textLayer.string = [[NSAttributedString alloc]initWithString:_charArray[arc4random()%36] attributes:@{NSForegroundColorAttributeName:[UIColor greenColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
    [self lightoff];
}

- (void)lightoff {
    
    [self performSelector:@selector(black) withObject:self afterDelay:1];
}


- (void)black {
    _timer = [NSTimer timerWithTimeInterval:.3f repeats:true block:^(NSTimer * _Nonnull timer) {
        
        
        const CGFloat *components = CGColorGetComponents(_color.CGColor);
        CGFloat G = components[1];
        if (G<=0) {
            [timer invalidate];
            return ;
        }
        _color = [UIColor colorWithRed:0 green:G-.2f blue:0 alpha:1];
        
        NSAttributedString *str = _textLayer.string;
        _textLayer.string = [[NSAttributedString alloc]initWithString:str.string attributes:@{NSForegroundColorAttributeName:_color,NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
    }];
    
    [_timer fire];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}


@end
