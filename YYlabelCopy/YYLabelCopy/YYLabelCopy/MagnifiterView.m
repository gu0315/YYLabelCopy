//
//  MagnifiterView.m
//  Test
//
//  Created by 顾钱想 on 2021/1/4.
//

#import "MagnifiterView.h"
@implementation MagnifiterView
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, 0, 80, 80)]) {
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 40;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setTouchPoint:(CGPoint)touchPoint {
    _touchPoint = touchPoint;
    self.center = CGPointMake(touchPoint.x, touchPoint.y - 20);
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //获取对我们创建的上下文的引用
    CGContextRef context = UIGraphicsGetCurrentContext();
    ///平移坐标系统
    CGContextTranslateCTM(context, self.frame.size.width*0.5,self.frame.size.height*0.5);
    ///缩放坐标系统
    CGContextScaleCTM(context, 1.5, 1.5);
    CGContextTranslateCTM(context, -1 * (_touchPoint.x), -1 * (_touchPoint.y));
    [self.viewToMagnify.layer renderInContext:context];
}
@end
