//
//  GuestureViewController.m
//  progUI-GestureRecognizer
//
//  Created by Emiko Clark on 12/2/16.
//  Copyright © 2016 Emiko Clark. All rights reserved.
//

// >>> issues: works unpredictably: check drag, rotate, pinch on imageView


#import "GuestureViewController.h"

@interface GuestureViewController ()

@end

@implementation GuestureViewController

// Max size of imageView
#define MAX_SIZE 300

static CGRect  screenSize;
static CGFloat screenWidth;
static CGFloat screenHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // calculate screen dimensions for centering myImageView
    screenSize   = [[UIScreen mainScreen] bounds];
    screenWidth  = CGRectGetMaxX(screenSize);
    screenHeight = CGRectGetMaxY(screenSize);
    
    [self setupAllViews];
    
}

#pragma mark - Create Gestures and objects Methods

-(void) setupAllViews {
    [self createBkgImageView];
    [self createImageView];
    [self createGestures];
    [self   createLabels];
    [self createResetButton];
}

- (void) createBkgImageView {
    self.bkgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.bkgImage.image = [UIImage imageNamed:@"snowflakeBkg.jpg"];
    self.bkgImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.bkgImage];
    [self.view sendSubviewToBack:self.bkgImage];
}

-(void) createGestures {
    //Tap Gesture
    self.singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action: @selector(singleTapResponder:)];
    
    
    self.doubleTap = [[UITapGestureRecognizer alloc ]initWithTarget:self action:@selector(doubleTapResponder:)];
    self.doubleTap.numberOfTapsRequired = 2;
    self.doubleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:self.doubleTap];
    
    // Number of taps required for gesture to be recognized
    self.singleTap.numberOfTapsRequired = 1;
    // Number of fingers on the screen required for gesture to be recognized
    self.singleTap.numberOfTouchesRequired = 1;
    [self.singleTap requireGestureRecognizerToFail: self.doubleTap];
    // Add tap gesture to the view
    [self.view addGestureRecognizer:self.singleTap];
    
    //Swipe Gesture
    // swipe left
    self.leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeResponder:)];
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    self.leftSwipe.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer: self.leftSwipe];
    
    // swipe right
    self.rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget: self action:@selector(rightSwipeResponder:)];
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer: self.rightSwipe];
    
    // swipe up
    self.upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action: @selector(upSwipeResponder:)];
    self.upSwipe.numberOfTouchesRequired = 1;
    self.upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer: self.upSwipe];
    
    // swipe down
    self.downSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget: self action: @selector(downSwipeResponder:)];
    self.downSwipe.numberOfTouchesRequired = 1;
    self.downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer: self.downSwipe];
    
    //Long Press Gesture
    self.longPress = [[UILongPressGestureRecognizer alloc ]initWithTarget:self action:@selector(longPressResponder:)];
    self.longPress.minimumPressDuration = 1.0f;
    self.longPress.allowableMovement = 30.0f;
    [self.view addGestureRecognizer:self.longPress];
    
    //Pinch Gesture
    self.pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action: @selector(pinchGestureResponder:)];
    self.myImageView.userInteractionEnabled = YES;
    //    [self.pinchView setCenter:self.pinchView.center];
    [self.myImageView addGestureRecognizer: self.pinchGesture];
    [self.view addSubview:self.myImageView]; // add pinchView as a subview of the view controllers view
    
    //Pan Gesture
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panImageResponder:)];
    self.self.myImageView.userInteractionEnabled = YES;
    [self.myImageView addGestureRecognizer: self.panGesture];
    
    //Rotate Gesture
    UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateResponder:)];
    self.myImageView.userInteractionEnabled = YES;
    [self.myImageView addGestureRecognizer: rotateGesture];
    [self.view addSubview:self.myImageView];
}


- (void) createImageView {
    self.myImageView = [[UIImageView alloc] initWithFrame: CGRectMake((screenWidth - MAX_SIZE)/2, 125, MAX_SIZE, MAX_SIZE)];
    self.view.backgroundColor = [UIColor whiteColor];
    self.myImageView.image = [UIImage imageNamed:@"yangWithSantaHat.jpg"];
    self.myImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview: self.myImageView];
}

- (void) createLabels {
    
    // create label for title of app
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth-300)/2, 40, MAX_SIZE, 30)];
    self.titleLabel.text = @"Gesture Recognizer";
    [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
    self.titleLabel.textColor = [UIColor blueColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: self.titleLabel];
    
    // create label to give users instructions for gestures
    self.instructionalLabel1 = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth - (screenWidth - 20))/2, 90, screenWidth - 20, 30)];
    self.instructionalLabel1.text = @"Tap, Double Tap, Long Press, & Swipe";
    self.instructionalLabel1.textAlignment = NSTextAlignmentCenter;
    [self.instructionalLabel1 setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    self.instructionalLabel1.textColor = [UIColor blueColor];
    [self.view addSubview: self.instructionalLabel1];
    
    // create label to give users instructions for gestures for pinch,drag, & rotate on image
    self.instructionalLabel2 = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth - 350)/2, 450, 350, 30)];
    self.instructionalLabel2.text = @"Pinch, Drag & Rotate on the image";
    [self.instructionalLabel2 setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    self.instructionalLabel2.textColor = [UIColor blueColor];
    self.instructionalLabel2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: self.instructionalLabel2];
    
    // create label that gives feedback to user on what gesture was recorded
    self.gestureDetectedLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth - MAX_SIZE)/2, screenHeight - 125, MAX_SIZE,30)];
    self.gestureDetectedLabel.textAlignment = NSTextAlignmentCenter;
    [self.gestureDetectedLabel setFont:[UIFont fontWithName:@"Helvetica" size:22]];
    self.gestureDetectedLabel.textColor = [UIColor blueColor];
    [self.view addSubview:self.gestureDetectedLabel];
}

- (void) createResetButton {
    self.resetButton = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth - 50)/2, screenHeight - 80, 50, 20)];
    [self.resetButton addTarget:self  action:@selector(resetButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    self.resetButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.resetButton setTitleColor:[UIColor blueColor] forState: UIControlStateNormal];
    [self.view addSubview: self.resetButton];
    
}

#pragma mark - UIGestureRecognizer Methods

- (void) singleTapResponder: (UITapGestureRecognizer *) sender{
    NSLog(@"Single tap detected");
    self.gestureDetectedLabel.text = @"Single Tap Detected";
}

- (void) doubleTapResponder: (UITapGestureRecognizer *) sender {
    NSLog(@"Double Tap Detected");
    self.gestureDetectedLabel.text = @"Double Tap Detected";
}


- (void) leftSwipeResponder: (UISwipeGestureRecognizer *) sender {
    NSLog(@"Left Swipe Detected");
    self.gestureDetectedLabel.text = @"Left Swipe Detected";
}

- (void) rightSwipeResponder: (UISwipeGestureRecognizer *) sender {
    NSLog(@"Right Swipe Detected");
    self.gestureDetectedLabel.text = @"Right Swipe Detected";
}

- (void) upSwipeResponder: (UISwipeGestureRecognizer *) sender {
    NSLog(@"Up Swipe Detected");
    self.gestureDetectedLabel.text = @"Up Swipe Detected";
}

- (void) downSwipeResponder: (UISwipeGestureRecognizer *) sender {
    NSLog(@"Down Swipe Detected");
    self.gestureDetectedLabel.text = @"Down Swipe Detected";
}

- (void) panImageResponder:(UIPanGestureRecognizer *) sender {
    UIView *pannedView = sender.view;
    self.gestureDetectedLabel.numberOfLines = 0;
    CGPoint translation = [sender translationInView: sender.view.superview];
    pannedView.center = CGPointMake(pannedView.center.x + translation.x, pannedView.center.y + translation.y);
    [sender setTranslation:CGPointZero inView:pannedView.superview];
    self.gestureDetectedLabel.text = @"Drag Gesture Detected";
}


- (void) longPressResponder: (UILongPressGestureRecognizer *) sender {
    NSLog(@"longpress detected");
    if ([sender isEqual: self.longPress]) {
        if (sender.state == UIGestureRecognizerStateBegan) {
            self.gestureDetectedLabel.text = @"Long Press Detected";
        }
    }
}

- (void) pinchGestureResponder: (UIPinchGestureRecognizer * ) sender {
    NSLog(@"Pinch Detected: %@",sender.view);
    self.gestureDetectedLabel.text = @"Pinch Gesture Detected";
    UIView *pinchedView = sender.view;
    UIGestureRecognizerState state = [sender state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged){
        CGFloat scale = [sender scale];
        [pinchedView setTransform:CGAffineTransformScale(pinchedView.transform, scale, scale)];
        [sender setScale:1.0];
    }
}

- (void)rotateResponder: (UIRotationGestureRecognizer *) sender {
    
    self.gestureDetectedLabel.text = @"Rotation Gesture Detected";
    UIGestureRecognizerState state = sender.state;
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged) {
        CGFloat rotation = [sender rotation];
        [sender.view setTransform:CGAffineTransformRotate(sender.view.transform, rotation)];
        NSLog(@"Rotated: %f",rotation);
        [sender setRotation:0];
    }
}

- (IBAction)resetButtonTapped:(UIButton *)sender {
    //clears all transformations done to image and resets to original position
    NSLog(@"Reset Button Tapped");
    self.gestureDetectedLabel.text  = @"";
    [self.myImageView removeFromSuperview];
    // recreate all views, gestures and subViews
    [self setupAllViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIGestureRecognizer Delegate Methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer  {
    return YES;
}

/*
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



@end
