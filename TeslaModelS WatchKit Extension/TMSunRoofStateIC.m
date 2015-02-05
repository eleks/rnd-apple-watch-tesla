//
//  TMSunRoofStateIC.m
//  TeslaModeS
//
//  Created by Oleksandr Bolhovetskyy on 11/27/14.
//  Copyright (c) 2014 Eleks. All rights reserved.
//

#import "TMSunRoofStateIC.h"


@implementation TMSunRoofStateIC


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    if (self) {
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ awakeWithContext", self);

        roofState = (VehicleRoofState) [context[@"roofState"] integerValue];
    }
}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
    [self setButtonEnable:NO withRoofState:roofState];
}


- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);

    [[WebServiceLayer sharedInstance] setSunRoofState:roofState withCompletionHandler:^(BOOL status) {
        if (!status) {
            NSLog(@"Error: can't set roof state");
        }
    }];
}


- (void)setButtonEnable:(BOOL)enable withRoofState:(VehicleRoofState)state {
    switch (state) {
        case RoofStateOpen:
            [self.btnOpenRoof setEnabled:enable];
            break;
        case RoofStateComfort:
            [self.btnComfort setEnabled:enable];
            break;
        case RoofStateVent:
            [self.btnVentilation setEnabled:enable];
            break;
        case RoofStateClose:
            [self.btnCloseRoof setEnabled:enable];
            break;
        default:
            break;
    }
}


#pragma mark Buttons


- (IBAction)btnOpenRoofTouch {
    roofState = RoofStateOpen;
    [self setButtonEnable:YES withRoofState:roofState];
}


- (IBAction)btnComfortTouch {
    roofState = RoofStateComfort;
    [self setButtonEnable:YES withRoofState:roofState];
}


- (IBAction)btnVentilationTouch {
    roofState = RoofStateVent;
    [self setButtonEnable:YES withRoofState:roofState];
}


- (IBAction)btnCloseRoofTouch {
    roofState = RoofStateClose;
    [self setButtonEnable:YES withRoofState:roofState];
}

@end
