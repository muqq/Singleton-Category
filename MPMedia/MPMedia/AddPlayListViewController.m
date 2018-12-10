//
//  AddPlayListViewController.m
//  MPMedia
//
//  Created by QQ Shih on 2017/4/14.
//  Copyright © 2017年 QQ Shih. All rights reserved.
//

#import "AddPlayListViewController.h"
#import "SelectSongViewController.h"
#import "SongCell.h"
#import "PlayList.h"
#import "MediaManager+Realm.h"

@interface AddPlayListViewController () <SelectSongViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *playListTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) RLMArray<Song *><Song> *songs;
@property (nonatomic) BOOL isDirty;

@end

@implementation AddPlayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isDirty = false;
    [self.tableView registerNib:[UINib nibWithNibName:@"SongCell" bundle:nil] forCellReuseIdentifier: [SongCell cellIdentifier]];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    if (self.playlist) {
        self.songs = self.playlist.songs;
        [self.tableView reloadData];
        self.playListTextField.text = self.playlist.name;
    } else {
        self.playlist = [[PlayList alloc] init];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if ([[segue destinationViewController] isKindOfClass:[SelectSongViewController class]]) {
        SelectSongViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

#pragma mark - SelectSongViewController

- (void)selectSongView:(SelectSongViewController *)controller didSelectSongs:(RLMArray<Song *><Song> *)songs {
    self.isDirty = true;
    self.songs = songs;
    [self.tableView reloadData];
}

#pragma mark - IBAction

- (IBAction)finishButtonTouchUpInside:(id)sender {
    if (self.playListTextField.text.length > 0 && ![self.playListTextField.text isEqualToString:@""]) {
        __weak AddPlayListViewController *weakSelf = self;
        [MediaManager.sharedManager updateObjectWithObject:self.playlist block:^{
            if (_isDirty) {
                weakSelf.playlist.songs = weakSelf.songs;
            }
            weakSelf.playlist.name = weakSelf.playListTextField.text;
        }];
        
        [self dismissViewControllerAnimated:true completion:nil];
        [weakSelf.delegate addPlayListViewController:weakSelf didFinishUpdateList:weakSelf.playlist];
    }
}

- (IBAction)cancelButtonTouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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
