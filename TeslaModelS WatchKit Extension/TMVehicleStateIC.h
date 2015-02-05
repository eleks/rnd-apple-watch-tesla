//
//  InterfaceController.h
//  TeslaModeS WatchKit Extension
//
//  Created by Oleksandr Malyarenko on 11/25/2014.
//  Copyright (c) 2014 Eleks. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

#import "TeslaModelSKit.h"
#import "TMConstants.h"

@interface TMVehicleStateIC : WKInterfaceController
{
    BOOL isLocked;
}

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblChargingState;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblChargePercent;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblChargeRange;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblChargingTime;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblLockState;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblOutsideTemperature;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblRangeTitle;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *groupCurrentCharge;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *groupTotalCharge;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *btnVehicleState;

@end
