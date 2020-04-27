//
//  JQueryWebClassMaker.m
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/27.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "JQueryWebClassMaker.h"
#import "JQueryWebMacroJavaScript.h"

/* 默认数组下标为0 */
typedef NS_ENUM(NSUInteger,JQueryWebTagMakerIndex){
    JQueryWebTagMakerDefaultIndex = 0
};

@interface JQueryWebClassMaker()
@property (nonatomic,weak,readonly)NSString *className; /* 标签名称 */
@property (nonatomic,weak,readonly)NSString *context; /* 文本内容 */
@property (nonatomic,weak,readonly)NSString *option; /* on操作 */
@property (nonatomic,weak,readonly)NSString *function; /* 函数封装 */
@property (nonatomic,weak,readonly)NSMutableDictionary *cssproperties; /* css传入字典封装 */
@property (nonatomic,assign,readonly)NSUInteger height; //高度
@property (nonatomic,assign,readonly)NSUInteger weight; //宽度
@end

@implementation JQueryWebClassMaker
#pragma mark -- 实例化
+ (instancetype)ClassMakerName:(NSString *)className{
    return [[self alloc] initWithClassName:className];
}

- (instancetype)initWithClassName:(NSString *)className
{
    self = [super init];
    if (self) {
        _className = className;
    }
    return self;
}

+ (instancetype)ClassMakerName:(NSString *)className context:(NSString *)context{
    return [[self alloc] initWithTagName:className context:context];
}

- (instancetype)initWithTagName:(NSString *)className context:(NSString *)context{
    self = [super init];
    if (self) {
        _className = className;
        _context = context;
    }
    return self;
}

+ (instancetype)ClassMakerName:(NSString *)className option:(NSString *)option function:(NSString *)function{
    return [[self alloc] initWithTagName:className option:option function:function];
}

- (instancetype)initWithTagName:(NSString *)className option:(NSString *)option function:(NSString *)function{
    self = [super init];
    if (self) {
        _className = className;
        _option = option;
        _function = function;
    }
    return self;
}

+ (instancetype)ClassMakerName:(NSString *)className properties:(NSMutableDictionary *)dict{
    return [[self alloc] initWithTagName:className properties:dict];
}

- (instancetype)initWithTagName:(NSString *)className properties:(NSMutableDictionary *)dict{
    self = [super init];
    if (self) {
        _className = className;
        _cssproperties = dict;
    }
    return self;
}

+ (instancetype)ClassMakerName:(NSString *)className height:(NSUInteger)height{
    return [[self alloc] initWithTagName:className height:height];
}

- (instancetype)initWithTagName:(NSString *)className height:(NSUInteger)height{
    self = [super init];
    if (self) {
        _className = className;
        _height = height;
    }
    return self;
}

+ (instancetype)ClassMakerName:(NSString *)className width:(NSUInteger)width{
    return [[self alloc] initWithTagName:className width:width];
}

- (instancetype)initWithTagName:(NSString *)className width:(NSUInteger)width{
    self = [super init];
    if (self) {
        _className = className;
        _weight = width;
    }
    return self;
}

#pragma mark - 解析文本内容标签
- (NSString * _Nonnull)parseTextClassNameWithSelect:(JQueryWebMakerStyle)selectStr{
    NSString *indexStr = [NSString stringWithFormat:@"%zd",JQueryWebTagMakerDefaultIndex];
    if (selectStr == JQueryWebMakerTextORVal) {
        return JQUERY_JS_CLASS_TEXT_VAL(_className,indexStr,_context);
    }else if(selectStr == JQueryWebMakerHTML){
        return JQUERY_JS_CLASS_HTML(_className,indexStr, _context);
    }else if (selectStr == JQueryWebMakerON){
        NSString *newOptionStr = [self humpStr:_option];
        NSString *newFunction = [self removeFunctionSemicolon:_function];
        return JQUERY_JS_CLASS_ON(_className, indexStr, newOptionStr, newFunction);
    }else if (selectStr == JQueryWebMakerCSS){
        /* 从保存的数组中获得key和value */
        @synchronized (self) {
            NSMutableDictionary *tempDict = [_cssproperties copy];
            NSString *resStr = [NSString string];
            for (NSUInteger i = 0; i < [tempDict count]; i++) {
                NSString *tempStr = JQUERY_JS_CLASS_CSS(_className, indexStr, tempDict.allKeys[i], tempDict.allValues[i]);
                resStr = [resStr stringByAppendingString:[tempStr stringByAppendingString:@"|"]];
            }
            
            return resStr;
        }
    }else if (selectStr == JQueryWebMakerShow){
        /* show操作 */
        return JQUERY_JS_CLASS_SHOW(_className, indexStr);
    }else if (selectStr == JQueryWebMakerShowWithFunction){
        return JQUERY_JS_CLASS_SHOWF(_className, indexStr, _option, _function);
    }else if (selectStr == JQueryWebMakerShowAnimation){
        return JQUERY_JS_CLASS_SHOWA(_className, indexStr, _context);
    }else if (selectStr == JQueryWebMakerHidden){
        return JQUERY_JS_CLASS_HIDDEN(_className, indexStr);
    }else if (selectStr == JQueryWebMakerHeight){
        return JQUERY_JS_CLASS_HEIGHT(_className, indexStr, _height);
    }else if (selectStr == JQueryWebMakerWidth){
        return JQUERY_JS_CLASS_WIDTH(_className, indexStr, _weight);
    }
    
    return [NSString string];
}

- (NSString *)parseTextClassNameWithSelect:(JQueryWebMakerStyle)selectStr index:(NSUInteger)index{
    NSCParameterAssert(index >= 0);
    NSString *indexStr = [NSString stringWithFormat:@"%zd",index];
    if (selectStr == JQueryWebMakerTextORVal) {
        return JQUERY_JS_CLASS_TEXT_VAL(_className,indexStr,_context);
    }else if(selectStr == JQueryWebMakerHTML){
        return JQUERY_JS_CLASS_HTML(_className, indexStr, _context);
    }else if (selectStr == JQueryWebMakerON){
        NSString *newOptionStr = [self humpStr:_option];
        NSString *newFunction = [self removeFunctionSemicolon:_function];
        return JQUERY_JS_CLASS_ON(_className, indexStr, newOptionStr, newFunction);
    }else if (selectStr == JQueryWebMakerCSS){
        /* 从保存的数组中获得key和value */
        @synchronized (self) {
            NSMutableDictionary *tempDict = [_cssproperties copy];
            NSString *resStr = [NSString string];
            for (NSUInteger i = 0; i < [tempDict count]; i++) {
                NSString *tempStr = JQUERY_JS_CLASS_CSS(_className, indexStr, tempDict.allKeys[i], tempDict.allValues[i]);
                resStr = [resStr stringByAppendingString:[tempStr stringByAppendingString:@"|"]];
            }
            
            return resStr;
        }
    }else if (selectStr == JQueryWebMakerShow){
        /* show操作 */
        return JQUERY_JS_CLASS_SHOW(_className, indexStr);
    }else if (selectStr == JQueryWebMakerShowWithFunction){
        return JQUERY_JS_CLASS_SHOWF(_className, indexStr, _option, _function);
    }else if (selectStr == JQueryWebMakerShowAnimation){
        return JQUERY_JS_CLASS_SHOWA(_className, indexStr, _context);
    }else if (selectStr == JQueryWebMakerHidden){
        return JQUERY_JS_CLASS_HIDDEN(_className, indexStr);
    }else if (selectStr == JQueryWebMakerHeight){
        return JQUERY_JS_CLASS_HEIGHT(_className, indexStr, _height);
    }else if (selectStr == JQueryWebMakerWidth){
        return JQUERY_JS_CLASS_WIDTH(_className, indexStr, _weight);
    }else if (selectStr == JQueryWebTagMakerAddClass){
        return JQUERY_JS_CLASS_ADDCLASS(_className, indexStr, _context);
    }else if (selectStr == JQueryWebTagMakerRemoveClass){
        return JQUERY_JS_CLASS_REMOVECLASS(_className, indexStr, _context);
    }else if (selectStr == JQueryWebTagMakerAttrValue){
        return JQUERY_JS_CLASS_ATTRVALUE_FUNCTION(_className, indexStr, _option, _function);
    }
    
    return [NSString string];
}


#pragma mark - humpStr
- (NSString *__nonnull)humpStr:(NSString *__nonnull)str{
    NSCParameterAssert(str != NULL);
    
    /* 处理option字符串,防止用户没有使用驼峰使用 */
    NSString *firstStr = [str substringWithRange:NSMakeRange(0, 1)];
    NSString *upcaseStr = [firstStr uppercaseString];
    NSString *lastStr = [str substringWithRange:NSMakeRange(1, _option.length-1)];
    
    return [upcaseStr stringByAppendingString:lastStr];
}

- (NSString *__nonnull)removeFunctionSemicolon:(NSString *__nonnull)str{
    NSCParameterAssert(str != NULL);
    
    NSString *lastStr =[str substringFromIndex:str.length-1];
    
    if([lastStr isEqualToString:@";"]) return [str substringWithRange:NSMakeRange(0, str.length-1)]; else return str;
}
@end
