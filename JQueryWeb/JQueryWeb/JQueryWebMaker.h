//
//  JQueryWebMaker.h
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/15.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

/**
 * JQueryWebMaker
 * 创建一个JQuery制作者
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQueryWebMaker : NSObject

/* JQuery实现标签处理 */
+ (JQueryWebMaker *(^)(NSString *))JQuery;

/* 文本操作 */
- (NSString *(^)(NSString *))text;
- (NSString *(^)(NSUInteger,NSString *))textWithIndex;
- (NSString *(^)(NSString *))html;
- (NSString *(^)(NSUInteger,NSString *))htmlWithIndex;
- (NSString *(^)(NSString *))val;
- (NSString *(^)(NSUInteger,NSString *))valWithIndex;
@end

NS_ASSUME_NONNULL_END
