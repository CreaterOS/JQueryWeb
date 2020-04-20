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
#define JQUERY_JS_TAG_TEXT_VAL(TAGNAME,COUNT,CONTEXT) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].innerText = '%@';",TAGNAME,COUNT,CONTEXT];
/* JavaScript标签文本HTML格式 */
#define JQUERY_JS_TAG_HTML(TAGNAME,COUNT,CONTEXT) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].innerHTML = '%@';",TAGNAME,COUNT,CONTEXT];
/* JavaScript标签ON操作 */
#define JQUERY_JS_TAG_ON(TAGNAME,COUNT,OPTION,FUNCTION) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].on%@ = %@;",TAGNAME,COUNT,OPTION,FUNCTION];
/* JavaScript标签CSS操作 */
#define JQUERY_JS_TAG_CSS(TAGNAME,COUNT,KEY,VALUE) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].style.%@ = '%@';",TAGNAME,COUNT,KEY,VALUE];

#endif /* JQueryWebMacroJavaScript_h */
