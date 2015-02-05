//
//  TMVihicleChargeStateIC.h
//  TeslaModeS
//
//  Created by Oleksandr Bolhovetskyy on 11/27/14.
//  Copyright (c) 2014 Eleks. All rights reserved.
//

#import <WatchKit/WatchKit.h>

#import "TeslaModelSKit.h"
#import "TMConstants.h"

@interface TMVehicleChargeStateIC : WKInterfaceController
{
    NSInteger chargeLimit;
}

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblChargingState;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblChargePercent;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblChargeRange;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblChargingTime;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblRangeTitle;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblChargeLimitTitle;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblChargeLimit;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *groupCurrentCharge;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *groupTotalCharge;

- (IBAction)btnChargeLimitDownTouch;
- (IBAction)btnChargeLimitUpTouch;

@end
