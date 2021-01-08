//
//  YYLabel+Copy.h
//  Test
//
//  Created by 顾钱想 on 2021/1/4.
//

#import "YYLabel.h"
#import "MagnifiterView.h"
#import "YYTextSelectionView.h"
typedef enum YYLabelCopyState : NSInteger {
    YYLabelCopyStateNormal,       // 普通状态
    YYLabelCopyStateTouching,     // 正在按下，需要弹出放大镜
    YYLabelCopyStateSelecting     // 选中了一些文本，需要弹出复制菜单
}YYLabelCopyState;
#define ANCHOR_TARGET_TAG 1

@interface YYLabel (Copy)<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILongPressGestureRecognizer *longGesture;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, strong) MagnifiterView *magnifiterView;

@property (nonatomic, assign) YYLabelCopyState yy_copyState;

@property (nonatomic, assign) NSInteger yy_copyStartPosition;

@property (nonatomic, assign) NSInteger yy_copyEndPosition;

@property (nonatomic, strong) UIImageView *yy_copyLeftDot;

@property (nonatomic, strong) UIImageView *yy_copyRightDot;

@property (nonatomic, strong) NSMutableArray *yy_copyMarkViews;
///添加手势
- (void)addGestureRecognizer;



@end


