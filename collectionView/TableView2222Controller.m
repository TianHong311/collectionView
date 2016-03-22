//
//  TableView2222Controller.m
//  collectionView
//
//  Created by juyouicheiOS on 15/12/13.
//  Copyright © 2015年 juyouicheiOS. All rights reserved.
//

#import "TableView2222Controller.h"
#import "AFNetworking.h"
#import "NameModel.h"
@interface TableView2222Controller ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray * indexTitleArray;
@end

@implementation TableView2222Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    [self refreshCollectionView];
    
    UIButton * button = [[UIButton  alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)backTo{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)refreshCollectionView{
    _dataSource = [NSMutableArray array];
    _indexTitleArray = [NSMutableArray array];
    NSString * urlStr = [NSString stringWithFormat:@"http://guzhiapi.jingzhengu.com/JuYouChe.asmx/GetModelByMakeId?HTTP/1.1&MakeId=%@", _carID];
    NSLog(@"%@", urlStr);
    //    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString * html = operation.responseString;
    
//        NSLog(@"%@", html);
        
        NSRange range1 = [html rangeOfString:@"["];
        
        NSRange range2 = [html rangeOfString:@"]"];
        
        NSString * str1 = [html substringFromIndex:range1.location + 1];
        
        NSString * str2 = [str1 substringToIndex:range2.location - range1.location - 1];
        NSLog(@"str2    %@", str2);
        NSArray * array = [str2 componentsSeparatedByString:@"{"];
        
//        NSLog(@"%d", array.count);
        NSMutableArray *dataSourceArr = [[NSMutableArray alloc]init];

        for (NSString * str in array) {
                        NSLog(@"str     %@", str);
            if (![str isEqualToString:@""]) {
                
                NSArray * array1 = [str componentsSeparatedByString:@":"];

//                NSRange range3 = [str rangeOfString:@"GroupName"];
//                                NSLog(@"range3  %lu", (unsigned long)range3.length);
//                NSString * str3 = [str substringFromIndex:range3.length + 4];
//               
//                
//                NameModel * model = [[NameModel alloc]init];
//                NSLog(@"str3  %@", str3);
                if ([str rangeOfString:@"MakeId"].location != NSNotFound) {
                    NSLog(@"yes");
                    for (NSString * dtrr in array1) {
                        NSArray * array2 = [str componentsSeparatedByString:@"\""];
                        NSLog(@"array2  %@, %@, %@, %@", array2[3], array2[7], array2[11], array2[15]);
                        
                        
                        break;
                    }
                    
                }else{
                     NSLog(@"no");
                    
                    for (NSString * dtrr in array1) {
                        NSArray * array2 = [str componentsSeparatedByString:@"\""];
                        NSLog(@"array2  %@, %@, %@", array2[3], array2[7], array2[11]);
                        
                        
                        break;
                    }
                    
                }
//
////                NSRange range9 = [str3 rangeOfString:@"MakeId"];
////                NSLog(@"s  %ld    %ld", (unsigned long)range9.location, (unsigned long)range9.length);
////                NSString * strrr = [str3 substringToIndex:range9.location];
////                NSLog(@"strrrr  %@", strrr);
////                NSRange range10 = [strrr rangeOfString:@","];
////                NSString * strtrter = [strrr substringToIndex:range10.location - 2];
////                NSLog(@"strtrter %@", strtrter);
//                              //               [_dataSource addObject:model];
//                //                NSLog(@"model %@", model);
//              
            }
//
//        }
//        NSLog(@"   %d", dataSourceArr.count);
//        NSString * currentAleph = @"";
//        NSString * lastAleph = @"";
//        if (dataSourceArr.count > 0) {
//            NameModel * model1 = dataSourceArr[0];
//            NSString *firstNamePinYIn = model1.GroupName;
//            NameModel * model2 = dataSourceArr[dataSourceArr.count - 1];
//            NSString *lastNamePinYIn = model2.GroupName;
//            currentAleph = [NSString stringWithFormat:@"%@",firstNamePinYIn];
//            lastAleph = [NSString stringWithFormat:@"%@",lastNamePinYIn];
////            NSLog(@"%@    %@", currentAleph, lastAleph);
//        }else{
//            NSLog(@"没有");
//            // 无数据背景图
//            if (_dataSource.count == 0) {
//                [self.tableView setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nodata"]]];
//                [self.tableView.backgroundView setContentMode:UIViewContentModeCenter];
//            } else {
//                [self.tableView setBackgroundView:nil];
//            }
//
//        }
//
//        NSMutableArray * mutableAlephGroupArr = [[NSMutableArray alloc]init];;
//        NSMutableArray * groupArr = [[NSMutableArray alloc]init];
//        if (dataSourceArr.count > 0) {
//            for (NameModel * model in dataSourceArr) {
////                NSLog(@"1234   %@", model.GroupName);
//                NSString * nameFirstLetter = model.GroupName;
//                
//                if ([currentAleph isEqualToString: nameFirstLetter]) {
//                    [mutableAlephGroupArr addObject:model];
////                    NSLog(@"2222  %@", mutableAlephGroupArr);
//                }else{
//                    [groupArr addObject:@{@"indexTitle":currentAleph,@"Info":[mutableAlephGroupArr mutableCopy]}];
//                    [self.indexTitleArray addObject:currentAleph];
//                    [mutableAlephGroupArr removeAllObjects];
////                      NSLog(@"33333  %@", mutableAlephGroupArr);
//                    currentAleph = nameFirstLetter;
//                    [mutableAlephGroupArr addObject:model];
////                    NSLog(@"44444  %@", mutableAlephGroupArr);
//                }
//            }
        
//            if (![lastAleph isEqualToString:@""]) {
//                [groupArr addObject:@{@"indexTitle":lastAleph,@"Info":[mutableAlephGroupArr mutableCopy]}];
//            }
        }

        
//        [self.indexTitleArray addObject:lastAleph];
//        NSLog(@"%@", _indexTitleArray);
//        [_dataSource addObjectsFromArray:[groupArr mutableCopy]];
//        [self.tableView reloadData];
//        NSLog(@"%d", _dataSource.count);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
    
    [operation start];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
  return _dataSource.count ;
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSDictionary * userInforDict = _dataSource[section];
//    NSArray * array = userInforDict[@"Info"];
//    return array.count;
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
//    NSDictionary * userInforDict = _dataSource[indexPath.section];
//    NSArray * array = userInforDict[@"Info"];
//    NameModel * model = array[indexPath.row];
//    cell.textLabel.text = model.provienceName;
//    
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSDictionary * userInfoDict = _dataSource[section];
//    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
//    label.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
//    label.textColor = [UIColor colorWithRed:95.0/255.0 green:95.0/255.0 blue:95.0/255.0 alpha:1.0];
//    label.font = [UIFont systemFontOfSize:15.0f];
//    label.text = [NSString stringWithFormat:@"        %@", userInfoDict[@"indexTitle"]];
//    NSLog(@"%@",userInfoDict[@"indexTitle"]);
//    return label;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   return 20;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    
//    return self.indexTitleArray;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TableView2222Controller * viewController = [[TableView2222Controller alloc]init];
    NSDictionary * userInforDict = _dataSource[indexPath.section];
    NSArray * array = userInforDict[@"Info"];
    NameModel * model = array[indexPath.row];
    viewController.carName = model.provienceName;
    viewController.carID = model.provienceID;
    [self presentViewController:viewController animated:YES completion:nil];
    
}

@end
