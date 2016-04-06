//
//  ViewController.m
//  TEST2048WithCollectionView
//
//  Created by renren on 16/3/2.
//  Copyright © 2016年 renren. All rights reserved.
//

#import "ViewController.h"
#import "TESTCollectionViewCell.h"
#import "TESTCollectionViewLayout.h"
#import "TESTViewController.h"
#import "TESTXib.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

static NSString * identifier = @"collectionViewCellIdentifier";

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UITextField * testField;

@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic, strong) NSIndexPath * indexPath;

@property (nonatomic, assign) NSInteger timeCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    if (self.navigationController.navigationBar == nil) {
//        
//    }
//    self.navigationController.navigationBar.hidden = NO;
//    self.navigationController.navigationBar.backgroundColor = [UIColor yellowColor];
    self.title = @"TEST";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"TEST.jpg"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem * testBtn = [[UIBarButtonItem alloc] initWithTitle:@"TEST" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = testBtn;
    self.navigationItem.rightBarButtonItem = testBtn;
    self.navigationController.toolbar.hidden = YES;
    NSArray * testArr = self.navigationController.navigationBar.items;
    NSLog(@"%ld", testArr.count);
    [self initData];
    [self setUpBaseView];
}

- (void)initData {
    self.dataArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 16; i ++) {
        [self.dataArr addObject:@(0)];
    }
    NSInteger initTot = arc4random() % 16;
    self.dataArr[initTot] = @(2);
    self.timeCount = 0;
}

- (void)setUpBaseView {
    
    TESTCollectionViewLayout * layout = [[TESTCollectionViewLayout alloc] init];
    layout.minimumInteritemSpacing = 10.f;
    layout.minimumLineSpacing = 10.f;
    layout.itemSize = CGSizeMake(50.f, 50.f);
    
    UIView * testNaviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    testNaviView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:testNaviView];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 230.f) / 2.f, (SCREEN_HEIGHT - 230.f - 64) / 2.f, 230.f, 230.f + 64.f) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.clipsToBounds = NO;
//    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[TESTCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    UISwipeGestureRecognizer * upSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp)];
    [upSwipeGesture setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.collectionView addGestureRecognizer:upSwipeGesture];
    
    UISwipeGestureRecognizer * downSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown)];
    [downSwipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.collectionView addGestureRecognizer:downSwipeGesture];
    
    UISwipeGestureRecognizer * leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    [leftSwipeGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.collectionView addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer * rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    [rightSwipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.collectionView addGestureRecognizer:rightSwipeGesture];
    
    [self.view addSubview:self.collectionView];
    
    UIView * testView = [[UIView alloc] initWithFrame:CGRectMake(0.f, SCREEN_HEIGHT - 100.f, 50.f, 50.f)];
    testView.backgroundColor = [UIColor purpleColor];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50.f, 50.f)];
    [imageView setImage:[UIImage imageNamed:@"TEST.jpg"]];
//    imageView.contentMode = UIViewContentModeCenter;
    [testView addSubview:imageView];
    [self.view addSubview:testView];
    
    [UIView animateWithDuration:0.8f delay:0.f usingSpringWithDamping:0.1f initialSpringVelocity:3.f options:UIViewAnimationOptionCurveEaseIn animations:^{
        testView.center = CGPointMake(SCREEN_WIDTH / 2.f, SCREEN_HEIGHT - 100.f);
    } completion:^(BOOL finished) {
        
    }];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TESTGOTO)];
    [testView addGestureRecognizer:tapGesture];
//    CABasicAnimation * animation = [CABasicAnimation animation];
//    animation.keyPath = @"position.x";
//    animation.toValue = @(SCREEN_WIDTH / 2);
//    animation.fromValue = @(-SCREEN_WIDTH / 2);
//    animation.duration = 1.5f;
//    [testView.layer addAnimation:animation forKey:nil];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:30.f weight:UIFontWeightLight];
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.text = @"00:00";
    [self.timeLabel sizeToFit];
    self.timeLabel.center = CGPointMake(SCREEN_WIDTH / 2.f, self.collectionView.frame.origin.y - 80.f);
    [self.view addSubview:self.timeLabel];
    
    self.testField = [[UITextField alloc] initWithFrame:CGRectMake(self.timeLabel.frame.origin.x + 100, self.timeLabel.frame.origin.y, 200, 40.f)];
    self.testField.placeholder = @"TEST";
    self.testField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:self.testField];
    
    UITapGestureRecognizer * textFieldGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respond)];
    [self.view addGestureRecognizer:textFieldGesture];
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.view addGestureRecognizer:panGesture];
}

- (void)panView:(UIPanGestureRecognizer *)panGesture {
    CGPoint movePoint = [panGesture translationInView:self.view];
    self.navigationController.view.transform = CGAffineTransformMakeTranslation(movePoint.x, 0);
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        if (movePoint.x < SCREEN_WIDTH / 2.f) {
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:0.2f animations:^{
                weakSelf.navigationController.view.transform = CGAffineTransformMakeTranslation(0, 0);
            }];
        }
    }
}

- (void)respond {
    [self.testField resignFirstResponder];
}

- (void)TESTGOTO {
    
//    BOOL navHide = self.navigationController.navigationBarHidden;
//    [self.navigationController setNavigationBarHidden:!navHide animated:YES];
////    self.collectionView.frame = CGRectMake((SCREEN_WIDTH - 230.f) / 2.f, height, 230.f, 230.f + 64);
//    return;
    TESTXib * vc = [[TESTXib alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:^{
//        
//    }];
}

- (void)updateTime {
    self.timeCount += 1;
    NSInteger secondCount = self.timeCount % 60;
    NSInteger minCount = self.timeCount / 60;
    NSString * secondStr = [NSString stringWithFormat:(secondCount >= 10 ? @"%ld" : @"0%ld"), secondCount];
    NSString * minStr = [NSString stringWithFormat:(minCount >= 10 ? @"%ld" : @"0%ld"), minCount];
    NSString * timeStr = [NSString stringWithFormat:@"%@:%@", minStr, secondStr];
    self.timeLabel.text = timeStr;
}

- (void)swipeUp {
    NSLog(@"Up");
    BOOL moveOK = [self moveUp];
    BOOL addOK = NO;
    for (NSInteger i = 0; i < 4; i ++) {
        for (NSInteger k = 0; k < 4; k ++) {
            NSInteger tot = i + k * 4;
            if (tot + 4 <= 12 + i) {
                NSNumber * currentNum = (NSNumber *)self.dataArr[tot];
                NSNumber * nextNum = (NSNumber *)self.dataArr[tot + 4];
                if ([currentNum isEqualToNumber:nextNum]) {
                    self.dataArr[tot] = @(currentNum.integerValue + nextNum.integerValue);
                    self.dataArr[tot + 4] = @(0);
                    if (![nextNum isEqualToNumber:@(0)]) {
                        addOK = YES;
                    }
                }
            }
        }
    }
    [self moveUp];
    if (!moveOK && !addOK) {
        return;
    }
    [self getNewNum];
}
- (void)swipeDown {
    NSLog(@"Down");
    BOOL moveOK = [self moveDown];
    BOOL addOK = NO;
    for (NSInteger i = 0; i < 4; i ++) {
        for (NSInteger k = 0; k < 4; k ++) {
            NSInteger tot = 15 - k * 4 - i;
            if (tot - 4 >= 3 - i) {
                NSNumber * currentNum = (NSNumber *)self.dataArr[tot];
                NSNumber * nextNum = (NSNumber *)self.dataArr[tot - 4];
                if ([currentNum isEqualToNumber:nextNum]) {
                    self.dataArr[tot] = @(currentNum.integerValue + nextNum.integerValue);
                    self.dataArr[tot - 4] = @(0);
                    if (![nextNum isEqualToNumber:@(0)]) {
                        addOK = YES;
                    }
                }
            }
        }
    }
    [self moveDown];
    if (!moveOK && !addOK) {
        return;
    }
    [self getNewNum];
}
- (void)swipeLeft {
    NSLog(@"Left");
    BOOL moveOK = [self moveLeft];
    BOOL addOK = NO;
    for (NSInteger i = 0; i < 4; i ++) {
        NSInteger tot = i * 4;
        for (NSInteger k = 0; k < 4; k ++) {
            if (k + 1 < 4) {
                NSNumber * currentNum = (NSNumber *)self.dataArr[k + tot];
                NSNumber * nextNum = (NSNumber *)self.dataArr[k + tot + 1];
                if ([currentNum isEqualToNumber:nextNum]) {
                    self.dataArr[k + tot] = @(currentNum.integerValue + nextNum.integerValue);
                    self.dataArr[k + tot + 1] = @(0);
                    if (![nextNum isEqualToNumber:@(0)]) {
                        addOK = YES;
                    }
                }
            }
        }
    }
    [self moveLeft];
    if (!moveOK && !addOK) {
        return;
    }
    [self getNewNum];
}
- (void)swipeRight {
    NSLog(@"Right");
    BOOL moveOK = [self moveRight];
    BOOL addOK = NO;
    for (NSInteger i = 0; i < 4; i ++) {
        NSInteger tot = i * 4 + 3;
        for (NSInteger k = 0; k < 4; k ++) {
            if (k + 1 < 4) {
                NSNumber * currentNum = self.dataArr[tot - k];
                NSNumber * nextNum = self.dataArr[tot - k - 1];
                if ([currentNum isEqualToNumber:nextNum]) {
                    self.dataArr[tot - k] = @(currentNum.integerValue + nextNum.integerValue);
                    self.dataArr[tot - k - 1] = @(0);
                    if (![nextNum isEqualToNumber:@(0)]) {
                        addOK = YES;
                    }
                }
            }
        }
    }
    [self moveRight];
    if (!moveOK && !addOK) {
        return;
    }
    [self getNewNum];
}

- (BOOL)moveUp {
    BOOL moveOK = NO;
    for (NSInteger i = 0; i < 4; i ++) {
        for (NSInteger k = 0; k < 4; k++) {
            NSInteger tot = i + k * 4;
            if (![self.dataArr[tot] isEqualToNumber:@(0)]) {
                continue;
            }
            for (NSInteger l = tot + 4; l <= 12 + i; l += 4) {
                if (![self.dataArr[l] isEqualToNumber:@(0)]) {
                    self.dataArr[tot] = self.dataArr[l];
                    self.dataArr[l] = @(0);
                    moveOK = YES;
                    break;
                }
            }
        }
    }
    return moveOK;
}

- (BOOL)moveDown {
    BOOL moveOK = NO;
    for (NSInteger i = 0; i < 4; i ++) {
        for (NSInteger k = 0; k < 4; k++) {
            NSInteger tot = 15 - i - 4 * k;
            if (![self.dataArr[tot] isEqualToNumber:@(0)]) {
                continue;
            }
            for (NSInteger l = tot - 4; l >= 3 - i; l -= 4) {
                if (![self.dataArr[l] isEqualToNumber:@(0)]) {
                    self.dataArr[tot] = self.dataArr[l];
                    self.dataArr[l] = @(0);
                    moveOK = YES;
                    break;
                }
            }
        }
    }
    return moveOK;
}

- (BOOL)moveLeft {
    BOOL moveOK = NO;
    for (NSInteger i = 0; i < 4; i ++) {
        NSInteger tot = i * 4;
        for (NSInteger k = 0; k < 4; k ++) {
            if (![self.dataArr[tot + k] isEqualToNumber:@(0)]) {
                continue;
            }
            else {
                for (NSInteger l = tot + k + 1; l < tot + 4 && l < self.dataArr.count; l ++) {
                    if (![self.dataArr[l] isEqualToNumber:@(0)]) {
                        self.dataArr[tot + k] = self.dataArr[l];
                        self.dataArr[l] = @(0);
                        moveOK = YES;
                        break;
                    }
                }
            }
        }
    }
    return moveOK;
}

- (BOOL)moveRight {
    BOOL moveOK = NO;
    for (NSInteger i = 0; i < 4; i ++) {
        NSInteger tot = i * 4 + 3;
        for (NSInteger k = 0; k < 4; k ++) {
            if (![self.dataArr[tot - k] isEqualToNumber:@(0)]) {
                continue;
            }
            else {
                for (NSInteger l = tot - k - 1; l > tot - 4 && l >= 0; l --) {
                    if (![self.dataArr[l] isEqualToNumber:@(0)]) {
                        self.dataArr[tot - k] = self.dataArr[l];
                        self.dataArr[l] = @(0);
                        moveOK = YES;
                        break;
                    }
                }
            }
        }
    }
    return moveOK;
}

- (void)getNewNum {
    NSInteger tot = arc4random() % 16;
    NSInteger count = 0;
    for (NSInteger i = 0; i < 16; i ++) {
        if ([self.dataArr[i] isEqualToNumber:@(0)]) {
            count ++;
        }
    }
    while (![self.dataArr[tot] isEqualToNumber:@(0)] && count != 0) {
        tot = arc4random() % 16;
    }
    self.dataArr[tot] = arc4random() % 2 == 0 ? @(2) : @(4);
    self.indexPath = [NSIndexPath indexPathForItem:tot inSection:0];

    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger item = indexPath.item;
    NSNumber * num = (NSNumber *)self.dataArr[item];
    TESTCollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell setItem:num];
    if (self.indexPath.item == indexPath.item) {
//        [cell setAnimate];
        CABasicAnimation * animation = [CABasicAnimation animation];
        animation.keyPath = @"transform.scale";
        animation.fromValue = @(1.0f);
        animation.toValue = @(1.5f);
        animation.duration = 0.25f;
        [cell.layer addAnimation:animation forKey:nil];
    }
    else {
        [cell.layer removeAllAnimations];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
