//
//  DataModel.m
//  TelstraPOC
//
//  Created by mac_admin on 24/11/17.
//  Copyright © 2017 mac_admin. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

-(id)initWithTitle:(NSString *)title andDescription:(NSString *)description andImageRef:(NSString *)imageHref
{
    self = [super init];
    if (self) {
        self.title = title;
        self.imageDescription = description;
        self.imageURL = imageHref;
        /*
        if (title == (id)[NSNull null]) {
            self.title = @"No Title Available";
        }
        else
        {
            self.title = title;
            if (description == (id)[NSNull null]) {
                self.imageDescription = @"No Description Available";
            }
            else
            {
                self.imageDescription = description;
            }
        }*/
    }
    return self;
}

@end
