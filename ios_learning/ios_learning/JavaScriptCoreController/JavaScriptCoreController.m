//
//  JavaScriptCoreController.m
//  ios_learning
//
//  Created by Gideon on 28/06/2017.
//  Copyright © 2017 Gideon. All rights reserved.
//

#import "JavaScriptCoreController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface JSValueDemoObj : NSObject
@property(nonatomic, assign) BOOL flag;
@property (nonatomic, copy) NSString *name;
@end
@implementation JSValueDemoObj

@end

@interface JavaScriptCoreController ()

@end

@implementation JavaScriptCoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self jsObjectValueTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)jsObjectValueTest
{
    JSContext *context = [[JSContext alloc] init];
    JSValue *objValue = [JSValue valueWithObject:@{@"age":@12,@"name":@"gideon"} inContext:context];
    BOOL hasProper = [objValue hasProperty:@"name"];

    id obj = [objValue toObject];
    NSLog(@"%@",obj);
    
    objValue = [JSValue valueWithPoint:CGPointMake(10, 10) inContext:context];
    obj = [objValue toObject];
    NSLog(@"%@",obj);
    
    objValue = [JSValue valueWithNullInContext:context];
    obj = [objValue toObject];
    NSLog(@"%@",obj);
    
    objValue = [JSValue valueWithObject:@[@"12",@12,@[@10,@{@"name":@"12"}]] inContext:context];
    obj = [objValue toObject];
    NSLog(@"%@",obj);
    
    JSValueDemoObj *demoObj = [[JSValueDemoObj alloc] init];
    objValue = [JSValue valueWithObject:demoObj inContext:context];
    hasProper = [objValue hasProperty:@"name"];
    obj = [objValue toObject];
    NSLog(@"%@",obj);
    
    [context evaluateScript:@"var add = function(a,b){return a+b;}"];
    objValue = context[@"add"];
    obj = [objValue callWithArguments:@[@2,@3]];
    NSLog(@"%@",obj);

}

@end


