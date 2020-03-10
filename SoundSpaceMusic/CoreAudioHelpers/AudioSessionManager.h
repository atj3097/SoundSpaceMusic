//
//  AudioSessionManager.h
//  SoundSpaceMusic
//
//  Created by God on 3/8/20.
//  Copyright © 2020 Adam Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioSessionManager : NSObject

+(AudioSessionManager*)sharedInstance;

//Call setup audio session before loading files or initializing the graph
-(void)setupAudioSession;

@end
