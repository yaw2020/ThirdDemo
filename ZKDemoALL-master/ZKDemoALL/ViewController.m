//
//  ViewController.m
//  ZKDemoALL
//
//  Created by 赵凯 on 2016/11/25.
//  Copyright © 2016年 赵凯. All rights reserved.
//

#import "ViewController.h"
#import <QuickLook/QuickLook.h>

@interface ViewController ()<UIWebViewDelegate,UIDocumentInteractionControllerDelegate,QLPreviewControllerDelegate,QLPreviewControllerDataSource>
{
    
    NSURL *_url1;
    NSURL *_url2;
    NSURL *_url3;
    UIWebView *_webView;
    UIDocumentInteractionController *_documentInt;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"测试1" ofType:@"docx"];
    _url1 = [NSURL fileURLWithPath:path1];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"测试2" ofType:@"xlsx"];
    _url2 = [NSURL fileURLWithPath:path2];
    
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"测试3" ofType:@"pptx"];
    _url3 = [NSURL fileURLWithPath:path3];
    
    //1.web页面显示
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 200, 40)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"web页显示" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //2.UIDocumentInteractionController
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 200, 40)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"Document显示" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnAction2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    //3.Quick Look
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(50, 300, 200, 40)];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitle:@"Quick显示" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnAction3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    
}

-(void)btnAction1{
    
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:_url3];
    [_webView loadRequest:request];
    [_webView setScalesPageToFit:YES];
    [self.view addSubview:_webView];

}

-(void)btnAction2{

    _documentInt = [UIDocumentInteractionController interactionControllerWithURL:_url3];
    [_documentInt setDelegate:self];
    [_documentInt presentPreviewAnimated:YES];
    [_documentInt presentOptionsMenuFromRect:CGRectMake(0, 0, 375, 667) inView:self.view  animated:YES];
}

-(void)btnAction3{

    QLPreviewController *myQlPreViewController = [[QLPreviewController alloc]init];
    myQlPreViewController.delegate =self;
    myQlPreViewController.dataSource =self;
    [myQlPreViewController setCurrentPreviewItemIndex:0];
    [self presentViewController:myQlPreViewController animated:YES completion:nil];
    
}


#pragma mark   ================UIDocumentInteractionController代理==============
- (UIViewController*)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController*)controller
{
    　return self;
}
- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller
{
    　return self.view;
}
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller
{
    
    　return self.view.frame;
}
//点击预览窗口的“Done”(完成)按钮时调用
- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController*)_controller
{
    [_documentInt dismissPreviewAnimated:YES];
}


#pragma mark   ===============Quick Look代理===============
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}
- (id)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    //    NSString *fileName = [self.listDic objectForKey:@"fileName"];
    //    NSString* path = [NSHomeDirectory()stringByAppendingPathComponent:[NSStringstringWithFormat:@"Documents/%@",fileName]];
    
    return _url3;
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
