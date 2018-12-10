//
//  SongCell.m
//  MPMedia
//
//  Created by QQ Shih on 2017/4/14.
//  Copyright © 2017年 QQ Shih. All rights reserved.
//

#import "SongCell.h"
#import "Artist.h"

@implementation SongCell

+ (NSString *)cellIdentifier {
    return @"song_cell";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSong:(Song *)song {
    self.songName.text = song.title;
    self.artistName.text = song.artist.name;
    self.songImage.image = [UIImage imageWithData:song.imageData];
}

@end
