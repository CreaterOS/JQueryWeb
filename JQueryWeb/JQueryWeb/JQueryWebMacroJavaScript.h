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
#define JQUERY_JS_ID_TEXT_VAL(IDNAME,CONTEXT) [NSString stringWithFormat:@"document.getElementById('%@').innerText = '%@'",IDNAME,CONTEXT];
/* JavaScript标签文本HTML格式 */
#define JQUERY_JS_ID_HTML(IDNAME,CONTEXT) [NSString stringWithFormat:@"document.getElementById('%@').innerHTML = '%@'",IDNAME,CONTEXT];
/* JavaScript标签ON操作 */
#define JQUERY_JS_ID_ON(IDNAME,OPTION,FUNCTION) [NSString stringWithFormat:@"document.getElementById('%@').on%@ = %@",IDNAME,OPTION,FUNCTION];
/* JavaScript标签CSS操作 */
#define JQUERY_JS_ID_CSS(IDNAME,KEY,VALUE) [NSString stringWithFormat:@"document.getElementById('%@').style.%@ = '%@'",IDNAME,KEY,VALUE];
/* JavaScript标签SHOW操作 */
#define JQUERY_JS_ID_SHOW(IDNAME) [NSString stringWithFormat:@"document.getElementById('%@').show = true;",IDNAME];
#define JQUERY_JS_ID_SHOWF(IDNAME,ANIMATION,FUNCTION) [NSString stringWithFormat:@"document.getElementById('%@').show('%@') = %@",IDNAME,ANIMATION,FUNCTION];
#define JQUERY_JS_ID_SHOWA(IDNAME,CONTEXT) [NSString stringWithFormat:@"document.getElementById('%@').show('%@')",IDNAME,CONTEXT];
/* JavaScript标签Hidden操作 */
#define JQUERY_JS_ID_HIDDEN(IDNAME) [NSString stringWithFormat:@"document.getElementById('%@').hidden = true",IDNAME];
/* JavaScript标签Height操作 */
#define JQUERY_JS_ID_HEIGHT(IDNAME,HEIGHT) [NSString stringWithFormat:@"document.getElementById('%@').style.height = '%zdpx'",IDNAME,HEIGHT];
/* JavaScript标签Width操作 */
#define JQUERY_JS_ID_WIDTH(IDNAME,WIDTH) [NSString stringWithFormat:@"document.getElementById('%@').style.width = '%zdpx'",IDNAME,WIDTH];
/* JavaScript标签AddClass操作 */
#define JQUERY_JS_ID_ADDCLASS(IDNAME,CLASSNAME) [NSString stringWithFormat:@"document.getElementById('%@').classList.add('%@')",IDNAME,CLASSNAME];
/* JavaScript标签RemoveClass操作 */
#define JQUERY_JS_ID_REMOVECLASS(IDNAME,CLASSNAME) [NSString stringWithFormat:@"document.getElementById('%@').classList.remove('%@')",IDNAME,CLASSNAME];
/* JavaScript标签Attr操作 */
#define JQUERY_JS_ID_ATTRVALUE_FUNCTION(IDNAME,ATTRNAME,VALUE) [NSString stringWithFormat:@"document.getElementById('%@').setAttribute('%@','%@')",IDNAME,ATTRNAME,VALUE];

/* ----------------------------- CLASSNAME -----------------------------*/
/* JavaScript标签文本内容 */
#define JQUERY_JS_CLASS_TEXT_VAL(CLASSNAME,COUNT,CONTEXT) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].innerText = '%@'",CLASSNAME,COUNT,CONTEXT];
/* JavaScript标签文本HTML格式 */
#define JQUERY_JS_CLASS_HTML(CLASSNAME,COUNT,CONTEXT) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].innerHTML = '%@'",CLASSNAME,COUNT,CONTEXT];
/* JavaScript标签ON操作 */
#define JQUERY_JS_CLASS_ON(CLASSNAME,COUNT,OPTION,FUNCTION) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].on%@ = %@",CLASSNAME,COUNT,OPTION,FUNCTION];
/* JavaScript标签CSS操作 */
#define JQUERY_JS_CLASS_CSS(CLASSNAME,COUNT,KEY,VALUE) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].style.%@ = '%@'",CLASSNAME,COUNT,KEY,VALUE];
/* JavaScript标签SHOW操作 */
#define JQUERY_JS_CLASS_SHOW(CLASSNAME,COUNT) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].show = true",CLASSNAME,COUNT];
#define JQUERY_JS_CLASS_SHOWF(CLASSNAME,COUNT,ANIMATION,FUNCTION) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].show('%@') = %@",CLASSNAME,COUNT,ANIMATION,FUNCTION];
#define JQUERY_JS_CLASS_SHOWA(CLASSNAME,COUNT,CONTEXT) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].show('%@')",CLASSNAME,COUNT,CONTEXT];
/* JavaScript标签Hidden操作 */
#define JQUERY_JS_CLASS_HIDDEN(CLASSNAME,COUNT) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].hidden = true",CLASSNAME,COUNT];
/* JavaScript标签Height操作 */
#define JQUERY_JS_CLASS_HEIGHT(CLASSNAME,COUNT,HEIGHT) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].style.height = '%zdpx'",CLASSNAME,COUNT,HEIGHT];
/* JavaScript标签Width操作 */
#define JQUERY_JS_CLASS_WIDTH(CLASSNAME,COUNT,WIDTH) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].style.width = '%zdpx'",CLASSNAME,COUNT,WIDTH];
/* JavaScript标签AddClass操作 */
#define JQUERY_JS_CLASS_ADDCLASS(CLASSNAME,COUNT,CLASSNAMES) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].classList.add('%@')",CLASSNAME,COUNT,CLASSNAMES];
/* JavaScript标签RemoveClass操作 */
#define JQUERY_JS_CLASS_REMOVECLASS(CLASSNAME,COUNT,CLASSNAMES) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].classList.remove('%@')",CLASSNAME,COUNT,CLASSNAMES];
/* JavaScript标签Attr操作 */
#define JQUERY_JS_CLASS_ATTRVALUE_FUNCTION(CLASSNAME,COUNT,ATTRNAME,VALUE) [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%@].setAttribute('%@','%@')",CLASSNAME,COUNT,ATTRNAME,VALUE];
#endif /* JQueryWebMacroJavaScript_h */
