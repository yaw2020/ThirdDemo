//
//  ViewController.m
//  OpenFile
//
//  Created by Cloud on 2018/11/25.
//  Copyright © 2018 Cloud. All rights reserved.
//

#import "ViewController.h"
#import "SaveFileManager.h"
#import "NSString+Regex.h"
@interface ViewController ()<UIDocumentInteractionControllerDelegate>

@end

@implementation ViewController
- (IBAction)openClick:(id)sender {
    [self.documentVC dismissPreviewAnimated:YES];
    NSString *filePath2=[[NSBundle mainBundle] pathForResource:@"JSPatch"ofType:@"pdf"];
    NSURL *path=[NSURL fileURLWithPath:filePath2];//我这儿是本地的文件
    self.documentVC= [UIDocumentInteractionController interactionControllerWithURL:path];
    self.documentVC.delegate=self;
    if ([self.documentVC presentPreviewAnimated:YES])
    {
        NSLog(@"打开成功");
    }
    else
    {
        NSLog(@"打开失败");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.documentVC dismissPreviewAnimated:YES];
//    NSString *filePath2=[[NSBundle mainBundle] pathForResource:@"111"ofType:@"doc"];
//    NSURL *path=[NSURL fileURLWithPath:filePath2];//我这儿是本地的文件
//    self.documentVC= [UIDocumentInteractionController interactionControllerWithURL:path];
//    self.documentVC.delegate=self;
//    if ([self.documentVC presentPreviewAnimated:YES])
//    {
//        NSLog(@"打开成功");
//    }
//    else
//    {
//        NSLog(@"打开失败");
//    }
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)openFile{
    [self.documentVC dismissPreviewAnimated:YES];
    NSString *string = [SaveFileManager sharedInstance].filePath;
    NSURL *path=[NSURL fileURLWithPath:string];//我这儿是本地的文件
    NSLog(@"打开时的路径:%@",[path absoluteString]);
    
    self.documentVC= [UIDocumentInteractionController interactionControllerWithURL:path];
    self.documentVC.delegate=self;
    if ([self.documentVC presentPreviewAnimated:YES])
    {
        NSLog(@"打开成功");
    }
    else
    {
        NSLog(@"打开失败");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller

{
    
        return self;
    
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller

{
    
        return self.view;
    
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller

{
    return self.view.frame;
    
}

@end
