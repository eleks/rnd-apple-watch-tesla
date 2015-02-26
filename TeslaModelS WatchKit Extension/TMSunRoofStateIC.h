//
//  TMSunRoofStateIC.h
//  TeslaModeS
//
//  Created by Oleksandr Bolhovetskyy on 11/27/14.
//  Copyright (c) 2014 Eleks. All rights reserved.
//

#import <WatchKit/WatchKit.h>

#import "TMSunRoofStateCell.h"
#import "TeslaModelSKit.h"

@interface TMSunRoofStateIC : WKInterfaceController
{
    VehicleRoofState roofState;
}

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblOpenRoof;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblComfort;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblVentilation;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *lblCloseRoof;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *btnOpenRoof;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *btnComfort;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *btnVentilation;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *btnCloseRoof;

- (IBAction)btnOpenRoofTouch;
- (IBAction)btnComfortTouch;
- (IBAction)btnVentilationTouch;
- (IBAction)btnCloseRoofTouch;

@end
