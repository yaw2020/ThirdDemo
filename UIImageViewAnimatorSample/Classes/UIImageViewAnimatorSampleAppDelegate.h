//
//  UIImageViewAnimatorSampleAppDelegate.h
//  UIImageViewAnimatorSample
//

#import <UIKit/UIKit.h>

@class UIImageViewAnimatorSampleViewController;

@interface UIImageViewAnimatorSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIImageViewAnimatorSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIImageViewAnimatorSampleViewController *viewController;

@end

