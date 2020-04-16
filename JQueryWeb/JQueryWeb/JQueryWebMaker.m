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
@property (nonatomic,weak)NSString *tagName; /* 标签名称 */
@property (nonatomic,weak)NSString *context; /* 文本内容 */
@property (nonatomic,assign)NSUInteger index; /* 下标 */
@property (nonatomic,weak)NSString *option; /* on操作 */
@property (nonatomic,weak)NSString *function; /* 函数封装 */
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
        return [self saveText:context select:JQueryWebMakerTextORVal];
    };
}

- (NSString * _Nonnull (^)(NSUInteger,NSString * _Nonnull))textWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *context){
        JQUERY_BLOCK_STRONG;
        return [self saveText:context index:index select:JQueryWebMakerTextORVal];
    };
}

- (NSString * _Nonnull (^)(NSString *_Nonnull))html{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSString *context) {
        JQUERY_BLOCK_STRONG;
        return [self saveText:context select:JQueryWebMakerHTML];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull))htmlWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *context){
        JQUERY_BLOCK_STRONG;
        return [self saveText:context index:index select:JQueryWebMakerHTML];
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
- (NSString *__nonnull)saveText:(NSString *)context select:(JQueryWebMakerStyle)select{
    NSCParameterAssert(context != NULL);
    
    @synchronized (self) {
        _context = context;
        /* 根据tagName进行选择对应的解析方法 */
        return [self parseTagName:_tagName options:^NSString *{
            
                JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName context:self.context];
                return [tagMaker parseTextTagNameWithSelect:select];
            
        }];
    }
}

- (NSString *__nonnull)saveText:(NSString *)context index:(NSUInteger)index select:(JQueryWebMakerStyle)select{
    NSCParameterAssert(context != NULL);
    
    @synchronized (self) {
        _context = context;
        _index = index;
        /* 根据tagName进行选择对应的解析方法 */
        return [self parseTagName:_tagName options:^NSString *{
            
            JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName context:self.context];
            return [tagMaker parseTextTagNameWithSelect:select index:index];
        }];
    }
}

#pragma mark - ON操作
- (NSString * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))on{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSString *option,NSString *function){
        JQUERY_BLOCK_STRONG;
        return [self saveOnWithOption:option function:function];
    };
}

- (NSString * _Nonnull (^)(NSUInteger, NSString * _Nonnull, NSString * _Nonnull))onWithIndex{
    JQUERY_BLOCK_WEAK;
    return ^NSString *(NSUInteger index,NSString *option,NSString *function){
        JQUERY_BLOCK_STRONG;
        return [self saveOnWithIndex:index option:option function:function];
    };
}

#pragma mark - 保存on操作信息
- (NSString * __nonnull)saveOnWithOption:(NSString * __nonnull)option function:(NSString * __nonnull)function{
    NSCParameterAssert(option != NULL);
    NSCParameterAssert(function != NULL);
    
    @synchronized (self) {
        _option = option;
        _function = function;
        
        return [self parseTagName:_tagName options:^NSString *{
            JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName option:self.option function:self.function];
            return [tagMaker parseTextTagNameWithSelect:JQueryWebMakerON];
        }];
    }
    
    return [NSString string];
}


- (NSString * __nonnull)saveOnWithIndex:(NSUInteger)index option:(NSString * __nonnull)option function:(NSString * __nonnull)function{
    NSCParameterAssert(option != NULL);
    NSCParameterAssert(function != NULL);
    
    @synchronized (self) {
        _option = option;
        _function = function;
        
        return [self parseTagName:_tagName options:^NSString *{
            JQueryWebTagMaker *tagMaker = [JQueryWebTagMaker TagMakerName:self.tagName option:self.option function:self.function];
            return [tagMaker parseTextTagNameWithSelect:JQueryWebMakerON index:index];
        }];
    }
    
    return [NSString string];
}



#pragma mark - 解析标签
- (NSString *__nonnull)parseTagName:(NSString *)tagName options:(NSString *(^)(void))option{
    NSCParameterAssert(tagName != NULL);
    
    return option();
}

@end
