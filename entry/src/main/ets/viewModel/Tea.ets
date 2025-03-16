import resourceManager from '@ohos.resourceManager'
@Observed
export class Tea {
  // 编号:在数组中的位置
  no: number = 0
  // 首字母
  firstI: string = ""
  name: string
  image: resourceManager.Resource
  // 简介
  about: string
  // 总价格
  price: number
  // 数量
  sum: number = 0
  // 顾客备注
  notes: string = ""
  // 类型,标记属于四类中的哪一类
  type: number
  // 时间
  Ctime: string = ""

  // 规格
  norms: Norms = {
    cup: 0,
    temp: 0,
    sweetness: 0
  }



  constructor(name: string,image: resourceManager.Resource,about: string,price: number,type: number,ctime?:string,sum?: number,notes?: string,norms?: Norms,firstI?: string,no?: number) {
    this.name = name
    this.image = image
    this.about = about
    this.price = price
    this.type = type
    if (ctime != undefined){
      this.Ctime = ctime
    }


    if(sum){
      this.sum = sum
    }
    if(notes){
      this.notes = notes
    }
    if(norms){
      this.norms = norms
    }
    if(firstI){
      this.firstI = firstI
    }
    if(no){
      this.no = no
    }
  }

}
export interface Norms {
  cup: number,
  temp: number,
  sweetness: number
}