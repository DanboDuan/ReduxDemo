//
//  CombineViewController.m
//  ReduxDemo
//
//  Created by bob on 2019/3/6.
//  Copyright © 2019 bob. All rights reserved.
//

#import "CombineViewController.h"
#import <Redux/Combine.h>

#import "CounterState.h"
#import "OperationState.h"
#import "CounterAction.h"
#import "CombinedReducers.h"
#import "Logger.h"

static const NSString * kSubCounterState = @"kSubCounterState";
static const NSString * kSubOperationState = @"kSubOperationState";


@interface CombineViewController ()<Subscriber>

@property (strong, nonatomic) Store<CombinedState *> *store;

@property (strong, nonatomic) UILabel *presenter;

@end

@implementation CombineViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        Reducer reducer = combineReducers(@{kSubCounterState:CombinedNumberReducer,
                                            kSubOperationState:CombinedOperationtReducer
                                            });
        self.store = [[Store alloc] initWithReducer:reducer
                                              state:nil
                                        middlewares:@[ActionLogger, StateLogger]];
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
    presenter.font = [UIFont boldSystemFontOfSize:18];
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
    //  dispatch OperationAction to CombinedOperationtReducer
    [self.store dispatch:[OperationAction actionWithOperation:type]];
    
    //  dispatch Actions to CombinedNumberReducer
    if ([type isEqualToString:@"-"]) {
        [self.store dispatch:[CounterDecrAction new]];
    } else {
        [self.store dispatch:[CounterIncrAction new]];
    }
}

- (void)valueButtontClick:(UIButton *)sender {
    [self.store dispatch:[OperationAction actionWithOperation:@"Set"]];
    [self.store dispatch:[CounterSetAction actionWithValue:8]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.store subscribe:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.store unsubscribe:self];
}

- (void)updateState:(CombinedState *)state {
    NSAssert([state isKindOfClass:[CombinedState class]], @"");
    CounterState *number = [state subStateForKey:kSubCounterState];
    OperationState *operation = [state subStateForKey:kSubOperationState];
    self.presenter.text = [NSString stringWithFormat:@"Operation(%@) number = %zd",operation.operation , number.number];
}

@end
