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
#import "JQueryWebONOptionsHeader.h"
#import "JQueryWebTagHeader.h"

/* 枚举法设置标签操作种类 */
typedef NS_ENUM(NSInteger, JQueryWebMakerStyle) {
    JQueryWebMakerTextORVal, /* innerText */
    JQueryWebMakerHTML, /* innerHTML */
    JQueryWebMakerON, /* on */
    JQueryWebMakerCSS, /* css */
    JQueryWebMakerShow, /* show */
    JQueryWebMakerShowWithFunction, /* show function */
    JQueryWebMakerShowAnimation, /* show animation */
    JQueryWebMakerHidden, /* hidden */
    JQueryWebMakerHeight, /* height */
    JQueryWebMakerWidth /* width */
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

/* on操作展开 */
- (NSString *(^)(NSUInteger,NSString *))onBlur;
- (NSString *(^)(NSUInteger,NSString *))onFocus;
- (NSString *(^)(NSUInteger,NSString *))onFocusin;
- (NSString *(^)(NSUInteger,NSString *))onFocusout;
- (NSString *(^)(NSUInteger,NSString *))onLoad;
- (NSString *(^)(NSUInteger,NSString *))onResize;
- (NSString *(^)(NSUInteger,NSString *))onScroll;
- (NSString *(^)(NSUInteger,NSString *))onUnload;
- (NSString *(^)(NSUInteger,NSString *))onClick;
- (NSString *(^)(NSUInteger,NSString *))onDblclick;
- (NSString *(^)(NSUInteger,NSString *))onMousedown;
- (NSString *(^)(NSUInteger,NSString *))onMouseup;
- (NSString *(^)(NSUInteger,NSString *))onMousemove;
- (NSString *(^)(NSUInteger,NSString *))onMouseover;
- (NSString *(^)(NSUInteger,NSString *))onMouseout;
- (NSString *(^)(NSUInteger,NSString *))onMouseenter;
- (NSString *(^)(NSUInteger,NSString *))onMouseleave;
- (NSString *(^)(NSUInteger,NSString *))onChange;
- (NSString *(^)(NSUInteger,NSString *))onSelect;
- (NSString *(^)(NSUInteger,NSString *))onSubmit;
- (NSString *(^)(NSUInteger,NSString *))onKeydown;
- (NSString *(^)(NSUInteger,NSString *))onKeypress;
- (NSString *(^)(NSUInteger,NSString *))onKeyup;
- (NSString *(^)(NSUInteger,NSString *))onError;
- (NSString *(^)(NSUInteger,NSString *))onContextmenu;

/* CSS properties操作 */
- (NSMutableArray *(^)(NSString *))css;
- (NSMutableArray *(^)(NSUInteger,NSString *))cssWithIndex;

/* CSS */
- (NSString *(^)(NSString *,NSString *))cssSet;
- (NSString *(^)(NSUInteger,NSString *,NSString *))cssSetWithIndex;

/* show操作 */
- (NSString *(^)(void))show;
- (NSString *(^)(NSUInteger))showWithIndex;
/* show带参数操作 */
/* show带参数 */
- (NSString *(^)(NSString *))showAnimation;
- (NSString *(^)(NSUInteger,NSString *))showAnimationWithIndex;
/* show带参数和函数 */
- (NSString *(^)(NSString *,NSString *))showSet;
- (NSString *(^)(NSUInteger,NSString *,NSString *))showSetWithIndex;

/* hidden */
- (NSString *(^)(void))hidden;
- (NSString *(^)(NSUInteger))hiddenWithIndex;

/* height */
- (NSString *(^)(NSUInteger))height;
- (NSString *(^)(NSUInteger,NSUInteger))heightWithCount;
/* width */
- (NSString *(^)(NSUInteger))width;
- (NSString *(^)(NSUInteger,NSUInteger))widthWithCount;

/* trim */
- (NSString *(^)(NSUInteger,NSString *))trim;

@end

NS_ASSUME_NONNULL_END
