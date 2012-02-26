//
//  SearchViewController_iPhone.m
//  Sex
//
//  Created by mac on 11-11-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController_iPhone.h"


@implementation SearchViewController_iPhone
@synthesize tbView;
@synthesize content;
@synthesize nibLoadedCell;
@synthesize filteredListContent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [tbView release];
    [content release];
    for (UIView *view in [nibLoadedCell subviews]) {
        [view removeFromSuperview];
    }
    [nibLoadedCell release];
    [filteredListContent release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:Background_iPhone]];
    self.tbView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"search_iphone.jpg"]];
    self.searchDisplayController.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	self.searchDisplayController.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.tbView.tableHeaderView = self.searchDisplayController.searchBar;
    self.searchDisplayController.searchBar.text = nil;
    sqliteOperation = [[SQLiteOperation alloc] init];
    content = [[sqliteOperation selectData:SelectAll resultColumns:10] retain];    
    tbView.delegate = self;
    tbView.dataSource = self;
    self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.content count]];
    NSLog(@"%d",[content count]);
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [filteredListContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {                
        [[NSBundle mainBundle] loadNibNamed:@"SearchCell_iPhone" owner:self options:NULL];
		cell = nibLoadedCell;        
    }
    UIImageView *imageView = [Utils addImageViewToView:CGRectMake(10, 5, 50, 50) :0 :[UIImage imageNamed:[[filteredListContent objectAtIndex:indexPath.row] objectAtIndex:3]]];
    [cell addSubview:imageView];
    [imageView release];
    
    UILabel *titleLabel = [Utils addLabelToView:CGRectMake(70, 5, 200, 20) :0 :[[filteredListContent objectAtIndex:indexPath.row] objectAtIndex:2] :13.0];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = UITextAlignmentLeft;
    [cell addSubview:titleLabel];
    [titleLabel release];
    
    UILabel *chaLabel  = [Utils addLabelToView:CGRectMake(70, 35, 60, 20) :0 :@"Challenge" :12.0];
    chaLabel.textColor = [UIColor blackColor];
    chaLabel.textAlignment = UITextAlignmentLeft;
    [cell addSubview:chaLabel];
    [chaLabel release];
    
    for (int i = 0; i < [[[filteredListContent objectAtIndex:indexPath.row] objectAtIndex:5] intValue]; ++i) {
        UIImageView *imageView = [Utils addImageViewToView:CGRectMake(130+10*i, 40, 10, 10) :0 :[UIImage imageNamed:LittleStar]];
        [cell addSubview:imageView];
        [imageView release];
    }
    
    UILabel *pleaLabel = [Utils addLabelToView:CGRectMake(190, 35, 60, 20) :0 :@"Pleasure" :12.0];
    pleaLabel.textColor = [UIColor blackColor];
    pleaLabel.textAlignment = UITextAlignmentLeft;
    [cell addSubview:pleaLabel];
    [pleaLabel release];
    
    for (int i = 0; i < [[[filteredListContent objectAtIndex:indexPath.row] objectAtIndex:6] intValue]; ++i) {
        UIImageView *imageView = [Utils addImageViewToView:CGRectMake(250+10*i, 40, 10, 10) :0 :[UIImage imageNamed:LittleStar]];
        [cell addSubview:imageView];
        [imageView release];
    }
    
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.	

	for (int i = 0;i < [content count]; ++i)
	{
		NSComparisonResult result = [[[content objectAtIndex:i] objectAtIndex:2] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame)
        {
            [self.filteredListContent addObject:[content objectAtIndex:i]];
        }
	}
    NSLog(@"filteredListContent count %d",[filteredListContent count]);
    
}
#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];

    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemShowController_iPhone *itemShowController = [[ItemShowController_iPhone alloc] initWithNibName:@"ItemShowController_iPhone" bundle:nil];
    itemShowController.content = filteredListContent;
    itemShowController.startFlag = indexPath.row;
    itemShowController.title = [[filteredListContent objectAtIndex:indexPath.row] objectAtIndex:2];
    [self.navigationController pushViewController:itemShowController animated:YES];
    [itemShowController release]; 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    return 60.0f;
}

@end
