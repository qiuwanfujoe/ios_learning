//
//  YYModelController.m
//  ios_learning
//
//  Created by Gideon on 12/22/16.
//  Copyright © 2016 Gideon. All rights reserved.
//

#import "YYModelController.h"
#import "YYModel.h"
#import "YYUser.h"
#import "YYBook.h"
#import "YYBook2.h"
#import "YYAttributes.h"
@interface YYModelController ()

@end

@implementation YYModelController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self sampleModelToJSON];
    [self propNotEqualKeyToJSON];
    [self nestedModelTojson];
    [self containerPropertyToJson];
}

//简单的 Model 与 JSON 相互转换
- (void)sampleModelToJSON
{
    // 将 JSON (NSData,NSString,NSDictionary) 转换为 Model:
    NSString *json = @"{\"uid\":123456,\"name\":\"Harry\",\"created\":\"1965-07-31T00:00:00+0000\"}";
    YYUser *user = [YYUser yy_modelWithJSON:json];
    NSLog(@"userId:%lld name:%@, created%@", user.uid, user.name, user.created);
    
    // 将 Model 转换为 JSON 对象:
    NSDictionary *jsonDict = [user yy_modelToJSONObject];
    NSLog(@"jsonUser:%@", jsonDict);
}

//Model 属性名和 JSON 中的 Key 不相同
- (void)propNotEqualKeyToJSON
{
    // 将 JSON (NSData,NSString,NSDictionary) 转换为 Model:
    NSString *json = @"{\"n\": \"Harry Pottery\",\"p\": 256,\"ext\": {\"desc\": \"A book written by J.K.Rowing.\"},\"ID\": 100010}";
    YYBook *book = [YYBook yy_modelWithJSON:json];
    NSLog(@"userId:%@ name:%@, created%@", book.bookID, book.name, book.desc);
    
    // 将 Model 转换为 JSON 对象:
    NSDictionary *jsonDict = [book yy_modelToJSONObject];
    NSLog(@"jsonbook:%@", jsonDict);
}

//Nested model
- (void)nestedModelTojson
{
    NSString *json = @"{\"author\":{\"name\":\"J.K.Rowling\",\"birthday\":\"1965-07-31T00:00:00+0000\"},\"name\":\"Harry Potter\",\"pages\":256}";
    YYBook2 *book = [YYBook2 yy_modelWithJSON:json];
    NSLog(@"name:%ld, created %@", (unsigned long)book.pages, book.name);
    
    // 将 Model 转换为 JSON 对象:
    NSDictionary *jsonDict = [book yy_modelToJSONObject];
    NSLog(@"jsonbook:%@", jsonDict);
}

//Container property
- (void)containerPropertyToJson
{
    NSString *json = @"{\"name\":\"test name\",\"shadows\":[{\"sid\":123,\"name\":\"shadow\"}],\"borders\":[{\"width\":1,\"height\":2}],\"attachments\":{\"attach1\":{\"aid\":123,\"name\":\"shadowa\"}, \"attach2\":{\"aid\":124,\"name\":\"shadow1\"}}}";
    YYAttributes *attachement = [YYAttributes yy_modelWithJSON:json];
    NSDictionary *jsonDict = [attachement yy_modelToJSONObject];
    NSLog(@"jsonattachement:%@", jsonDict);
}

@end
