//
//  MainViewController.m
//  TelstraPOC
//
//  Created by mac_admin on 22/11/17.
//  Copyright © 2017 mac_admin. All rights reserved.
//

#import "MainViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "Constant.h"
#import "SubtitleTableViewCell.h"

@interface MainViewController ()

@end

@implementation MainViewController

#define BgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];

    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    
    self.myJson = [[NSDictionary alloc] init];
    self.tableDataArray = [[NSMutableArray alloc] init];
   
    
    dispatch_async(BgQueue, ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"]];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

//Customizing the View

-(void)loadInitialView
{
    self.view.backgroundColor = TEAL;
    
}
-(void)loadTableView
{
    
}
-(void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Creating table View
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[SubtitleTableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    //Adding table view to the view
    [self.view addSubview:self.tableView];
    
    //Setting Layout Constraints to tableView
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:1.0f];
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:1.0f];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:1.0f];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:1.0f];
    
    [self.view addConstraint:leadingConstraint];
    [self.view addConstraint:trailingConstraint];
    [self.view addConstraint:topConstraint];
    [self.view addConstraint:bottomConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Data Source Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SubtitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    
    //Creating model Object to access data
    
    DataModel *modelObject = (DataModel *)self.tableDataArray[indexPath.row];
    NSString *dataTitle = modelObject.title;
    NSString *description = modelObject.imageDescription;
    
    if(dataTitle != (id)[NSNull null])
    {
        cell.textLabel.text = dataTitle;
    }
    else
    {
        cell.textLabel.text = nil;
    }
    if (description != (id)[NSNull null])
    {
        cell.detailTextLabel.text = description;
    }
    else
    {
        cell.detailTextLabel.text = nil;
    }
    
    NSString *imageURLString = modelObject.imageURL;
    
    
    //Setting Placeholder Image
    cell.imageView.image = [UIImage imageNamed:@"placeholderImage"];
    
    //customImageView.image = [UIImage imageNamed:@"placeholderImage"];
    if(imageURLString != (id)[NSNull null])
    {
        
        NSURL *imageURL = [NSURL URLWithString:imageURLString];
        [self downloadImageWithURL:imageURL completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                cell.imageView.image = image;
                //customImageView.image = image;
            }
        }];
    }
    else{
        //Setting the image in case the URL is none
        cell.imageView.image = [UIImage imageNamed:@"noImage"];
        //customImageView.image = [UIImage imageNamed:@"noImage"];
    }
    
    //Framimg the imageView
    
    CGSize itemSize = CGSizeMake(60, 60);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    
    DataModel *modelObject = (DataModel *)self.tableDataArray[indexPath.row];
    NSString *title = modelObject.imageDescription;
    CGRect rowRect;
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    NSMutableParagraphStyle *paraStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [attr setObject:paraStyle forKey:NSParagraphStyleAttributeName];
    [attr setObject:cellFont forKey:NSFontAttributeName];
    if (title != (id)[NSNull null]) {
        rowRect = [title boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    }
    
    return rowRect.size.height + 75;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
}

#pragma mark - Helper Methods

-(void)fetchedData:(NSData *)data
{
    NSError *error;
    //NSLog(@"data.. %@",data);
    
    if(data)
    {
        _myJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if( _myJson && !error)
        {
            NSLog(@"Success");
        }
        else if (error)
        {
            //NSLog(@"Failed.. Error; %@",[error localizedDescription]);
            
            //In case network issue load the Local Json File
            NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"JsonData" ofType:@"json"];
            NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
            NSError *jsonError;
            if (!jsonError) {
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
                NSArray *jsonArray = [jsonDict valueForKey:@"rows"];
                
                for (NSDictionary *dataDict in jsonArray) {
                    
                    NSString *title = [dataDict valueForKey:@"title"];
                    NSString *description = [dataDict valueForKey:@"description"];
                    NSString *imageURL = [dataDict valueForKey:@"imageHref"];
                    
                    //Creating Model Object and adding to the array
                    DataModel *modelObject = [[DataModel alloc] initWithTitle:title andDescription:description andImageRef:imageURL];
                    [self.tableDataArray addObject:modelObject];
                    navTitle = [jsonDict valueForKey:@"title"];
                }
            }
        }
    }
    
    //Setting the title of navigation bar
    self.navigationItem.title = navTitle;
    [self.tableView reloadData];
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}



@end
