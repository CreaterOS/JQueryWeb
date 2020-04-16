//
//  JQueryWebTagMaker.h
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/15.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

/**
 * 用于解析标签
 */
#import <Foundation/Foundation.h>
#import "JQueryWebMaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface JQueryWebTagMaker : JQueryWebMaker

/* 实例化操作 */
+ (instancetype)TagMakerName:(NSString *)tagName context:(NSString *)context;
+ (instancetype)TagMakerName:(NSString *)tagName option:(NSString *)option function:(NSString *)function;

/* 解析 */
- (NSString * _Nonnull)parseTextTagNameWithSelect:(JQueryWebMakerStyle)selectStr;

- (NSString *)parseTextTagNameWithSelect:(JQueryWebMakerStyle)selectStr index:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
