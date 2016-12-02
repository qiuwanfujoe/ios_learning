//
//  ViewController.m
//  ios_learning
//
//  Created by Gideon on 11/9/16.
//  Copyright © 2016 Gideon. All rights reserved.
//

#import "ViewController.h"
#import "TouchIdController.h"
#import "GQChatListController.h"
#import "QRCodeController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *funtionArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.funtionArray = [@[@"指纹识别", @"融云聊天", @"二维码"] mutableCopy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.funtionArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentify = @"ReuseTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReuseTableCell"];
    }
    cell.textLabel.text = [self.funtionArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [self.funtionArray objectAtIndex:indexPath.row];
    if ([title isEqualToString:@"指纹识别"]) {
        TouchIdController *vc = [[TouchIdController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"融云聊天"]) {
        GQChatListController *vc = [[GQChatListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"二维码"]) {
        QRCodeController *vc = [[QRCodeController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
