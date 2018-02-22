//
//  ViewControllerRTSPStream.m
//  rtspStream
//
//  Created by AllanChen on 2018/2/13.
//  Copyright © 2018年 allanChen. All rights reserved.
//

#import "ViewControllerRTSPStream.h"

@interface ViewControllerRTSPStream ()  <VLCMediaPlayerDelegate>

@end

@implementation ViewControllerRTSPStream
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
    //self.processSlider.value =0.0;
    [vlcMediaPlayer stop];
}
- (IBAction)updateUrlAndPlay:(id)sender {
    //[vlcMediaPlayer stop];
    
    vlcMediaPlayer.media = [VLCMedia mediaWithURL:[NSURL URLWithString:self.textUrl.text]];
    [vlcMediaPlayer play];
    [self.btnStart setTitle:@"pause" forState:UIControlStateNormal];
    [self.btnStop setTitle:@"stop" forState:UIControlStateNormal];
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
        //vlcMediaPlayer.position = self.processSlider.value;
        _setPosition = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
    
    NSLog(@"3");
    
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
    [self.textUrl setText:strUrl];
    
    [vlcMediaPlayer play];
    [self.btnStart setTitle:@"pause" forState:UIControlStateNormal];
    [self.btnStop setTitle:@"stop" forState:UIControlStateNormal];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [vlcMediaPlayer stop];
    
    if(vlcMediaPlayer)
    {
        if(vlcMediaPlayer.media)
            [vlcMediaPlayer stop];
        
        @try {
            [vlcMediaPlayer removeObserver:self forKeyPath:@"time"];
            [vlcMediaPlayer removeObserver:self forKeyPath:@"remainingTime"];
            [vlcMediaPlayer removeObserver:self forKeyPath:@"state"];
        }
        @catch (NSException *exception) {
            NSLog(@"we weren't an observer yet");
        }
        
        if(vlcMediaPlayer)
        {
            vlcMediaPlayer.delegate = nil;
            vlcMediaPlayer = nil;
        }
    }
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
}

-(void) setUpView
{
    self.view.backgroundColor = [UIColor blackColor];
    self.imgView = [[UIImageView alloc] init];
    
    self.imgView.frame = CGRectMake(0,self.view.frame.size.height/2 - 400/2,self.view.frame.size.width,400);
    
    [self.btnUrlUpdate setTitle:@"mediaURL" forState:UIControlStateNormal];
    [self.btnUrlUpdate.layer setCornerRadius:10]; //设置半径
    [self.btnUrlUpdate.layer setBorderWidth:1.0]; //边框宽度
    [self.btnStart.layer setCornerRadius:10]; //设置半径
    [self.btnStart.layer setBorderWidth:1.0]; //边框宽度
    [self.btnStop.layer setCornerRadius:10]; //设置半径
    [self.btnStop.layer setBorderWidth:1.0]; //边框宽度
    
    /*self.processSlider = [[UISlider alloc]init];
    self.processSlider.frame = CGRectMake(120, self.view.frame.size.height - 85 , self.view.frame.size.width - 140, 21);
    [self.view addSubview: self.processSlider];
    [self.processSlider addTarget:self action:@selector(ProcessSliderAction:) forControlEvents:UIControlEventValueChanged];*/
    
}

#pragma mark - VLC media player control

- (void)mediaPlayerStateChanged:(NSNotification *)aNotification
{
    NSLog(@"mediaPlayerStateChanged");
    VLCMediaPlayerState curState = [vlcMediaPlayer state];
    if(curState == VLCMediaPlayerStateError)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Error!" delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
        [alert show];
    }
    if(curState == VLCMediaPlayerStateStopped || curState == VLCMediaPlayerStateEnded)
    {
        
    }
    if(curState == VLCMediaPlayerStatePaused)
    {
        
    }
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

