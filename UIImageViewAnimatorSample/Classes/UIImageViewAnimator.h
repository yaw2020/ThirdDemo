//
//  UIImageViewAnimator.h
//  UIImageViewAnimatorSample
//

#import <UIKit/UIKit.h>


@interface UIImageViewAnimator : UIView 
{
@private
	IBOutlet UIImageView *	imageview;

	NSTimer *				animtimer;
	NSArray *				imageNames;
	NSInteger				index;
	NSTimeInterval			duration;
	
	id						context;
	id						delegate;
	SEL						frameChangeSelector;
	SEL						startSelector;
	SEL						stopSelector;
	
	Boolean					cacheImages;
	Boolean					reverse;
	Boolean					imageset;
}

@property (nonatomic)			NSInteger		index;
@property (nonatomic,readonly)	NSInteger		count;
@property (nonatomic,copy)		NSArray *		imageNames;
@property (nonatomic)			NSTimeInterval	duration;
@property (nonatomic)			Boolean			cacheImages;
@property (nonatomic)			Boolean			reverse;

@property (nonatomic,retain)	id				delegate;
@property (nonatomic)			SEL				startSelector;
@property (nonatomic)			SEL				stopSelector;
@property (nonatomic)			SEL				frameChangeSelector;

- (void) startAnimating;
- (void) startAnimatingWithContext:(id)_context;
- (void) stopAnimating;
- (Boolean) isAnimating;

- (void) precache;

@end
