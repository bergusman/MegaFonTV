//
//  GeneralViewController.m
//  MegaFonTV
//
//  Created by Vitaly Berg on 27/08/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "GeneralViewController.h"

#import "DetailsViewController.h"

@interface GeneralViewController ()

@end

@implementation GeneralViewController

#pragma mark - Setups

- (void)setupNavigationItem {
    self.navigationItem.title = @"МегаФон.ТВ";
}

#pragma mark - Content

- (void)showDetails {
    DetailsViewController *detailsVC = [[DetailsViewController alloc] init];
    detailsVC.modalPresentationCapturesStatusBarAppearance = YES;
    detailsVC.modalPresentationStyle = UIModalPresentationCustom;
    detailsVC.transitioningDelegate = detailsVC;
    [self presentViewController:detailsVC animated:YES completion:nil];
}

#pragma mark - Actions

- (IBAction)openAction:(id)sender {
    [self showDetails];
}

- (IBAction)tapAction:(id)sender {
    [self showDetails];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
}

@end
