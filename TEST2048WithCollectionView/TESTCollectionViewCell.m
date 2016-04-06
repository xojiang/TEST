//
//  TESTCollectionViewCell.m
//  TEST2048WithCollectionView
//
//  Created by renren on 16/3/4.
//  Copyright © 2016年 renren. All rights reserved.
//

#import "TESTCollectionViewCell.h"

@interface TESTCollectionViewCell ()

@property (nonatomic, strong) UILabel * numLabel;

@end

@implementation TESTCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    self.contentView.backgroundColor = [UIColor yellowColor];
    self.numLabel = [UILabel new];
    self.numLabel.font = [UIFont boldSystemFontOfSize:30.f];
    self.numLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.numLabel];
}

- (void)setItem:(NSNumber *)item {
    self.numLabel.hidden = [item isEqualToNumber:@(0)];
    self.numLabel.text = item.stringValue;
    [self.numLabel sizeToFit];
    self.numLabel.center = CGPointMake(self.frame.size.width / 2, self.frame.size.width / 2);
}

- (void)setAnimate {
    self.contentView.alpha = 0.2f;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1.f animations:^{
        weakSelf.contentView.alpha = 1.f;
    }];
}

@end
