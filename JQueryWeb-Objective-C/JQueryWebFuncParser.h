//
//  JQueryWebFuncParser.h
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/27.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

/**
 * 分析函数内部的JQuery语句
 */

#import "JQueryWebMaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface JQueryWebFuncParser : JQueryWebMaker

/* 需要传入Func来判断 */
+ (instancetype)jqueryWebFuncParser:(NSString *_Nonnull)function;

/* 解析函数 */
- (void)parserFunc;
@end

NS_ASSUME_NONNULL_END
