
// import dataCtrl from '../dataModel/DataCtrl'
import { Dialog } from '../view/Dialog'
import { Bill } from '../viewModel/Bill'
@Component
export  struct HomePage_Bill {

  @Link bills: Bill[]
  @State showPanel: boolean = false
  @State bill: Bill = new Bill('','','',0,0,0)
  // 用作储存需要删除记录项的下标
  index: number = 0

  controllerTo: CustomDialogController = new CustomDialogController({
    builder: Dialog({
      message: '确定要删除此项订单记录吗？',
      onYes: () => {

        // dataCtrl.deleteBill(this.bills[this.index].Bno)
        this.bills.splice(this.index,1)

        this.controllerTo.close()
      },
      onNo: () => {
        this.controllerTo.close()
      }
    })
  })

  build() {
    Column(){
      if(this.bills.length == 0){
        Text('订单空空如也~')
          .width('100%')
          .height('100%')
          .textAlign(TextAlign.Center)
          .fontSize(30)
          .fontColor(Color.Gray)
      }
      List(){
        ForEach(this.bills,(bill: Bill,index) => {
          ListItem(){
            Column({space: 5}){
              Text(`订单编号：${bill.Bno}`)
                .width('100%')
                .fontSize(17)
                .fontWeight(FontWeight.Bold)
              Text(bill.Btime)
                .width('100%')
              .fontSize(Color.Gray)
              Row(){
                Text(bill.Btype)
                  .fontSize(17)
                  .fontWeight(FontWeight.Bold)
                Blank()
                Text(`总价：￥${bill.Bprice}`)
                  .fontSize(17)
                  .fontWeight(FontWeight.Bold)
              }
              .width('100%')
            }
            .padding({bottom: 5})
            .width('100%')
            .border({
              width: {bottom: 1},
              color: Color.Gray
            })
          }
          .onClick(() => {
            this.bill = bill
            this.showPanel = true

          })
          .swipeAction({end: this.left_delete_button(index)})
          .padding(10)
        })
      }
      .layoutWeight(1)
      .chainAnimation(true)

      Panel(this.showPanel){

        Column(){
          Column(){
            Image($r('app.media.bill_touxiang'))
              .borderRadius(50)
              .height(50)
            Text('ABC')
              .margin({bottom: 10})
            Text(`-${this.bill.Bprice}`)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .border({
            width: {bottom: 1},
            color: Color.Gray
          })
          .padding(30)
          .alignItems(HorizontalAlign.Center)


          Row(){
            Column({space: 5}){
              Text('当前状态')
                .text1Styles()
              Text('支付时间')
                .text1Styles()
              Text('商品')
                .text1Styles()
              Text('商品全称')
                .text1Styles()
              Text('收单机构')
                .text1Styles()
              Text('支付方式')
                .text1Styles()
              Text('交易单号')
                .text1Styles()
              Text('商户单号')
                .text1Styles()
              Text('订单类型')
                .text1Styles()
              Text('桌号')
                .text1Styles()
              Text('人数')
                .text1Styles()

            }
            .height('100%')

            Column({space: 5}){
              Text('支付成功')
                .text2Styles()
              Text(this.bill.Btime)
                .text2Styles()
              Text('松达的茶-消费')
                .text2Styles()
              Text('松达的茶')
                .text2Styles()
              Text('中国建设银行股份有限公司深圳市分行')
                .text2Styles()
              Text('零钱')
                .text2Styles()
              Text(this.bill.Bno)
                .text2Styles()
              Text('可在支持的商户扫码退款')
                .text2Styles()
              Text(this.bill.Btype)
                .text2Styles()
              Text(this.bill.Bdno.toString())
                .text2Styles()
              Text(this.bill.Bsum.toString())
                .text2Styles()
            }
            .height('100%')
          }
          .height('40%')
          .width('100%')
          .padding(10)

          Button('关闭')
            .backgroundColor('#d5be8e')
            .margin({top: 15})
            .onClick(() => {
              this.showPanel = false
            })

        }
        .width('100%')
        .height('100%')
        .alignItems(HorizontalAlign.Center)
        .padding(10)
      }
      .height('100%')
      .mode(PanelMode.Full)
      .dragBar(false)
      .backgroundMask(Color.Gray)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
  }


  // 左滑删除按钮定义
  @Builder left_delete_button(index: number){

    Button('删除')
      .onClick(() => {
        this.index = index
        this.controllerTo.open()
      })
      .backgroundColor(Color.Red)
      .margin(10)
  }

}

@Extend(Text) function  text1Styles(){
  .width('25%')
  .fontColor(Color.Gray)
  .textAlign(TextAlign.Start)
}

@Extend(Text) function text2Styles(){
  .width('75%')
  .textAlign(TextAlign.Start)
}