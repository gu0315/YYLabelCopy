//
//  ViewController.m
//  YYLabelCopy
//
//  Created by 顾钱想 on 2021/1/8.
//

#import "ViewController.h"
#import "YYLabel+Copy.h"
#import <YYText.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.scrollEnabled = YES;

    [self.view addSubview:scrollView];

    YYLabel *label = [YYLabel new];
    [scrollView addSubview: label];
    label.displaysAsynchronously = YES;
    label.ignoreCommonProperties = YES;
    label.numberOfLines = 0;

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess,YYlabel支持复制啦,如果喜欢欢迎给个star,🙏,有什么问题👏issuess"];
    text.yy_font = [UIFont systemFontOfSize:16];
    text.yy_color = [UIColor grayColor];
    text.yy_lineSpacing = 10;

    // Create text container
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX);
    container.maximumNumberOfRows = 0;

    // Generate a text layout.
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:text];

    label.frame = CGRectMake(0, 0, self.view.frame.size.width,layout.textBoundingSize.height);
    label.textLayout = layout;
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, label.frame.size.height * 2);
    ///复制使用
    [label addGestureRecognizer];
}


@end

