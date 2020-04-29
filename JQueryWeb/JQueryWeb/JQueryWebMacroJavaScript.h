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

/* ----------------------------- TAGNAME -----------------------------*/
/* JavaScript标签文本内容 */
#define JQUERY_JS_TAG_TEXT_VAL(TAGNAME,COUNT,CONTEXT) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].innerText = '%@'",TAGNAME,COUNT,CONTEXT];
/* JavaScript标签文本HTML格式 */
#define JQUERY_JS_TAG_HTML(TAGNAME,COUNT,CONTEXT) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].innerHTML = '%@'",TAGNAME,COUNT,CONTEXT];
/* JavaScript标签ON操作 */
#define JQUERY_JS_TAG_ON(TAGNAME,COUNT,OPTION,FUNCTION) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].on%@ = %@",TAGNAME,COUNT,OPTION,FUNCTION];
/* JavaScript标签CSS操作 */
#define JQUERY_JS_TAG_CSS(TAGNAME,COUNT,KEY,VALUE) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].style.%@ = '%@'",TAGNAME,COUNT,KEY,VALUE];
/* JavaScript标签SHOW操作 */
#define JQUERY_JS_TAG_SHOW(TAGNAME,COUNT) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].show = true",TAGNAME,COUNT];
#define JQUERY_JS_TAG_SHOWF(TAGNAME,COUNT,ANIMATION,FUNCTION) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].show('%@') = %@",TAGNAME,COUNT,ANIMATION,FUNCTION];
#define JQUERY_JS_TAG_SHOWA(TAGNAME,COUNT,CONTEXT) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].show('%@')",TAGNAME,COUNT,CONTEXT];
/* JavaScript标签Hidden操作 */
#define JQUERY_JS_TAG_HIDDEN(TAGNAME,COUNT) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].hidden = true",TAGNAME,COUNT];
/* JavaScript标签Height操作 */
#define JQUERY_JS_TAG_HEIGHT(TAGNAME,COUNT,HEIGHT) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].style.height = '%zdpx'",TAGNAME,COUNT,HEIGHT];
/* JavaScript标签Width操作 */
#define JQUERY_JS_TAG_WIDTH(TAGNAME,COUNT,WIDTH) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].style.width = '%zdpx'",TAGNAME,COUNT,WIDTH];
/* JavaScript标签AddClass操作 */
#define JQUERY_JS_TAG_ADDCLASS(TAGNAME,COUNT,CLASSNAME) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].classList.add('%@')",TAGNAME,COUNT,CLASSNAME];
/* JavaScript标签RemoveClass操作 */
#define JQUERY_JS_TAG_REMOVECLASS(TAGNAME,COUNT,CLASSNAME) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].classList.remove('%@')",TAGNAME,COUNT,CLASSNAME];
/* JavaScript标签Attr操作 */
#define JQUERY_JS_TAG_ATTRVALUE_FUNCTION(TAGNAME,COUNT,ATTRNAME,VALUE) [NSString stringWithFormat:@"document.getElementsByTagName('%@')[%@].setAttribute('%@','%@')",TAGNAME,COUNT,ATTRNAME,VALUE];

/* ----------------------------- IDNAME -----------------------------*/

/* JavaScript标签文本内容 */
#define JQUERY_JS_ID_TEXT_VAL(TAGNAME,CONTEXT) [NSString stringWithFormat:@"document.getElementById('%@').innerText = '%@'",TAGNAME,CONTEXT];
/* JavaScript标签文本HTML格式 */
#define JQUERY_JS_ID_HTML(TAGNAME,CONTEXT) [NSString stringWithFormat:@"document.getElementById('%@').innerHTML = '%@'",TAGNAME,CONTEXT];
/* JavaScript标签ON操作 */
#define JQUERY_JS_ID_ON(TAGNAME,OPTION,FUNCTION) [NSString stringWithFormat:@"document.getElementById('%@').on%@ = %@",TAGNAME,OPTION,FUNCTION];
/* JavaScript标签CSS操作 */
#define JQUERY_JS_ID_CSS(TAGNAME,KEY,VALUE) [NSString stringWithFormat:@"document.getElementById('%@').style.%@ = '%@'",TAGNAME,KEY,VALUE];
/* JavaScript标签SHOW操作 */
#define JQUERY_JS_ID_SHOW(TAGNAME) [NSString stringWithFormat:@"document.getElementById('%@').show = true;",TAGNAME];
#define JQUERY_JS_ID_SHOWF(TAGNAME,ANIMATION,FUNCTION) [NSString stringWithFormat:@"document.getElementById('%@').show('%@') = %@",TAGNAME,ANIMATION,FUNCTION];
#define JQUERY_JS_ID_SHOWA(TAGNAME,CONTEXT) [NSString stringWithFormat:@"document.getElementById('%@').show('%@')",TAGNAME,CONTEXT];
/* JavaScript标签Hidden操作 */
#define JQUERY_JS_ID_HIDDEN(TAGNAME) [NSString stringWithFormat:@"document.getElementById('%@').hidden = true",TAGNAME];
/* JavaScript标签Height操作 */
#define JQUERY_JS_ID_HEIGHT(TAGNAME,HEIGHT) [NSString stringWithFormat:@"document.getElementById('%@').style.height = '%zdpx'",TAGNAME,HEIGHT];
/* JavaScript标签Width操作 */
#define JQUERY_JS_ID_WIDTH(TAGNAME,WIDTH) [NSString stringWithFormat:@"document.getElementById('%@').style.width = '%zdpx'",TAGNAME,WIDTH];
/* JavaScript标签AddClass操作 */
#define JQUERY_JS_ID_ADDCLASS(TAGNAME,CLASSNAME) [NSString stringWithFormat:@"document.getElementById('%@').classList.add('%@')",TAGNAME,CLASSNAME];
/* JavaScript标签RemoveClass操作 */
#define JQUERY_JS_ID_REMOVECLASS(TAGNAME,CLASSNAME) [NSString stringWithFormat:@"document.getElementById('%@').classList.remove('%@')",TAGNAME,CLASSNAME];
/* JavaScript标签Attr操作 */
#define JQUERY_JS_ID_ATTRVALUE_FUNCTION(TAGNAME,ATTRNAME,VALUE) [NSString stringWithFormat:@"document.getElementById('%@').setAttribute('%@','%@')",TAGNAME,ATTRNAME,VALUE];

/* ----------------------------- CLASSNAME -----------------------------*/
/* JavaScript标签文本内容 */
#define JQUERY_JS_CLASS_TEXT_VAL(TAGNAME,COUNT,CONTEXT) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].innerText = '%@'",TAGNAME,COUNT,CONTEXT];
/* JavaScript标签文本HTML格式 */
#define JQUERY_JS_CLASS_HTML(TAGNAME,COUNT,CONTEXT) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].innerHTML = '%@'",TAGNAME,COUNT,CONTEXT];
/* JavaScript标签ON操作 */
#define JQUERY_JS_CLASS_ON(TAGNAME,COUNT,OPTION,FUNCTION) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].on%@ = %@",TAGNAME,COUNT,OPTION,FUNCTION];
/* JavaScript标签CSS操作 */
#define JQUERY_JS_CLASS_CSS(TAGNAME,COUNT,KEY,VALUE) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].style.%@ = '%@'",TAGNAME,COUNT,KEY,VALUE];
/* JavaScript标签SHOW操作 */
#define JQUERY_JS_CLASS_SHOW(TAGNAME,COUNT) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].show = true",TAGNAME,COUNT];
#define JQUERY_JS_CLASS_SHOWF(TAGNAME,COUNT,ANIMATION,FUNCTION) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].show('%@') = %@",TAGNAME,COUNT,ANIMATION,FUNCTION];
#define JQUERY_JS_CLASS_SHOWA(TAGNAME,COUNT,CONTEXT) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].show('%@')",TAGNAME,COUNT,CONTEXT];
/* JavaScript标签Hidden操作 */
#define JQUERY_JS_CLASS_HIDDEN(TAGNAME,COUNT) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].hidden = true",TAGNAME,COUNT];
/* JavaScript标签Height操作 */
#define JQUERY_JS_CLASS_HEIGHT(TAGNAME,COUNT,HEIGHT) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].style.height = '%zdpx'",TAGNAME,COUNT,HEIGHT];
/* JavaScript标签Width操作 */
#define JQUERY_JS_CLASS_WIDTH(TAGNAME,COUNT,WIDTH) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].style.width = '%zdpx'",TAGNAME,COUNT,WIDTH];
/* JavaScript标签AddClass操作 */
#define JQUERY_JS_CLASS_ADDCLASS(TAGNAME,COUNT,CLASSNAME) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].classList.add('%@')",TAGNAME,COUNT,CLASSNAME];
/* JavaScript标签RemoveClass操作 */
#define JQUERY_JS_CLASS_REMOVECLASS(TAGNAME,COUNT,CLASSNAME) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].classList.remove('%@')",TAGNAME,COUNT,CLASSNAME];
/* JavaScript标签Attr操作 */
#define JQUERY_JS_CLASS_ATTRVALUE_FUNCTION(TAGNAME,COUNT,ATTRNAME,VALUE) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].setAttribute('%@','%@')",TAGNAME,COUNT,ATTRNAME,VALUE];
#endif /* JQueryWebMacroJavaScript_h */
