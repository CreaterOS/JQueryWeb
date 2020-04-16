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

/* 枚举法设置标签操作种类 */
typedef NS_ENUM(NSInteger, JQueryWebMakerStyle) {
    JQueryWebMakerTextORVal, /* innerText */
    JQueryWebMakerHTML, /* innerHTML */
    JQueryWebMakerON /* on */
};

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

/* ON操作 */
- (NSString *(^)(NSString *,NSString *))on;
- (NSString *(^)(NSUInteger,NSString *,NSString *))onWithIndex;
/* 支持多个事件绑定同一个函数 */
- (NSMutableArray *(^)(NSString *,...))onMoreOptions;
- (NSMutableArray *(^)(NSUInteger,NSString *,...))onMoreOptionsWithIndex;
/* 支持多个事件绑定不同函数 */
- (NSMutableArray *(^)(NSUInteger,...))onMoreEventWithIndex;
@end

NS_ASSUME_NONNULL_END
