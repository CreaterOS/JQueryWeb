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

NS_ASSUME_NONNULL_BEGIN

@interface JQueryWebTagMaker : NSObject

/* 实例化操作 */
+ (instancetype)TagMakerName:(NSString *)tagName context:(NSString *)context;

/* 解析 */
- (NSString * _Nonnull)parseTagName;

- (NSString * _Nonnull)parseTagNameWithIndex:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
