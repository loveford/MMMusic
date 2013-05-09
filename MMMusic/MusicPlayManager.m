//
//  MusicPlayManager.m
//  MMMusic
//
//  Created by mouwenbin on 5/9/13.
//  Copyright (c) 2013 mouwenbin. All rights reserved.
//

#import "MusicPlayManager.h"

static MusicPlayManager *_musicManager;
@implementation MusicPlayManager

#pragma mark - LifeCycle
+ (MusicPlayManager *)shareMusicManager
{
    if (nil == _musicManager) {
        _musicManager = [[super allocWithZone:NULL] init];
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

#pragma mark - CustomMethod
- (void)saveToData
{
    NSString *tempStorage ;
//    if (self.StorageMusicName == @"mrlb")
//    {
//        tempStorage = [NSString stringWithFormat:@"%@",self.StorageMusicName];
//        tempStorage=[tempStorage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//去空白
//    }else if(self.StorageMusicName == @"zjbf")
//    {
//        tempStorage = [NSString stringWithFormat:@"%@",self.StorageMusicName];
//        tempStorage=[tempStorage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//去空白
//    }else if(self.StorageMusicName == @"wzat")
//    {
//        tempStorage = [NSString stringWithFormat:@"%@",self.StorageMusicName];
//        tempStorage=[tempStorage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//去空白
//    }
    
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[self.iPodMediaCollection items]];
	[[NSUserDefaults standardUserDefaults]setObject:data forKey:tempStorage];
	[[NSUserDefaults standardUserDefaults]synchronize];
    
}

@end
