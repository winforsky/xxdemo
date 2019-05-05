//
//  SecondViewController.m
//  XXDemo
//
//  Created by zsp on 2019/4/16.
//  Copyright © 2019 woop. All rights reserved.
//

#import "SecondViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "UIImage+SVGManager.h"
#import <SVGKit.h>

#import <JAMSVGImage/JAMSVGImageView.h>

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UITableView *localNotificationTableView;
@property (nonatomic, strong) NSMutableArray *localNotifications;

@property(nonatomic, strong)AVPlayer *avPlayer;
@property(nonatomic, strong)id timeObserve;


@property(nonatomic, strong)UIImageView *svgImageView;
@property (nonatomic, assign) BOOL isPinGesture;//是否是缩放手势
@property (nonatomic, assign) CGFloat totalScale;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self play];
//        [self loadSVG];
    [self loadLayer];
}

- (void) loadLayer {
    
    UIView *tmpView=[[UIView alloc] initWithFrame:CGRectMake(80, 90, 300, 300)];
    tmpView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:tmpView];
    
    CALayer *commonLayer =  [CALayer layer];
    commonLayer.backgroundColor=[UIColor blueColor].CGColor;
    commonLayer.frame=CGRectMake(0, 0, 80, 120);
    [tmpView.layer insertSublayer:commonLayer atIndex:0];
    
    CALayer *commonLayer00 =  [CALayer layer];
    commonLayer00.backgroundColor=[UIColor orangeColor].CGColor;
    commonLayer00.frame=CGRectMake(-40, -60, 80, 120);
    commonLayer00.anchorPoint=CGPointMake(0, 0);
    
    [tmpView.layer insertSublayer:commonLayer00 atIndex:0];
    
    CALayer *commonLayer01 =  [CALayer layer];
    commonLayer01.backgroundColor=[UIColor purpleColor].CGColor;
    //先设置frame 再设置锚点anchorPoint 会影响最终显示位置position的值
    commonLayer01.frame=CGRectMake(40, 60, 80, 120);
    commonLayer01.anchorPoint=CGPointMake(1, 1);
//    frame.origin.x = position.x - anchorPoint.x * bounds.size.width；
//    frame.origin.y = position.y - anchorPoint.y * bounds.size.height；
    //先设置锚点anchorPoint 再设置frame 不会影响最终显示位置position的值，但会影响旋转时的固定点
    commonLayer01.frame=CGRectMake(40, 60, 80, 120);
    
    [tmpView.layer insertSublayer:commonLayer01 atIndex:0];
    
    /*
     更容易的理解：相对论：
     还是以桌子与白纸为例，如果固定图钉在桌上的位置，也就是positon不变，这个时候图钉处在白纸的不同地方就是不同的anchorPoint，相应地也就是不同的frame。
     另一方面，如果固定图钉在白纸上的位置（没订在桌子上），不管怎么平移白纸，anchorPoint肯定是不变的，但frame肯定是随之变化的
     */
}

- (void)loadSVG {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        imageView.image=[UIImage svgImageNamed:@"70d.svg" size:CGSizeMake(320, 320)];
        imageView.center=self.view.center;
        self.svgImageView=imageView;
        self.svgImageView.userInteractionEnabled=YES;
        [self.view addSubview:self.svgImageView];
    
//    JAMSVGImage *tiger = [JAMSVGImage imageNamed:@"70d"];
//    JAMSVGImageView *tigerImageView = [[JAMSVGImageView alloc] initWithSVGImage:tiger];
//    tigerImageView.frame=CGRectMake(0, 0, 320, 320);
//    tigerImageView.center=self.view.center;
//    tigerImageView.contentMode = UIViewContentModeScaleAspectFit;
//
//    self.svgImageView=tigerImageView;
//    self.svgImageView.userInteractionEnabled=YES;
//    [self.view addSubview:self.svgImageView];
    
    self.totalScale = 1.0;
    [self addPinchGestureToView:self.svgImageView];
}

#pragma mark - GestureRecognizer
- (void)addPinchGestureToView:(UIView *)view {
    UIPinchGestureRecognizer *gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:gesture];
}
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan ) {
        self.isPinGesture = YES;
    }else if (pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat scale = pinchGestureRecognizer.scale;
        //放大情况
        if(scale > 1.0){
            if(self.totalScale > 4.0) return;
        }
        //缩小情况
        if (scale < 1.0) {
            if (self.totalScale < 0.3) return;
        }
        [self setDrewViewScale:scale];
        self.totalScale *=scale;
        pinchGestureRecognizer.scale = 1.0;
    }else if (pinchGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        self.isPinGesture = NO;
        [self showToastAtBottom:[NSString stringWithFormat:@"缩放%.1f倍",self.totalScale]];
    }
}

//设置缩放
- (void)setDrewViewScale:(CGFloat)scale {
    //101画板缩放
    //H5缩放
    //原生网格缩放
    self.svgImageView.transform = CGAffineTransformScale(self.svgImageView.transform, scale, scale);
    
}

- (void)showToastAtBottom:(NSString*)msg {
    NSLog(@"aaa=> %@", msg);
}

- (void)play {
    NSString *urlStr=@"https://betacs.101.com/v0.1/download?dentryId=75dd7973-627b-4dcd-8401-976d6825d563";
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlStr]];
    self.avPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
    self.timeObserve = [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0)
                                                                   queue:dispatch_get_main_queue()
                                                              usingBlock:^(CMTime time) {
                                                                  //当前播放的时间
                                                                  float current = CMTimeGetSeconds(time);
                                                                  //总时间
                                                                  float total = CMTimeGetSeconds(item.duration);
                                                                  NSLog(@"play url URL ===%@", @"addPeriodicTimeObserverForInterval");
                                                              }];
    [self.avPlayer play];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playFinished:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:_avPlayer.currentItem];
}

- (void)playFinished:(id)sender {
    NSLog(@"play url URL ===%@", @"playFinished");
    if (_timeObserve) {
        [self.avPlayer removeTimeObserver:_timeObserve];
        _timeObserve=nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:nil];
    _avPlayer=nil;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)addLocalNotification:(id)sender {
    
}

- (void)makeLocalNotification {
    
}

@end
