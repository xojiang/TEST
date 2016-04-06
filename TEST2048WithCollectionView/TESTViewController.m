//
//  TESTViewController.m
//  TEST2048WithCollectionView
//
//  Created by renren on 16/3/14.
//  Copyright © 2016年 renren. All rights reserved.
//

#import "TESTViewController.h"

@interface TESTViewController ()

@end

@implementation TESTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"TESTXib" owner:self options:nil];
    self.testView = nib[0];
    self.view = self.testView;
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
