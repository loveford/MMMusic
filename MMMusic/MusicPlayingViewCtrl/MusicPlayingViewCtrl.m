//
//  MusicPlayingViewCtrl.m
//  MMMusic
//
//  Created by mouwenbin on 5/9/13.
//  Copyright (c) 2013 mouwenbin. All rights reserved.
//

#import "MusicPlayingViewCtrl.h"

@interface MusicPlayingViewCtrl ()

@end

@implementation MusicPlayingViewCtrl
@synthesize musicPlayerManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
