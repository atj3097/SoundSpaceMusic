//
//  CoreAudioManager.h
//  SoundSpaceMusic
//
//  Created by God on 3/8/20.
//  Copyright © 2020 Adam Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AudioManager.h"

extern const Float64 kSampleRate;

@interface CoreAudioManager : NSObject <AudioManager>

-(void)loadAudioFiles;
-(void)initializeAUGraph;

-(void)startPlaying;
-(void)stopPlaying;

-(void)setGuitarInputVolume:(Float32)value;
-(void)setDrumInputVolume:(Float32)value;

-(Float32*)guitarFrequencyDataOfLength:(UInt32*)size;
-(Float32*)drumsFrequencyDataOfLength:(UInt32*)size;

@end
