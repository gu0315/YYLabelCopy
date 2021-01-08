//
//  MagnifiterView.h
//  Test
//  放大镜
//  Created by 顾钱想 on 2021/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MagnifiterView : UIView
@property (weak, nonatomic) UIView *viewToMagnify;
@property (nonatomic) CGPoint touchPoint;
@end

NS_ASSUME_NONNULL_END
