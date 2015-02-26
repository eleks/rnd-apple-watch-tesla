//
//  GlanceController.m
//  TeslaModeS WatchKit Extension
//
//  Created by Oleksandr Malyarenko on 11/25/2014.
//  Copyright (c) 2014 Eleks. All rights reserved.
//

#import "GlanceController.h"


@interface GlanceController ()

@end


@implementation GlanceController


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"%@ initWithContext", self);
    [self getVehicleState];
}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}


- (void)getVehicleState {
    SummaryModel *model = [LocalStorageHelper loadSummaryModel];
    if (model) {
        [self.lblVehicleState setAttributedText:[[NSAttributedString alloc] initWithString:model.carLocked ? @"Locked" : @"Unlocked" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize15}]];
        [self.lblVehicleState setTextColor:model.carLocked ? TextColorForLockedVehicle : TextColorForUnlockedVehicle];

        [self.lblChargeTitle setAttributedText:[[NSAttributedString alloc] initWithString:model.chargingState ? @"Charging..." : @"Charge" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];
        [self.lblCharge setAttributedText:[[NSAttributedString alloc] initWithString:model.batteryLevel attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];

        NSInteger hours = (NSInteger) floor(model.timeToFullCharge / 3600);
        NSInteger minutes = (NSInteger) round((model.timeToFullCharge - hours * 3600) / 60);
        NSString *time = [NSString stringWithFormat:@"%ldh %ldmin remaining", (long) hours, (long) minutes];
        [self.lblChargeTime setAttributedText:[[NSAttributedString alloc] initWithString:time attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];

        [self.lblRangeTitle setAttributedText:[[NSAttributedString alloc] initWithString:@"Range" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];
        [self.lblRange setAttributedText:[[NSAttributedString alloc] initWithString:model.estimatedBatteryRange attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];
        [self.lblMph setAttributedText:[[NSAttributedString alloc] initWithString:@"mph" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize15}]];

        [self.imgVehicle setImageNamed:model.carLocked ? @"glance_car_closed" : @"glance_car_opened"];
    }
}

@end



