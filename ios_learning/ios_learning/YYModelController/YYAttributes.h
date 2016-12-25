//
//  YYAttributes.h
//  ios_learning
//
//  Created by Gideon on 12/22/16.
//  Copyright © 2016 Gideon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYAttributes : NSObject
@property NSString *name;
@property NSArray *shadows; //Array<Shadow>
@property NSSet *borders; //Set<Border>
@property NSMutableDictionary *attachments; //Dict<NSString,Attachment>
@end
