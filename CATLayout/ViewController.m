//
//  ViewController.m
//  CATLayout
//
//  Created by wit on 15/1/8.
//  Copyright (c) 2015年 cat. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CATLayout.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // auto layout
    UIView *container1 = [[UIView alloc] init];
    container1.translatesAutoresizingMaskIntoConstraints = NO;
    container1.layer.borderColor = [UIColor colorWithRed:0.888 green:0.900 blue:0.437 alpha:1.000].CGColor;
    container1.layer.borderWidth = .5f;
    [self.view addSubview:container1];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:container1
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.f
                                                           constant:10.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:container1
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.f
                                                           constant:-10.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:container1
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.f
                                                           constant:100.f]];
    [container1 addConstraint:[NSLayoutConstraint constraintWithItem:container1
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1.f
                                                            constant:60.f]];
    
    UILabel *left1 = [[UILabel alloc] init];
    left1.translatesAutoresizingMaskIntoConstraints = NO;
    left1.text = @"left";
    left1.textColor = [UIColor darkTextColor];
    left1.textAlignment = NSTextAlignmentCenter;
    left1.backgroundColor = [UIColor colorWithRed:0.637 green:0.907 blue:0.907 alpha:0.8];
    [container1 addSubview:left1];
    [container1 addConstraint:[NSLayoutConstraint constraintWithItem:left1
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:container1
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.f
                                                            constant:5.f]];
    [container1 addConstraint:[NSLayoutConstraint constraintWithItem:left1
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:container1
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:.3f
                                                            constant:0.f]];
    [container1 addConstraint:[NSLayoutConstraint constraintWithItem:left1
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:container1
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.f
                                                            constant:5.f]];
    [container1 addConstraint:[NSLayoutConstraint constraintWithItem:left1
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:container1
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.f
                                                            constant:-5.f]];
    
    UILabel *right1 = [[UILabel alloc] init];
    right1.translatesAutoresizingMaskIntoConstraints = NO;
    right1.text = @"right";
    right1.textColor = [UIColor darkTextColor];
    right1.textAlignment = NSTextAlignmentCenter;
    right1.backgroundColor = [UIColor colorWithRed:0.881 green:0.573 blue:0.468 alpha:0.8];
    [container1 addSubview:right1];
    [container1 addConstraint:[NSLayoutConstraint constraintWithItem:right1
                                                           attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:container1
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1.f
                                                            constant:-5.f]];
    [container1 addConstraint:[NSLayoutConstraint constraintWithItem:right1
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:container1
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:.6f
                                                            constant:0.f]];
    [container1 addConstraint:[NSLayoutConstraint constraintWithItem:right1
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:container1
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.f
                                                            constant:5.f]];
    [container1 addConstraint:[NSLayoutConstraint constraintWithItem:right1
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:container1
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.f
                                                            constant:-5.f]];
    
    // cat layout - mix layout/align/pin
    UIView *container2 = [[UIView alloc] init];
    container2.translatesAutoresizingMaskIntoConstraints = NO;
    container2.translatesAutoresizingMaskIntoConstraints = NO;
    container2.layer.borderColor = [UIColor colorWithRed:0.888 green:0.900 blue:0.437 alpha:1.000].CGColor;
    container2.layer.borderWidth = .5f;
    [self.view addSubview:container2];
    [container2.cat_align.left.to(self.view).constant(10.f) set];
    [container2.cat_align.right.to(self.view).constant(-10.f) set];
    [container2.cat_layout.top.equal.bottomOf(container1).constant(50.f) set];
    [container2.cat_pin.height.equal.to(container1) set];
    
    UILabel *left2 = [[UILabel alloc] init];
    left2.translatesAutoresizingMaskIntoConstraints = NO;
    left2.text = @"left";
    left2.textColor = [UIColor darkTextColor];
    left2.textAlignment = NSTextAlignmentCenter;
    left2.backgroundColor = [UIColor colorWithRed:0.637 green:0.907 blue:0.907 alpha:0.8];
    [container2 addSubview:left2];
    [left2.cat_align.left.to(container2).constant(5.f) set];
    [left2.cat_layout.width.equal.multiply(.3f).widthOf(container2) set];
    [left2.cat_align.top.to(container2).constant(5.f) set];
    [left2.cat_align.bottom.to(container2).constant(-5.f) set];
    
    // cat layout - layout only
    UILabel *right2 = [[UILabel alloc] init];
    right2.translatesAutoresizingMaskIntoConstraints = NO;
    right2.text = @"right";
    right2.textColor = [UIColor darkTextColor];
    right2.textAlignment = NSTextAlignmentCenter;
    right2.backgroundColor = [UIColor colorWithRed:0.881 green:0.573 blue:0.468 alpha:0.8];
    [container2 addSubview:right2];
    [right2.cat_layout.right.equal.rightOf(container2).constant(-5.f) set];
    [right2.cat_layout.width.equal.multiply(.6f).widthOf(container2) set];
    [right2.cat_layout.top.equal.topOf(container2).constant(5.f) set];
    [right2.cat_layout.bottom.equal.bottomOf(container2).constant(-5.f) set];
    
    
    // tip label
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    tipLabel.adjustsFontSizeToFitWidth = YES;
    tipLabel.text = @"rotate device to view the effect of auto layout";
    tipLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:tipLabel];
    [tipLabel.cat_align.centerX.to(self.view) set];
    [tipLabel.cat_align.baseline.to(self.view).constant(-50) set];
    [tipLabel.cat_align.leading.equalOrGreater.than(self.view) set];
    [tipLabel.cat_align.trailing.equalOrLess.than(self.view) set];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
