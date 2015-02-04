//
//  TMBlowingIC.m
//  TeslaModeS
//
//  Created by Oleksandr Bolhovetskyy on 11/27/14.
//  Copyright (c) 2014 Eleks. All rights reserved.
//

#import "TMTemperatureIC.h"


@implementation TMTemperatureIC


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Initialize variables here.
    // Configure interface objects here.
    NSLog(@"%@ awakeWithContext", self);

    [self.lblDriversZone setAttributedText:[[NSAttributedString alloc] initWithString:@"Driver's zone" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];
    [self.lblPassengersZone setAttributedText:[[NSAttributedString alloc] initWithString:@"Passenger's zone" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];

    if (context) {
        driverTemperature = [context[@"driverTemperature"] floatValue];
        passengerTemperature = [context[@"passengerTemperature"] floatValue];

        [self.lblDriverZoneTemperature setAttributedText:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f", driverTemperature] attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];
        [self.lblPassengerZoneTemperature setAttributedText:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f", passengerTemperature] attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];
    }
}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
    [[WebServiceLayer sharedInstance] setTemperatureForDriver:driverTemperature forPassenger:passengerTemperature withCompletionHandler:^(BOOL status) {

    }];
}


- (IBAction)btnDriverTemperatureDown {
    if (driverTemperature > 18) {
        driverTemperature -= 1;

        [self.lblDriverZoneTemperature setAttributedText:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f", driverTemperature] attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];
    }
}


- (IBAction)btnDriverTemperatureUp {
    if (driverTemperature < 27) {
        driverTemperature += 1;

        [self.lblDriverZoneTemperature setAttributedText:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f", driverTemperature] attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];
    }
}


- (IBAction)btnPassengerTemperatureDown {
    if (passengerTemperature > 18) {
        passengerTemperature -= 1;

        [self.lblPassengerZoneTemperature setAttributedText:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f", passengerTemperature] attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];
    }
}


- (IBAction)btnPassengerTemperatureUp {
    if (passengerTemperature < 27) {
        passengerTemperature += 1;

        [self.lblPassengerZoneTemperature setAttributedText:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f", passengerTemperature] attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];
    }
}

@end
