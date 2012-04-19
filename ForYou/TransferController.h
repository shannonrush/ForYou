//
//  TransferController.h
//  ForYou
//
//  Created by Shannon Rush on 4/16/12.
//  Copyright (c) 2012 Rush Devo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseController.h"

@interface TransferController : BaseController {
    IBOutlet UISegmentedControl *fromControl;
    IBOutlet UITextField *amountField;
}

-(IBAction)transfer:(id)sender;

@end
