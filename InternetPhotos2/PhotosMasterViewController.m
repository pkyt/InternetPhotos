//
//  PhotosMasterViewController.m
//  InternetPhotos2
//
//  Created by Pavlo Kytsmey on 2/27/14.
//  Copyright (c) 2014 Pavlo Kytsmey. All rights reserved.
//

#import "PhotosMasterViewController.h"
#import "Photo.h"
#import "Website.h"
#import "PhotosSearchViewController.h"
#import "PhotosAddViewController.h"

@interface PhotosMasterViewController ()

@end

@implementation PhotosMasterViewController

@synthesize managedObjectContext;
@synthesize websites;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Website" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.websites = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    self.title = @"Websites";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    // return [self.websites count];
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //Website* w = [websites objectAtIndex:section];
    //return [w.ownPhoto count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    /*Website *info = [websites objectAtIndex:indexPath.section];
    NSArray* photos = [info.ownPhoto allObjects];
    Photo* p = [photos objectAtIndex:indexPath.row];
    cell.textLabel.text = p.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",
                                 p.path];
    return cell;*/
    if (indexPath.section == 0) {
        cell.textLabel.text = @"Add photo";
        cell.detailTextLabel.text = @"from website";
    }else{
        cell.textLabel.text = @"Find all photos";
        cell.detailTextLabel.text = @"from website";
    }
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    // Website* info = [websites objectAtIndex:section];
    // return info.name;
    if (section == 0) {
        return @"Download";
    }else{
        return @"Search";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PhotosAddViewController* newView = [PhotosAddViewController new];
        [self.navigationController pushViewController:newView animated:YES];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        PhotosSearchViewController * pictureView = [[PhotosSearchViewController alloc] init];
        [self.navigationController pushViewController:pictureView animated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
