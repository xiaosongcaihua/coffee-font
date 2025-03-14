@Component
export  struct Header {
  build() {
    Row(){
      Text('松达的茶')
        .fontColor('white')
        .fontSize(30)
        .padding({left: 15})
    }
    .width('100%')
    .height('220px')
    .backgroundColor('#c49a81');
  }
}