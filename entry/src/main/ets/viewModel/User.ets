export class User{
  public static Uno: string
  public static  Upassword: string
  public static  Uname: string
}

export interface UserLogin{
  Uno: string
  Upassword: string
}
export interface UserLoginRes{
  uno: string
  upassword: string
  uname: string
}
export interface UserRegister{
  Uno: string
  Upassword: string
  Uname: string
}
export interface SelectUserByUno{
  Uno: string
}
export interface updateUserPSD{
  Upassword: string
  Uno: string
}
