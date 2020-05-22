//
//  ViewController.m
//  JQueryWeb
//
//  Created by Bryant Reyn on 2020/4/15.
//  Copyright © 2020 Bryant Reyn. All rights reserved.
//

#import "ViewController.h"
#import "JQueryWebMacroJavaScript.h"
#import "JQueryWebMaker.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.apple.com.cn"]]];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:[self hidden]];
}

#pragma mark - 文本修改
- (NSString *)alterText{
    return JQueryWebMaker.JQueryClass(@".ac-gf-footer-legal-copyright").textWithIndex(0,@"JQueryWeb");
}

#pragma mark - 点击操作
- (NSString *)onOP{
    return JQueryWebMaker.JQueryID(@"#ac-gn-firstfocus").on(@"click",@"function(){ alert('Hello JQueryWeb'); }");
}

- (NSString *)onClickOP{
    return JQueryWebMaker.JQueryID(@"#ac-gn-firstfocus").onClick(0,@"function(){ alert('Hello JQueryWeb'); }");
}


#pragma mark - show
- (NSMutableArray *)css{
    NSMutableArray *cssArr = JQueryWebMaker.JQuery(@"p").css(@"{color:yellow,background:green}");
    
    return cssArr;
}

#pragma mark - show
- (NSString *)show{
   return JQueryWebMaker.JQuery(@"p").show();
}

#pragma mark - hidden
- (NSString *)hidden{
    return JQueryWebMaker.JQueryClass(@".ac-gf-footer-legal-copyright").hidden();
}
@end
