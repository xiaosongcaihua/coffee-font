@Component
export  struct Header {
  build() {
    Row(){
      Text('幸运咖啡')
        .fontColor('white')
        .fontSize(30)
        .padding({left: 15})
    }
    .width('100%')
    .height('220px')
    .backgroundColor('#c49a81');
  }
}