import router from '@ohos.router'
import window from '@ohos.window'
@Entry
@Component
struct MainPage {
  aboutToAppear(){
    setTimeout(
      () => {
        router.pushUrl(
          {
            url: 'pages/Login'
          },
          router.RouterMode.Single,
          err => {
            if(err){
              console.log('08808','登录页跳转失败')
            }
          }
        )
      },
      2000
    )
  }

  build() {
    Column(){
      Image($r('app.media.p1'))
        .sharedTransition(`log_image`, { duration: 800, curve: Curve.Linear, delay: 100 })
        .width(150)
        .height(150)
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    .backgroundColor('#c49a81')
  }
}