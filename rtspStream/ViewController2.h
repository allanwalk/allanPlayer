//
//  ViewController2.h
//  rtspStream
//
//  Created by AllanChen on 2018/2/13.
//  Copyright © 2018年 allanChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileVLCKit/MobileVLCKit.h>

@interface ViewController2 : UIViewController
@property (nonatomic, strong) IBOutlet UIImageView *imgView;//*imgMovieView;
@property (nonatomic, strong) IBOutlet UISlider *processSlider;
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UIButton *btnStop;
@property (weak, nonatomic) IBOutlet UIButton *btnVideoSwitch;

@end
