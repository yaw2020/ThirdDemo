//
//  UIImageViewAnimator.m
//  UIImageViewAnimatorSample
//

#import "UIImageViewAnimator.h"


@interface UIImageViewAnimator (PrivateMethods)

- (void) updateFrame;
- (void) setImageAtIndex:(NSInteger)_index;

@end


@implementation UIImageViewAnimator

#pragma mark ---------------------------------------------------------
#pragma mark === Properties  ===
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// get the current index
// --------------------------------------------------
- (NSInteger) index
{
	return index;
}

// --------------------------------------------------
// set the Current index
// --------------------------------------------------
- (void) setIndex:(NSInteger)_index
{
	if ( ( _index >= 0 ) && 
		 ( _index < [imageNames count] ) )
	{
		index = _index;
		
		[self setImageAtIndex:index];
	}
}

// --------------------------------------------------
// get the number of images in the animation
// --------------------------------------------------
- (NSInteger) count
{
	return [imageNames count];
}

// --------------------------------------------------
// get the image names array
// --------------------------------------------------
- (NSArray*) imageNames
{
	return imageNames;
}

// --------------------------------------------------
// set the image names array
// --------------------------------------------------
- (void) setImageNames:(NSArray *)_array
{
	[imageNames release];
 	imageNames = [[_array copy] retain];
	
	if ( index >= [imageNames count] )
	{
		index = [imageNames count]-1;
	}
	
	[self setImageAtIndex:index];
}

@synthesize duration;
@synthesize cacheImages;
@synthesize reverse;
@synthesize delegate;
@synthesize startSelector;
@synthesize stopSelector;
@synthesize frameChangeSelector;

#pragma mark ---------------------------------------------------------
#pragma mark === End Properties  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// Initialize 
// --------------------------------------------------
- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) 
	{
        // Initialization code
    }
	return self;
}

// --------------------------------------------------
// Initialize 
// --------------------------------------------------
- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) 
	{
        // Initialization code
    }
    return self;
}

// --------------------------------------------------
// dealloc
// --------------------------------------------------
- (void)dealloc 
{
	[imageview release];
	
	[animtimer invalidate];
	
	[imageNames release];
	
	[delegate release];
	
	[context release];
	
    [super dealloc];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Constructor / Destructor Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Public Functions  ===
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// start the animation
// --------------------------------------------------
- (void) startAnimating
{
	[self startAnimatingWithContext:nil];
}

// --------------------------------------------------
// start the animation with context
// --------------------------------------------------
- (void) startAnimatingWithContext:(id)_context
{	
	if ( animtimer == nil )
	{
		context = _context;
		
		if ( !imageset )
		{
			[self setImageAtIndex:index];
		}
	
		NSTimeInterval frameTime = duration / [imageNames count];
	
		animtimer = [NSTimer scheduledTimerWithTimeInterval:frameTime target:self selector:@selector(updateFrame) userInfo:nil repeats:YES];
		
		if ( startSelector )
		{
			[delegate performSelector:startSelector withObject:context];
		}
	}
}

// --------------------------------------------------
// Stop the animation at the current point
// --------------------------------------------------
- (void) stopAnimating
{
	[animtimer invalidate];
	animtimer = nil; 
}

// --------------------------------------------------
// Is the object being Animated
// --------------------------------------------------
- (Boolean) isAnimating
{
	return ( animtimer != nil );
}

// --------------------------------------------------
// pre Cache the images into memory
// --------------------------------------------------
- (void) precache
{
	cacheImages = TRUE;
	
	UIImage * img = nil;
	for ( int i=0; i<[imageNames count]; i++ )
	{
		NSString * name = [imageNames objectAtIndex:i];
		img = [UIImage imageNamed:name];
	}
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Public Functions  ===
#pragma mark ---------------------------------------------------------

#pragma mark ---------------------------------------------------------
#pragma mark === Private Functions  ===
#pragma mark ---------------------------------------------------------

// --------------------------------------------------
// update the current frame
// --------------------------------------------------
- (void) updateFrame
{
	NSInteger newIndex = index + ( ( reverse ) ? -1 : 1 );
	if ( ( newIndex >= 0 ) && 
		 ( newIndex < [imageNames count] ) )
	{
		index = newIndex;
		
		if ( frameChangeSelector )
		{
			// call the frame delegate
			[delegate performSelector:frameChangeSelector withObject:context];
		}
		
		[self setImageAtIndex:index];
		
		// ------------------------------------------------
		// call the stop animation on the last frame
		// ------------------------------------------------
		if ( ( index == 0 ) ||
			 ( index == [imageNames count] -1 ) )
		{
			// stop the timer
			[self stopAnimating];
			
			if ( stopSelector )
			{
				// call the delegate
				[delegate performSelector:stopSelector withObject:context];
			}
		}
		// ------------------------------------------------
	}
	else // Parinoid check
	{
		// stop the timer
		[self stopAnimating];
		
		if ( stopSelector )
		{
			// call the delegate
			[delegate performSelector:stopSelector withObject:context];
		}
	}

}

// --------------------------------------------------
// set the image view with the image at index
// --------------------------------------------------
- (void) setImageAtIndex:(NSInteger)_index
{
	imageset = TRUE;
	
	NSString * name = [imageNames objectAtIndex:_index];
	
	// load the image from the bundle
	UIImage * img = nil;
	if ( cacheImages )
	{
		img = [UIImage imageNamed:name];
	}
	else
	{
		img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
	}
	
	// set it into the view
	[imageview setImage:img];
}

#pragma mark ---------------------------------------------------------
#pragma mark === End Private Functions  ===
#pragma mark ---------------------------------------------------------

@end
