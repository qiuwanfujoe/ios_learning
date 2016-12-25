//
//  YYAttributes.m
//  ios_learning
//
//  Created by Gideon on 12/22/16.
//  Copyright © 2016 Gideon. All rights reserved.
//

#import "YYAttributes.h"
#import "YYShadow.h"
#import "YYBorder.h"
#import "YYAttachment.h"
@implementation YYAttributes
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"shadows" : [YYShadow class],
             @"borders" : YYBorder.class,
             @"attachments" : @"YYAttachment" };
}
@end
