//
//  TMClimatIC.h
//  TeslaModeS
//
//  Created by Oleksandr Bolhovetskyy on 11/27/14.
//  Copyright (c) 2014 Eleks. All rights reserved.
//

#import <WatchKit/WatchKit.h>

#import "TeslaModelSKit.h"
#import "TMConstants.h"

@interface TMClimatIC : WKInterfaceController
{
    float driverTemperature;
    float passengerTemperature;
    
    VehicleRoofState roofState;
}

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblOutsideTemperature;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblFanState;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *groupCurrentFanState;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *groupTotalFanState;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *btnDefrosters;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *btnSetRoofState;

@end
