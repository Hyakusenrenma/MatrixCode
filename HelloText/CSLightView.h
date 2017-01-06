//
//  CSLightView.h
//  HelloText
//
//  Created by Avalon on 2017/1/5.
//  Copyright © 2017年 Avalon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSLightView : UIView

@property (nonatomic,strong)CATextLayer *textLayer;

@property (nonatomic,strong)UIColor *color;

@property (nonatomic,strong)NSMutableArray<NSString *> *charArray;


- (void)light;
- (void)lightoff;

@end
