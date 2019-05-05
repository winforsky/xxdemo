//
//  LectureStarTipView.m
//  XXDemo
//
//  Created by zsp on 2019/2/22.
//  Copyright © 2019 woop. All rights reserved.
//

#import "LectureStarTipView.h"
#import <Masonry/Masonry.h>

@interface LectureStarTipView ()
@property(nonatomic, strong)UIImageView * tipBgImageView;
@property(nonatomic, strong)UIImageView * tipStarImageView;
@property(nonatomic, strong)UILabel *tipLabel;

@end

@implementation LectureStarTipView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)updateViewWithData:(NSString*)text {
    self.tipLabel.text=text;
    UIImage *tmpImage=[UIImage imageNamed:@"elearning_lecturer_label_bg"];
    self.tipBgImageView.image=[tmpImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setupUI {
    
    self.backgroundColor=[UIColor clearColor];
    self.tipBgImageView=[[UIImageView alloc] init];
    
    [self addSubview:self.tipBgImageView];
    
    self.tipStarImageView=[[UIImageView alloc] init];
    self.tipStarImageView.image=[UIImage imageNamed:@"elearning_lecturer_label_star"];
    [self addSubview:self.tipStarImageView];
    
    self.tipLabel=[[UILabel alloc] init];
//    self.tipLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.tipLabel];
    
    
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(3);
        make.leading.equalTo(self).offset(40);
        make.trailing.equalTo(self).offset(-10);
    }];
    
    [self.tipStarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(14);
//        make.trailing.equalTo(self.tipLabel.mas_leading).offset(-5);
        make.centerY.equalTo(self.tipLabel);
        make.width.height.mas_equalTo(22);
    }];
    
    [self.tipBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    return YES;
}

@end
