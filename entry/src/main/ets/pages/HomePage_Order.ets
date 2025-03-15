import { OrderModel } from '../view/OrderModel'
import { StaticValue } from '../viewModel/StaticValue'
import { Tea } from '../viewModel/Tea'
@Component
export  struct HomePage_Order {
  // 饮品总集合(包括四类)
  @Provide teas: Tea[] = []
  @State currentIndex: number = 1

  build() {
    Column(){
      // 搜索框
      SearchModel({initTeas: this.initTeas.bind(this)})

      // 左侧导航栏及右侧内容模块
      LeftBarModel({currentIndex: $currentIndex})
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }

  // 初始化数组
  initTeas(){
    StaticValue.teas = []
    StaticValue.teas.push(
      new Tea(
        '牧场酸酪牛油果',
        $r('app.media.niuYouGuo'),
        '定制牧场奶源酸酪·百分百进口牛油果鲜果·不使用过你，清爽顺滑',
        // 价格
        23,
        // 类别
        1,
        // 数量
        undefined,
        // 备注
        undefined,
        // 规格
        undefined,
        'mcslnyg',
        // 标记
        0
      ),
      new Tea(
        '喜悦黄果茶',
        $r('app.media.yellow_sq'),
        '匠心甄选黄色系水果·当季芒果·鲜制橙丁百香果，真果无香精',
        19,
        1,
        undefined,
        undefined,
        undefined,
        'xyhgc',
        1
      ),
      new Tea(
        '东坡荔枝生椰露',
        $r('app.media.coco_sq'),
        '当季新鲜荔枝果肉·定制生椰乳·每日现制西米，椰椰荔香清甜交融',
        19,
        1,
        undefined,
        undefined,
        undefined,
        'dplzsyl',
        2
      ),
      new Tea(
        '水牛乳·粉黛玫影',
        $r('app.media.pinkmilk_square'),
        '无香精[玫影]玫瑰红茶·优选广西水牛乳调制奶底',
        15,
        2,
        undefined,
        undefined,
        undefined,
        'snrfdmy',
        3
      ),
      new Tea(
        '水牛乳双拼波波',
        $r('app.media.black_sq'),
        '优选广西牧场水牛乳·水牛乳冻·慢数黑糖波波，口感甜腻不喜慎点',
        19,
        2,
        undefined,
        undefined,
        undefined,
        'snrspbb',
        4
      ),
      new Tea(
        '轻波波牛乳茶',
        $r('app.media.bobo_sq'),
        '人气轻波波牛乳灵感延伸·慢熬黑糖波波，口感香醇，真牛乳无奶精',
        15,
        2,
        undefined,
        undefined,
        undefined,
        'qbbnrc',
        5
      ),
      new Tea(
        '芋泥牛乳满贯',
        $r('app.media.yuni_sq'),
        '芋泥系列大满贯版，5重口感，浓浓芋香，轻盈不腻',
        18,
        2,
        undefined,
        undefined,
        undefined,
        'ynnrmg',
        6
      ),
      new Tea(
        '烤黑糖波波牛乳茶',
        $r('app.media.black_sq'),
        '65分钟慢熬黑糖波波·真牛乳·定制嫣红茶底，口感浓厚不喜慎点',
        19,
        2,
        undefined,
        undefined,
        undefined,
        'khtbbnrc',
        7
      ),
      new Tea(
        '多肉桃李',
        $r('app.media.peach_square'),
        '当季三华李与当季黄油桃，脆、鲜、甜层层递进',
        15,
        3,
        undefined,
        undefined,
        undefined,
        'drtl',
        8
      ),
      new Tea(
        '芝芝多肉桃桃',
        $r('app.media.pinkpeach_sq'),
        '优选当季新鲜水蜜桃·新岩岚，岩茶·醇香芝士，不添加香精色素',
        28,
        3,
        undefined,
        undefined,
        undefined,
        'zzdrtt',
        9
      ),
      new Tea(
        '芝芝多肉青提',
        $r('app.media.grape_sq'),
        '优选阳光玫瑰青提·鲜果颗颗去皮·无奶精芝士，甜脆香郁。',
        28,
        3,
        undefined,
        undefined,
        undefined,
        'zzdrqt',
        10
      ),
      new Tea(
        '芝芝莓莓',
        $r('app.media.strawberry_sq'),
        '当季新鲜草莓·定制绿妍茶底·无奶精芝士，奶香浓醇，莓香满溢',
        28,
        3,
        undefined,
        undefined,
        undefined,
        'zzmm',
        11
      ),
      new Tea(
        '大桶鸭屎香柠茶',
        $r('app.media.lemond_square'),
        '暴打新鲜柠檬·甄选无香精鸭屎香单从茶，超大桶的清爽更解腻',
        18,
        4,
        undefined,
        undefined,
        undefined,
        'dtysxnc',
        12
      ),
      new Tea(
        '芝芝玫影',
        $r('app.media.redtea_sq'),
        '全新[玫影]玫瑰红茶，无香精自然玫瑰香·无奶精芝士，甜醇顺滑',
        13,
        4,
        undefined,
        undefined,
        undefined,
        'zzmy',
        13
      ),
      new Tea(
        '纯绿妍茶后',
        $r('app.media.greentea_sq'),
        '甄选茶园定制绿妍茶底，淡雅芳幽，默认不加糖，0糖0卡轻负担',
        8,
        4,
        undefined,
        undefined,
        undefined,
        'clych',
        14
      )
    )
    this.teas = StaticValue.teas
  }



  aboutToAppear(){
    // 运行时先把饮品加载进去
    this.initTeas()
  }
}






// 搜索框
@Component
struct SearchModel {

  @Consume teas: Tea[]
  initTeas: ()=> void = ()=>{}

  // 搜索函数
  searchWay(message: string){
    if(message == ''){
      this.teas = StaticValue.teas
    }
    else{
      this.teas = []

      StaticValue.teas.forEach((tea: Tea,index) => {
        if(tea.firstI.includes(message)){
          this.teas.push(tea)
        }
      })
    }
  }

  build() {
    Row(){
      Text('类别')
        .width('15%')
        .textAlign(TextAlign.Center)
        .fontColor(Color.Gray)
      Row(){
        Image($r('app.media.search'))
          .height('60%')
        TextInput({placeholder: '搜饮品（请输入拼音首字母）'})
          // 搜索函数
          .onChange(message => {
            this.searchWay(message)
          })
          .backgroundColor('#0000')
      }
      .width('75%')
      .padding({left: 10})
      .backgroundColor('#d6b98d')
      .borderRadius(20)


      .height('90%')
    }
    .width('100%')
    .height(40)
    .margin({top: 5})
  }
}

// 左侧导航栏及右侧内容块
@Component
struct LeftBarModel {
  @Link currentIndex: number

  // 通用样式
  @Styles barStyles(){
    .border({
      width: {left: 1},
      color: Color.Gray
    })
  }

  build() {
    Tabs({barPosition: BarPosition.Start}){
      TabContent(){
        OrderModel({currentType: 1})
      }
      .tabBar(this.TabBuilder('灵感上新',1,$r('app.media.lingGanZhiShang')))
      .barStyles()


      TabContent(){
        OrderModel({currentType: 2})
      }
      .tabBar(this.TabBuilder('浓郁牛乳',2,$r('app.media.nongYu')))
      .barStyles()

      TabContent(){
        OrderModel({currentType: 3})
      }
      .tabBar(this.TabBuilder('时令鲜果',3,$r('app.media.shiLingXianGuo')))
      .barStyles()

      TabContent(){
        OrderModel({currentType: 4})
      }
      .tabBar(this.TabBuilder('简单茗茶',4,$r('app.media.jianDanMingCha')))
      .barStyles()
    }
    .vertical(true)
    .barMode(BarMode.Scrollable)
    .animationDuration(100)
    .onChange((index:number) => {
      this.currentIndex = index + 1
    })
  }



  @Builder TabBuilder(title: string, targetIndex: number, normalImg: Resource) {
    Column() {
      Image(normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .textAlign(TextAlign.Center)
        .width('80%')
        .fontColor(this.currentIndex === targetIndex ? '#ff000000' : '#6B6B6B')
    }
    .backgroundColor(this.currentIndex === targetIndex ? '#eaeaea' : '#fafafa')
    .width('100%')
    .height('12%')
    .justifyContent(FlexAlign.Center)
  }
}