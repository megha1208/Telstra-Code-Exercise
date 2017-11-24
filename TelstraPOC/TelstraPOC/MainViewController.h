//
//  MainViewController.h
//  TelstraPOC
//
//  Created by mac_admin on 22/11/17.
//  Copyright © 2017 mac_admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImage/UIImageView+WebCache.h"
#import "DataModel.h"

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSString *navTitle;
}

@property UITableView *tableView;
@property NSDictionary *myJson;
@property NSMutableArray *tableDataArray;


@end
