//
//  TESTXib.m
//  TEST2048WithCollectionView
//
//  Created by renren on 16/3/14.
//  Copyright © 2016年 renren. All rights reserved.
//

#import "TESTXib.h"

@interface TESTXib ()

@end

@implementation TESTXib

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToBack)];
    [self.testView addGestureRecognizer:tapGesture];
}

- (void)goToBack {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
