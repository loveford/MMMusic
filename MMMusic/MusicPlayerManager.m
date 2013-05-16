//
//  MusicPlayManager.m
//  MMMusic
//
//  Created by mouwenbin on 5/9/13.
//  Copyright (c) 2013 mouwenbin. All rights reserved.
//

#import "MusicPlayerManager.h"
#import<AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import "MusicItem.h"
@interface MusicPlayerManager ()<AVAudioPlayerDelegate>
{
    UIBackgroundTaskIdentifier bgTask;
    NSInteger _songIndex;
}
@property (nonatomic, retain) AVAudioPlayer *musicPlayer;
@end

static MusicPlayerManager *_musicManager;
@implementation MusicPlayerManager
@synthesize StorageMusicName = _StorageMusicName;
@synthesize musicPlayer = _musicPlayer;
@synthesize musicList = _musicList;
#pragma mark - LifeCycle
+ (MusicPlayerManager *)shareMusicManager
{
    if (nil == _musicManager) {
        _musicManager = [[super allocWithZone:NULL] init];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
    return _musicManager;
}

+ (id) allocWithZone:(NSZone *)zone
{
    return [[self shareMusicManager] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

-(oneway void)release
{
    
}

- (id)retain
{
    return  self;
}

- (NSUInteger)retainCount
{
    return NSIntegerMax;
}

- (id)autorelease
{
    return self;
}

-(void)dealloc
{
    self.StorageMusicName = nil;
    self.iPodMediaCollection = nil;
    [super dealloc];
}

- (NSMutableArray *)musicList
{
    if (!_musicList) {
        self.musicList = [NSMutableArray array];
//        [self loadMusicList];
    }
    return _musicList;
}
#pragma mark - CustomMethod
#pragma mark - SaveMusicList
- (void)saveToData
{
    NSString *tempStorage ;
    if (self.StorageMusicName == @"mrlb")
    {
        tempStorage = [NSString stringWithFormat:@"%@",self.StorageMusicName];
        tempStorage=[tempStorage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//去空白
    }else if(self.StorageMusicName == @"zjbf")
    {
        tempStorage = [NSString stringWithFormat:@"%@",self.StorageMusicName];
        tempStorage=[tempStorage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//去空白
    }else if(self.StorageMusicName == @"wzat")
    {
        tempStorage = [NSString stringWithFormat:@"%@",self.StorageMusicName];
        tempStorage=[tempStorage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//去空白
    }
    
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.musicList];
	[[NSUserDefaults standardUserDefaults]setObject:data forKey:tempStorage];
	[[NSUserDefaults standardUserDefaults]synchronize];
    
}

- (void)loadMusicList
{
    NSString *tempStorage ;
    if (self.StorageMusicName == nil) {
        self.StorageMusicName = @"mrlb";
    }
    if (self.StorageMusicName == @"mrlb")
    {
        tempStorage = [NSString stringWithFormat:@"%@",self.StorageMusicName];
        tempStorage=[tempStorage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//去空白
    }else if(self.StorageMusicName == @"zjbf")
    {
        tempStorage = [NSString stringWithFormat:@"%@",self.StorageMusicName];
        tempStorage=[tempStorage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//去空白
    }else if(self.StorageMusicName == @"wzat")
    {
        tempStorage = [NSString stringWithFormat:@"%@",self.StorageMusicName];
        tempStorage=[tempStorage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//去空白
    }
    
	NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:tempStorage];

    NSArray *songList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (songList) {
        self.musicList = [NSMutableArray arrayWithArray:songList];
    }else{
        self.musicList = [NSMutableArray array];
    }
    
}

#pragma mark - MusicPlayerMethod

- (void)preperToPlay
{
    [self loadMusicList];
}

-(void)loadMusic:(MusicItem*)musicItem
{
    _songIndex = [self.musicList indexOfObject:musicItem];
    NSError *error;
    self.musicPlayer= [[[AVAudioPlayer alloc] initWithContentsOfURL:musicItem.url error:&error] autorelease];
    _musicPlayer.delegate=self;
    _musicPlayer.volume= 0.5;
    [_musicPlayer prepareToPlay];
    if (!self.musicPlayer && self.musicList.count) {
        [self next];
    }
}

//播放完成自动切换
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    _songIndex++;
    if(_songIndex==_musicList.count)
        _songIndex= 0;
    
    
    [self loadMusic:[_musicList objectAtIndex:_songIndex]];
    [_musicPlayer play];
    
//    if([UIApplication sharedApplication].applicationState== UIApplicationStateBackground) {
//        
//        [_musicPlayer play];
//        
//        UIApplication*app = [UIApplication sharedApplication];
//        UIBackgroundTaskIdentifier newTask = [app beginBackgroundTaskWithExpirationHandler:nil];
//        if(bgTask!= UIBackgroundTaskInvalid) {
//            
//            [app endBackgroundTask: bgTask];
//        }
//        bgTask = newTask;
//    }
//    else {
//        
//        [_musicPlayer play];
//    }
}

- (void)play
{
    [_musicPlayer play];
//    if([UIApplication sharedApplication].applicationState== UIApplicationStateBackground) {
//        
//        
//        
//        UIApplication*app = [UIApplication sharedApplication];
//        UIBackgroundTaskIdentifier newTask = [app beginBackgroundTaskWithExpirationHandler:nil];
//        if(bgTask!= UIBackgroundTaskInvalid) {
//            
//            [app endBackgroundTask: bgTask];
//        }
//        bgTask = newTask;
//    }
//    else {
//        
//        [_musicPlayer play];
//    }
}

- (void)pause
{
    [_musicPlayer pause];
}

- (void)next
{
    if (!_musicList.count) {
        return;
    }
//    BOOL playFlag;
    if(_musicPlayer.playing)
    {
//        playFlag=YES;
        [_musicPlayer stop];
    }
//    else
//        playFlag=NO;
    _songIndex++;
    if(_songIndex==_musicList.count)
        _songIndex= 0;
    
    [self loadMusic:[_musicList objectAtIndex:_songIndex]];

//    if(playFlag==YES)
//    {
//        [_musicPlayer play];
//        
//    }
    [_musicPlayer play];
}

-(void)previous
{
    if (!_musicList.count) {
        return;
    }
//    BOOL playFlag;
    if(_musicPlayer.playing)
    {
//        playFlag=YES;
        [_musicPlayer stop];
    }
//    else
//    {
//        playFlag=NO;
//    }
    _songIndex--;
    if(_songIndex<0)
        _songIndex= _musicList.count-1
        ;
    
    [self loadMusic:[_musicList objectAtIndex:_songIndex]];
    [_musicPlayer play];
//    if(playFlag==YES)
//    {
//        [_musicPlayer play];
//        
//    }
    
}

#pragma mark - Copy the Songs From iPod Library
-(void)exportMP3:(NSURL*)url toFileUrl:(NSString*)fileURL
{
   
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:fileURL]) {
        return;
    }
    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL: url options:nil];
    
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset: songAsset
                                                                      presetName: AVAssetExportPresetPassthrough];
    
    exporter.outputFileType = @"public.3gpp";
//    NSString *exportFile = [[self getMusicDocument] stringByAppendingPathComponent:
//                            @"exported.mp4"];
    
    NSURL *exportURL = [NSURL fileURLWithPath:fileURL];
    exporter.outputURL = exportURL;
    
    // do the export
    // (completion handler block omitted)
    [exporter exportAsynchronouslyWithCompletionHandler:
     ^{
         NSData *data = [NSData dataWithContentsOfFile: fileURL];
         if (!data.length) {
             [fileManager removeItemAtPath:fileURL error:nil];
         }
         // Do with data something
//         [fileManager createFileAtPath:fileURL contents:data attributes:nil];
     }];
    
    return;
    AVURLAsset *asset=[[[AVURLAsset alloc] initWithURL:url options:nil] autorelease];
    AVAssetReader *reader=[[[AVAssetReader alloc] initWithAsset:asset error:nil] autorelease];
    [reader setTimeRange:CMTimeRangeMake(kCMTimeZero, kCMTimePositiveInfinity)];
    NSMutableArray *myOutputs =[[NSMutableArray alloc] init];
    for(id track in [asset tracks])
    {
        AVAssetReaderTrackOutput *ot=[AVAssetReaderTrackOutput assetReaderTrackOutputWithTrack:track outputSettings:nil];
        
        [myOutputs addObject:ot];
        [reader addOutput:ot];
    }
    [reader startReading];
    NSFileHandle *fileHandle ;
    NSFileManager *fm=[NSFileManager defaultManager];
    if(![fm fileExistsAtPath:fileURL])
    {
        [fm createFileAtPath:fileURL contents:[[[NSData alloc] init] autorelease] attributes:nil];
    }
    fileHandle=[NSFileHandle fileHandleForUpdatingAtPath:fileURL];
    [fileHandle seekToEndOfFile];
    
    AVAssetReaderOutput *output=[myOutputs objectAtIndex:0];
    
    int totalBuff=0;
    BOOL one=TRUE;
    while(TRUE)
    {
        CMSampleBufferRef ref=[output copyNextSampleBuffer];
        // NSLog(@"%@",ref);
        if(ref==NULL)
            break;
        //copy data to file
        //read next one
        AudioBufferList audioBufferList;
        NSMutableData *data=[[NSMutableData alloc] init];
        CMBlockBufferRef blockBuffer;
        CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer(ref, NULL, &audioBufferList, sizeof(audioBufferList), NULL, NULL, 0, &blockBuffer);
        // NSLog(@"%@",blockBuffer);
        
        if(blockBuffer==NULL)
        {
            
            [data release];
            continue;
            
        }
        if(&audioBufferList==NULL)
        {
            [data release];
            continue;
        }
        
        for( int y=0; y<audioBufferList.mNumberBuffers; y++ )
        {
            AudioBuffer audioBuffer = audioBufferList.mBuffers[y];
            Float32 *frame = (Float32*)audioBuffer.mData;
            
            
            [data appendBytes:frame length:audioBuffer.mDataByteSize];
            
            
            
        }
        
        totalBuff++;
        
        CFRelease(blockBuffer);
        CFRelease(ref);
        ref=NULL;
        blockBuffer=NULL;
        [fileHandle writeData:data];
        [data release];
    }
    
    [fileHandle closeFile];
    [myOutputs release];  
}

#pragma mark - FileManager

- (NSString *)getMusicDocument
{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory= [NSHomeDirectory()
                                   stringByAppendingPathComponent:@"Documents"];
    
//    if (![fileManager isExecutableFileAtPath:@"DownloadMusic"]) {
//        [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/DownloadMusic", documentsDirectory] withIntermediateDirectories:YES attributes:nil error:&error];
//        
//    }
//    
//    documentsDirectory = [NSString stringWithFormat:@"%@/DownloadMusic/",documentsDirectory];
    return documentsDirectory;
}

@end
