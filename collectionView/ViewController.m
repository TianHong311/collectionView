//
//  ViewController.m
//  collectionView
//
//  Created by juyouicheiOS on 15/12/12.
//  Copyright © 2015年 juyouicheiOS. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "DDXML.h"
#import "AFNetworking.h"
#import "NameModel.h"
#import "TableViewController.h"




#define kCollectionViewCell @"kCollectionViewCell"
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
// 存放模型的数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray * indexTitleArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kCollectionViewCell];
    [self loadData];
    [self refreshCollectionView];
    [self iniininii];
}

- (void)iniininii{
     NSString * urlStr = [NSString stringWithFormat:@"http://guzhiapi.jingzhengu.com/JuYouChe.asmx/EstimateOldCarByArea?HTTP/1.1&TrimId=110871&BuyCarData=2013.12.16&Mileages=23&ProvinceId=2401&CityId=2401"];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:2.0f];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString * html = operation.responseString;
        NSString * str = html;
        NSRange  range1 = [str rangeOfString:@"Msrp"];
        NSString * str1 = [str substringFromIndex:range1.location + range1.length + 3];
 
        NSRange  range3 = [str rangeOfString:@"B2CPrices"];
        NSString * str2 = [str substringFromIndex:range3.location + range3.length + 3];
        NSRange  range4 = [str2 rangeOfString:@"B2BPrices"];
        NSString * str3 = [str2 substringToIndex:range4.location - 3];
        
        NSRange range5 = [str rangeOfString:@"B2BPrices"];
        NSString * str4 = [str substringFromIndex:range5.location + range5.length + 3];
        NSRange range6 = [str4 rangeOfString:@"PtvUrl"];
        NSString * str5 = [str4 substringToIndex:range6.location - 3];
        
        
        [self resovleString:str5];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"error   %@", error);
    }];
    
    [operation start];


}

- (void)resovleString:(NSString * )str{
    NSString * str4 = [str substringFromIndex:8];
    NSLog(@"str4  %@", str4);
    NSRange range5 = [str4 rangeOfString:@"B"];
    NSString * str5 = [str4 substringToIndex:range5.location - 3];
    NSLog(@"str5  %@",str5);
    
    NSString * str6 = [str4 substringFromIndex:range5.location + 5];
    NSLog(@"str6 %@", str6);
    NSRange  range6 = [str6 rangeOfString:@"C"];
    NSString * str7 = [str6 substringToIndex:range6.location - 3];
    NSLog(@"str7  %@", str7);
    
    
    NSString * str8 = [str6 substringFromIndex:range6.location + 5];
    NSLog(@"str8 %@", str8);
    NSString * str9 = [str8 substringToIndex:str8.length - 1];
    NSLog(@"str9 %@", str9);
}


- (void)refreshCollectionView{
    _dataSource = [NSMutableArray array];
    _indexTitleArray = [NSMutableArray array];
    NSString * urlStr = @"http://guzhiapi.jingzhengu.com/JuYouChe.asmx/GetMakes?HTTP/1.1";
    NSLog(@"%@", urlStr);
    
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:2.0f];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString * html = operation.responseString;
        NSLog(@"aergiargwhoia");
//        NSLog(@"html   %@", html);

        NSRange range1 = [html rangeOfString:@"["];
        
        NSRange range2 = [html rangeOfString:@"]"];
        
        NSString * str1 = [html substringFromIndex:range1.location + 1];
        
        NSString * str2 = [str1 substringToIndex:range2.location - range1.location - 1];

        NSArray * array = [str2 componentsSeparatedByString:@"{"];
        
        
          NSMutableArray *dataSourceArr = [NSMutableArray array];
        
        for (NSString * str in array) {
//            NSLog(@"str     %@", str);
            if (![str isEqualToString:@""]) {
                NSRange range3 = [str rangeOfString:@"GroupName"];
//                NSLog(@"range3  %lu", (unsigned long)range3.length);
                NSString * str3 = [str substringFromIndex:range3.length + 4];
//                NSLog(@"str3  %@", str3);
                
               NameModel * model = [[NameModel alloc]init];
               NSString * str4 = [str3 substringToIndex:1];
//               NSLog(@"str4  %@", str4);
               NSRange range4 = [str3 rangeOfString:@"Name"];
               NSString * str5 = [str3 substringFromIndex:range4.length + 7];
//                NSLog(@"str5  %@", str5);
               NSRange range5 = [str5 rangeOfString:@","];
               NSString * str6 = [str5 substringToIndex:range5.location - 1];
//                NSLog(@"str6  %@", str6);
                
                NSRange range6 = [str5 rangeOfString:@":"];
                NSString * str7 = [str5 substringFromIndex:range6.location + 2];
//                NSLog(@"str7  %@", str7);
                
                NSRange range7 = [str7 rangeOfString:@"}"];
                NSString * str8 = [str7 substringToIndex:range7.location - 1];
//                   NSLog(@"str8  %@", str8);
                 model.GroupName = str4;
               model.provienceName = str6;
               model.provienceID = str8;
//               [_dataSource addObject:model];
//                NSLog(@"model %@", model);
                [dataSourceArr addObject:model];
            }
           
        }
        
        NSString * currentAleph = @"";
        NSString * lastAleph = @"";
        if (dataSourceArr.count > 0) {
            NameModel * model1 = dataSourceArr[0];
            NSString *firstNamePinYIn = model1.GroupName;
            NameModel * model2 = dataSourceArr[dataSourceArr.count - 1];
            NSString *lastNamePinYIn = model2.GroupName;
            currentAleph = [NSString stringWithFormat:@"%c",[firstNamePinYIn characterAtIndex:0]];
            lastAleph = [NSString stringWithFormat:@"%c",[lastNamePinYIn characterAtIndex:0]];
            
        }
        
        NSMutableArray * mutableAlephGroupArr = [NSMutableArray array];
        NSMutableArray * groupArr = [NSMutableArray array];
        for (NameModel * model in dataSourceArr) {
          
            NSString * nameFirstLetter = [[NSString alloc] initWithFormat:@"%@",model.GroupName];
            
            if ([currentAleph isEqualToString: nameFirstLetter]) {
                [mutableAlephGroupArr addObject:model];
//                NSLog(@"2222  %@", mutableAlephGroupArr);
            }else{
                [groupArr addObject:@{@"indexTitle":currentAleph,@"Info":[mutableAlephGroupArr mutableCopy]}];
                [self.indexTitleArray addObject:currentAleph];
                [mutableAlephGroupArr removeAllObjects];
                currentAleph = nameFirstLetter;
                [mutableAlephGroupArr addObject:model];
//                NSLog(@"3333333  %@", mutableAlephGroupArr);
            }

            
        }
        
        [self.indexTitleArray addObject:lastAleph];
        [_dataSource addObjectsFromArray:[groupArr mutableCopy]];
        
//         NSLog(@"%@", _dataSource);
        [self.collectionView reloadData];
     
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
         NSLog(@"error   %@", error);
    }];
    
    [operation start];

}

- (void)loadData{

//    NSURL * url = [NSURL URLWithString:@"http://guzhiapi.jingzhengu.com/JuYouChe.asmx/GetMakes?HTTP/1.1"];
    
   

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataSource.count;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSDictionary * userInforDict = _dataSource[section];
    NSArray * array = userInforDict[@"Info"];
//    NSLog(@"array   %@", array);
    return array.count;
//    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256 /255.0f green:arc4random() % 256 /255.0f blue:arc4random() % 256 /255.0f alpha:1.0f];
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
    
//    NameModel * model = _dataSource[indexPath.item];
//    cell.titltttttLbel.text = model.provienceName;
    cell.titltttttLbel.text = @"SDFGSDFG";
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(80, 60);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TableViewController * viewController = [[TableViewController alloc]init];
    
    [self presentViewController:viewController animated:YES completion:nil];
}




@end
