import promptAction from '@ohos.promptAction'
// import dataCtrl from '../dataModel/DataCtrl'
import { Dialog } from '../view/Dialog'
import { jieSuanDialog } from '../view/jieSuanDialog'
import { Tea } from '../pojo/Tea'
import { User } from '../pojo/User'

@Component
export struct HomePage_BuyCar {

  @Link teas: Tea[]
  // 桌号
  @State Btno: number = 0
  // 人数
  @State Bsum: number = 0
  // 外带
  @State Btype: boolean = false
  // 服务费
  @Consume sumF_: number
  // 总费用
  @Consume sumF: number
  // 计算总费用方法
  jisuanSumF: () => void = ()=> {}

  build() {
    Column(){
      if(this.teas.length == 0){
        Text('购物车空空如也~')
          .width('100%')
          .height('100%')
          .textAlign(TextAlign.Center)
          .fontSize(30)
          .fontColor(Color.Gray)
      }
      List(){
        ForEach(this.teas,(tea: Tea,index) => {
          ListItem(){
            showTea({tea: tea,jisuanSumF: this.jisuanSumF.bind(this),teas: $teas})
          }
          .width('100%')
          .height('20%')
          .padding(5)
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({top: 10})

      // 结算操作栏
      Ok_buy({teas: $teas,jisuanSumF: this.jisuanSumF.bind(this),Btno: $Btno,Bsum: $Bsum,Btype: $Btype})



    }
    .width('100%')
    .height('100%')
  }
}


@Component
struct showTea {

  controllerTo: CustomDialogController = new CustomDialogController({
    builder: Dialog({
      message: '确定要从购物车移除此项饮品吗？',
      onYes: () => {
        // 先从数据库中删除，再从列表中删除
        // dataCtrl.deleteBuyCarTo(this.tea.Ctime,User.Uno)
        let index = this.teas.indexOf(this.tea)
        this.teas.splice(index,1)
        this.jisuanSumF()

        this.controllerTo.close()
      },
      onNo: () => {
        this.controllerTo.close()
      }
    })
  })

  @ObjectLink tea: Tea
  @Link teas: Tea[]
  jisuanSumF: () => void=()=>{}
  build() {
    Row(){
      Image(this.tea.image as Resource)
        .height('100%')

      Column(){
        Text(this.tea.name)
          .width('100%')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Start)
        Row({space: 5}){
          if(this.tea.norms.cup == 1){
            Text('小杯')
              .fontColor(Color.Gray)
          }
          else if(this.tea.norms.cup == 2){
            Text('中杯')
              .fontColor(Color.Gray)
          }
          else{
            Text('大杯')
              .fontColor(Color.Gray)
          }

          if(this.tea.norms.temp == 1){
            Text('全冰')
              .fontColor(Color.Gray)
          }
          else if(this.tea.norms.temp == 2){
            Text('少冰')
              .fontColor(Color.Gray)
          }
          else if(this.tea.norms.temp == 3){
            Text('去冰')
              .fontColor(Color.Gray)
          }
          else {
            Text('常温')
              .fontColor(Color.Gray)
          }

          if(this.tea.norms.sweetness == 1){
            Text('全糖')
              .fontColor(Color.Gray)
          }
          else if(this.tea.norms.temp == 2){
            Text('少糖')
              .fontColor(Color.Gray)
          }
          else if(this.tea.norms.temp == 3){
            Text('半糖')
              .fontColor(Color.Gray)
          }
          else {
            Text('微糖')
              .fontColor(Color.Gray)
          }
        }
        .width('100%')

        Blank()

        Row(){
          Text(`￥${this.tea.price}`)
            .fontColor('#327c6b')
            .fontSize(17)

          Blank()

          // 计数器
          Counter(){
            Text(this.tea.sum.toString())
          }
          .onInc(async () => {
            // 注意先加价格再加数量，否则逻辑错误
            this.tea.price += this.tea.price / this.tea.sum
            this.tea.sum++
            this.jisuanSumF()
            // await dataCtrl.updateBuyCar(User.Uno,this.tea.Ctime,this.tea.sum)
          })
          .onDec(async () => {
            // 只有大于1时才可以减
            console.log('08808','--------')
            if(this.tea.sum > 1){
              this.tea.price -= this.tea.price / this.tea.sum
              this.tea.sum--
              this.jisuanSumF()
              // await dataCtrl.updateBuyCar(User.Uno,this.tea.Ctime,this.tea.sum)
            }
            else if (this.tea.sum == 1){
              this.controllerTo.open()
            }
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
      }
      .padding({left: 5,top: 5,right: 10})
      .height('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}


@Component
struct Ok_buy {
  @Consume sumF: number
  @Consume sumF_: number
  @Link teas: Tea[]
  jisuanSumF: () => void=()=>{}
  // 桌号
  @Link Btno: number
  // 人数
  @Link Bsum: number
  // 外带
  @Link Btype: boolean

  controller: CustomDialogController = new CustomDialogController({
    builder: jieSuanDialog({teas: $teas,Btno: this.Btno,Bsum: this.Bsum,Btype: this.Btype})
  })

  controllerT: CustomDialogController = new CustomDialogController({
    builder: Dialog({message: '确定要清空购物车吗？',onYes: () => {
      this.teas = []
      // dataCtrl.deleteBuyCar()
      this.jisuanSumF()

      this.controllerT.close()
    },
      onNo: () => {
        this.controllerT.close()
      }})
  })

  build() {
    Column({space: 10}){
      Row({space: 1}){
        Image($r('app.media.zhuo_hao'))
          .height('100%')
        Text('桌号:')
        TextInput()
          .onChange(message => {
            this.Btno = parseInt(message)
          })
          .width(50)
          .backgroundColor('#0000')
          .borderRadius(0)
          .border({
            width: {bottom: 1},
            color: Color.Gray
          })
        Image($r('app.media.ren_shu'))
          .height('100%')
        Text('人数:')
        TextInput()
          .onChange(message => {
            this.Bsum = parseInt(message)
          })
          .width(50)
          .backgroundColor('#0000')
          .borderRadius(0)
          .border({
            width: {bottom: 1},
            color: Color.Gray
          })

        Checkbox()
          .onChange(yn => {
            if(yn){
              this.Btype = true
            }
            else {
              this.Btype = false
            }
          })
        Image($r('app.media.wai_dai'))
          .height('100%')
        Text('外带')
      }
      .height(40)

      Row({space: 5}){
        Image($r('app.media.shop'))
          .height('100%')
        Column(){
          Text(`饮料费：￥${this.sumF}`)
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontSize(20)
            .fontColor(Color.Gray)
          Text(`服务费：￥${this.sumF_}`)
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontSize(20)
            .fontColor(Color.Gray)
        }
        .height('100%')
        .layoutWeight(1)

        // 清空购物车
        Image($r('app.media.shan_chu'))
          .onClick(() => {
            this.controllerT.open()
          })
          .height('100%')

        // 结算
        Button('结算')
          .onClick(() => {
            if(this.Btno != 0 && this.Bsum != 0){
              this.controller.open()
            }
            else{
              promptAction.showToast({
                message: '请先将信息补充完整！',
                duration: 1500
              })
            }
          })
          .type(ButtonType.Normal)
          .backgroundColor('#d6b98d')
          .fontColor(Color.White)
          .fontSize(20)
          .height('100%')
          .width(150)

      }
      .width('100%')
      .height(50)
    }
  }
}