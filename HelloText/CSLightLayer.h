//
//  CSLightLayer.h
//  HelloText
//
//  Created by Avalon on 2017/1/6.
//  Copyright © 2017年 Avalon. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface CSLightLayer : CATextLayer

@property (nonatomic,strong)UIColor *currentColor;

//@property (nonatomic)CGColorRef color;

@property (nonatomic,strong)NSArray<NSString *> *charArray;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)light;
- (void)lightoff;

@end
