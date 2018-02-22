//
//  ViewControllerRTSPStream.h
//  rtspStream
//
//  Created by AllanChen on 2018/2/13.
//  Copyright © 2018年 allanChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileVLCKit/MobileVLCKit.h>

@interface ViewControllerRTSPStream : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *imgView;//*imgMovieView;
@property (nonatomic, strong) IBOutlet UISlider *processSlider;
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UIButton *btnStop;
@property (weak, nonatomic) IBOutlet UITextField *textUrl;
@property (weak, nonatomic) IBOutlet UIButton *btnUrlUpdate;

@end
