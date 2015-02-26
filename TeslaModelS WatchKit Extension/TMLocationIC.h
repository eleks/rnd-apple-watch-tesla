//
//  TMLocationIC.h
//  TeslaModeS
//
//  Created by Oleksandr Bolhovetskyy on 11/28/14.
//  Copyright (c) 2014 Eleks. All rights reserved.
//

#import <WatchKit/WatchKit.h>

#import "TeslaModelSKit.h"
#import "TMConstants.h"

@interface TMLocationIC : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceGroup *groupSpeed;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblSpeed;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblSpeedTitle;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblMph;
@property (weak, nonatomic) IBOutlet WKInterfaceMap *mapVehicleLocation;

@end
