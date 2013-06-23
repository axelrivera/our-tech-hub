//
//  MainViewController.m
//  TechHubFeed
//
//  Created by Axel Rivera on 6/22/13.
//  Copyright (c) 2013 Axel Rivera. All rights reserved.
//

#import "MainViewController.h"

#import "TechHubAPIClient.h"
#import "WebViewController.h"

@interface MainViewController () <UIActionSheetDelegate>

@end

@implementation MainViewController

- (id)init
{
    self = [super initWithNibName:@"MainViewController" bundle:nil];
    if (self) {
        _dataSource = [@[] mutableCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Our Tech Hub";

    self.tableView.rowHeight = 60.0;


    [[TechHubAPIClient sharedClient] getPath:@"news.json"
                                  parameters:nil
                                     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         self.dataSource = responseObject;
         [self.tableView reloadData];
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {

     }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.numberOfLines = 3;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    }

    NSDictionary *dictionary = self.dataSource[indexPath.row];

    cell.textLabel.text = dictionary[@"title"];

    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSDictionary *dictionary = self.dataSource[indexPath.row];

    WebViewController *webController = [[WebViewController alloc] initWithDictionary:dictionary];
    [self.navigationController pushViewController:webController animated:YES];
}

@end
