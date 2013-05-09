//
//  MusicPlayManager.h
//  MMMusic
//
//  Created by mouwenbin on 5/9/13.
//  Copyright (c) 2013 mouwenbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MPMediaPickerController.h>

@interface MusicPlayManager : NSObject
@property   (nonatomic,retain) MPMediaItemCollection  *iPodMediaCollection;
+(MusicPlayManager *)shareMusicManager;
- (void)saveToData;
@end
