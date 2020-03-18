//
//  UIImageViewAnimatorSampleViewController.m
//  UIImageViewAnimatorSample
//

#import "UIImageViewAnimatorSampleViewController.h"
#import "UIImageViewAnimator.h"

@implementation UIImageViewAnimatorSampleViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[animator release];
    [super dealloc];
}

- (void) viewDidLoad
{
	NSMutableArray * dataSet = [NSMutableArray arrayWithCapacity:5];
	for ( int i=0; i<5; i++ )
	{
		NSString * name = [NSString stringWithFormat:@"frame%d.png", i];
		[dataSet addObject:name];
	}
	
	[animator setImageNames:dataSet];
	[animator setDuration:1];
	
	//test notification!	
	[animator setCacheImages:YES];
	[animator setDelegate:self];
	[animator setStartSelector:@selector(start:)];
	[animator setStopSelector:@selector(stop:)];
}

-(void)start:(id)_context
{
	NSLog( @"Animation playback has been triggered" );
}

- (void) stop:(id)_context
{
	NSLog( @"Animation playback has finished" );
}

- (IBAction) startAnimation:(id)_sender
{
	if ( ![animator isAnimating] )
	{
		[animator setIndex:0];
		[animator startAnimating];
	}
}

@end
