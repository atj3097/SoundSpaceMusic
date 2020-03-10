//
//  AudioEngineManager.h
//  SoundSpaceMusic
//
//  Created by God on 3/8/20.
//  Copyright © 2020 Adam Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioManager.h"

@interface AudioEngineManager : NSObject <AudioManager>

-(void)loadEngine;
-(void)startPlaying;

-(void)setGuitarInputVolume:(Float32)value;
-(void)setDrumInputVolume:(Float32)value;

@end
