//
//  TableViewController.m
//  collectionView
//
//  Created by juyouicheiOS on 15/12/13.
//  Copyright © 2015年 juyouicheiOS. All rights reserved.
//

#import "TableViewController.h"
#import "AFNetworking.h"
#import "NameModel.h"
#import "TableView2222Controller.h"


@interface TableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray * indexTitleArray;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
//    [self refreshCollectionView];
       [self refreshCollectionView1];
    self.tableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    UIButton * button = [[UIButton  alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)backTo{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)refreshCollectionView1{
    _dataSource = [NSMutableArray array];
    _indexTitleArray = [NSMutableArray array];
    NSString * urlStr = @"http://guzhiapi.jingzhengu.com/JuYouChe.asmx/GetMakes?HTTP/1.1";
    // urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", urlStr);
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString * html = operation.responseString;
//                NSLog(@"%@", html);
        
        NSRange range1 = [html rangeOfString:@"["];
        
        NSRange range2 = [html rangeOfString:@"]"];
        
        NSString * str1 = [html substringFromIndex:range1.location];
        
        NSString * str2 = [str1 substringToIndex:range2.location - range1.location + 1];
        NSLog(@"str2  %@", str2);
        
        
//        NSArray * array = [str2 componentsSeparatedByString:@"{"];
        
        
//        NSMutableArray *dataSourceArr = [NSMutableArray array];
//        
//        for (NSString * str in array) {
//            //            NSLog(@"str     %@", str);
//            if (![str isEqualToString:@""]) {
//                NSRange range3 = [str rangeOfString:@"GroupName"];
//                //                NSLog(@"range3  %lu", (unsigned long)range3.length);
//                NSString * str3 = [str substringFromIndex:range3.length + 4];
//                //                NSLog(@"str3  %@", str3);
//                
//                NameModel * model = [[NameModel alloc]init];
//                NSString * str4 = [str3 substringToIndex:1];
//                //               NSLog(@"str4  %@", str4);
//                NSRange range4 = [str3 rangeOfString:@"Name"];
//                NSString * str5 = [str3 substringFromIndex:range4.length + 7];
//                //                NSLog(@"str5  %@", str5);
//                NSRange range5 = [str5 rangeOfString:@","];
//                NSString * str6 = [str5 substringToIndex:range5.location - 1];
//                //                NSLog(@"str6  %@", str6);
//                
//                NSRange range6 = [str5 rangeOfString:@":"];
//                NSString * str7 = [str5 substringFromIndex:range6.location + 2];
//                //                NSLog(@"str7  %@", str7);
//                
//                NSRange range7 = [str7 rangeOfString:@"}"];
//                NSString * str8 = [str7 substringToIndex:range7.location - 1];
//                //                   NSLog(@"str8  %@", str8);
//                model.GroupName = str4;
//                model.provienceName = str6;
//                model.provienceID = str8;
//                //               [_dataSource addObject:model];
//                //                NSLog(@"model %@", model);
//                [dataSourceArr addObject:model];
//            }
//            
//        }
//        
//        NSString * currentAleph = @"";
//        NSString * lastAleph = @"";
//        if (dataSourceArr.count > 0) {
//            NameModel * model1 = dataSourceArr[0];
//            NSString *firstNamePinYIn = model1.GroupName;
//            NameModel * model2 = dataSourceArr[dataSourceArr.count - 1];
//            NSString *lastNamePinYIn = model2.GroupName;
//            currentAleph = [NSString stringWithFormat:@"%c",[firstNamePinYIn characterAtIndex:0]];
//            lastAleph = [NSString stringWithFormat:@"%c",[lastNamePinYIn characterAtIndex:0]];
//            
//        }
//        
//        NSMutableArray * mutableAlephGroupArr = [NSMutableArray array];
//        NSMutableArray * groupArr = [NSMutableArray array];
//        for (NameModel * model in dataSourceArr) {
//            
//            NSString * nameFirstLetter = [[NSString alloc] initWithFormat:@"%@",model.GroupName];
//            
//            if ([currentAleph isEqualToString: nameFirstLetter]) {
//                [mutableAlephGroupArr addObject:model];
//                //                NSLog(@"2222  %@", mutableAlephGroupArr);
//            }else{
//                [groupArr addObject:@{@"indexTitle":currentAleph,@"Info":[mutableAlephGroupArr mutableCopy]}];
//                [self.indexTitleArray addObject:currentAleph];
//                [mutableAlephGroupArr removeAllObjects];
//                currentAleph = nameFirstLetter;
//                [mutableAlephGroupArr addObject:model];
//                
////                NSLog(@"3333333  %@", mutableAlephGroupArr);
//            }
//        }
//        
//        if (![lastAleph isEqualToString:@""]) {
//            [groupArr addObject:@{@"indexTitle":lastAleph,@"Info":[mutableAlephGroupArr mutableCopy]}];
//        }
//         [self.indexTitleArray addObject:lastAleph];
//       
//        [_dataSource addObjectsFromArray:[groupArr mutableCopy]];
//        
//              NSLog(@"%@", _dataSource);
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
    
    [operation start];
    
}

- (void)refreshCollectionView{
    _dataSource = [NSMutableArray array];
    _indexTitleArray = [NSMutableArray array];
    NSString * urlStr = @"http://guzhiapi.jingzhengu.com/JuYouChe.asmx/GetMakes?HTTP/1.1";
    // urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", urlStr);
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString * html = operation.responseString;
        //                NSLog(@"%@", html);
        
        NSRange range1 = [html rangeOfString:@"["];
        
        NSRange range2 = [html rangeOfString:@"]"];
        
        NSString * str1 = [html substringFromIndex:range1.location + 1];
        
        NSString * str2 = [str1 substringToIndex:range2.location - range1.location - 1];
        NSLog(@"str2  %@", str2);
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
        
        if (![lastAleph isEqualToString:@""]) {
            [groupArr addObject:@{@"indexTitle":lastAleph,@"Info":[mutableAlephGroupArr mutableCopy]}];
        }
        [self.indexTitleArray addObject:lastAleph];
        
        [_dataSource addObjectsFromArray:[groupArr mutableCopy]];
        
        //              NSLog(@"%@", _dataSource);
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
    
    [operation start];
    
}


- (void)loadData{
    //    _dataSource = [NSMutableArray array];
    ////     NSURL * url = [NSURL URLWithString:@"http://guzhiapi.jingzhengu.com/JuYouChe.asmx/GetProvince?HTTP/1.1"];
    //    NSURL * url = [NSURL URLWithString:@"http://guzhiapi.jingzhengu.com/JuYouChe.asmx/GetMakes?HTTP/1.1"];
    //
    //    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
    //        if (connectionError == nil) {
    //            DDXMLDocument * xmlDoc = [[DDXMLDocument alloc]initWithData:data options:0 error:nil];
    ////            NSLog(@"%@", xmlDoc);
    //             DDXMLElement *rootEle = xmlDoc.rootElement;
    ////            NSLog(@"%@", rootEle);
    //
    //            NSString * html = rootEle;
    ////            NSLog(@"str  %@", html);
    //
    //             NSString * str = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
    //             NSString * strhtml = [html stringByReplacingOccurrencesOfString:str withString:@""];
    //             strhtml = [strhtml stringByReplacingOccurrencesOfString:@"<string xmlns=\"http://tempuri.org/\">" withString:@""];
    //             strhtml = [strhtml stringByReplacingOccurrencesOfString:@"</string>"@"" withString:@""];
    //
    //             NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    //             strhtml= [[NSString alloc]initWithString:[strhtml stringByTrimmingCharactersInSet:whiteSpace]];
    //            NSLog(@"%@", strhtml);
    //            
    //            
    //            
    //            
    //            NSLog(@"%@", _dataSource);
    //        }else{
    //             NSLog(@"%@", connectionError);
    //        }
    //    }];
    
}




#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//   return _dataSource.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSDictionary * userInforDict = _dataSource[section];
//    NSArray * array = userInforDict[@"Info"];
//    return array.count;
    return 10;
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
    
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSDictionary * userInfoDict = _dataSource[section];
//    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
//    label.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
//    label.textColor = [UIColor colorWithRed:95.0/255.0 green:95.0/255.0 blue:95.0/255.0 alpha:1.0];
//    label.font = [UIFont systemFontOfSize:15.0f];
//    label.text = [NSString stringWithFormat:@"        %@", userInfoDict[@"indexTitle"]];
////    NSLog(@"%@",userInfoDict[@"indexTitle"]);
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
//    TableView2222Controller * viewController = [[TableView2222Controller alloc]init];
//    NSDictionary * userInforDict = _dataSource[indexPath.section];
//    NSArray * array = userInforDict[@"Info"];
//    NameModel * model = array[indexPath.row];
//   viewController.carName = model.provienceName;
//    viewController.carID = model.provienceID;
//    [self presentViewController:viewController animated:YES completion:nil];

}




@end
