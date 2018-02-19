//
//  ViewController3.m
//  rtspStream
//
//  Created by AllanChen on 2018/2/13.
//  Copyright © 2018年 allanChen. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()  <VLCMediaPlayerDelegate>

@end

@implementation ViewController3
{
    VLCMediaPlayer *vlcMediaPlayer;
    BOOL _setPosition;
}

- (IBAction)stopAndStart:(id)sender {
    if(vlcMediaPlayer.isPlaying ){
        [vlcMediaPlayer pause];
        [self.btnStart setTitle:@"play" forState:UIControlStateNormal];
    }
    else{
        [vlcMediaPlayer play];
        [self.btnStart setTitle:@"pause" forState:UIControlStateNormal];
    }
}
- (IBAction)videoStop:(id)sender {
    [vlcMediaPlayer stop];
}

- (IBAction)ProcessSliderAction:(UISlider *)sender
{
    // [self _resetIdleTimer];
    
    /* we need to limit the number of events sent by the slider, since otherwise, the user
     * wouldn't see the I-frames when seeking on current mobile devices. This isn't a problem
     * within the Simulator, but especially on older ARMv7 devices, it's clearly noticeable. */
    [self performSelector:@selector(SetPositionForReal) withObject:nil afterDelay:0.3];
    _setPosition = NO;
}

- (void)SetPositionForReal
{
    if (!_setPosition) {
        vlcMediaPlayer.position = self.processSlider.value;
        _setPosition = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"3");
    
    self.imgView = [[UIImageView alloc] init];
    
    self.imgView.frame = CGRectMake(0,self.view.frame.size.height/2 - 400/2,self.view.frame.size.width,400);
    
    self.processSlider = [[UISlider alloc]init];
    self.processSlider.frame = CGRectMake(120, self.view.frame.size.height - 85 , self.view.frame.size.width - 140, 21);
    [self.view addSubview: self.processSlider];
    [self.processSlider addTarget:self action:@selector(ProcessSliderAction:) forControlEvents:UIControlEventValueChanged];
    
    // Initialize media player
    vlcMediaPlayer = [[VLCMediaPlayer alloc] init];
    vlcMediaPlayer.delegate = self;
    vlcMediaPlayer.drawable = self.imgView;
    
    [self.view addSubview:self.imgView];
    
    /* listen for notifications from the player */
    [vlcMediaPlayer addObserver:self forKeyPath:@"time" options:0 context:nil];
    [vlcMediaPlayer addObserver:self forKeyPath:@"remainingTime" options:0 context:nil];
    [vlcMediaPlayer addObserver:self forKeyPath:@"state" options:0 context:nil];
    // Do any additional setup after loading the view.
    
    NSString* strUrl = [NSString stringWithFormat:@"rtsp://184.72.239.149/vod/mp4:BigBuckBunny_175k.mov"];
    vlcMediaPlayer.media = [VLCMedia mediaWithURL:[NSURL URLWithString:strUrl]];
    
    [vlcMediaPlayer play];
    [self.btnStart setTitle:@"pause" forState:UIControlStateNormal];
    [self.btnStop setTitle:@"stop" forState:UIControlStateNormal];

}

- (void)viewDidAppear:(BOOL)animated
{}

- (void)viewWillDisappear:(BOOL)animated
{
    [vlcMediaPlayer pause];
    NSLog(@"viewwillDisappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
#pragma mark media handling
    NSLog(@"%@",keyPath);
    if([keyPath isEqualToString:@"state"]){
        NSLog(@"%@",VLCMediaPlayerStateToString([vlcMediaPlayer state]));
    }
    /*if([keyPath isEqualToString:@"state"]){
     NSLog(@"observeValueForKeyPath");
     VLCMediaPlayerState curState = [_mediaPlayer state];
     NSLog(@"%ld",curState);
     if(curState == VLCMediaPlayerStateError)
     {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Error!" delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
     [alert show];
     }
     if(curState == VLCMediaPlayerStateStopped || curState == VLCMediaPlayerStateEnded)
     {
     [self GetPlaybackFilePath:_idxPlayList];
     UIButton *btn = (UIButton*)[_footerPanel viewWithTag:1];
     [btn setImage:[UIImage imageNamed:@"btn_PB_play_n.png"] forState:UIControlStateNormal];
     [btn setImage:[UIImage imageNamed:@"btn_PB_play_h.png"] forState:UIControlStateHighlighted];
     btn = (UIButton*)[_footerLandPanel viewWithTag:1];
     [btn setImage:[UIImage imageNamed:@"btn_PB_play_n.png"] forState:UIControlStateNormal];
     [btn setImage:[UIImage imageNamed:@"btn_PB_play_h.png"] forState:UIControlStateHighlighted];
     
     // Loading settings
     settingObj = [SettingObject settingObjectFromData:[dicNVR objectForKey:@"setting_info"]];
     // Prevent screen will be locked when this app is running
     if(settingObj.lockScreen)
     [UIApplication sharedApplication].idleTimerDisabled = YES;
     else
     [UIApplication sharedApplication].idleTimerDisabled = NO;
     }
     if(curState == VLCMediaPlayerStatePaused)
     {
     // Loading settings
     settingObj = [SettingObject settingObjectFromData:[dicNVR objectForKey:@"setting_info"]];
     // Prevent screen will be locked when this app is running
     if(settingObj.lockScreen)
     [UIApplication sharedApplication].idleTimerDisabled = YES;
     else
     [UIApplication sharedApplication].idleTimerDisabled = NO;
     }
     return ;
     }
     
     self.positionSlider.value = [_mediaPlayer position];
     // _timeDisplay.text = [[_mediaPlayer time] stringValue];
     NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
     [_dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
     NSDate *date = [_dateFormatter dateFromString:_strFileTime];
     _timeDisplay.text = [_dateFormatter stringFromDate:[date dateByAddingTimeInterval:([[_mediaPlayer time] intValue] / 1000)]];*/
}

-(void) setUpView
{
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

