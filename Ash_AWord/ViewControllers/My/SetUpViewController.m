//
//  SetUpViewController.m
//  Ash_AWord
//
//  Created by xmfish on 15/4/1.
//  Copyright (c) 2015年 ash. All rights reserved.
//

#import "SetUpViewController.h"

@interface SetUpViewController ()

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customViewDidLoad];
    self.navigationItem.title = @"设置";
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100.0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (![AWordUser sharedInstance].isLogin) {
        return nil;
    }
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    view.backgroundColor = [UIColor clearColor];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(lgout:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    button.layer.cornerRadius = 5.0;
    button.layer.masksToBounds = YES;
    button.frame = CGRectMake(20, 25, kScreenWidth-40, 40);
    [view addSubview:button];
    return view;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"清除缓存";
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                SDImageCache *cache = [SDImageCache sharedImageCache];
                NSUInteger size = [cache getSize];
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.detailTextLabel.text = size/1024 < 1024 ? [NSString stringWithFormat:@"%.2fKB",(float)size/1024.0]:[NSString stringWithFormat:@"%.2fMB",(float)size/(1024.0*1024.0)];
                });
            });

        }
            
            break;
        case 1:
            cell.textLabel.text = @"推荐给朋友";
            break;
        case 2:
        {
            cell.textLabel.text = @"当前版本";
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            NSString *buildVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
            NSString *version = [NSString stringWithFormat:@"v%@.%@",app_Version, buildVersion];
            cell.detailTextLabel.text = version;
        }
            break;
        case 3:
            cell.textLabel.text = @"关于我们";
            break;
        case 4:
            cell.textLabel.text = @"欢迎打5星好评";
            break;
            
        default:
            break;
    }
    return cell;
}
-(void)lgout:(id)sender
{
    [AWordUser sharedInstance].isLogin = NO;
    [AWordUser sharedInstance].uid = @"";
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccessNotificationName object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end