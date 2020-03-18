//
//  AppDelegate.h
//  OpenFile
//
//  Created by Cloud on 2018/11/25.
//  Copyright © 2018 Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIDocumentInteractionControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) UIDocumentInteractionController *documentVC;
@property(nonatomic,copy)NSString *filePath;
@end

