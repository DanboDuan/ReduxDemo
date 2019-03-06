//
//  ComplexCounterViewController.m
//  ReduxDemo
//
//  Created by bob on 2019/2/28.
//  Copyright © 2019 bob. All rights reserved.
//

#import "ComplexCounterViewController.h"
#import <Redux/Redux.h>

#import "ComplexState.h"
#import "CounterAction.h"
#import "ComplexReducer.h"
#import "Logger.h"

// Store handler ComplexState
// but we want subscribe CounterState
// so make a transForm

@interface ComplexCounterViewController ()<Subscriber>

@property (strong, nonatomic) Store<ComplexState *> *store;

@property (strong, nonatomic) UILabel *presenter;

@end

@implementation ComplexCounterViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        CounterState *state = [CounterState new];
        state.number = 13;

        self.store = [[Store alloc] initWithReducer:ComplexReducer
                                              state:[ComplexState stateWithCounter:state]
                                        middlewares:@[ActionLogger, StateLogger]
                                    autoSkipRepeats:NO];
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
        [self.store dispatch:[CounterDecrAction new]];
    } else {
        [self.store dispatch:[CounterIncrAction new]];
    }
}

- (void)valueButtontClick:(UIButton *)sender {
    [self.store dispatch:[CounterSetAction actionWithValue:8]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SubscriptionTransForm<ComplexState *, CounterState *> *transForm = [[SubscriptionTransForm alloc] initWith:^Subscription< CounterState *> * _Nonnull(Subscription<ComplexState *>* _Nonnull subscription) {
        SubscriptionTransForm<ComplexState *, CounterState *> *select = [SubscriptionTransForm new];
        return [select select:subscription with:^CounterState * _Nonnull(ComplexState * _Nonnull state) {
            return state.counterState;
        }];
    }];

    [self.store subscribe:self withTransform:transForm];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.store unsubscribe:self];
}

- (void)updateState:(CounterState *)state {
    NSAssert([state isKindOfClass:[CounterState class]], @"");
    self.presenter.text = [NSString stringWithFormat:@"%zd",state.number];
}

@end
