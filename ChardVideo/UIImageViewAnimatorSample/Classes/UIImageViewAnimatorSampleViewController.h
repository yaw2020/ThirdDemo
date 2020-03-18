//
//  UIImageViewAnimatorSampleViewController.h
//  UIImageViewAnimatorSample
//

#import <UIKit/UIKit.h>

@class UIImageViewAnimator;

@interface UIImageViewAnimatorSampleViewController : UIViewController 
{
@private
	IBOutlet UIImageViewAnimator * animator;
}

- (IBAction) startAnimation:(id)_sender;

@end

