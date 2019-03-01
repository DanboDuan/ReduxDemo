## 比较

1. [浅谈 MVC、MVP 和 MVVM 架构模式](https://draveness.me/mvx)
2. [MVC，MVP 和 MVVM 的图示](http://www.ruanyifeng.com/blog/2015/02/mvcmvp_mvvm.html)

### MVC

1. View 传送指令到 Controller
1. Controller 完成业务逻辑后，要求 Model 改变状态
1. Model 将新的数据发送到 View，用户得到反馈

* 标准模式
![](Img/mvc001.png)
* 变式
![](Img/mvc002.png)
* 变式
![](Img/mvc002.jpg)

#### Tips
1. 模块化
2. 模块之间分离，可维护性、可移植性、可扩展性与可重用性高
3. 系统结构复杂，有适用范围
4. 一般项目中，MVC架构很难保持，会变得复杂错乱
5. 视图与控制器间的过于紧密的连接


### MVP
1. 各部分之间的通信，都是双向的
2. View 与 Model 不发生联系，都通过 Presenter 传递
3. View 非常薄，不部署任何业务逻辑，称为"被动视图"（Passive View），即没有任何主动性，而 Presenter非常厚，所有逻辑都部署在那里。

![](Img/mvp001.png)

#### Tips
1. 解耦Model和View
2. 系统复杂性降低，更加灵活，适合小的项目
3. Presenter和View之间依赖多，复用性、移植性、扩展性不好



### MVVM

![](Img/mvvm001.png)

#### Tips
1. 双向绑定技术，当Model变化时，View-Model会自动更新，View也会自动变化
2. View的功能进一步的强化，具有控制的部分功能
3. 数据绑定使得耦合比较严重
4. 复用性、移植性、扩展性不好


### Redux

![](Img/redux_concept.png)

![](Img/redux_detail.png)

1. 单一数据源
2. State 是只读的
3. 使用纯函数来执行修改


#### Tips

1. 数据流形式
2. 所有数据都是只读的，要想修改数据，必须 dispatch 一个 action 来描述什么发生了改变
3. 数据不可变，当处理 action 时，必须生成一个新的 state，不得直接修改原始对象
4. 可预测性
5. 适用范围，需要灵活应用







