//
//  ViewController.h
//  OpenFile
//
//  Created by Cloud on 2018/11/25.
//  Copyright © 2018 Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(nonatomic,strong)UIDocumentInteractionController *documentVC;
-(void)openFile;
@end

