import systemDateTime from '@ohos.systemDateTime'
// import dataCtrl from '../dataModel/DataCtrl'
import { Tea } from '../viewModel/Tea'
import { User } from '../viewModel/User'
@CustomDialog
@Preview
export  struct Dialog {
  controller: CustomDialogController

  message: string = ""
  onYes: () => void = ()=>{}
  onNo: () => void = ()=>{}

  build() {
    Column({space: 20}){
      Text(this.message)

      Row(){
        Button('确定')
          .onClick(() => {
            this.onYes()
          })
          .type(ButtonType.Normal)
          .borderRadius(15)
          .backgroundColor('#d5be8e')
        Button('取消')
          .onClick(() => {
            this.onNo()
          })
          .type(ButtonType.Normal)
          .borderRadius(15)
          .backgroundColor('#d5be8e')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width('100%')
    .padding(30)
  }
}