//
//  JQueryWebMacroJavaScript.h
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/15.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#ifndef JQueryWebMacroJavaScript_h
#define JQueryWebMacroJavaScript_h

/* 防止Block循环引用 */
#define JQUERY_BLOCK_WEAK __weak typeof(self) weakself = self;
#define JQUERY_BLOCK_STRONG __strong typeof(weakself) self = weakself;

/* JavaScript标签文本内容 */
#define JQUERY_JS_TAG(TAGNAME,COUNT,CONTEXT) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].innerText = '%@'",TAGNAME,COUNT,CONTEXT];

#endif /* JQueryWebMacroJavaScript_h */
