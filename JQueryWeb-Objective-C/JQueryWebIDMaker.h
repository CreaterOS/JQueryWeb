//
//  JQueryWebIDMaker.h
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/23.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "JQueryWebMaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface JQueryWebIDMaker : JQueryWebMaker

/* 实例化操作 */
+ (instancetype)IDMakerName:(NSString *)idName;
+ (instancetype)IDMakerName:(NSString *)idName context:(NSString *)context;
+ (instancetype)IDMakerName:(NSString *)idName option:(NSString *)option function:(NSString *)function;
+ (instancetype)IDMakerName:(NSString *)idName properties:(NSMutableDictionary *)dict;
+ (instancetype)IDMakerName:(NSString *)idName height:(NSUInteger)height;
+ (instancetype)IDMakerName:(NSString *)idName width:(NSUInteger)width;

/* 解析 */
- (NSString * _Nonnull)parseTextIDNameWithSelect:(JQueryWebMakerStyle)selectStr;
@end

NS_ASSUME_NONNULL_END
