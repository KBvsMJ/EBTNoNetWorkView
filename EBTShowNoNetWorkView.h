//
//  EBTNoNetWorkView.h
//  EBaoTongDai
//
//  Created by ebaotong on 15/7/3.
//  Copyright (c) 2015年 com.csst. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef void(^EBTShowNoNetWorkCompleteHandler) ();
/**
 *  没有网络时进行提示view
 */
@interface EBTShowNoNetWorkView : UIView
/**
 *  使用单例方法
 *
 *  @return 单例对象
 */
+ (EBTShowNoNetWorkView *)shareInstance;
/**
 *  使用类方法来显示调用没有网络时候提示view
 *
 *  @param completeHandler block参数回调
 */
+ (void)showNoNetWorkView:(void(^)())completeHandler;
@end
