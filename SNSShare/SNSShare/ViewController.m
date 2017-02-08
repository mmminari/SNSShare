//
//  ViewController.m
//  SNSShare
//
//  Created by 김민아 on 2017. 2. 8..
//  Copyright © 2017년 김민아. All rights reserved.
//

#import "ViewController.h"
#import "ImageCell.h"
#import "DetailViewController.h"

#import <Photos/PHAsset.h>
#import <Photos/PHCollection.h>
#import <Photos/PHAssetResourceManager.h>
#import <Photos/PHImageManager.h>

#define STANDARD_DEVICE_WIDTH                                       414.0f
#define DEVICE_WIDTH                                                [UIScreen mainScreen].bounds.size.width
#define WRATIO_WIDTH(w)                                             (w/3.0f) / STANDARD_DEVICE_WIDTH * DEVICE_WIDTH

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *imageList;
@property (assign, nonatomic) NSInteger seletedRow;
@property (weak, nonatomic) IBOutlet UICollectionView *cvImage;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageList = [NSMutableArray array];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.cvImage registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCell"];
    
    [self getAlbum];
    
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger result = 0;
    
    result = self.imageList.count;
    
    return result;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ImageCell *cell = [self.cvImage dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    @try {
        
        PHAsset *asset = self.imageList[indexPath.item];
        
        //cell.ivPhoto.image = [self imageFromPHAsset:asset];
        
        [self setImageFromPHAsset:asset imageView:cell.ivPhoto];
        
    } @catch (NSException *exception)
    {
        NSLog(@"exception : %@", exception.description);
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CGFloat cellSize = (DEVICE_WIDTH - 3.0f) / 4 ;
    
    CGSize result = CGSizeMake(cellSize, cellSize);
    
    return result;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"didSelect : %zd", indexPath.item);
    
    self.seletedRow = indexPath.item;
    
    [self performSegueWithIdentifier:@"sgid-moveToDetailVC" sender:self];

}


#pragma mark - PHAsset

- (void)getAlbum
{
    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        PHAsset *asset = (PHAsset *)obj;
        
        [self.imageList addObject:asset];
        
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.cvImage reloadData];
        
    });
    
}

#pragma mark - Private Method

- (void)setImageFromPHAsset:(PHAsset *)asset imageView:(UIImageView *)imageView
{
    CGFloat cellSize = (DEVICE_WIDTH - 3.0f) / 4 ;
    
    CGSize ImageSize = CGSizeMake(cellSize, cellSize);
    
    // PHImageManger을 통해 PHAsset의 Image접근
    // 이미지 로드는 비동기로 처리되기 때문에 dispatch block 안에서 세팅 해주어야 한다.
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:ImageSize contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = result;
        });
        
        
    }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"sgid-moveToDetailVC"])
    {
        DetailViewController *detailVC = [segue destinationViewController];
        
        PHAsset *asset = self.imageList[self.seletedRow];
        
        [self setImageFromPHAsset:asset imageView:detailVC.ivDetail];
    }
}

@end
