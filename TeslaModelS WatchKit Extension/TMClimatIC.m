//
//  TMClimatIC.m
//  TeslaModeS
//
//  Created by Oleksandr Bolhovetskyy on 11/27/14.
//  Copyright (c) 2014 Eleks. All rights reserved.
//

#import "TMClimatIC.h"


@implementation TMClimatIC


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"%@ initWithContext", self);

    [self getVehicleState];
}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
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
            return;
        }
        VehicleStateModel *vehicleState = states[VehicleState];
        VehicleClimateStateModel *climateState = states[VehicleClimate];

        roofState = vehicleState.roofState;
        if (roofState == RoofStateUnknown) {
            [self.btnSetRoofState setEnabled:NO];
        }
        NSInteger fanSpeed = [climateState.fanSpeed integerValue];
        [self.lblFanState setAttributedText:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", climateState.fanSpeed] attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];
        [self.groupCurrentFanState setWidth:3 * fanSpeed + 1];
        [self.groupTotalFanState setWidth:(6 - fanSpeed) * 3 + 1];
        [self.lblOutsideTemperature setAttributedText:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@°", climateState.outsideTemperature] attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];

        NSDictionary *attributes = @{NSFontAttributeName : SanFranciscoFontWithSize15, NSForegroundColorAttributeName : [UIColor whiteColor]};
        [self.btnDefrosters setAttributedTitle:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@°", climateState.insideTemperature] attributes:attributes]];

        driverTemperature = [climateState.driverTemperatureSettings floatValue];
        passengerTemperature = [climateState.passengerTemperatureSettings floatValue];

        if (roofState == RoofStateUnknown || roofState == RoofStateClose) {
            if (climateState.isFrontDefrosterOn && climateState.isRearDefrosterOn) {
                [self.btnDefrosters setBackgroundImageNamed:@"climat_closedR_frontD_rearD"];
            }
            else if (climateState.isFrontDefrosterOn) {
                [self.btnDefrosters setBackgroundImageNamed:@"climat_closedR_frontD"];
            }
            else if (climateState.isRearDefrosterOn) {
                [self.btnDefrosters setBackgroundImageNamed:@"climat_closedR_rearD"];
            }
            else {
                [self.btnDefrosters setBackgroundImageNamed:@"climat_closedR"];
            }
        }
        else {
            if (climateState.isFrontDefrosterOn && climateState.isRearDefrosterOn) {
                [self.btnDefrosters setBackgroundImageNamed:@"climat_openedR_frontD_rearD"];
            }
            else if (climateState.isFrontDefrosterOn) {
                [self.btnDefrosters setBackgroundImageNamed:@"climat_openedR_frontD"];
            }
            else if (climateState.isRearDefrosterOn) {
                [self.btnDefrosters setBackgroundImageNamed:@"climat_openedR_rearD"];
            }
            else {
                [self.btnDefrosters setBackgroundImageNamed:@"climat_openedR"];
            }
        }
    }];
}


#pragma mark Segue


- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier {
    NSMutableDictionary *context = [NSMutableDictionary dictionary];
    if ([segueIdentifier isEqualToString:@"segueSetTemperature"]) {
        context[@"driverTemperature"] = @(driverTemperature);
        context[@"passengerTemperature"] = @(passengerTemperature);
    }
    else if ([segueIdentifier isEqualToString:@"segueSetRoofState"]) {
        context[@"roofState"] = @(roofState);
    }

    return context;
}

@end
