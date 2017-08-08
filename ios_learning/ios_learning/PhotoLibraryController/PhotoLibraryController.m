//
//  PhotoLibraryController.m
//  ios_learning
//
//  Created by Gideon on 8/7/17.
//  Copyright © 2017 Gideon. All rights reserved.
//

#import "PhotoLibraryController.h"
#import <Photos/Photos.h>
@interface PhotoLibraryController ()
@end

@implementation PhotoLibraryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestPhotoAccessPermission];
}

- (void)createPhotoCollection
{
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"Gideon0807"];
        
    } completionHandler:^(BOOL success, NSError *error) {
        NSLog(@"Finished create collection from the album. %@", (success ? @"Success" : error));
    }];
}

- (void)deleteCollection
{
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.predicate = [NSPredicate predicateWithFormat:@"title LIKE %@", @"Gideon*"];
    options.fetchLimit = MAXFLOAT;
    PHFetchResult *results = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:options];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetCollectionChangeRequest deleteAssetCollections:results];
        
    } completionHandler:^(BOOL success, NSError *error) {
        NSLog(@"Finished create collection from the album. %@", (success ? @"Success" : error));
    }];
    
}

- (void)fetCollections
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //获取系统相册
        PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
        NSLog(@"系统相册%ld", smartAlbums.count);

        [smartAlbums enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PHAssetCollection *collection = (PHAssetCollection*)obj;
            if (collection.assetCollectionSubtype != 202 && collection.assetCollectionSubtype != 208 && collection.assetCollectionSubtype < 212) {
                PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:options];
                BOOL original = NO;

                for (PHAsset *asset in fetchResult) {
                    // 是否要原图
                    CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
                    
                    // 从asset中获得图片
                    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
                    // 同步获得图片, 只会返回1张图片
//                    imageOptions.synchronous = YES;
                    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:imageOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                        NSLog(@"图片内容%@", result);
                    }];
                }
            }
        }];
        
        //获取用户创建相册
        PHFetchResult *albums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        NSLog(@"用户创建相册%ld", albums.count);

        [albums enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PHAssetCollection *collection = (PHAssetCollection*)obj;
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:options];
            
            for (PHAsset *asset in fetchResult) {
                // 是否要原图
                BOOL original = NO;
                CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
                
                PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
                // 同步获得图片, 只会返回1张图片
//                imageOptions.synchronous = YES;
                // 从asset中获得图片
                [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:imageOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    NSLog(@"图片内容%@", result);
                }];
            }
        }];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        });
        
    });
}

- (void)requestPhotoAccessPermission
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized ||
            status == PHAuthorizationStatusNotDetermined) {
            [self fetCollections];
//            [self createPhotoCollection];
            [self deleteCollection];
        }
    }];
}
@end
