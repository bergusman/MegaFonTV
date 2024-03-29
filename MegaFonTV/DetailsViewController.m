//
//  DetailsViewController.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 27/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "DetailsViewController.h"

#import "ContainerCardView.h"
#import "GeneralCardView.h"
#import "DetailsCardView.h"
#import "PersonsCardView.h"

#import "PageControl.h"

#import "UIImage+Drawing.h"

#import "Movie.h"

#import <UIImageEffects/UIImage+ImageEffects.h>
#import <MediaPlayer/MediaPlayer.h>

@interface DetailsViewController () <UIScrollViewDelegate, UIViewControllerAnimatedTransitioning>

@property (weak, nonatomic) IBOutlet UIImageView *blurImageView;
@property (weak, nonatomic) IBOutlet UIImageView *dimImageView;

@property (weak, nonatomic) IBOutlet UIButton *hideButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet PageControl *pageControl;

@property (strong, nonatomic) ContainerCardView *generalContainerCardView;
@property (strong, nonatomic) ContainerCardView *detailsContainerCardView;
@property (strong, nonatomic) ContainerCardView *personsContainerCardView;

@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (strong, nonatomic) Movie *movie;
@property (assign, nonatomic) BOOL payed;

@property (assign, nonatomic) BOOL dismissing;

@end

@implementation DetailsViewController

#pragma mark - Setups

- (void)setupButtons {
    UIImage *image = [UIImage solidImageWithSize:self.buyButton.bounds.size color:RGBA(104, 49, 149, 0.9)];
    [self.buyButton setBackgroundImage:image forState:UIControlStateNormal];
    
    image = [UIImage solidImageWithSize:self.likeButton.bounds.size color:RGBA(37, 183, 110, 0.8)];
    [self.likeButton setBackgroundImage:image forState:UIControlStateNormal];
    
    [self.likeButton setImage:[UIImage imageNamed:@"heart-selected"] forState:(UIControlStateSelected | UIControlStateHighlighted)];
    
    self.buttonsView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.buttonsView.bounds].CGPath;
    self.buttonsView.layer.shadowOpacity = 0.4;
    self.buttonsView.layer.shadowRadius = 8;
    self.buttonsView.layer.shadowOffset = CGSizeMake(0, 3);
}

- (void)setupPageControl {
    self.pageControl.dotStep = 20;
    self.pageControl.currentDotImage = [UIImage dot1WithColor:RGB(121, 121, 121)];
    self.pageControl.dotImage = [UIImage dot2WithColor:RGB(121, 121, 121)];
}

#pragma mark - Content

- (void)loadMovie {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Movie.json" withExtension:@""];
    NSData *data = [NSData dataWithContentsOfURL:url];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    self.movie = [Movie movieWithJSON:json];
}

- (void)fillCards {
    ContainerCardView *containerCardView;
    
    containerCardView = [[ContainerCardView alloc] init];
    GeneralCardView *generalCardView = [GeneralCardView instantiateFromNib];
    generalCardView.playHandler = ^() {
        [self playTrailer];
    };
    containerCardView.contentView = generalCardView;
    containerCardView.center = CGPointMake(160, 190);
    self.generalContainerCardView = containerCardView;
    [self.scrollView addSubview:containerCardView];
    
    containerCardView = [[ContainerCardView alloc] init];
    DetailsCardView *detailsCardView = [DetailsCardView instantiateFromNib];
    [detailsCardView fillWithMovie:self.movie];
    containerCardView.contentView = detailsCardView;
    containerCardView.center = CGPointMake(320 + 160, 190);
    self.detailsContainerCardView = containerCardView;
    [self.scrollView addSubview:containerCardView];
    
    containerCardView = [[ContainerCardView alloc] init];
    PersonsCardView *personsCardView = [PersonsCardView instantiateFromNib];
    [personsCardView fillWithMovie:self.movie];
    containerCardView.contentView = personsCardView;
    containerCardView.center = CGPointMake(640 + 160, 190);
    self.personsContainerCardView = containerCardView;
    [self.scrollView addSubview:containerCardView];
    
    self.scrollView.contentSize = CGSizeMake(960, 380);
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
}

- (void)playTrailer {
    NSString *videoUrl = @"http://46.182.26.14/mftv/trailer.mp4";
    MPMoviePlayerViewController *playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:videoUrl]];
    [self presentMoviePlayerViewControllerAnimated:playerVC];
}

- (void)playMovie {
    
    NSString *videoUrl = @"http://46.182.26.14/mftv/trailer.mp4";
    MPMoviePlayerViewController *playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:videoUrl]];
    [self presentMoviePlayerViewControllerAnimated:playerVC];
}

#pragma mark - Actions

- (IBAction)hideButton:(id)sender {
    if ([[self.hideButton titleForState:UIControlStateNormal] isEqualToString:@"Скрыть из выдачи"]) {
        [self.hideButton setTitle:@"Показывать" forState:UIControlStateNormal];
    } else {
        [self.hideButton setTitle:@"Скрыть из выдачи" forState:UIControlStateNormal];
    }
}

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buyAction:(id)sender {
    if (self.payed) {
        [self playMovie];
    } else {
        self.payed = YES;
        [UIView animateWithDuration:0.2 animations:^{
            [self.buyButton setTitle:@"Смотреть" forState:UIControlStateNormal];
        }];
    }
}

- (IBAction)likeAction:(id)sender {
    self.likeButton.selected = !self.likeButton.selected;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.dragging || scrollView.decelerating) {
        CGFloat r = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
        r = fabsf(r - floor(r + 0.5));
        if (r > 0.3) {
            return;
        }
        
        NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
        if (self.pageControl.currentPage != index) {
            index = MAX(0, MIN(3, index));
            self.pageControl.currentPage = index;
        }
    }
}

#pragma mark - Presenting

- (NSTimeInterval)presentingTransitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)presentingTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    self.blurImageView.image = [self bluredImageOfScreen:fromViewController.view.window];
    
    toViewController.view.frame = fromViewController.view.frame;
    [[transitionContext containerView] addSubview:toViewController.view];
    
    self.blurImageView.alpha = 0;
    self.dimImageView.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.blurImageView.alpha = 1;
        self.dimImageView.alpha = 1;
    } completion:nil];
    
    self.scrollView.alpha = 0;
    self.scrollView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.detailsContainerCardView.alpha = 0;
    self.personsContainerCardView.alpha = 0;
    self.pageControl.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.scrollView.alpha = 1;
        self.scrollView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.detailsContainerCardView.alpha = 1;
        self.personsContainerCardView.alpha = 1;
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.pageControl.alpha = 1;
        } completion:nil];
    }];
    
    self.hideButton.center = CGPointMake(self.hideButton.center.x, -40);
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.hideButton.center = CGPointMake(self.hideButton.center.x, 43);
    } completion:nil];
    
    self.closeButton.center = CGPointMake(self.closeButton.center.x, -40);
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.closeButton.center = CGPointMake(self.closeButton.center.x, 43);
    } completion:nil];
    
    self.buttonsView.center = CGPointMake(self.buttonsView.center.x, 568 + 52);
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.buttonsView.center = CGPointMake(self.buttonsView.center.x, 516);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    });
}

- (UIImage *)bluredImageOfScreen:(UIWindow *)window {
    UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, [UIScreen mainScreen].scale);
    [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //UIColor *color = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    image = [image applyBlurWithRadius:18 tintColor:nil saturationDeltaFactor:0.9 maskImage:nil];
    
    return image;
}

#pragma mark - Dismissing

- (NSTimeInterval)dismissingTransitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)dismissingTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.dimImageView.alpha = 0;
    } completion:nil];
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.blurImageView.alpha = 0;
        self.dimImageView.alpha = 0;
        self.hideButton.alpha = 0;
        self.closeButton.alpha = 0;
        self.scrollView.alpha = 0;
        self.scrollView.transform = CGAffineTransformMakeScale(3, 3);
        self.pageControl.alpha = 0;
        self.buttonsView.alpha = 0;
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    });
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.dismissing) {
        return [self dismissingTransitionDuration:transitionContext];
    } else {
        return [self presentingTransitionDuration:transitionContext];
    }
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.dismissing) {
        [self dismissingTransition:transitionContext];
    } else {
        [self presentingTransition:transitionContext];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.dismissing = NO;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:[MPMoviePlayerViewController class]]) {
        return nil;
    }
    
    self.dismissing = YES;
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupButtons];
    [self setupPageControl];
    [self loadMovie];
    [self fillCards];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
