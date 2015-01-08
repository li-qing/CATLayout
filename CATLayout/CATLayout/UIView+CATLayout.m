//
//  UIView+CATLayout.m
//  CATLayout
//
//  Created by wit on 15/1/8.
//  Copyright (c) 2015年 cat. All rights reserved.
//

#import "UIView+CATLayout.h"

#pragma mark - builder
@interface CATConstraintBuilder ()
@property (nonatomic, weak)     UIView *fromView;
@property (nonatomic, assign)   NSLayoutAttribute fromAttribute;
@property (nonatomic, weak)     UIView *toView;
@property (nonatomic, assign)   NSLayoutAttribute toAttribute;
@property (nonatomic, assign)   NSLayoutRelation relation;
@property (nonatomic, assign)   CGFloat multiplier;
@property (nonatomic, assign)   CGFloat constantValue;
@property (nonatomic, assign)   UILayoutPriority priority;
@property (nonatomic, copy)     NSString *identifier;
@end

@implementation CATConstraintBuilder
#pragma mark life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.multiplier = 1.f;
        self.priority = UILayoutPriorityRequired;
    }
    return self;
}

#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone {
    CATLayout *copy = [[[self class] allocWithZone:zone] init];
    copy.fromView = _fromView;
    copy.fromAttribute = _fromAttribute;
    copy.toView = _toView;
    copy.toAttribute = _toAttribute;
    copy.relation = _relation;
    copy.multiplier = _multiplier;
    copy.constantValue = _constantValue;
    copy.priority = _priority;
    copy.identifier = _identifier;
    return copy;
}

#pragma mark reverse
- (instancetype)reverse {
    CATConstraintBuilder *reverse = [self copy];
    
    // from - to
    reverse.fromView = _toView;
    reverse.fromAttribute = _toAttribute;
    reverse.toView = _fromView;
    reverse.toAttribute = _fromAttribute;
    
    // relation
    switch (_relation) {
        case NSLayoutRelationGreaterThanOrEqual:
            reverse.relation = NSLayoutRelationLessThanOrEqual;
            break;
        case NSLayoutRelationLessThanOrEqual:
            reverse.relation = NSLayoutRelationGreaterThanOrEqual;
            break;
        case NSLayoutRelationEqual:
        default:
            // copy as equal
            break;
    }
    
    // multiplier & constant
    // from = to * multiplier + constant
    // to   = from / multiplier - constant / multiplier
    // multiplier'  = 1 / multiplier
    // constant'    = - constant * multiplier'
    reverse.multiplier = _multiplier == 0 ? 0 : 1 / _multiplier;
    reverse.constantValue = -_constantValue * reverse.multiplier;
    
    return self;
}

#pragma mark build
- (NSLayoutConstraint *)constraint {
    return [NSLayoutConstraint constraintWithItem:_fromView
                                        attribute:_fromAttribute
                                        relatedBy:_relation
                                           toItem:_toView
                                        attribute:_toAttribute
                                       multiplier:_multiplier
                                         constant:_constantValue];
}

- (NSArray *)cat_ancestorOfView:(UIView *)view {
    NSMutableArray *result = [NSMutableArray array];
    UIView *cursor = view;
    while (cursor.superview) {
        [result addObject:cursor.superview];
        cursor = cursor.superview;
    }
    return result;
}

- (NSLayoutConstraint *)set {
    // single view
    if (!_toView || _fromView == _toView) {
        return [self setInView:_fromView];
    }
    
    // descendant available
    if ([_fromView isDescendantOfView:_toView]) {
        return [self setInView:_toView];
    }
    if ([_toView isDescendantOfView:_fromView]) {
        return [self setInView:_fromView];
    }
    
    // search for common ancestor
    NSArray *fromAncestors = [self cat_ancestorOfView:_fromView];
    NSArray *toAncestors = [self cat_ancestorOfView:_toView];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self In %@", toAncestors];
    NSArray *common = [fromAncestors filteredArrayUsingPredicate:predicate];
    return [self setInView:[common firstObject]];
}

- (NSLayoutConstraint *)setInView:(UIView *)container {
    NSLayoutConstraint *constraint = [self constraint];
    [container addConstraint:constraint];
    return constraint;
}

@end

#pragma mark - category
@implementation UIView (CATLayout)
- (CATLayout *)cat_layout {
    CATLayout *layout = [[CATLayout alloc] init];
    layout.fromView = self;
    return layout;
}
- (CATPin *)cat_pin {
    CATPin *pin = [[CATPin alloc] init];
    pin.fromView = self;
    return pin;
}
- (CATAlign *)cat_align {
    CATAlign *align = [[CATAlign alloc] init];
    align.fromView = self;
    return align;
}
@end

#pragma mark - layout
@implementation CATLayout

#pragma mark from
- (CATLayout *)width {
    self.fromAttribute = NSLayoutAttributeWidth;
    return self;
}
- (CATLayout *)height {
    self.fromAttribute = NSLayoutAttributeHeight;
    return self;
}

- (CATLayout *)left {
    self.fromAttribute = NSLayoutAttributeLeft;
    return self;
}
- (CATLayout *)right {
    self.fromAttribute = NSLayoutAttributeRight;
    return self;
}
- (CATLayout *)top {
    self.fromAttribute = NSLayoutAttributeTop;
    return self;
}
- (CATLayout *)bottom {
    self.fromAttribute = NSLayoutAttributeBottom;
    return self;
}

- (CATLayout *)leading {
    self.fromAttribute = NSLayoutAttributeLeading;
    return self;
}
- (CATLayout *)trailing {
    self.fromAttribute = NSLayoutAttributeTrailing;
    return self;
}
- (CATLayout *)baseline {
    self.fromAttribute = NSLayoutAttributeBaseline;
    return self;
}

- (CATLayout *)centerX {
    self.fromAttribute = NSLayoutAttributeCenterX;
    return self;
}
- (CATLayout *)centerY {
    self.fromAttribute = NSLayoutAttributeCenterY;
    return self;
}

- (CATLayout *)leftMargin {
    self.fromAttribute = NSLayoutAttributeLeftMargin;
    return self;
}
- (CATLayout *)rightMargin {
    self.fromAttribute = NSLayoutAttributeRightMargin;
    return self;
}
- (CATLayout *)topMargin {
    self.fromAttribute = NSLayoutAttributeTopMargin;
    return self;
}
- (CATLayout *)bottomMargin {
    self.fromAttribute = NSLayoutAttributeBottomMargin;
    return self;
}

- (CATLayout *)leadingMargin {
    self.fromAttribute = NSLayoutAttributeLeadingMargin;
    return self;
}
- (CATLayout *)trailingMargin {
    self.fromAttribute = NSLayoutAttributeTrailingMargin;
    return self;
}

- (CATLayout *)centerXMargin {
    self.fromAttribute = NSLayoutAttributeCenterXWithinMargins;
    return self;
}
- (CATLayout *)centerYMargin {
    self.fromAttribute = NSLayoutAttributeCenterYWithinMargins;
    return self;
}

#pragma mark relation
- (CATLayout *)equal {
    self.relation = NSLayoutRelationEqual;
    return self;
}
- (CATLayout *)equalOrGreater {
    self.relation = NSLayoutRelationGreaterThanOrEqual;
    return self;
}
- (CATLayout *)equalOrLess {
    self.relation = NSLayoutRelationLessThanOrEqual;
    return self;
}

#pragma mark to
- (CATLayout *(^)(UIView *))widthOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeWidth;
        return self;
    };
}
- (CATLayout *(^)(UIView *))heightOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeHeight;
        return self;
    };
}

- (CATLayout *(^)(UIView *))leftOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeLeft;
        return self;
    };
}
- (CATLayout *(^)(UIView *))rightOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeRight;
        return self;
    };
}
- (CATLayout *(^)(UIView *))topOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeTop;
        return self;
    };
}
- (CATLayout *(^)(UIView *))bottomOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeBottom;
        return self;
    };
}

- (CATLayout *(^)(UIView *))leadingOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeLeading;
        return self;
    };
}
- (CATLayout *(^)(UIView *))trailingOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeTrailing;
        return self;
    };
}
- (CATLayout *(^)(UIView *))baselineOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeBaseline;
        return self;
    };
}

- (CATLayout *(^)(UIView *))centerXOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeCenterX;
        return self;
    };
}
- (CATLayout *(^)(UIView *))centerYOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeCenterY;
        return self;
    };
}

- (CATLayout *(^)(UIView *))leftMarginOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeLeftMargin;
        return self;
    };
}
- (CATLayout *(^)(UIView *))rightMarginOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeRightMargin;
        return self;
    };
}
- (CATLayout *(^)(UIView *))topMarginOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeTopMargin;
        return self;
    };
}
- (CATLayout *(^)(UIView *))bottomMarginOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeBottomMargin;
        return self;
    };
}

- (CATLayout *(^)(UIView *))leadingMarginOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeLeadingMargin;
        return self;
    };
}
- (CATLayout *(^)(UIView *))trailingMarginOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeTrailingMargin;
        return self;
    };
}

- (CATLayout *(^)(UIView *))centerXMarginOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeCenterXWithinMargins;
        return self;
    };
}
- (CATLayout *(^)(UIView *))centerYMarginOf {
    return ^(UIView *view) {
        self.toView = view;
        self.toAttribute = NSLayoutAttributeCenterYWithinMargins;
        return self;
    };
}

#pragma mark multiply/constant/priority/identifier
- (CATLayout *(^)(CGFloat))multiply {
    return ^(CGFloat multiplier) {
        self.multiplier = multiplier;
        return self;
    };
}
- (CATLayout *(^)(CGFloat))constant {
    return ^(CGFloat constantValue) {
        self.constantValue = constantValue;
        return self;
    };
}
- (CATLayout *(^)(UILayoutPriority))prior {
    return ^(UILayoutPriority priority) {
        self.priority = priority;
        return self;
    };
}
- (CATLayout *(^)(NSString *))identify {
    return ^(NSString *identifier) {
        self.identifier = identifier;
        return self;
    };
}
@end

#pragma mark - pin
@implementation CATPin
#pragma mark from & to attribute
- (CATPin *)width {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeWidth;
    return self;
}
- (CATPin *)height {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeHeight;
    return self;
}

#pragma mark relation
- (CATPin *)equal {
    self.relation = NSLayoutRelationEqual;
    return self;
}
- (CATPin *)equalOrGreater {
    self.relation = NSLayoutRelationGreaterThanOrEqual;
    return self;
}
- (CATPin *)equalOrLess {
    self.relation = NSLayoutRelationLessThanOrEqual;
    return self;
}

#pragma mark toView
- (CATPin *(^)(UIView *))to {
    return ^(UIView *view) {
        self.toView = view;
        return self;
    };
}
- (CATPin *(^)(UIView *))than {
    return ^(UIView *view) {
        self.toView = view;
        return self;
    };
}

#pragma mark multiply/constant/priority/identifier
- (CATPin *(^)(CGFloat))multiply {
    return ^(CGFloat multiplier) {
        self.multiplier = multiplier;
        return self;
    };
}
- (CATPin *(^)(CGFloat))constant {
    return ^(CGFloat constantValue) {
        self.constantValue = constantValue;
        return self;
    };
}
- (CATPin *(^)(UILayoutPriority))prior {
    return ^(UILayoutPriority priority) {
        self.priority = priority;
        return self;
    };
}
- (CATPin *(^)(NSString *))identify {
    return ^(NSString *identifier) {
        self.identifier = identifier;
        return self;
    };
}
@end

#pragma mark align
@implementation CATAlign
#pragma mark from & to attribute
- (CATAlign *)left {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeLeft;
    return self;
}
- (CATAlign *)right {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeRight;
    return self;
}
- (CATAlign *)top {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeTop;
    return self;
}
- (CATAlign *)bottom {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeBottom;
    return self;
}

- (CATAlign *)leading {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeLeading;
    return self;
}
- (CATAlign *)trailing {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeTrailing;
    return self;
}
- (CATAlign *)baseline {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeBaseline;
    return self;
}

- (CATAlign *)centerX {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeCenterX;
    return self;
}
- (CATAlign *)centerY {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeCenterY;
    return self;
}

- (CATAlign *)leftMargin {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeLeftMargin;
    return self;
}
- (CATAlign *)rightMargin {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeRightMargin;
    return self;
}
- (CATAlign *)topMargin {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeTopMargin;
    return self;
}
- (CATAlign *)bottomMargin {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeBottomMargin;
    return self;
}

- (CATAlign *)leadingMargin {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeLeadingMargin;
    return self;
}
- (CATAlign *)trailingMargin {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeTrailingMargin;
    return self;
}

- (CATAlign *)centerXMargin {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeCenterXWithinMargins;
    return self;
}
- (CATAlign *)centerYMargin {
    self.fromAttribute = self.toAttribute = NSLayoutAttributeCenterYWithinMargins;
    return self;
}

#pragma mark relation
- (CATAlign *)equal {
    self.relation = NSLayoutRelationEqual;
    return self;
}
- (CATAlign *)equalOrGreater {
    self.relation = NSLayoutRelationGreaterThanOrEqual;
    return self;
}
- (CATAlign *)equalOrLess {
    self.relation = NSLayoutRelationLessThanOrEqual;
    return self;
}

#pragma mark toView
- (CATAlign *(^)(UIView *))to {
    return ^(UIView *view) {
        self.toView = view;
        return self;
    };
}
- (CATAlign *(^)(UIView *))than {
    return ^(UIView *view) {
        self.toView = view;
        return self;
    };
}

#pragma mark multiply/constant/priority/identifier
- (CATAlign *(^)(CGFloat))multiply {
    return ^(CGFloat multiplier) {
        self.multiplier = multiplier;
        return self;
    };
}
- (CATAlign *(^)(CGFloat))constant {
    return ^(CGFloat constantValue) {
        self.constantValue = constantValue;
        return self;
    };
}
- (CATAlign *(^)(UILayoutPriority))prior {
    return ^(UILayoutPriority priority) {
        self.priority = priority;
        return self;
    };
}
- (CATAlign *(^)(NSString *))identify {
    return ^(NSString *identifier) {
        self.identifier = identifier;
        return self;
    };
}
@end
