//
//  UIView+CATLayout.h
//  CATLayout
//
//  Created by wit on 15/1/8.
//  Copyright (c) 2015年 cat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CATLayout, CATPin, CATAlign;

@interface UIView (CATLayout)
/**
 create an instance of layout builder
 @return auto layout constraint builder
 */
- (CATLayout *)cat_layout;
/**
 create an instance of pin builder
 @return auto layout constraint builder
 */
- (CATPin *)cat_pin;
/**
 create an instance of align builder
 @return auto layout constraint builder
 */
- (CATAlign *)cat_align;
@end

#pragma mark - builder
/** abstract auto layout constraint builder */
@interface CATConstraintBuilder : NSObject <NSCopying>

#pragma mark reverse
/** create a builder that reverse from-to attributes/relation/multiply/constant */
- (instancetype)reverse;

#pragma mark builder
/**
 build the constraint
 @return constraint
 @sa -set, -setInView.
 */
- (NSLayoutConstraint *)constraint;
/**
 build and add the constraint to the nearest common ancestor of fromView and toView
 @sa -constraint, -setInView.
 @return constraint
 */
- (NSLayoutConstraint *)set;
/**
 build and add the constraint to the container
 @param container   the view to add the constraint
 @return constraint
 @sa -constraint, -set.
 */
- (NSLayoutConstraint *)setInView:(UIView *)container;
@end

#pragma mark - layout
/** 
 auto layout constraint builder using chaining pattern 
 
 syntax:
 
 cat_layout.<from attribute>.<relation>.<multiply(multiplier)>.<to attribute of view>.<constant(offset)>
 */
@interface CATLayout : CATConstraintBuilder

#pragma mark from
/** set from attribute to width */
@property (nonatomic, readonly) CATLayout *width;
/** set from attribute to height */
@property (nonatomic, readonly) CATLayout *height;

/** set from attribute to left */
@property (nonatomic, readonly) CATLayout *left;
/** set from attribute to right */
@property (nonatomic, readonly) CATLayout *right;
/** set from attribute to top */
@property (nonatomic, readonly) CATLayout *top;
/** set from attribute to bottom */
@property (nonatomic, readonly) CATLayout *bottom;

/** set from attribute to leading */
@property (nonatomic, readonly) CATLayout *leading;
/** set from attribute to trailing */
@property (nonatomic, readonly) CATLayout *trailing;
/** set from attribute to baseline */
@property (nonatomic, readonly) CATLayout *baseline;

/** set from attribute to centerX */
@property (nonatomic, readonly) CATLayout *centerX;
/** set from attribute to centerY */
@property (nonatomic, readonly) CATLayout *centerY;

/** set from attribute to leftMargin */
@property (nonatomic, readonly) CATLayout *leftMargin       NS_AVAILABLE_IOS(8_0);
/** set from attribute to rightMargin */
@property (nonatomic, readonly) CATLayout *rightMargin      NS_AVAILABLE_IOS(8_0);
/** set from attribute to topMargin */
@property (nonatomic, readonly) CATLayout *topMargin        NS_AVAILABLE_IOS(8_0);
/** set from attribute to bottomMargin */
@property (nonatomic, readonly) CATLayout *bottomMargin     NS_AVAILABLE_IOS(8_0);

/** set from attribute to leadingMargin */
@property (nonatomic, readonly) CATLayout *leadingMargin    NS_AVAILABLE_IOS(8_0);
/** set from attribute to trailingMargin */
@property (nonatomic, readonly) CATLayout *trailingMargin   NS_AVAILABLE_IOS(8_0);

/** set from attribute to centerXMargin */
@property (nonatomic, readonly) CATLayout *centerXMargin    NS_AVAILABLE_IOS(8_0);
/** set from attribute to centerYMargin */
@property (nonatomic, readonly) CATLayout *centerYMargin    NS_AVAILABLE_IOS(8_0);

#pragma mark relation
/** set from attribute to equal */
@property (nonatomic, readonly) CATLayout *equal;
/** set from attribute to equal or greater than */
@property (nonatomic, readonly) CATLayout *equalOrGreater;
/** set from attribute to equal or less than */
@property (nonatomic, readonly) CATLayout *equalOrLess;

#pragma mark to
/** set to attribute to width of view */
@property (nonatomic, readonly) CATLayout *(^widthOf)(UIView *view);
/** set to attribute to height of view */
@property (nonatomic, readonly) CATLayout *(^heightOf)(UIView *view);

/** set to attribute to left of view */
@property (nonatomic, readonly) CATLayout *(^leftOf)(UIView *view);
/** set to attribute to right of view */
@property (nonatomic, readonly) CATLayout *(^rightOf)(UIView *view);
/** set to attribute to top of view */
@property (nonatomic, readonly) CATLayout *(^topOf)(UIView *view);
/** set to attribute to bottom of view */
@property (nonatomic, readonly) CATLayout *(^bottomOf)(UIView *view);

/** set to attribute to leading of view */
@property (nonatomic, readonly) CATLayout *(^leadingOf)(UIView *view);
/** set to attribute to trailing of view */
@property (nonatomic, readonly) CATLayout *(^trailingOf)(UIView *view);
/** set to attribute to baseline of view */
@property (nonatomic, readonly) CATLayout *(^baselineOf)(UIView *view);

/** set to attribute to centerX of view */
@property (nonatomic, readonly) CATLayout *(^centerXOf)(UIView *view);
/** set to attribute to centerY of view */
@property (nonatomic, readonly) CATLayout *(^centerYOf)(UIView *view);

/** set to attribute to leftMargin of view */
@property (nonatomic, readonly) CATLayout *(^leftMarginOf)(UIView *view)        NS_AVAILABLE_IOS(8_0);
/** set to attribute to rightMargin of view */
@property (nonatomic, readonly) CATLayout *(^rightMarginOf)(UIView *view)       NS_AVAILABLE_IOS(8_0);
/** set to attribute to topMargin of view */
@property (nonatomic, readonly) CATLayout *(^topMarginOf)(UIView *view)         NS_AVAILABLE_IOS(8_0);
/** set to attribute to bottomMargin of view */
@property (nonatomic, readonly) CATLayout *(^bottomMarginOf)(UIView *view)      NS_AVAILABLE_IOS(8_0);

/** set to attribute to leadingMargin of view */
@property (nonatomic, readonly) CATLayout *(^leadingMarginOf)(UIView *view)     NS_AVAILABLE_IOS(8_0);
/** set to attribute to trailingMargin of view */
@property (nonatomic, readonly) CATLayout *(^trailingMarginOf)(UIView *view)    NS_AVAILABLE_IOS(8_0);

/** set to attribute to centerXMargin of view */
@property (nonatomic, readonly) CATLayout *(^centerXMarginOf)(UIView *view)     NS_AVAILABLE_IOS(8_0);
/** set to attribute to centerYMargin of view */
@property (nonatomic, readonly) CATLayout *(^centerYMarginOf)(UIView *view)     NS_AVAILABLE_IOS(8_0);

#pragma mark multiply/constant/priority/identifier
/** set multiplier to the parameter of the block */
@property (nonatomic, readonly) CATLayout *(^multiply)(CGFloat multiplier);
/** set constant to the parameter of the block */
@property (nonatomic, readonly) CATLayout *(^constant)(CGFloat constant);
/** set priority to the parameter of the block */
@property (nonatomic, readonly) CATLayout *(^prior)(UILayoutPriority priority);
/** set identifier to the parameter of the block */
@property (nonatomic, readonly) CATLayout *(^identify)(NSString *identifier);
@end

#pragma mark - pin
/**
 auto layout constraint builder using chaining pattern
 
 syntax:
 
 cat_pin.<width or height>.<relation>.<multiply(multiplier)>.<to/than(view)>.<constant(offset)>
 */
@interface CATPin : CATConstraintBuilder
#pragma mark from & to attribute
/** set from & to attribute to width */
@property (nonatomic, readonly) CATPin *width;
/** set from & to attribute to height */
@property (nonatomic, readonly) CATPin *height;

#pragma mark relation 
/** set from attribute to equal */
@property (nonatomic, readonly) CATPin *equal;
/** set from attribute to equal or greater than */
@property (nonatomic, readonly) CATPin *equalOrGreater;
/** set from attribute to equal or less than */
@property (nonatomic, readonly) CATPin *equalOrLess;

#pragma mark toView
/** set toView to the parameter of the block */
@property (nonatomic, readonly) CATPin *(^to)(UIView *view);
/** set toView to the parameter of the block */
@property (nonatomic, readonly) CATPin *(^than)(UIView *view);

#pragma mark multiply/constant/priority/identifier
/** set multiplier to the parameter of the block */
@property (nonatomic, readonly) CATPin *(^multiply)(CGFloat multiplier);
/** set constant to the parameter of the block */
@property (nonatomic, readonly) CATPin *(^constant)(CGFloat constant);
/** set priority to the parameter of the block */
@property (nonatomic, readonly) CATPin *(^prior)(UILayoutPriority priority);
/** set identifier to the parameter of the block */
@property (nonatomic, readonly) CATPin *(^identify)(NSString *identifier);
@end

#pragma mark - align
/**
 auto layout constraint builder using chaining pattern
 
 syntax:
 
 cat_align.<attribute>.<relation>.<to/than(view)>.<constant(offset)>
 */
@interface CATAlign : CATConstraintBuilder
#pragma mark from & to attribute
/** set from & to attribute to left */
@property (nonatomic, readonly) CATAlign *left;
/** set from & to attribute to right */
@property (nonatomic, readonly) CATAlign *right;
/** set from & to attribute to top */
@property (nonatomic, readonly) CATAlign *top;
/** set from & to attribute to bottom */
@property (nonatomic, readonly) CATAlign *bottom;

/** set from & to attribute to leading */
@property (nonatomic, readonly) CATAlign *leading;
/** set from & to attribute to trailing */
@property (nonatomic, readonly) CATAlign *trailing;
/** set from & to attribute to baseline */
@property (nonatomic, readonly) CATAlign *baseline;

/** set from & to attribute to centerX */
@property (nonatomic, readonly) CATAlign *centerX;
/** set from & to attribute to centerY */
@property (nonatomic, readonly) CATAlign *centerY;

/** set from & to attribute to leftMargin */
@property (nonatomic, readonly) CATAlign *leftMargin      NS_AVAILABLE_IOS(8_0);
/** set from & to attribute to rightMargin */
@property (nonatomic, readonly) CATAlign *rightMargin     NS_AVAILABLE_IOS(8_0);
/** set from & to attribute to topMargin */
@property (nonatomic, readonly) CATAlign *topMargin       NS_AVAILABLE_IOS(8_0);
/** set from & to attribute to bottomMargin */
@property (nonatomic, readonly) CATAlign *bottomMargin    NS_AVAILABLE_IOS(8_0);

/** set from & to attribute to leadingMargin */
@property (nonatomic, readonly) CATAlign *leadingMargin   NS_AVAILABLE_IOS(8_0);
/** set from & to attribute to trailingMargin */
@property (nonatomic, readonly) CATAlign *trailingMargin  NS_AVAILABLE_IOS(8_0);

/** set from & to attribute to centerXMargin */
@property (nonatomic, readonly) CATAlign *centerXMargin   NS_AVAILABLE_IOS(8_0);
/** set from & to attribute to centerYMargin */
@property (nonatomic, readonly) CATAlign *centerYMargin   NS_AVAILABLE_IOS(8_0);

#pragma mark relation
/** set from attribute to equal */
@property (nonatomic, readonly) CATAlign *equal;
/** set from attribute to equal or greater than */
@property (nonatomic, readonly) CATAlign *equalOrGreater;
/** set from attribute to equal or less than */
@property (nonatomic, readonly) CATAlign *equalOrLess;

#pragma mark toView
/** set toView to the parameter of the block */
@property (nonatomic, readonly) CATAlign *(^to)(UIView *view);
/** set toView to the parameter of the block */
@property (nonatomic, readonly) CATAlign *(^than)(UIView *view);

#pragma mark multiply/constant/priority/identifier
/** set constant to the parameter of the block; however multiply is meaning less in alignment */
@property (nonatomic, readonly) CATAlign *(^multiply)(CGFloat multiplier);
/** set constant to the parameter of the block */
@property (nonatomic, readonly) CATAlign *(^constant)(CGFloat constant);
/** set priority to the parameter of the block */
@property (nonatomic, readonly) CATAlign *(^prior)(UILayoutPriority priority);
/** set identifier to the parameter of the block */
@property (nonatomic, readonly) CATAlign *(^identify)(NSString *identifier);
@end
