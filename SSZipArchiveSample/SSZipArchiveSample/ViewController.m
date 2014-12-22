//
//  ViewController.m
//  SSZipArchiveSample
//
//  Created by Toshikazu Fukuoka on 2014/12/22.
//  Copyright (c) 2014年 Toshikazu Fukuoka. All rights reserved.
//

#import "ViewController.h"
#import "SSZipArchive.h"

@interface ViewController () <SSZipArchiveDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // パスワード付きzipを解凍する
    NSString *zipFilePath = [[NSBundle mainBundle] pathForResource:@"photo1" ofType:@"zip"];
    NSString *destinationPath = NSTemporaryDirectory();
    NSString *password = @"12345";
    NSError *error = nil;
    [SSZipArchive unzipFileAtPath:zipFilePath
                    toDestination:destinationPath
                        overwrite:YES
                         password:password
                            error:&error
                         delegate:self];
    if (error) {
        // エラーが発生した場合
        NSLog(@"error:%@", error);
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SSZipArchiveDelegate
- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath {

    // 解凍したzipファイルから画像ファイルを読み込んでUIImageViewに設定する
    NSString *filePath = [NSString stringWithFormat:@"%@/photo1.jpg",unzippedPath];
    NSData *photoData = [NSData dataWithContentsOfFile:filePath];
    self.imageView.image = [UIImage imageWithData:photoData scale:[[UIScreen mainScreen] scale]];
}

@end
