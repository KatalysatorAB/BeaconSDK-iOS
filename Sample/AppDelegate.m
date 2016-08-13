//
//  AppDelegate.m
//  Sample
//
//  Created by Sven Roeder on 02/11/13.
//  Copyright (c) 2013 Katalysator AB. All rights reserved.
//

#import "AppDelegate.h"
#import <KatalysatorSDK/KatalysatorSDK.h>

@implementation AppDelegate

#define GLIMR_API_TOKEN @"B3945743-D258-49D0-AFBF-1E409AE59501"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // START COLLECTING
    KATConfiguration *config = [[KATConfiguration alloc] init];
    config.apiToken = [[NSUUID alloc] initWithUUIDString:GLIMR_API_TOKEN];
    config.suppressBluetoothAccuracyAlert = YES;

    KATBeaconManager *beaconManager = [[KATBeaconManager alloc] initWithConfiguration:config];
    [beaconManager startCollecting];
    
    [beaconManager debugWithHandler:^(id result) {
        NSLog(@"DEBUG %@", result);
    }];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // RECEIVE TAGS
    NSUUID *apiToken = [[NSUUID alloc] initWithUUIDString:GLIMR_API_TOKEN];

    KATAudienceManager *audienceManager = [[KATAudienceManager alloc] initWithApiToken:apiToken];
    [audienceManager audiencesAndGeotagsWithCompletion:^(NSDictionary *audiences, NSError *error) {
        NSLog(@"AUDIENCES %@", audiences);
    }];
}

@end
