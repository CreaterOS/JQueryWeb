//
//  JQueryWebTagMaker.m
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/15.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

/**
 * JQueryWebPTagMaker
 * 用来实现对<p></p>标签的JQuery操作
 */
#import "JQueryWebTagMaker.h"
#import "JQueryWebMacroJavaScript.h"

@interface JQueryWebTagMaker()
@property (nonatomic,weak,readonly)NSString *tagName;
@property (nonatomic,weak,readonly)NSString *context;

@end

@implementation JQueryWebTagMaker

+ (instancetype)TagMakerName:(NSString *)tagName context:(NSString *)context{
    return [[self alloc] initWithTagName:tagName context:context];
}

- (instancetype)initWithTagName:(NSString *)tagName context:(NSString *)context{
    self = [super init];
    if (self) {
        _tagName = tagName;
        _context = context;
    }
    return self;
}

#pragma mark - 解析标签
- (NSString * _Nonnull)parseTagName{
    return JQUERY_JS_TAG(_tagName,@"0",_context);
}

- (NSString *)parseTagNameWithIndex:(NSUInteger)index{
    NSCParameterAssert(index >= 0);
    NSString *indexStr = [NSString stringWithFormat:@"%zd",index];
    return JQUERY_JS_TAG(_tagName,indexStr,_context);
}
@end
