//
//  GuestureViewController.h
//  progUI-GestureRecognizer
//
//  Created by Emiko Clark on 12/2/16.
//  Copyright © 2016 Emiko Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuestureViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *gestureDetectedLabel;
@property (nonatomic, strong) IBOutlet UIImageView *myImageView;
@property (nonatomic, strong) IBOutlet UIImageView *bkgImage;
@property (nonatomic, strong) IBOutlet UIButton *resetButton;
@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UILabel *instructionalLabel1;
@property (nonatomic, strong)  UILabel *instructionalLabel2;
@property (nonatomic) UITapGestureRecognizer *singleTap;
@property (nonatomic) UITapGestureRecognizer *doubleTap;
@property (nonatomic) UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic) UISwipeGestureRecognizer *rightSwipe;
@property (nonatomic) UISwipeGestureRecognizer *upSwipe;
@property (nonatomic) UISwipeGestureRecognizer *downSwipe;
@property (nonatomic) UILongPressGestureRecognizer *longPress;
@property (nonatomic) UIPanGestureRecognizer  *panGesture;
@property (nonatomic) UIPinchGestureRecognizer *pinchGesture;
@property (nonatomic) UIRotationGestureRecognizer *rotateGesture;

#pragma mark - Create Gestures and objects Methods
-(void) setupAllViews;
- (void) createBkgImageView;
- (void) createGestures;
- (void) createImageView;
- (void) createLabels;
- (void) createResetButton;


#pragma mark - UIGestureRecognizer Methods
- (void) singleTapResponder: (UITapGestureRecognizer *) sender;
- (void) doubleTapResponder: (UITapGestureRecognizer *) sender;
- (void) leftSwipeResponder: (UISwipeGestureRecognizer *) sender;
- (void) rightSwipeResponder: (UISwipeGestureRecognizer *) sender;
- (void) upSwipeResponder: (UISwipeGestureRecognizer *) sender;
- (void) downSwipeResponder: (UISwipeGestureRecognizer *) sender;
- (void) panImageResponder:(UIPanGestureRecognizer *) sender;
- (void) longPressResponder: (UILongPressGestureRecognizer *) sender;
- (void) pinchGestureResponder: (UIPinchGestureRecognizer * ) sender;
- (void) rotateResponder: (UIRotationGestureRecognizer *) sender;

#pragma mark - UIGestureRecognizer Delegate Methods
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

@end
