//
//  JQueryWebMaker.m
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/15.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "JQueryWebMaker.h"
#import "JQueryWebTagMaker.h"
#import "JQueryWebMacroJavaScript.h"

@interface JQueryWebMaker()
@property (nonatomic,weak)NSString *tagName;
@property (nonatomic,weak)NSString *context;
@property (nonatomic,assign)NSUInteger index;
@end


@implementation JQueryWebMaker
+ (JQueryWebMaker * _Nonnull (^)(NSString * _Nonnull))JQuery{
    JQUERY_BLOCK_WEAK;
    return ^JQueryWebMaker*(NSString *tagName){
        JQUERY_BLOCK_STRONG;
        return [[self alloc] initWithTagName:tagName];
    };
}

- (instancetype)initWithTagName:(NSString *)tagName{
    NSCParameterAssert(tagName != NULL);
    self = [super init];
    if (self) {
        _tagName = tagName;
    }
    return self;
}

#pragma mark - 文本操作
- (NSString * _Nonnull (^)(NSString * _Nonnull))text{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSString *context) {
        JQUERY_BLOCK_STRONG;
        return [self saveText:context];
    };
}

- (NSString * _Nonnull (^)(NSUInteger,NSString * _Nonnull))textWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *context){
        JQUERY_BLOCK_STRONG;
        return [self saveText:context index:index];
    };
}

- (NSString * _Nonnull (^)(NSString *_Nonnull))html{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSString *context) {
        JQUERY_BLOCK_STRONG;
        return self.text(context);
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))htmlWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *context){
        JQUERY_BLOCK_STRONG;
        return self.textWithIndex(index,context);
    };
}

- (NSString * _Nonnull (^)(NSString *_Nonnull))val{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSString *context) {
        JQUERY_BLOCK_STRONG;
        return self.text(context);
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))valWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *context){
        JQUERY_BLOCK_STRONG;
        return self.textWithIndex(index,context);
    };
}

#pragma mark - 保存文本信息
- (NSString *__nonnull)saveText:(NSString *)context{
    NSCParameterAssert(context != NULL);
    
    _context = context;
    /* 根据tagName进行选择对应的解析方法 */
    return [self parseTagName:_tagName options:^NSString *{
        JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName context:self.context];
        return [tagMaker parseTagName];
    }];
}

- (NSString *__nonnull)saveText:(NSString *)context index:(NSUInteger)index{
    NSCParameterAssert(context != NULL);
    
    _context = context;
    _index = index;
    /* 根据tagName进行选择对应的解析方法 */
    return [self parseTagName:_tagName options:^NSString *{
        JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName context:self.context];
        return [tagMaker parseTagNameWithIndex:index];
    }];
}

#pragma mark - 解析标签
- (NSString *__nonnull)parseTagName:(NSString *)tagName options:(NSString *(^)(void))option{
    NSCParameterAssert(tagName != NULL);
    
    return option();
}

@end
