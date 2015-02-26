//
//  GlanceController.h
//  TeslaModeS WatchKit Extension
//
//  Created by Oleksandr Malyarenko on 11/25/2014.
//  Copyright (c) 2014 Eleks. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

#import "TeslaModelSKit.h"
#import "TMConstants.h"

@interface GlanceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblVehicleState;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblChargeTitle;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblCharge;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblChargeTime;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblRangeTitle;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblRange;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblMph;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *imgVehicle;

@end
