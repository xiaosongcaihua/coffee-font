import router from '@ohos.router'
import { StaticValue } from '../viewModel/StaticValue'
import { Tea } from '../viewModel/Tea'
@Component
export  struct OrderModel {
  @Consume teas: Tea[]
  currentType: number = 0
  build() {
    Column(){
      List(){
        ForEach(this.teas,(tea: Tea,index) => {
          if(tea.type == this.currentType){
            ListItem(){
              Row(){
                Image(tea.image as Resource)
                  .sharedTransition(`image${tea.no}`, { duration: 800, curve: Curve.Linear, delay: 100 })
                  .width(100)
                  .margin({right: 10})

                Column(){
                  Text(tea.name)
                    .width('100%')
                    .textAlign(TextAlign.Start)
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                  Text(tea.about)
                    .fontColor(Color.Gray)

                  Row(){
                    Text('￥' + tea.price.toString())
                      .fontColor('#5c8179')
                      .fontSize(20)

                    // 空白占位
                    Blank()

                    Button('选规格')
                      .onClick(() => {
                        router.pushUrl(
                          {
                            url: 'pages/SelectSpecifications',
                            params: {tea}
                          },
                          router.RouterMode.Single,
                          err => {
                            if(err){
                              console.log('选规格页面路由失败')
                            }
                          }
                        )
                      })
                      .backgroundColor('#d5be8e')
                      .fontColor(Color.White)
                      .height('30')
                  }
                  .margin({top: 10})
                  .width('100%')
                }
                .layoutWeight(1)
              }
              .width('100%')
              .height(130)
              .padding(10)
            }
            .margin({bottom: 10})
          }

        })
      }
      .width('100%')
      .height('94%')

    }
    .height('100%')
    .width('100%')
  }
}