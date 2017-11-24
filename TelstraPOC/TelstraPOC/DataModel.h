//
//  DataModel.h
//  TelstraPOC
//
//  Created by mac_admin on 24/11/17.
//  Copyright © 2017 mac_admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageDescription;
@property (nonatomic, strong) NSString *imageURL;

-(id)initWithTitle:(NSString *)title andDescription:(NSString *)description andImageRef:(NSString *)imageHref;

@end
