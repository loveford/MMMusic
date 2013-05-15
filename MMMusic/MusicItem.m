//
//  MusicItem.m
//  MMMusic
//
//  Created by mouwenbin on 5/10/13.
//  Copyright (c) 2013 mouwenbin. All rights reserved.
//

#import "MusicItem.h"

@implementation MusicItem
@synthesize name,lyrics,url,isIPodMusic;

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.name = [coder decodeObjectForKey:@"name"];
        self.lyrics = [coder decodeObjectForKey:@"lyrics"];
        self.url = [coder decodeObjectForKey:@"url"];
        self.isIPodMusic = [coder decodeBoolForKey:@"isIPodMusic"];
    }
    return self;
}
- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:name forKey:@"name"];
    [coder encodeObject:lyrics forKey:@"lyrics"];
    [coder encodeObject:url forKey:@"url"];
    [coder encodeBool:isIPodMusic forKey:@"isIPodMusic"];
}


- (void)dealloc
{
    self.url = nil;
    self.name = nil;
    self.lyrics = nil;
    [super dealloc];
}

@end
