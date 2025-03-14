import router from '@ohos.router'
import systemDateTime from '@ohos.systemDateTime'
import promptAction from '@ohos.promptAction'
// import dataCtrl from '../dataModel/DataCtrl'
import { Tea } from '../pojo/Tea'
import { User } from '../pojo/User'
import { HomePage_BuyCar } from './HomePage_BuyCar'
import { Header } from '../view/Header'
interface Norms  {
  cup: number;
  temp: number;
  sweetness: number;
}
// @Entry
@Component
struct SelectSpecifications {
  // tea: Tea = router.getParams()['tea']
  tea: Tea = router.getParams() as Tea
  @State sum: number = 1

// 规格
  @State norms: Norms = {
    cup: 0,
    temp: 0,
    sweetness: 0
  }

  build() {
    Column(){

      Header()
      Column(){
        Image(this.tea.image as Resource)
          .sharedTransition(`image${this.tea.no}`, { duration: 800, curve: Curve.Linear, delay: 100 })
          .width('100%')
        Column(){
          Text(this.tea.name)
            .width('100%')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
            .border({
              width: {
                bottom: 1
              },
              color: Color.Gray
            })
            .margin({bottom: 10})

          // 规格选择模块
          SelectModel({buttonClick: this.buttonClick.bind(this),norms: $norms})

          Row(){
            // 计数器
            Counter(){
              Text(this.sum.toString())
            }
            .onInc(() => {
              this.sum++
            })
            .onDec(() => {
              // 只有大于1时才可以减
              if(this.sum > 1){
                this.sum--
              }
            })

            Button('加入购物车')
              .onClick(() => {
                if(this.norms.cup == 0 || this.norms.temp == 0 || this.norms.sweetness == 0){
                  promptAction.showToast({
                    message: '请先选择茶品标准!',
                    duration: 1500
                  })
                }
                else{
                  // 获取当前时间
                  systemDateTime.getDate(async (err,data) => {
                    if(err){
                      console.log('08808','获取当前时间错误！')
                      return
                    }
                    const nowYear = data.getFullYear().toString();
                    const nowMonth = (data.getMonth() + 1).toString().padStart(2, '0'); // 填充前导零
                    const nowDay = data.getDate().toString().padStart(2, '0')
                    const nowHour = data.getHours().toString().padStart(2, '0')
                    const nowMi = data.getMinutes().toString().padStart(2, '0')
                    const nowSec = data.getSeconds().toString().padStart(2, '0')

                    // 组装时间
                    let Ctime: string = `${nowYear}年${nowMonth}月${nowDay}日 ${nowHour}:${nowMi}:${nowSec}`
                    // 插入购物车数据库
                    // await dataCtrl.insertBuy_car(Ctime,User.Uno,this.tea.name,this.sum,this.norms['cup'],this.norms['temp'],this.norms['sweetness'],this.tea.no)

                    promptAction.showToast({
                      message: '添加成功！',
                      duration: 1500
                    })
                    router.back()
                  })
                }
              })
              .type(ButtonType.Normal)
              .width('30%')
              .borderRadius(15)
              .backgroundColor('#d1bf8f')

            Button('退出')
              .onClick(() => {
                router.back()
              })
              .type(ButtonType.Normal)
              .borderRadius(15)
              .width('25%')
              .backgroundColor('#d1bf8f')

          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({top: 20,bottom: 20})
          .border({
            width: {top: 1},
            color: Color.Gray
          })
        }
        .padding(10)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#fafafa')
      // .padding()
    }
    .width('100%')
    .height('100%')
  }

  // 按钮点击触发函数
  buttonClick(type: string,index: number){
    // this.norms[type] = index
  }
}

// 规格选择模块
@Component
struct SelectModel {
  // 从父组件传进来的按钮点击事件
  @Prop buttonClick: (type: string,index: number) => void

  @Link norms: object
  build() {
    Column(){

      Text('规格')
        .width('100%')
        .fontColor(Color.Gray)
      Row(){
        Button('小杯')
          .buttonStyles()
          .backgroundColor(this.norms['cup'] == 1 ? '#dfc8a3' : '#eaeaea')
          .fontColor(this.norms['cup'] == 1 ? Color.White : 'black')
          .onClick(() => {
            this.buttonClick('cup',1)
          })
        Button('中杯')
          .buttonStyles()
          .backgroundColor(this.norms['cup'] == 2 ? '#dfc8a3' : '#eaeaea')
          .fontColor(this.norms['cup'] == 2 ? Color.White : 'black')
          .onClick(() => {
            this.buttonClick('cup',2)
          })
        Button('大杯')
          .buttonStyles()
          .backgroundColor(this.norms['cup'] == 3 ? '#dfc8a3' : '#eaeaea')
          .fontColor(this.norms['cup'] == 3 ? Color.White : 'black')
          .onClick(() => {
            this.buttonClick('cup',3)
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({top: 5,bottom: 5})

      Text('温度')
        .width('100%')
        .fontColor(Color.Gray)
      Row(){
        Button('全冰')
          .buttonStyles()
          .backgroundColor(this.norms['temp'] == 1 ? '#dfc8a3' : '#eaeaea')
          .fontColor(this.norms['temp'] == 1 ? Color.White : 'black')
          .onClick(() => {
            this.buttonClick('temp',1)
          })
        Button('少冰')
          .buttonStyles()
          .backgroundColor(this.norms['temp'] == 2 ? '#dfc8a3' : '#eaeaea')
          .fontColor(this.norms['temp'] == 2 ? Color.White : 'black')
          .onClick(() => {
            this.buttonClick('temp',2)
          })
        Button('去冰')
          .buttonStyles()
          .backgroundColor(this.norms['temp'] == 3 ? '#dfc8a3' : '#eaeaea')
          .fontColor(this.norms['temp'] == 3 ? Color.White : 'black')
          .onClick(() => {
            this.buttonClick('temp',3)
          })
        Button('常温')
          .buttonStyles()
          .backgroundColor(this.norms['temp'] == 4 ? '#dfc8a3' : '#eaeaea')
          .fontColor(this.norms['temp'] == 4 ? Color.White : 'black')
          .onClick(() => {
            this.buttonClick('temp',4)
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({top: 5,bottom: 5})

      Text('甜度')
        .width('100%')
        .fontColor(Color.Gray)
      Row(){
        Button('全糖')
          .buttonStyles()
          .backgroundColor(this.norms['sweetness'] == 1 ? '#dfc8a3' : '#eaeaea')
          .fontColor(this.norms['sweetness'] == 1 ? Color.White : 'black')
          .onClick(() => {
            this.buttonClick('sweetness',1)
          })
        Button('少糖')
          .buttonStyles()
          .backgroundColor(this.norms['sweetness'] == 2 ? '#dfc8a3' : '#eaeaea')
          .fontColor(this.norms['sweetness'] == 2 ? Color.White : 'black')
          .onClick(() => {
            this.buttonClick('sweetness',2)
          })
        Button('半糖')
          .buttonStyles()
          .backgroundColor(this.norms['sweetness'] == 3 ? '#dfc8a3' : '#eaeaea')
          .fontColor(this.norms['sweetness'] == 3 ? Color.White : 'black')
          .onClick(() => {
            this.buttonClick('sweetness',3)
          })
        Button('微糖')
          .buttonStyles()
          .backgroundColor(this.norms['sweetness'] == 4 ? '#dfc8a3' : '#eaeaea')
          .fontColor(this.norms['sweetness'] == 4 ? Color.White : 'black')
          .onClick(() => {
            this.buttonClick('sweetness',4)
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({top: 5,bottom: 3})
      .padding({bottom: 5})
    }
  }
}

// 按钮样式
@Extend(Button) function buttonStyles(){
  .type(ButtonType.Normal)
  .fontColor('black')
  .width('20%')
  .borderRadius(12)
  .backgroundColor('#eaeaea')
}