//
//  ScheduleViewController.m
//  ReduxDemo
//
//  Created by bob on 2019/3/11.
//  Copyright © 2019 bob. All rights reserved.
//

#import "ScheduleViewController.h"
#import <Redux/Redux.h>

#import "CounterState.h"
#import "ScheduledCounterAction.h"
#import "ScheduleReducer.h"
#import "Logger.h"


@interface ScheduleViewController ()<Subscriber>

@property (strong, nonatomic) Store<CounterState *> *store;
@property (strong, nonatomic) UILabel *presenter;
@property (strong, nonatomic) ScheduledCounterAction *scheduledAction;

@end

@implementation ScheduleViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.store = [[Store alloc] initWithReducer:ScheduleReducer
                                              state:nil
                                        middlewares:@[ActionLogger, StateLogger, ScheduleMiddleware]];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadButtons];
}

- (void)loadButtons {
    CGFloat width = self.view.frame.size.width;

    UILabel *presenter = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, width, 60)];
    presenter.font = [UIFont boldSystemFontOfSize:30];
    presenter.textAlignment = NSTextAlignmentCenter;
    presenter.textColor = [UIColor blackColor];
    [self.view addSubview:presenter];
    self.presenter = presenter;


    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(width/2 - 50, 180, 44, 44)];
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"-" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button1.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    button1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:button1];

    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(width/2 + 5, 180, 44, 44)];
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button2 setTitle:@"+" forState:UIControlStateNormal];
    [button2.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    button2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:button2];

    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(width/2- 150, 230, 300, 44)];
    [button3 addTarget:self action:@selector(cancelButtontClick:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button3 setTitle:@"Cancel Scheduled" forState:UIControlStateNormal];
    [button3.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    button3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:button3];
}

- (void)buttonClick:(UIButton *)sender {
    NSString *type = sender.currentTitle;
    if (self.scheduledAction) {
        [self.scheduledAction cancelAction];
    }
    ScheduledCounterAction *action = [[ScheduledCounterAction alloc] initWithOperation:type];
    self.scheduledAction = [self.store dispatch:action];
}

- (void)cancelButtontClick:(UIButton *)sender {
    [self.scheduledAction cancelAction];
    self.scheduledAction = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.store subscribe:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.store unsubscribe:self];
}

- (void)updateState:(CounterState *)state {
    NSAssert([state isKindOfClass:[CounterState class]], @"");
    self.presenter.text = [NSString stringWithFormat:@"%@ - (%zd)", state.operation, state.number];
}
@end
