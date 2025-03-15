import { http } from "@kit.NetworkKit";
import { BusinessError } from "@kit.BasicServicesKit";
import { On } from "@ohos.UiTest";
import { User } from "../viewModel/User";

export class HttpUtil{
  private static baseUrl:string ="http://localhost:8080/"
  /**
   * GET 请求
   * @param url
   * @param callBack
   * @param reqData
   */
  public static get(url:string,callBack:Function,reqData?:object ){
    let httpRequest = http.createHttp();
    httpRequest.request(
      HttpUtil.baseUrl+url,
      {
        //method: http.RequestMethod.GET, // 可选，默认为http.RequestMethod.GET
        // 开发者根据自身业务需要添加header字段
        header: { 'Content-Type': 'application/json;charset=UTF-8' },
        // 当使用POST请求时此字段用于传递请求体内容，具体格式与服务端协商确
        extraData: reqData,
        expectDataType: http.HttpDataType.OBJECT},
      (err: BusinessError, data: http.HttpResponse)=>{
        console.log("响应的数据："+data.result)
        callBack(data.result)
      })
  }

  public static post(url:string,callBack:Function,reqData?:object ){
    let httpRequest = http.createHttp();
    httpRequest.request(
      HttpUtil.baseUrl+url,
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 开发者根据自身业务需要添加header字段
        header: { 'Content-Type': 'application/json' },
        // 当使用POST请求时此字段用于传递请求体内容，具体格式与服务端协商确定
        extraData: reqData,
        expectDataType: http.HttpDataType.OBJECT},
      (err: BusinessError, data: http.HttpResponse)=>{
        console.log("响应的数据："+data.result)
        callBack(data.result)
      })
  }

  public static put(url:string,callBack:Function,reqData?:object ){
    let httpRequest = http.createHttp();
    httpRequest.request(
      HttpUtil.baseUrl+url,
      {
        method: http.RequestMethod.PUT, // 可选，默认为http.RequestMethod.GET
        // 开发者根据自身业务需要添加header字段
        header: { 'Content-Type': 'application/json' },
        // 当使用POST请求时此字段用于传递请求体内容，具体格式与服务端协商确定
        extraData: reqData,
        expectDataType: http.HttpDataType.OBJECT},
      (err: BusinessError, data: http.HttpResponse)=>{
        console.log("响应的数据："+data.result)
        callBack(data.result)
      })
  }

  public static delete(url:string,callBack:Function,reqData?:object ){
    let httpRequest = http.createHttp();
    httpRequest.request(
      HttpUtil.baseUrl+url,
      {
        method: http.RequestMethod.DELETE, // 可选，默认为http.RequestMethod.GET
        // 开发者根据自身业务需要添加header字段
        header: { 'Content-Type': 'application/json' },
        // 当使用POST请求时此字段用于传递请求体内容，具体格式与服务端协商确定
        extraData: reqData,
        expectDataType: http.HttpDataType.OBJECT},
      (err: BusinessError, data: http.HttpResponse)=>{
        console.log("响应的数据："+data.result)
        callBack(data.result)
      })
  }


}

//函数
export function  getTest():string{
  return "测试"
}
