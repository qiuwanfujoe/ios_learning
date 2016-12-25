//
//  YYBook.m
//  ios_learning
//
//  Created by Gideon on 12/22/16.
//  Copyright © 2016 Gideon. All rights reserved.
//

#import "YYBook.h"

@implementation YYBook
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"n",
             @"page" : @"p",
             @"desc" : @"ext.desc",
             @"bookID" : @[@"id",@"ID",@"book_id"]};
}
@end
