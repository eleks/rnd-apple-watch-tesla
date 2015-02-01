//
//  TMLocationIC.m
//  TeslaModeS
//
//  Created by Oleksandr Bolhovetskyy on 11/28/14.
//  Copyright (c) 2014 Eleks. All rights reserved.
//

#import "TMLocationIC.h"


@implementation TMLocationIC


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Initialize variables here.
    // Configure interface objects here.
    NSLog(@"%@ awakeWithContext", self);

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
    [[WebServiceLayer sharedInstance] getVehicleLocationWithCompletionHandler:^(VehicleLocationModel *model, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        if (model.speed == 0.0f) {
            [self.groupSpeed setHidden:YES];
            [self.mapVehicleLocation setHeight:self.contentFrame.size.height * 0.9f];
        }
        else {
            [self.groupSpeed setHidden:NO];
            [self.lblSpeed setAttributedText:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.02f", model.speed] attributes:@{NSFontAttributeName : SanFranciscoFontWithSize25}]];
            [self.lblMph setAttributedText:[[NSAttributedString alloc] initWithString:@"mph" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize15}]];
            [self.lblSpeedTitle setAttributedText:[[NSAttributedString alloc] initWithString:@"Speed" attributes:@{NSFontAttributeName : SanFranciscoFontWithSize9}]];

            [self.groupSpeed setHeight:self.contentFrame.size.height * 0.24f];
            [self.mapVehicleLocation setHeight:self.contentFrame.size.height * 0.68f];
        }

        MKCoordinateSpan span = MKCoordinateSpanMake(0.005f, 0.005f);
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake(model.latitude, model.longitude);
        [self.mapVehicleLocation setRegion:MKCoordinateRegionMake(location, span)];
        [self.mapVehicleLocation addAnnotation:location withImageNamed:@"map_place_icon" centerOffset:CGPointMake(0, 0)];
    }];
}

@end
