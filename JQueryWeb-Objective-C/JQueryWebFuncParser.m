//
//  JQueryWebFuncParser.m
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/27.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "JQueryWebFuncParser.h"
#import "JQueryWebTagMaker.h"
#import "JQueryWebIDMaker.h"
#import "JQueryWebClassMaker.h"

@interface JQueryWebFuncParser()
@property (nonatomic,weak)NSString *function; /* 函数 */

@end

@implementation JQueryWebFuncParser

#pragma mark - 初始化
+ (instancetype)jqueryWebFuncParser:(NSString *)function{
    NSCParameterAssert(function != NULL);
    
    return [[self alloc] initWithFuncParser:function];
}

- (instancetype)initWithFuncParser:(NSString *)function
{
    self = [super init];
    if (self) {
        _function = function;
    }
    return self;
}

#pragma mark - 解析函数
- (void)parserFunc{
    NSString *parserStr = _function;
    
    parserStr = [parserStr substringFromIndex:11];
    parserStr = [parserStr substringWithRange:NSMakeRange(0, parserStr.length-1)];
    
    NSArray *strArray = [parserStr componentsSeparatedByString:@";"];
    
    for (NSString *str in strArray) {
        if ([[str substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"$("]) {
            if ([str containsString:@"#"]) {
                /* ID处理 */
                
            }else if ([str containsString:@"."]){
                /* Class处理 */
            }else{
                /* 标签处理 */
            }
        }
    }
}

@end
