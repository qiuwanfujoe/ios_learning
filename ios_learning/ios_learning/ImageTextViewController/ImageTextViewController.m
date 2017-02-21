//
//  ImageTextViewController.m
//  ios_learning
//
//  Created by Gideon on 2/21/17.
//  Copyright © 2017 Gideon. All rights reserved.
//

#import "ImageTextViewController.h"
/** HEX颜色 */
#define CTColorHex(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:1.0]
#define CTColorHexA(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:(a)]

@interface ImageTextViewController ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation ImageTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

    // Do any additional setup after loading the view.
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 200, 20)];
    [self.view addSubview:self.textLabel];
    [self initView];
}

- (void)initView
{
    //出发航空
    NSString *departString = @"法国航空AF1687";
    NSMutableAttributedString *departAirline = [[NSMutableAttributedString alloc] initWithString:departString  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:CTColorHex(0xffffff)}];
    
    //箭头文字
    NSTextAttachment *arrowAttach = [[NSTextAttachment alloc] init];
    arrowAttach.image = [UIImage imageNamed:@"bg_airticket_carrier"];
    arrowAttach.bounds = CGRectMake(5, -2, 9, 9);
    NSAttributedString *arrowString = [NSAttributedString attributedStringWithAttachment:arrowAttach];
    
    //实际承运
    NSMutableAttributedString *actureText = [[NSMutableAttributedString alloc] initWithString:@"  实际承运" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:CTColorHexA(0xffffff, 0.6)}];

    //到达航空
    NSString *arriveString = @" 荷兰皇家KL1286";
    NSMutableAttributedString *arriveAirline = [[NSMutableAttributedString alloc] initWithString:arriveString  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:CTColorHex(0xffffff)}];
    
    //拼接文案
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] init];
    [attributeString appendAttributedString:departAirline];
    [attributeString appendAttributedString:arrowString];
    [attributeString appendAttributedString:actureText];
    [attributeString appendAttributedString:arriveAirline];
    
    self.textLabel.attributedText = attributeString;
}

@end
