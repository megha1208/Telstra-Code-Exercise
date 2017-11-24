//
//  ViewController.h
//  TelstraPOC
//
//  Created by mac_admin on 22/11/17.
//  Copyright © 2017 mac_admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property UITableView *tableView;
@property UILabel *label;

@end

