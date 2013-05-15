//
//  MusicItem.h
//  MMMusic
//
//  Created by mouwenbin on 5/10/13.
//  Copyright (c) 2013 mouwenbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicItem : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *lyrics;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, assign) BOOL isIPodMusic;
@end
