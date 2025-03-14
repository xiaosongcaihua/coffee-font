import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { Header } from '../view/Header'
// import dataCtrl from '../dataModel/DataCtrl'
@Entry
@Component
struct SignUp {
  @State Uno: string = ''
  @State Uname: string = ''
  @State Upassword: string = ''
  @State reUpassword: string = ''


  build() {
    Column(){
      // 顶栏
      Header()

      // 头像
      TouXiangModel()

      // 输入框及按钮
      InputModel({Uno: $Uno,Uname: $Uname,Upassword: $Upassword,reUpassword: $reUpassword});
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#fafafa')
  }
}


// 头像
@Component
struct TouXiangModel {
  build() {
    Row(){
      Image($r("app.media.p2"))
        .height('110%')
        .width('30%')
    }
    .width('100%')
    .height('100')
    .justifyContent(FlexAlign.Center)
    .margin(70)
  }
}

// 输入框及按钮
@Component
struct InputModel {

  @Link Uno: string
  @Link Uname: string
  @Link Upassword: string
  @Link reUpassword: string

  build() {
    Column({space: 20}){
      TextInput({placeholder: '请输入用户名（小于等于15位）'})
        .onChange((message) => {
          this.Uno = message
        })
        .width('90%')
        .height(50)

      TextInput({placeholder: '请输入昵称'})
        .onChange((message) => {
          this.Uname = message
        })
        .width('90%')
        .height(50)

      TextInput({placeholder: '请输入密码（小于等于15位）'})
        .type(InputType.Password)
        .onChange((message) => {
          this.Upassword = message
        })
        .width('90%')
        .height(50)

      TextInput({placeholder: '请再次输入密码'})
        .type(InputType.Password)
        .onChange((message) => {
          this.reUpassword = message
        })
        .width('90%')
        .height(50)

      Row(){
        Button('注册')
          .onClick(async () => {
            if(this.reUpassword != this.Upassword){
              promptAction.showToast({
                message: '密码输入不一致！',
                duration: 1500
              })
            }
            else if(this.Uno == '' || this.Uname == '' || this.Upassword == ''){
              promptAction.showToast({
                message: '信息不可为空！',
                duration: 1500
              })
            }
            // else if(!await dataCtrl.selectUser_(this.Uno)){
            //   promptAction.showToast({
            //     message: '此账号已存在，请修改！',
            //     duration: 1500
            //   })
            // }
            else if(this.Uno.length > 15 || this.Upassword.length > 15){
              promptAction.showToast({
                message: '账号或密码不可大于15位，请修改！',
                duration: 1500
              })
            }
            // else {
            //   dataCtrl.insertUser(this.Uno,this.Upassword,this.Uname)
            //   promptAction.showToast({
            //     message: '注册成功！',
            //     duration: 1500
            //   })
            //   router.back()
            // }
          })
          .width(100)
          .backgroundColor('#c49a81')
        Button('取消')
          .onClick(() => {
            router.back()
          })
          .width(100)
          .backgroundColor('#c49a81')
      }
      .width('100%')
      .margin({top: 20})
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .layoutWeight(1)
  }
}