//
//  ThunkViewController.m
//  ReduxDemo
//
//  Created by bob on 2019/3/3.
//  Copyright © 2019 bob. All rights reserved.
//

#import "ThunkViewController.h"
#import <Redux/Thunk.h>

#import "CounterState.h"
#import "CounterAction.h"
#import "CounterReducer.h"
#import "Logger.h"
#import "AsyncAction.h"


@interface ThunkViewController ()<Subscriber>

@property (strong, nonatomic) Store<CounterState *> *store;

@property (strong, nonatomic) UILabel *presenter;


@end

@implementation ThunkViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.store = [[Store alloc] initWithReducer:CounterReducer
                                              state:[CounterState stateWithNumber:12]
                                        middlewares:@[ThunkMiddleware, ActionLogger, StateLogger]];
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

    UILabel *presenter = [[UILabel alloc] initWithFrame:CGRectMake(width/4, 100, width/2, 60)];
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

    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(width/2- 100, 230, 200, 44)];
    [button3 addTarget:self action:@selector(valueButtontClick:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button3 setTitle:@"set to 8" forState:UIControlStateNormal];
    [button3.titleLabel setFont:[UIFont boldSystemFontOfSize:30]];
    button3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:button3];
}

- (void)buttonClick:(UIButton *)sender {
    NSString *type = sender.currentTitle;
    if ([type isEqualToString:@"-"]) {
        [self.store dispatch:[AsyncAction actionWithAction:[CounterDecrAction new]]];
    } else {
        [self.store dispatch:[AsyncAction actionWithAction:[CounterIncrAction new]]];
    }
}

- (void)valueButtontClick:(UIButton *)sender {
    [self.store dispatch:[CounterSetAction actionWithValue:8]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.store subscribe:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.store unsubscribe:self];
}

- (void)updateState:(CounterState *)state {
    self.presenter.text = [NSString stringWithFormat:@"%zd",state.number];
}
@end
