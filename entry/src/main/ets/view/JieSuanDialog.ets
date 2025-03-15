import systemDateTime from '@ohos.systemDateTime'
// import dataCtrl from '../dataModel/DataCtrl'
import { Tea } from '../viewModel/Tea'
import { User } from '../viewModel/User'
@CustomDialog
export  struct jieSuanDialog {
  controller: CustomDialogController
  // 饮料费、服务费
  @Consume sumF: number
  @Consume sumF_: number
  @Link teas: Tea[]

  // 桌号
  @Prop Btno: number
  // 人数
  @Prop Bsum: number
  // 外带
  @Prop Btype: boolean

  build() {
      Column(){
        Text(`饮料费：￥${this.sumF}`)
          .width('100%')
          .textAlign(TextAlign.Start)
        Text(`服务费：￥${this.sumF_}`)
          .width('100%')
          .textAlign(TextAlign.Start)
        Text(`总价：￥${this.sumF + this.sumF_}`)
          .width('100%')
          .textAlign(TextAlign.Start)
        Text('请扫描以下二维码进行支付:')
          .width('100%')
          .textAlign(TextAlign.Start)
        Image($r('app.media.shouKuan'))
          .margin(20)
        .width('70%')
        Row(){
          Button('完成支付')
            .backgroundColor('#d6b98d')
            .borderRadius(15)
            .onClick(() => {
              // 获取当前时间
              systemDateTime.getDate(async (err,data) => {
                if (err) {
                  console.log('08808', '获取当前时间错误！')
                  return
                }
                const nowYear = data.getFullYear().toString();
                const nowMonth = (data.getMonth() + 1).toString().padStart(2, '0'); // 填充前导零
                const nowDay = data.getDate().toString().padStart(2, '0')
                const nowHour = data.getHours().toString().padStart(2, '0')
                const nowMi = data.getMinutes().toString().padStart(2, '0')
                const nowSec = data.getSeconds().toString().padStart(2, '0')

                // 组装时间
                let Btime: string = `${nowYear}年${nowMonth}月${nowDay}日 ${nowHour}:${nowMi}:${nowSec}`
                // 组装编号:时间+账号
                let Bno: string = `${nowYear}${nowMonth}${nowDay}${nowHour}${nowMi}${nowSec}${User.Uno}`
                // 插入数据
                // await dataCtrl.insertBought(Bno,Btime,(this.Btype == true ? '外带' : '堂食'),this.sumF + this.sumF_,User.Uno,this.Btno,this.Bsum)
                console.log('08808','插入订单数据')
                console.log('08808',this.sumF + this.sumF_)

                // dataCtrl.deleteBuyCar()
                this.teas = []
                this.sumF = 0
                this.sumF_ = 0
                this.controller.close()
              })
            })
            .type(ButtonType.Normal)
            .fontColor(Color.White)
          Button('取消支付')
            .backgroundColor('#d6b98d')
            .borderRadius(15)
            .onClick(() => {
              this.controller.close()
            })
            .type(ButtonType.Normal)
            .fontColor(Color.White)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
      }
    .width('100%')
    .padding(10)
  }
}