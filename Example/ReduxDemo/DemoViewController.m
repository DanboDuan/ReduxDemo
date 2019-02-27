//
//  DemoViewController.m
//  DecoratorDemo
//
//  Created by bob on 2019/2/21.
//  Copyright © 2019 bob. All rights reserved.
//

#import "DemoViewController.h"

NSString * const CellReuseIdentifier = @"UITableViewCell_ri";


@interface FeedModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *actionVCName;
@property (nonatomic, assign) NSInteger actionVC;

@end

@implementation FeedModel



@end

static NSArray *testFeedList() {
    NSMutableArray *array = [NSMutableArray array];

    [array addObject:({
        FeedModel *model = [FeedModel new];
        model.title = @"Test 1";
        model.actionVC = 1;;
        model;
    })];

    [array addObject:({
        FeedModel *model = [FeedModel new];
        model.title = @"Test 2";
        model.actionVCName = @"";
        model.actionVC = 2;
        model;
    })];

    return array;
}

@interface DemoViewController ()

@property (nonatomic, strong) NSArray *feedList;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    self.feedList = testFeedList();
    self.navigationItem.title = @"Demo";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
    if (!cell) {
        cell = [UITableViewCell new];
    }
    FeedModel *model = [self.feedList objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd: %@",(NSInteger)(indexPath.row + 1),model.title];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FeedModel *model = [self.feedList objectAtIndex:indexPath.row];
    if (!model.actionVCName.length) {

    }
}

@end
