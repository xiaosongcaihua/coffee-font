import router from '@ohos.router'
import { Header } from '../view/Header'
import { Bill } from '../viewModel/Bill'
import { StaticValue } from '../viewModel/StaticValue'
import { Tea } from '../viewModel/Tea'
import { User } from '../viewModel/User'
import { HomePage_Bill } from './HomePage_Bill'
import { HomePage_BuyCar } from './HomePage_BuyCar'
import { HomePage_Me } from './HomePage_Me'
import { HomePage_Order } from './HomePage_Order'
@Entry
@Component
struct HomePage {
  // 当前标签页，初始化为 1，即点餐页
  @State currentIndex: number = 1
  // 购物车数据
  @State buyCarTeas: Tea[] = []
  // 购物车饮品总价格
  @Provide sumF: number = 0
  // 购物车服务费
  @Provide sumF_: number = 0
  // 订单数据
  @State bills: Bill[] = []

  build() {
    Column(){
      Header()

      Tabs({barPosition: BarPosition.End}){
        TabContent(){
          HomePage_Order()
        }
        .tabBar(this.TabBuilder('点单',1,$r('app.media.order_selected'),$r('app.media.order_')))

        TabContent(){
          HomePage_BuyCar({teas: $buyCarTeas,jisuanSumF: this.jisuanSumF.bind(this)})
        }
        .tabBar(this.TabBuilder('购物车',2,$r('app.media.shop_selected'),$r('app.media.shop_')))

        TabContent(){
          HomePage_Bill({bills: $bills})
        }
        .tabBar(this.TabBuilder('订单',3,$r('app.media.bill_selected'),$r('app.media.bill_')))

        TabContent(){
          HomePage_Me()
        }
        .tabBar(this.TabBuilder('我的',4,$r('app.media.my_select'),$r('app.media.my_')))
      }
      .layoutWeight(1)
      .animationDuration(100)
      .onChange(async (index:number) => {
        this.currentIndex = index + 1
        if(this.currentIndex == 2){
          await this.initTeas()
          this.jisuanSumF()
          console.log('08808','当前是第二个页面，进行了数组初始化，进行了数据校验')
        }
        if(this.currentIndex == 3){
          await this.initBills()
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#fafafa')
  }
  jisuanSumF(){
    this.sumF = 0
    this.buyCarTeas.forEach((tea,index) => {
      this.sumF += tea.price
    })

    // 只要购物车不空，服务费两毛
    if(this.buyCarTeas.length != 0){
      this.sumF_ = StaticValue.sumF_
    }
    else {
      this.sumF_ = 0
    }
  }



  @Builder TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#ff000000' : '#6B6B6B')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }






  // 读取购物车数据，初始化饮品数组
  async initTeas(){
    // this.buyCarTeas = await dataCtrl.readBuy_car()
    console.log('08808','购物车数据读取成功！')
  }

  // 读订单数据，初始化订单数组
  async initBills(){
    // this.bills = await dataCtrl.readBought()
    console.log('08808','订单数据读取成功！')
  }
}
