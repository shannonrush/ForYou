//
//  SettingsController.h
//  ForYou
//
//  Created by Shannon Rush on 4/14/12.
//  Copyright (c) 2012 Rush Devo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface SettingsController : BaseController {
    IBOutlet UILabel *idLabel;
    IBOutlet UILabel *balanceLabel;
}

-(IBAction)checkStatus:(id)sender;

@end
