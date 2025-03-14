import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
// import dataCtrl from '../dataModel/DataCtrl'
import { Header } from '../view/Header'
import { User } from '../pojo/User'
import { url } from '@kit.ArkTS'
@Component
@Entry
struct Index {

  @State Uno: string = ''
  @State Upassword: string = ''

  build() {
    Column(){
      // 顶栏
      Header()

      // logo
      LogoModel()

      // 登录注册
      LogInModel({Uno: $Uno,Upassword: $Upassword})

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#fafafa')
  }
}



// 登录注册模块
@Component
struct LogInModel {

  @Link Uno: string
  @Link Upassword: string

  build() {
    Column({space: 20}){
      TextInput({placeholder: '请输入用户名'})
        .onChange(message => {
          this.Uno = message
        })
        .width('80%')
        .borderRadius(0)
        .backgroundColor('null')
        .border({color: Color.Gray,style: BorderStyle.Solid,width: {
          bottom: 2
        }})
        .backgroundColor('#00000000')

      TextInput({placeholder: '请输入密码'})
        .type(InputType.Password)
        .onChange(message => {
          this.Upassword = message
        })
        .width('80%')
        .borderRadius(0)
        .backgroundColor('null')
        .border({color: Color.Gray,style: BorderStyle.Solid,width: {
          bottom: 2
        }})
        .backgroundColor('#00000000')

      // 登录注册按钮
      Button('登录',{type: ButtonType.Normal})
        .onClick(async () => {
          router.pushUrl(
            {
              url: 'pages/HomePage_order'
            },
            router.RouterMode.Single,
            err => {
              if(err){
                console.log('注册页面跳转失败')
              }
            }
          )
          // if(await dataCtrl.selectUser(this.Uno,this.Upassword)) {
          //   // 密码正确后将用户数据填入
          //   User.Uno = this.Uno
          //   User.Upassword = this.Upassword
          //   User.Uname = await dataCtrl.selectUserName(this.Uno)
          //   // 跳转
          //   router.replaceUrl(
          //     {
          //       url: 'pages/HomePage',
          //     },
          //     router.RouterMode.Single,
          //     err => {
          //       if (err) {
          //         console.log('testLog', '主页面跳转错误')
          //       }
          //     }
          //   )
          // }
          // else {
          //   promptAction.showToast({
          //     message: '账号或密码错误！',
          //     duration: 1500
          //   })
          // }
        })
        .margin({top: 20})
        .width('80%')
        .height('15%')
        .backgroundColor('#c49a81')
        .fontColor(Color.White)
        .fontSize(20)
      Button('没有账号？点我注册',{type: ButtonType.Normal})
        .onClick(() => {
          router.pushUrl(
            {
              url: 'pages/SignUp'
            },
            router.RouterMode.Single,
            err => {
              if(err){
                console.log('注册页面跳转失败')
              }
            }
          )
        })
        .height('5%')
        .padding(0)
        .backgroundColor('#00000000')
        .border({color: Color.Gray,width: {
          bottom: 1
        }})
        .fontColor(Color.Gray)
        .fontSize(15)
    }
    .width('100%')
    .height('40%')
  }
}

// logo图片
@Component
struct LogoModel {
  build() {
    Row(){
      Image($r('app.media.p1'))
        .sharedTransition(`log_image`, { duration: 800, curve: Curve.Linear, delay: 100 })
        .height('100%')
    }
    .width('100%')
    .height('25%')
    .justifyContent(FlexAlign.Center)
    .margin({top: 40,bottom: 40})
  }
}