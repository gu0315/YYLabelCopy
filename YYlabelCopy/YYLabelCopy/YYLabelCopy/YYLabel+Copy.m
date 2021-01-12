//
//  YYLabel+Copy.m
//  Test
//
//  Created by 顾钱想 on 2021/1/4.
//

#import "YYLabel+Copy.h"
#import <CoreText/CoreText.h>
#import "YYTextAsyncLayer.h"
#import <UIKit/UIKit.h>
#import <YYText.h>
#import <Foundation/Foundation.h>
// 添加runtime头文件
#import <objc/runtime.h>
static const void *k_yy_copyState = @"yy_copyState";
static const void *k_yy_copyStartPosition = @"yy_copyStartPosition";
static const void *k_yy_copyEndPosition = @"yy_copyEndPosition";
@implementation YYLabel (Copy)
///关联对象添加属性
- (void)setLongGesture:(UILongPressGestureRecognizer *)longGesture {
    objc_setAssociatedObject(self, @selector(longGesture), longGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILongPressGestureRecognizer *)longGesture {
    return objc_getAssociatedObject(self, @selector(longGesture));
}

- (void)setPanGesture:(UIPanGestureRecognizer *)panGesture {
    objc_setAssociatedObject(self, @selector(panGesture), panGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIPanGestureRecognizer *)panGesture {
    return objc_getAssociatedObject(self, @selector(panGesture));
}

- (void)setMagnifiterView:(MagnifiterView *)magnifiterView {
    objc_setAssociatedObject(self, @selector(magnifiterView), magnifiterView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MagnifiterView *)magnifiterView {
    return objc_getAssociatedObject(self, @selector(magnifiterView));
}

- (void)setYy_copyState:(YYLabelCopyState)yy_copyState {
    objc_setAssociatedObject(self, k_yy_copyState, [NSNumber numberWithFloat:yy_copyState], OBJC_ASSOCIATION_ASSIGN);
}

- (YYLabelCopyState)yy_copyState {
    return [objc_getAssociatedObject(self, k_yy_copyState) integerValue];
}

- (void)setYy_copyStartPosition:(NSInteger)yy_copyStartPosition {
    objc_setAssociatedObject(self, k_yy_copyStartPosition, [NSNumber numberWithFloat:yy_copyStartPosition], OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)yy_copyStartPosition {
   return [objc_getAssociatedObject(self, k_yy_copyStartPosition) integerValue];
}

- (void)setYy_copyEndPosition:(NSInteger)yy_copyEndPosition {
    objc_setAssociatedObject(self, k_yy_copyEndPosition, [NSNumber numberWithFloat:yy_copyEndPosition], OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)yy_copyEndPosition {
   return [objc_getAssociatedObject(self, k_yy_copyEndPosition) integerValue];
}

- (void)setYy_copyLeftDot:(UIImageView *)yy_copyLeftDot {
   objc_setAssociatedObject(self, @selector(yy_copyLeftDot), yy_copyLeftDot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)yy_copyLeftDot {
   return objc_getAssociatedObject(self, @selector(yy_copyLeftDot));
}

- (void)setYy_copyRightDot:(UIImageView *)yy_copyRightDot {
   objc_setAssociatedObject(self, @selector(yy_copyRightDot), yy_copyRightDot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)yy_copyRightDot {
   return objc_getAssociatedObject(self, @selector(yy_copyRightDot));
}

- (void)setYy_copyMarkViews:(NSMutableArray *)yy_copyMarkViews {
   objc_setAssociatedObject(self, @selector(yy_copyMarkViews), yy_copyMarkViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)yy_copyMarkViews {
   return objc_getAssociatedObject(self, @selector(yy_copyMarkViews));
}

- (void)addGestureRecognizer {
    ///添加蒙版
    self.yy_copyMarkViews = [NSMutableArray array];
    self.yy_copyLeftDot = [self createSelectionAnchorWithTop:YES];
    self.yy_copyRightDot = [self createSelectionAnchorWithTop:NO];
    [self isShowMark:NO];
    [self addSubview:self.yy_copyLeftDot];
    [self addSubview:self.yy_copyRightDot];
    ///长按
    self.longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longCurrentViewGesture:)];
    [self addGestureRecognizer:self.longGesture];
    ///拖动
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCurrentViewGesture:)];
    self.panGesture.maximumNumberOfTouches = 1;
    self.panGesture.delegate = self;
    [self addGestureRecognizer:self.panGesture];
}

#pragma mark - UIGestureRecognizerDelegate
///长按手势
-(void)longCurrentViewGesture:(UILongPressGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:self];
    ///TODO判断是否在高亮区域

    if (gesture.state == UIGestureRecognizerStateBegan ||
       gesture.state == UIGestureRecognizerStateChanged) {
       CFIndex index = [self touchContentOffsetInView:self point:point frameRef:self.textLayout.frame];
       ///判断是否在选中区域
       if (index != -1 && index < self.textLayout.text.length) {
           //[self showMagnifier];
           self.magnifiterView.touchPoint = point;
           self.yy_copyStartPosition = index;
           self.yy_copyEndPosition = index + 2;
           self.yy_copyState = YYLabelCopyStateTouching;
           [self isShowMark:YES];
           [self drawSelectionArea];
           [self drawDot];
           [self hiddenMenu];
       }
   }
   if (gesture.state == UIGestureRecognizerStateEnded) {
       if (self.yy_copyStartPosition >= 0 && self.yy_copyEndPosition <= self.textLayout.text.length){
            self.yy_copyState = YYLabelCopyStateSelecting;
           [self isShowMark:YES];
           [self drawSelectionArea];
           [self drawDot];
           [self hiddenMagnifier];
       } else {
            self.yy_copyState = YYLabelCopyStateNormal;
            self.yy_copyStartPosition = -1;
            self.yy_copyEndPosition = -1;
            ///移除涂层,大头针
            [self isShowMark:NO];
            [self hiddenMagnifier];
            [self hiddenMenu];
       }
   }
}

///拖动手势
- (void)panCurrentViewGesture:(UIPanGestureRecognizer*)gesture{
    if (self.yy_copyState == YYLabelCopyStateNormal) {
        return;
    }
    CGPoint point = [gesture locationInView:self];
    if (gesture.state == UIGestureRecognizerStateBegan) {
       if (self.yy_copyLeftDot && CGRectContainsPoint(CGRectInset(self.yy_copyLeftDot.frame, -25, -6), point)) {
           self.yy_copyLeftDot.tag = ANCHOR_TARGET_TAG;
           [self hiddenMenu];
       } else if (self.yy_copyRightDot && CGRectContainsPoint(CGRectInset(self.yy_copyRightDot.frame, -25, -6), point)) {
           self.yy_copyRightDot.tag = ANCHOR_TARGET_TAG;
           [self hiddenMenu];
       }
   } else if (gesture.state == UIGestureRecognizerStateChanged) {
       CFIndex index = [self touchContentOffsetInView:self point:point frameRef:self.textLayout.frame];
       if (index == -1) {
           return;
       }
       if (self.yy_copyLeftDot.tag == ANCHOR_TARGET_TAG && index < self.yy_copyEndPosition) {
           self.yy_copyStartPosition = index;
           self.magnifiterView.touchPoint = point;
           [self hiddenMenu];
       } else if (self.yy_copyRightDot.tag == ANCHOR_TARGET_TAG && index > self.yy_copyStartPosition) {
           self.yy_copyEndPosition = index;
           self.magnifiterView.touchPoint = point;
           [self hiddenMenu];
       }
       [self drawSelectionArea];
       [self drawDot];
   } else if (gesture.state == UIGestureRecognizerStateEnded ||
              gesture.state == UIGestureRecognizerStateCancelled) {
       self.yy_copyLeftDot.tag = 0;
       self.yy_copyRightDot.tag = 0;
       [self showMenu];
       [self hiddenMagnifier];
   }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    ///判断手势是否在选中区域
    CGPoint point = [touch locationInView:self];
    CFIndex index = [self touchContentOffsetInView:self point:point frameRef:self.textLayout.frame];
    if (index == -1) {
       [self removeALlcopy];
       return NO;
    }
    if (index >= self.yy_copyStartPosition && index <= self.yy_copyEndPosition) {
       return YES;
    }
    [self removeALlcopy];
    return NO;
}

- (void)removeALlcopy {
    [self isShowMark:NO];
    [self hiddenMenu];
    [self hiddenMagnifier];
    [self.yy_copyMarkViews enumerateObjectsUsingBlock: ^(CALayer *v, NSUInteger idx, BOOL *stop) {
       [v removeFromSuperlayer];
    }];
    self.yy_copyStartPosition = -1;
    self.yy_copyEndPosition = -1;
    self.yy_copyLeftDot.tag = 0;
    self.yy_copyRightDot.tag = 0;
}

- (void)isShowMark:(BOOL)isShow {
    self.yy_copyLeftDot.hidden = !isShow;
    self.yy_copyRightDot.hidden = !isShow;
}

#pragma mark 判断点击的位置是否在 range内
 ///将点击的位置转换成字符串的偏移量，如果没有找到，则返回-1
- (CFIndex)touchContentOffsetInView:(UIView *)view
                            point:(CGPoint)point
                           frameRef:(CTFrameRef)frameRef{
    if (!self.textLayout.lines) {
        return -1;
    }
    CFIndex count = self.textLayout.lines.count;
    CFIndex idx = -1;
    for (int i = 0; i < count; i++) {
        YYTextLine *textLine = self.textLayout.lines[i];
        CTLineRef line = textLine.CTLine;
        // 获得每一行的CGRect信息
        CGRect flippedRect = CGRectMake(textLine.left, textLine.top, textLine.bounds.size.width, textLine.height);
        if (CGRectContainsPoint(flippedRect, point)) {
            // 将点击的坐标转换成相对于当前行的坐标cocoapods
            CGPoint relativePoint = CGPointMake(point.x-CGRectGetMinX(flippedRect),
                                                point.y-CGRectGetMinY(flippedRect));
            // 获得当前点击坐标对应的字符串偏移
            idx = CTLineGetStringIndexForPosition(line, relativePoint);
        }
    }
    return idx;
}

/**
 此处判断
 根据上面返回的字符串的偏移量，对比range是否在点击的位置
 */
- (BOOL)judgeAtIndex:(CFIndex)index inRange:(NSRange)range {
    if (NSLocationInRange(index, range)) {
        ///点击处在range内
        return YES;
    }
    return NO;
}

#pragma mark  Draw Selected Path
///绘制图标
- (void)drawDot{
    if (self.yy_copyStartPosition < 0 || self.yy_copyEndPosition > self.textLayout.text.length) {
       return;
    }
    CTFrameRef textFrame = self.textLayout.frame;
    CFArrayRef lines = CTFrameGetLines(textFrame);
    if (!lines) {
        return;
    }
    CFIndex count = CFArrayGetCount(lines);
    for (int i = 0; i < count; i++) {
        YYTextLine *textLine = self.textLayout.lines[i];
        CTLineRef line = textLine.CTLine;
        if ([self judgeAtIndex:self.yy_copyStartPosition inRange:textLine.range]) {
           CGFloat ascent = textLine.ascent;
           CGFloat descent = textLine.descent;
           CGFloat leading = textLine.leading;
           CGFloat offset;
           offset = CTLineGetOffsetForStringIndex(line, self.yy_copyStartPosition, NULL);
           CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
           CGPoint origin = CGPointMake(textLine.position.x + offset - 10, textLine.top - 10);
           self.yy_copyLeftDot.frame = CGRectMake(origin.x, origin.y, self.yy_copyRightDot.frame.size.width, self.yy_copyRightDot.frame.size.height);
       }
       if ([self judgeAtIndex:self.yy_copyEndPosition inRange:textLine.range]) {
           CGFloat ascent, descent, leading, offset;
           offset = CTLineGetOffsetForStringIndex(line, self.yy_copyEndPosition, NULL);
           CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
           CGPoint origin = CGPointMake(textLine.position.x + offset - 10, textLine.top - 10);
           self.yy_copyRightDot.frame = CGRectMake(origin.x, origin.y, self.yy_copyRightDot.frame.size.width, self.yy_copyRightDot.frame.size.height);
           break;
       }
    }
}

- (void)drawSelectionArea {
     if (self.yy_copyStartPosition < 0 || self.yy_copyEndPosition > self.textLayout.text.length) {
         return;
     }
     if (!self.textLayout.lines) {
         return;
     }
     ///先移除之前的图层
     [self.yy_copyMarkViews enumerateObjectsUsingBlock: ^(CALayer *v, NSUInteger idx, BOOL *stop) {
        [v removeFromSuperlayer];
     }];
     for (int i = 0; i < self.textLayout.lines.count; i++) {
         YYTextLine *textLine = self.textLayout.lines[i];
         CTLineRef line = textLine.CTLine;
         // 1. start和end在一个line,则直接弄完break
         if ([self judgeAtIndex:self.yy_copyStartPosition inRange:textLine.range] && [self judgeAtIndex:self.yy_copyEndPosition inRange:textLine.range]) {
             CGFloat ascent, descent, leading, offset, offset2;
             offset = CTLineGetOffsetForStringIndex(line, self.yy_copyStartPosition, NULL);
             offset2 = CTLineGetOffsetForStringIndex(line, self.yy_copyEndPosition, NULL);
             CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
             CGRect lineRect = CGRectMake(textLine.position.x + offset, textLine.top, offset2 - offset, ascent + descent);
             [self fillSelectionAreaInRect:lineRect];
             break;
         }
         // 2. start和end不在一个line
         //如果start在line中，则填充Start后面部分区域
         if ([self judgeAtIndex:self.yy_copyStartPosition inRange:textLine.range]) {
             CGFloat ascent, descent, leading, width, offset;
             offset = CTLineGetOffsetForStringIndex(line, self.yy_copyStartPosition, NULL);
             width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
             CGRect lineRect = CGRectMake(textLine.position.x + offset, textLine.top, width - offset, ascent + descent);
             [self fillSelectionAreaInRect:lineRect];
         } //如果 start在line前，end在line后，则填充整个区域
         else if (self.yy_copyStartPosition < textLine.range.location && self.yy_copyEndPosition >= textLine.range.location + textLine.range.length) {
             CGFloat ascent, descent, leading, width;
             width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
             CGRect lineRect = CGRectMake(textLine.position.x, textLine.top, width, ascent + descent);
             [self fillSelectionAreaInRect:lineRect];
         } //如果start在line前，end在line中，则填充end前面的区域,break
         else if (self.yy_copyStartPosition < textLine.range.location && [self judgeAtIndex:self.yy_copyEndPosition inRange:textLine.range]) {
             CGFloat ascent, descent, leading, width, offset;
             offset = CTLineGetOffsetForStringIndex(line, self.yy_copyEndPosition, NULL);
             width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
             CGRect lineRect = CGRectMake(textLine.position.x, textLine.top, offset, ascent + descent);
             [self fillSelectionAreaInRect:lineRect];
         }
     }
}
///填充颜色
- (void)fillSelectionAreaInRect:(CGRect)lineRect {
    CALayer *layer =  [[CALayer alloc] init];
    layer.frame = lineRect;
    layer.backgroundColor = [UIColor colorWithRed:(253.0/255.0) green:(77.0/255.0) blue:(66.0/255.0) alpha:0.2].CGColor;
    [self.layer insertSublayer:layer atIndex:0];
    [self.yy_copyMarkViews addObject:layer];
}

- (CGRect)getMenuRect {
    CGRect menuRect = CGRectZero;
    if (!self.textLayout.lines) {
        return CGRectZero;
    }
    NSInteger count = self.textLayout.lines.count;
    for (int i = 0; i < count; i++) {
        YYTextLine *textLine = self.textLayout.lines[i];
        CTLineRef line = textLine.CTLine;
        if ([self judgeAtIndex:self.yy_copyStartPosition inRange:textLine.range]) {
            CGFloat ascent, descent, leading, offset, offset2;
            offset = CTLineGetOffsetForStringIndex(line, self.yy_copyStartPosition, NULL);
            offset2 = CTLineGetOffsetForStringIndex(line, self.yy_copyEndPosition, NULL);
            CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
            CGFloat y = textLine.top < 20 ? 0 : textLine.top;
            CGFloat x = (textLine.position.x + offset) > (self.frame.size.width - 50) ? self.frame.size.width - 30 : textLine.position.x + offset + 15;
            menuRect = CGRectMake(x, y, 30, 20);
        }
    }
    return menuRect;
}

- (UIImageView *)createSelectionAnchorWithTop:(BOOL)isTop {
   UIImage *dotImg = [UIImage imageNamed:@"drag-dot"];
   if (!isTop) {
        dotImg = [UIImage imageWithCGImage:dotImg.CGImage
                                 scale:dotImg.scale orientation:UIImageOrientationDown];
   }
   UIImageView *imageView = [[UIImageView alloc] initWithImage:dotImg];
   imageView.frame = CGRectMake(0, 0, 20, 35);
   return imageView;
}

#pragma mark Hidden Menu
-(void)hiddenMenu{
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

#pragma mark Show Menu
-(void)showMenu {
    if (!self.isFirstResponder) {
       [self becomeFirstResponder];
    }
    if (self.isFirstResponder) {
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           UIMenuController *menuController = [UIMenuController sharedMenuController];
           UIMenuItem *menuItemCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(menuCopy:)];
           UIMenuItem *menuItemHighlight = [[UIMenuItem alloc] initWithTitle:@"高亮" action:@selector(highlight:)];
           NSArray *menus = @[menuItemCopy,menuItemHighlight];
           [menuController setMenuItems:menus];
           //菜单箭头方向(默认会自动判定)
           [menuController setTargetRect:[self getMenuRect] inView:self];
           [menuController setMenuVisible:YES animated:YES];
       });
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action ==@selector(menuCopy:) || action == @selector(highlight:) || action == @selector(itemHighlightCopy:) || action == @selector(menuItemHighlight:)){
        return YES;
    }
    return NO;//隐藏系统默认的菜单项
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}
///复制
- (void)menuCopy:(UIMenuItem *)item {
    ///获取选中的数据
    if (self.yy_copyStartPosition < 0 || self.yy_copyEndPosition > self.textLayout.text.length) {
        return;
    }
    NSRange range = NSMakeRange(self.yy_copyStartPosition, self.yy_copyEndPosition - self.yy_copyStartPosition);
    NSString *str = [self.text substringWithRange:range];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = str;
    NSLog(@"复制的数据-----------\n%@",str);
}
///高亮
- (void)highlight:(UIMenuItem *)item {
   if ((self.yy_copyStartPosition < 0 || self.yy_copyEndPosition > self.textLayout.text.length) || self.textLayout.text == nil) {
       return;
   }
   NSRange range = NSMakeRange(self.yy_copyStartPosition, self.yy_copyEndPosition - self.yy_copyStartPosition);
   NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.textLayout.text];
   YYTextBorder *border = [YYTextBorder new];
   border.fillColor = [UIColor colorWithRed:227/255.0 green:207/255.0 blue:87/255.0 alpha:0.2];
   border.strokeColor = [UIColor redColor];
   border.insets = UIEdgeInsetsMake(0.5, 0.5, 0.5, 1);
   //normal状态边框
   [text yy_setTextBackgroundBorder:border range:range];
   YYTextHighlight *highlight = [YYTextHighlight new];
   [highlight setBackgroundBorder:border];
   __weak __typeof(self)weakSelf = self;
   highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
       ///弹出取消高亮
       if (!self.isFirstResponder) {
          [self becomeFirstResponder];
       }
       if (self.isFirstResponder) {
          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
              [dic setValue:[NSNumber valueWithRange:range] forKey:@"range"];
              [dic setValue:[NSNumber valueWithCGRect:rect] forKey:@"rect"];
              [weakSelf becomeFirstResponder];
              UIMenuController *menuController = [UIMenuController sharedMenuController];
              UIMenuItem *menuItemCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(itemHighlightCopy:)];
              objc_setAssociatedObject(menuController, @"menuItemCopy", dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
              UIMenuItem *menuItemHighlight = [[UIMenuItem alloc] initWithTitle:@"取消高亮" action:@selector(menuItemHighlight:)];
              objc_setAssociatedObject(menuController, @"menuItemHighlight", dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
              NSArray *menus = @[menuItemCopy,menuItemHighlight];
              [menuController setMenuItems:menus];
              //菜单箭头方向(默认会自动判定)
              [menuController setTargetRect:rect inView:weakSelf];
              [menuController setMenuVisible:YES animated:YES];
          });
       }
   };
   [text yy_setTextHighlight:highlight range:range];
   self.attributedText = text;
   [self removeALlcopy];
}

- (void)itemHighlightCopy:(UIMenuItem *)item {
    NSDictionary *dic = objc_getAssociatedObject(item, @"menuItemCopy");
    if (dic == nil) {
        return;
    }
    NSRange range = [[dic objectForKey:@"range"] rangeValue];
    NSString *str = [self.text substringWithRange:range];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = str;
    NSLog(@"复制的数据-----------\n%@",str);

}
///取消高亮
- (void)menuItemHighlight:(UIMenuItem *)item {
    NSDictionary *dic = objc_getAssociatedObject(item, @"menuItemHighlight");
    if (dic == nil) {
        return;
    }
    NSRange range = [[dic objectForKey:@"range"] rangeValue];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.textLayout.text];
    YYTextBorder *border = [YYTextBorder new];
    border.fillColor = [UIColor whiteColor];
    border.strokeColor = [UIColor whiteColor];
    border.insets = UIEdgeInsetsMake(0.5, 0.5, 0.5, 1);
    [text yy_setTextBackgroundBorder:border range:range];
    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setBackgroundBorder:border];
    [text yy_setTextHighlight:highlight range:range];
    self.attributedText = text;
}

#pragma mark - 放大镜 Magnifier View
///显示放大镜
-(void)showMagnifier{
    if (self.magnifiterView == nil) {
        self.magnifiterView = [[MagnifiterView alloc] init];
        self.magnifiterView.viewToMagnify = self;
        [self.superview addSubview:self.magnifiterView];
    }
}
///隐藏放大镜
-(void)hiddenMagnifier{
    if (self.magnifiterView) {
        [self.magnifiterView removeFromSuperview];
        self.magnifiterView = nil;
    }
}
@end
