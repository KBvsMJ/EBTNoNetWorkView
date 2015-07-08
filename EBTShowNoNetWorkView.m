//
//  EBTNoNetWorkView.m
//  EBaoTongDai
//
//  Created by ebaotong on 15/7/3.
//  Copyright (c) 2015年 com.csst. All rights reserved.
//

#import "EBTShowNoNetWorkView.h"

#define kContentViewHeight  30.f
#define kMargin 25.f
#define kBottomMargin 64.f
@interface EBTShowNoNetWorkView ()
{
    UIView *viewContent; //底部背景颜色view
    UILabel* lblRemind;  //提示内容
}

@end
@implementation EBTShowNoNetWorkView
+ (EBTShowNoNetWorkView *)shareInstance
{
    static EBTShowNoNetWorkView *myInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        myInstance = [[EBTShowNoNetWorkView alloc]init];
       
    });

    return myInstance;
}
- (instancetype)init
{
    if (self = [super init]) {
        
        [self setUp];
    }
    return self;
}
- (void)setUp
{
    self.backgroundColor = [UIColor clearColor];
    self.frame = [UIScreen mainScreen].bounds;
    viewContent = [[UIView alloc]init];
    viewContent.translatesAutoresizingMaskIntoConstraints = NO;
    viewContent.backgroundColor = kRedLightFontColor;
    viewContent.layer.masksToBounds = YES;
    viewContent.layer.cornerRadius = 6;
    [self addSubview:viewContent];
    NSDictionary *constraint_Dic = @{
                                 @"margin":@kMargin,
                                 @"bottom":@kBottomMargin,
                                 @"height":@kContentViewHeight
                                 };
    NSArray *contentView_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[viewContent]-margin-|" options:0 metrics:constraint_Dic views:NSDictionaryOfVariableBindings(viewContent)];
    
    NSArray *contentView_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[viewContent(height)]-bottom-|" options:0 metrics:constraint_Dic views:NSDictionaryOfVariableBindings(viewContent)];
    
    [self addConstraints:contentView_H];
    [self addConstraints:contentView_V];

    
    lblRemind = [[UILabel alloc]init];
    lblRemind.textColor = [UIColor whiteColor];
    lblRemind.textAlignment= NSTextAlignmentCenter;
    lblRemind.font = [UIFont systemFontOfSize:16.f];
    lblRemind.translatesAutoresizingMaskIntoConstraints = NO;
    lblRemind.text =@"当前网络不可用,请检查您的网络设置。";
    [viewContent addSubview:lblRemind];
    
    NSArray *label_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lblRemind]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblRemind)];
    
    NSArray *label_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lblRemind]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lblRemind)];
    
    [viewContent addConstraints:label_H];
    [viewContent addConstraints:label_V];
    
    
}
/**
 *  显示view
 */
- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    viewContent.alpha = 0.f;
    viewContent.transform=CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView animateWithDuration:0.3f animations:^{
        viewContent.alpha = 0.75;
        viewContent.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];

}
/**
 *  移除view
 */
-(void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        viewContent.alpha = 0;
        viewContent.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/**
 *  显示view后等待2秒自动移除
 *
 *  @param completeHandler 参数回调
 */
+(void)showNoNetWorkView:(void (^)())completeHandler
{
    if (completeHandler) {
        completeHandler();
    }
    [[EBTShowNoNetWorkView shareInstance] show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[EBTShowNoNetWorkView shareInstance] dismiss];
    });
}
@end
