//
//  InterfaceController.m
//  TeslaModeS WatchKit Extension
//
//  Created by Oleksandr Malyarenko on 11/25/2014.
//  Copyright (c) 2014 Eleks. All rights reserved.
//

#import "TMVehicleStateIC.h"


@interface TMVehicleStateIC ()

@end


@implementation TMVehicleStateIC


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    isLocked = NO;
    [self getVehicleState];
}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);

    [self.lblRangeTitle setAttributedText:[[NSAttributedString alloc] initWithString:@"Range" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];

    [self getVehicleState];
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}


- (void)getVehicleState {
    [[WebServiceLayer sharedInstance] getCombinedVehicleState:^(NSDictionary *states, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            [self.lblChargingTime setHidden:YES];
            return;
        }
        VehicleChargeStateModel *chargeState = states[VehicleCharging];
        VehicleStateModel *vehicleState = states[VehicleState];
        VehicleClimateStateModel *climateState = states[VehicleClimate];

        [self.lblChargingState setAttributedText:[[NSAttributedString alloc] initWithString:chargeState.chargingState ? @"Charging..." : @"Charge" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];
        [self.lblChargePercent setAttributedText:[[NSAttributedString alloc] initWithString:chargeState.batteryLevel attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];
        NSString *range = [NSString stringWithFormat:@"%.0f", [chargeState.estimateBatteryRange floatValue]];
        [self.lblChargeRange setAttributedText:[[NSAttributedString alloc] initWithString:range attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];

        float chargePercent = (float) ([chargeState.batteryLevel floatValue] / 100.0);
        [self.groupCurrentCharge setWidth:(self.contentFrame.size.width - 12) * chargePercent];
        [self.groupTotalCharge setWidth:(self.contentFrame.size.width - 12) * (1 - chargePercent)];

        NSInteger hours = (NSInteger) floor(chargeState.timeToFullCharge / 3600);
        NSInteger minutes = (NSInteger) round((chargeState.timeToFullCharge - hours * 3600) / 60);
        NSString *time = [NSString stringWithFormat:@"%ldh %ldmin remaining", (long) hours, (long) minutes];
        [self.lblChargingTime setAttributedText:[[NSAttributedString alloc] initWithString:time attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];
        [self.lblChargingTime setHidden:!chargeState.chargingState];

        isLocked = vehicleState.carLocked;
        [self.lblLockState setAttributedText:[[NSAttributedString alloc] initWithString:vehicleState.carLocked ? @"Locked" : @"Unlocked" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize15}]];
        [self.lblLockState setTextColor:vehicleState.carLocked ? TextColorForLockedVehicle : TextColorForUnlockedVehicle];

        if (vehicleState.roofState == RoofStateUnknown || vehicleState.roofState == RoofStateClose) {
            [self.btnVehicleState setBackgroundImageNamed:vehicleState.carLocked ? @"car_locked" : @"car_unlocked"];
        }
        else if (vehicleState.roofState != RoofStateUnknown && vehicleState.roofState != RoofStateClose) {
            [self.btnVehicleState setBackgroundImageNamed:vehicleState.carLocked ? @"car_opened_roof" : @"car_unlocked_opened_roof"];
        }

        [self.lblOutsideTemperature setAttributedText:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@°", climateState.outsideTemperature] attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];
        NSDictionary *attributes = @{NSFontAttributeName : SanFranciscoFontWithSize15, NSForegroundColorAttributeName : [UIColor whiteColor]};
        [self.btnVehicleState setAttributedTitle:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@°", climateState.insideTemperature] attributes:attributes]];

        [self resetMenuButtons];
    }];
}


#pragma mark Menu


- (void)resetMenuButtons {
    [self clearAllMenuItems];
    [self addMenuItemWithImageNamed:isLocked ? @"unlock_car" : @"lock_car" title:isLocked ? @"Unlock" : @"Lock" action:@selector(btnMenuLockTouch)];
    [self addMenuItemWithImageNamed:@"horn_honk" title:@"Horn" action:@selector(btnMenuHornTouch)];
    [self addMenuItemWithImageNamed:@"lights_on" title:@"Lights" action:@selector(btnMenuLightsTouch)];
}


- (void)btnMenuLockTouch {
    if (isLocked) {
        [[WebServiceLayer sharedInstance] unlockDoorWithCompletionHandler:^(BOOL status) {
            if (status) {
                isLocked = !isLocked;
                [self resetMenuButtons];
                [self.lblLockState setAttributedText:[[NSAttributedString alloc] initWithString:isLocked ? @"Locked" : @"Unlocked" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize15}]];
                [self.lblLockState setTextColor:isLocked ? TextColorForLockedVehicle : TextColorForUnlockedVehicle];
                [self.btnVehicleState setBackgroundImageNamed:isLocked ? @"car_locked" : @"car_unlocked"];
            }
        }];
    }
    else {
        [[WebServiceLayer sharedInstance] lockDoorWithCompletionHandler:^(BOOL status) {
            if (status) {
                isLocked = !isLocked;
                [self resetMenuButtons];
                [self.lblLockState setAttributedText:[[NSAttributedString alloc] initWithString:isLocked ? @"Locked" : @"Unlocked" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize15}]];
                [self.lblLockState setTextColor:isLocked ? TextColorForLockedVehicle : TextColorForUnlockedVehicle];
                [self.btnVehicleState setBackgroundImageNamed:isLocked ? @"car_locked" : @"car_unlocked"];
            }
        }];
    }
}


- (void)btnMenuHornTouch {
    [[WebServiceLayer sharedInstance] honkHornOnceWithCompletionHandler:^(BOOL status) {

    }];
}


- (void)btnMenuLightsTouch {
    [[WebServiceLayer sharedInstance] flashLightsOnceWithCompletionHandler:^(BOOL status) {

    }];
}

@end



