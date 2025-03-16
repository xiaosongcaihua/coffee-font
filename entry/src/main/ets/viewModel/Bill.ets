export class Bill {
  bno: string
  btime: string
  btype: string
  bprice: number
  bdno: number
  bsum: number

  constructor(Bno:string,Btime:string,Btype:string,Bprice:number,Bdno:number,Bsum:number) {
    this.bno = Bno
    this.btime = Btime
    this.btype = Btype
    this.bprice = Bprice
    this.bdno = Bdno
    this.bsum = Bsum
  }
}
export interface  BillInfo {
  bno: string
  btime: string
  btype: string
  bprice: number
  bdno: number
  bsum: number
  uno:string
}