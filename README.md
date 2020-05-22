# JQueryWeb

#### 版本：v2.0
#### 开发者：CreaterOS
#### 发布时间：2020.05.22
#### 项目完善：如果您在使用中发现任何BUG或者有任何宝贵意见，可直接通过863713745@qq.com邮箱致电我们，我们尽最快的努力为您解决问题，并保证项目的稳定更新

## 版本迭代
历史版本 | Objective-C |描述 | Swift | 描述
---|---|---|---|---
v1.0 | v1.0 | 通过JQuery语法形式进行封装，快速高效的产生JS语句。 | / | 未开发
v2.0 | v1.0 | 未更新框架 | v1.0 | 根据Swift语法特点，优化框架。


---
#### **JQueryWeb是一款可以实现Web开发中JQuery和JavaScript无缝转换的操作,这是一款适用于Objective-C和Swift的开发框架。我们致力于使得网页修改过程变得更加快捷和稳定。**

#### Objective-C版本：链式编程思想,贴合JQuery编码风格
#### Swift版本: Swift先天语法风格优势，更加契合JQuery编码风格
---

JQueryWeb是一个轻量级的Web框架，它更好的还原了JQuery语法形式，采用链式编程思想，使得开发更有效率，从而使得代码更简介易读。JQuery更好的支持IOS和Mac OSX。

使用JavaScript修改网页有什么问题？
Objective-C和Swift官方给出的修改网页内容，通过WebView中提供的stringByEvaluatingJavaScriptFromString修改网页。但是，使用JS代码会使得代码是冗长的，并且在没有代码提示情况下，使得开发变得描述性差，并且出现很难发现的语法错误。想象一个，简单修改网页文本内容

**Objective-C:**
```
NSString *str = document.getElementsByClassName('ac-gf-footer-legal-copyright')[0].innerText = 'CreaterOS'
[webView stringByEvaluatingJavaScriptFromString:str];
```
**Swift:**

```
webView.stringByEvaluatingJavaScript(from: "document.getElementsByClassName('ac-gf-footer-legal-copyright')[0].innerText = 'CreaterOS'")
```

即使有这样一个简单的示例，所需的代码也很冗长。并且需要手动全部打出来，中间没有提供智能提示，假设，当您需要处理大量的网页修改时候，JavaScript很快就变得不可读，并且出现不可预知的错误的可能性也就更大。

---
JQueryWeb与您共进退
这是使用JQueryWebMaker创建的相同功能

**JQueryWeb-Objective-C:**
```
[webView stringByEvaluatingJavaScriptFromString:JQueryWebMaker.JQueryClass(@".ac-gf-footer-legal-copyright").text(@"JQueryWeb")];
```
**JQueryWeb-Swift:**
```
JQueryWebMaker.init(className: ".ac-gf-footer-legal-copyright").text(context: "JQueryWeb")
```

JQueryWeb为您提供了更贴近JQuery原生语法的格式，采用链式操作，让您在开发中效率更好，对于需要下标时候，您也可以这样使用

**JQueryWeb-Objective-C:**
```
[webView stringByEvaluatingJavaScriptFromString:JQueryWebMaker.JQueryClass(@".ac-gf-footer-legal-copyright").textWithIndex(0,@"JQueryWeb")];
```
**JQueryWeb-Swift:**

```
JQueryWebMaker.init(className: ".ac-gf-footer-legal-copyright").text(index: 0, context: "JQueryWeb")
```

### 如何使用 
**JQueryWeb-Objective-C**

使用JQueryWeb只需要导入JQueryWebMaker用来管理需要的JQuery代码

```
#import "JQueryWebMaker.h"
```

**JQueryWeb-Swift**

只需要将JQueryWeb文件夹拖入项目中，就可以直接使用

### 创建方式任由你选择：

**JQueryWeb-Objective-C:**
```
document.getElementsByTagName  等效于 JQuery
```
```
document.getElementById  等效于 JQueryID
```
```
document.getElementsByClassName  等效于 JQueryClass
```
这三种创建方式传入的参数和JQuery原生语法相同。

**JQueryWeb-Swift:**

建议只使用JQueryWebMaker创建管理需要处理的内容。
```
JQueryWebMaker.init(tagName: "tagName")
```

```
JQueryWebMaker.init(idName: "#idName")
```

```
JQueryWebMaker.init(className: ".className")
```

### 常用修改网页参数对比表
#### 文本操作
JQuery | JQueryWeb
---|---
text | text
html | html
val | val

#### on操作
JQuery | JQueryWeb
---|---
on | on 
on | onMoreOptions
on | onMoreEventWithIndex
onBlur | onBlur
onFocus | onFocus
onFocusin | onFocusin
onLoad | onLoad
onResize | onResize
onScroll | onScroll
onUnload | onUnload
onClick | onClick
onDblclick | onDblclick
onMousedown | onMousedown
onMouseup | onMouseup
onMousemove | onMousemove
onMouseover | onMouseover
onMouseout | onMouseout
onMouseenter | onMouseenter
onMouseleave | onMouseleave
onChange | onChange
onSelect | onSelect
onSubmit | onSubmit
onKeydown | onKeydown
onKeypress | onKeypress
onKeyup| onKeyup
onError | onError
onContextmenu | onContextmenu

#### css操作
JQuery | JQueryWeb
---|---
css | css 

#### show操作
JQuery | JQueryWeb
---|---
show | show 

#### hidden操作
JQuery | JQueryWeb
---|---
hidden | hidden

#### 长宽操作
JQuery | JQueryWeb
---|---
height | height
width | width

#### 类型操作
JQuery | JQueryWeb
---|---
addClass | addClass
removeClass | removeClass
attr | attr

### 默认使用
**如果您使用和JQuery一样的，例如css会自动默认选择第一个出现class或者tag名称的标签，当然，您也可以自定义下标，利用xxxWithIndex来指明标签的出现的位置，第一个参数填入位置。**

### 高级宏使用函数
**JQueryWeb-Objective-C:**

如果您不想使用JQueryWeb封装的方法来使用，也可以通过提供的宏定义进行快速使用。
只需要调用就可以快速使用

```
import "JQueryWebMacroJavaScript.h"
```
**JQueryWeb-Swift:**
JQueryWeb提供了可以直接使用的JS函数来使用，详细在JQueryWebMacroJavaScript.swift文件中有定义。

### 安装
**直接通过GitHub下载到本地，将JQueryWeb拖到项目中，即可使用。**

### 为这个项目做贡献
如果您有功能请求或错误报告，请随时发送863713745@qq.com上传问题，我们会第一时间为您提供修订和帮助。也非常感谢您的支持。

### 安全披露
如果您认为已通过JQueryWeb找到了安全漏洞和需要修改的漏洞，则应尽快通过电子邮件将其报告至863713745@qq.com。感谢您的支持。
