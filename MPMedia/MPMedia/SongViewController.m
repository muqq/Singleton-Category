//
//  ViewController.m
//  MPMedia
//
//  Created by QQ Shih on 2017/4/13.
//  Copyright © 2017年 QQ Shih. All rights reserved.
//

#import "SongViewController.h"
#import "MediaManager+Song.h"
#import "SongCell.h"

@interface SongViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) RLMResults<Song *> *songs;

@end

@implementation SongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak SongViewController *weakSelf = self;
    [MediaManager.sharedManager checkAuth:^(MPMediaLibraryAuthorizationStatus status) {
        if (status == MPMediaLibraryAuthorizationStatusAuthorized) {
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [MediaManager.sharedManager syncSongs];
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.songs = [MediaManager.sharedManager querySongs];
                    [weakSelf.tableView reloadData];
                });
            });
        }
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SongCell" bundle:nil] forCellReuseIdentifier: [SongCell cellIdentifier]];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
}

# pragma mark - UITableViewDelegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[SongCell cellIdentifier] forIndexPath: indexPath];
    cell.song = self.songs[indexPath.row];
    return cell;
}

@end
