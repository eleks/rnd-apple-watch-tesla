//
//  TMVihicleChargeStateIC.m
//  TeslaModeS
//
//  Created by Oleksandr Bolhovetskyy on 11/27/14.
//  Copyright (c) 2014 Eleks. All rights reserved.
//

#import "TMVehicleChargeStateIC.h"


@implementation TMVehicleChargeStateIC

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Initialize variables here.
    // Configure interface objects here.
    NSLog(@"%@ awakeWithContext", self);
    chargeLimit = 75;
    [self getVehicleState];
}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
    [self.lblRangeTitle setAttributedText:[[NSAttributedString alloc] initWithString:@"Range" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];
    [self.lblChargeLimitTitle setAttributedText:[[NSAttributedString alloc] initWithString:@"Charge limit" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];

    [self getVehicleState];
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
    [[WebServiceLayer sharedInstance] setChargeLimit:chargeLimit withCompletionHandler:^(BOOL status) {

    }];
}


- (void)getVehicleState {
    [[WebServiceLayer sharedInstance] getChargeStateWithCompletionHandler:^(VehicleChargeStateModel *model, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            [self.lblChargingTime setHidden:YES];
            return;
        }
        [self.lblChargingState setAttributedText:[[NSAttributedString alloc] initWithString:model.chargingState ? @"Charging..." : @"Charge" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];
        [self.lblChargePercent setAttributedText:[[NSAttributedString alloc] initWithString:model.batteryLevel attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];
        NSString *range = [NSString stringWithFormat:@"%.0f", [model.estimateBatteryRange floatValue]];
        [self.lblChargeRange setAttributedText:[[NSAttributedString alloc] initWithString:range attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];

        float chargePercent = (float) ([model.batteryLevel floatValue] / 100.0);
        [self.groupCurrentCharge setWidth:(self.contentFrame.size.width - 12) * chargePercent];
        [self.groupTotalCharge setWidth:(self.contentFrame.size.width - 12) * (1 - chargePercent)];

        NSInteger hours = (NSInteger) floor(model.timeToFullCharge / 3600);
        NSInteger minutes = (NSInteger) round((model.timeToFullCharge - hours * 3600) / 60);
        NSString *time = [NSString stringWithFormat:@"%ldh %ldmin remaining", (long) hours, (long) minutes];
        [self.lblChargingTime setAttributedText:[[NSAttributedString alloc] initWithString:time attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];
        [self.lblChargingTime setHidden:!model.chargingState];
        [self.lblChargeLimit setAttributedText:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%li", (long) chargeLimit] attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];
    }];
}


#pragma mark Buttons


- (IBAction)btnChargeLimitDownTouch {
    if (chargeLimit > 0) {
        chargeLimit -= 1;
        [self.lblChargeLimit setAttributedText:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%li", (long) chargeLimit] attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];
    }
}


- (IBAction)btnChargeLimitUpTouch {
    if (chargeLimit < 100) {
        chargeLimit += 1;
        [self.lblChargeLimit setAttributedText:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%li", (long) chargeLimit] attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];
    }
}

@end
