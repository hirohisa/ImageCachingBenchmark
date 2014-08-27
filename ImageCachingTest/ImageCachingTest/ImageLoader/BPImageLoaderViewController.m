//
//  BPImageLoaderViewController.m
//  ImageCachingTest
//
//  Created by Hirohisa Kawasaki on 2014/08/27.
//  Copyright (c) 2014年 bpoplauschi. All rights reserved.
//

#import "BPImageLoaderViewController.h"
#import "UIImageView+ImageLoader.h"

@interface BPImageLoaderViewController ()

@end

@implementation BPImageLoaderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"ImageLoader";
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBPCellID];

    cell.textLabel.text = [NSString stringWithFormat:@"%ld %ld", (long)indexPath.section, (long)indexPath.row];
    NSURL *url = [self imageUrlForIndexPath:indexPath];
    cell.imageUrl = url;
    cell.customImageView.image = nil;

    NSDate *initialDate = [NSDate date];
    [cell.customImageView il_setImageWithURL:url placeholderImage:nil completion:^(BOOL finished) {
        CGFloat retrieveTime = [[NSDate date] timeIntervalSinceDate:initialDate];
        [self trackRetrieveDuration:retrieveTime forCacheType:BPCacheTypeNone];
    }];

    return cell;
}

@end
