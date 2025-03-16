import router from '@ohos.router'
import { HttpUtil } from '../common/Util'
import { Header } from '../view/Header'
import { Bill } from '../viewModel/Bill'
import { buycar, BuycarKey } from '../viewModel/buycar'
import { R } from '../viewModel/R'
import { StaticValue } from '../viewModel/StaticValue'
import { Norms, Tea } from '../viewModel/Tea'
import { SelectUserByUno, User } from '../viewModel/User'
import { HomePage_Bill } from './HomePage_Bill'
import { HomePage_BuyCar } from './HomePage_BuyCar'
import { HomePage_Me } from './HomePage_Me'
import { HomePage_Order } from './HomePage_Order'
import { TestRunner } from '@kit.TestKit'
import { http } from '@kit.NetworkKit'

@Entry
@Component
struct HomePage {
  // 当前标签页，初始化为 1，即点餐页
  @State currentIndex: number = 1
  // 购物车数据
  @State buyCarTeas: Tea[] = []
  // 数据库购物车数据
  @State buycars :buycar[] = []
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
      .onChange((index:number) => {
        this.currentIndex = index + 1
        if(this.currentIndex == 2){
          let buycar:BuycarKey = {ctime:"" , uno:User.Uno}
          HttpUtil.post("buycar/all" , (result:R)=>{
            this.buycars = result.data as buycar[]
            console.log('08808','购物车数据读取成功！')
            //初始化buycarTea
            this.buyCarTeas = []
            for (let buycar of this.buycars) {
              let norms: Norms = {
                cup: buycar.ccup,
                temp: buycar.ctemp,
                sweetness: buycar.csweetness
              }
              let Ctno = buycar.ctno
              let tea: Tea = new Tea(
                // 饮品名称
                buycar.tname,
                // 饮品图片地址
                StaticValue.teas[Ctno].image,
                // 饮品简介
                StaticValue.teas[Ctno].about,
                // 饮品总价 数量*单价
                StaticValue.teas[Ctno].price * buycar.csum,
                // 饮品类型
                StaticValue.teas[Ctno].type,
                //time
                buycar.ctime,
                // 饮品数量
                buycar.csum,
                // 客户备注 暂且不用
                '',
                // 饮品规格
                norms
              )
              this.buyCarTeas.push(tea)
            }
            this.jisuanSumF()
            console.log('08808','当前是第二个页面，进行了数组初始化，进行了数据校验')
          } , buycar)
        }
        if(this.currentIndex == 3){
          this.initBills()
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
  initTeas(){
    let buycar:BuycarKey = {ctime:"" , uno:User.Uno}
    HttpUtil.post("buycar/all" , (result:R)=>{
      this.buyCarTeas = result.data as Tea[]
      console.log('08808','购物车数据读取成功！')
    } , buycar)
  }

  // 读订单数据，初始化订单数组
  initBills(){
    let bougutlistQuery:SelectUserByUno = {Uno:User.Uno}
    HttpUtil.post("bought/all" , (result:R)=>{
      this.bills = result.data as Bill[]
    } , bougutlistQuery)
    console.log('08808','订单数据读取成功！')
  }
}
