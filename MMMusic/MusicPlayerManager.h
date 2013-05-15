//
//  MusicPlayManager.h
//  MMMusic
//
//  Created by mouwenbin on 5/9/13.
//  Copyright (c) 2013 mouwenbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MPMediaPickerController.h>
@class MusicItem;
@interface MusicPlayerManager : NSObject
@property (nonatomic,retain) MPMediaItemCollection  *iPodMediaCollection;
@property (nonatomic, retain) NSMutableArray *musicList;
@property (nonatomic,copy) NSString *StorageMusicName;
+(MusicPlayerManager *)shareMusicManager;
- (void)preperToPlay;
- (void)saveToData;
-(void)loadMusic:(MusicItem*)musicItem;
- (void)play;
- (void)pause;
- (void)next;
-(void)previous;
- (NSString *)getMusicDocument;
-(void)exportMP3:(NSURL*)url toFileUrl:(NSString*)fileURL;
@end
