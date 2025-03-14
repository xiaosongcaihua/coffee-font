import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
// import dataCtrl from '../dataModel/DataCtrl'
import { Header } from '../view/Header'
import { User } from '../pojo/User'
// @Entry
@Component
export  struct UpdatePassword {

  oldPassword: string = ""
  newPassword: string = ""

  build() {
    Column(){
      Header()

      Column(){
        Text('设置新密码')
          .margin({bottom: 50})
          .width('100%')
          .fontSize(35)
          .textAlign(TextAlign.Start)

        Row(){
          Text('旧密码')
          TextInput({placeholder: '请输入旧密码'})
            .onChange(message => {
              this.oldPassword = message
            })
            .backgroundColor('#0000')
            .width('70%')
        }
        .width('100%')
        .border({
          width: {bottom: 1},
          color: Color.Gray
        })
        .margin({bottom: 5})

        Row(){
          Text('新密码')
          TextInput({placeholder: '请设置新密码'})
            .onChange(message => {
              this.newPassword = message
            })
            .backgroundColor('#0000')
            .width('70%')
        }
        .width('100%')
        .border({
          width: {bottom: 1},
          color: Color.Gray
        })

        Blank()
        Button('确定')
          .onClick(async () => {
            if(this.oldPassword == User.Upassword){
              if(this.newPassword != '' && this.newPassword != undefined){
                // await dataCtrl.updataPassword(User.Uno,this.newPassword)

                router.clear()
                router.replaceUrl(
                  {
                    url: 'pages/LogIn'
                  },
                  router.RouterMode.Single,
                  err => {
                    if(err){
                      console.log('08808','密码修改再跳转失败')
                    }
                  }
                )
                promptAction.showToast({
                  message: '密码修改成功,请重新登录',
                  duration: 1500
                })
              }
              else {
                promptAction.showToast({
                  message: '密码不能为空',
                  duration: 1500
                })
              }
            }
            else{
              promptAction.showToast({
                message: '旧密码错误',
                duration: 1500
              })
            }
          })
          .width('270')
          .borderRadius(5)
          .type(ButtonType.Normal)
          .backgroundColor('#d6b98d')

        Button('取消')
          .onClick(() => {
            router.back()
          })
          .width('270')
          .borderRadius(5)
          .type(ButtonType.Normal)
          .backgroundColor('#d6b98d')
          .margin({bottom: 180,top: 15})
      }
      .width('100%')
      .layoutWeight(1)
      .padding(10)
    }
    .backgroundColor('#fafafa')
    .width('100%')
    .height('100%')
  }
}