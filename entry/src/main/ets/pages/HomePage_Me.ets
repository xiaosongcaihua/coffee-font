import router from '@ohos.router'
import { Dialog } from '../view/Dialog'
import { User } from '../pojo/User'
// @Preview
@Component
@Entry
export struct HomePage_Me {

  controllerLogOut: CustomDialogController = new CustomDialogController({
    builder: Dialog({
      message: '确定要退出登陆吗（下次需要重新登陆）？',
      onYes: () => {
        router.replaceUrl(
          {
            url: 'pages/LogIn'
          },
          router.RouterMode.Single,
          err => {
            if(err){
              console.log('08808','退出登录路由失败')
            }
          }
        )

        this.controllerLogOut.close()
      },
      onNo: () => {
        this.controllerLogOut.close()
      }
    })
  })


  build() {
    Column(){
      // Image($r('app.media.tou_xiang'))
      Image($r('app.media.icon'))
        .width('30%')
      Text('UserName: ' + User.Uname)
        .fontSize(20)
      Text('UserNo: ' + User.Uno)
        .fontSize(20)

      Button('修改密码')
        .onClick(() => {
          router.pushUrl(
            {
              url: 'pages/UpdatePassword'
            },
            router.RouterMode.Single,
            err => {
              if(err){
                console.log('08808','跳转到密码修改页失败')
              }
            }
          )
        })
        .margin({top: 100})
        .backgroundColor('#d6b98d')
      Button('退出登录')
        .onClick(() => {
          this.controllerLogOut.open()
        })
        .margin({top: 15})
        .backgroundColor('#d6b98d')
    }
    .alignItems(HorizontalAlign.Center)
    .padding({top: 200,left: 90,right: 90})
    .width('100%')
    .height('100%')
  }
}