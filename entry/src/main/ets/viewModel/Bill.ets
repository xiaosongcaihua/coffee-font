export class Bill {
  Bno: string
  Btime: string
  Btype: string
  Bprice: number
  Bdno: number
  Bsum: number

  constructor(Bno:string,Btime:string,Btype:string,Bprice:number,Bdno:number,Bsum:number) {
    this.Bno = Bno
    this.Btime = Btime
    this.Btype = Btype
    this.Bprice = Bprice
    this.Bdno = Bdno
    this.Bsum = Bsum
  }
}