//
//  JQueryWebClassMaker.h
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/27.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "JQueryWebMaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface JQueryWebClassMaker : JQueryWebMaker
/* 实例化操作 */
+ (instancetype)ClassMakerName:(NSString *)className;
+ (instancetype)ClassMakerName:(NSString *)className context:(NSString *)context;
+ (instancetype)ClassMakerName:(NSString *)className option:(NSString *)option function:(NSString *)function;
+ (instancetype)ClassMakerName:(NSString *)className properties:(NSMutableDictionary *)dict;
+ (instancetype)ClassMakerName:(NSString *)className height:(NSUInteger)height;
+ (instancetype)ClassMakerName:(NSString *)className width:(NSUInteger)width;
/* 解析 */
- (NSString * _Nonnull)parseTextClassNameWithSelect:(JQueryWebMakerStyle)selectStr;

- (NSString *)parseTextClassNameWithSelect:(JQueryWebMakerStyle)selectStr index:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
