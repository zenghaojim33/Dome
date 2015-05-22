#ifndef Dome_Key_h
#define Dome_Key_h

//按类别名称获取本身及其下的子类别
#define GetByName @"http://server.dome123.com/category.ashx?aim=getbyid&id=%@"

//按类别id或类别名称搜索商品
#define GetByCategory @"http://server.dome123.com/product.ashx?aim=getbycategory&key=%@&seachtype=%@&pagesize=20&pageindex=%d&sort=%@"

//
#define GetByCategoryID @"http://server.dome123.com/attribute.ashx?aim=getbycategoryid&cid=%@"

//valueids=属性值id&categoryid=商品类别id&pagesize=每页记录数&pageindex=第几页&sort=排序字段
#define  Getbycategoryandvalueid  @"http://server.dome123.com/product.ashx?aim=getbycategoryandvalueid&valueids=%@&categoryid=%@&pagesize=24&pageindex=%d&sort=%@&sequence=%@"



/*排序 
 price 价格
 sales 销量
 createtime 时间
 */

//登录 {phone:手机号码,@"password:密码"}
#define Login @"http://app.dome123.com/Handler.ashx?Action=Login&data=%@"

//找回密码 {phone:手机号码,@"code:验证码",password:旧密码,@"passwordagain:新密码"}
#define RetrievePassWord @"http://app.dome123.com/Handler.ashx?Action=ChangePassWord&data=%@"

//获取验证码 {phone:手机号码}
#define GetSmsCodel @"http://app.dome123.com/Handler.ashx?Action=GetCodePassWord&data=%@"

//获取验证码 {phone:手机号码}
#define GetSmsCodel2 @"http://app.dome123.com/Handler.ashx?Action=GetCode&data=%@"

//注册 {phone:手机号码,@"password:密码,code:验证码",shoid:店id}
#define Register @"http://app.dome123.com/Handler.ashx?Action=Register&data=%@"

//买家升级卖家 {uid:用户id,shopid:店id}
#define UpGrade @"http://app.dome123.com/Handler.ashx?Action=UserUpdate&data=%@"

//修改资料
/*
 {
 userID:用户id
 shopname:店铺名
 province:省
 city:城
 area:区
 address:详细地址
 email:邮箱
 acountname:银行
 bank:开户名
 certificate:身份证
 bankno:卡号
 shopinfo:店铺简介
 }
 */
#define ChangeInfo @"http://app.dome123.com/Handler.ashx?Action=SetInfo&data=%@"

//获取资料 {id:用户id}
#define GetInfo @"http://app.dome123.com/Handler.ashx?Action=GetInfo&data=%@"

//产品地址(用于分享) 产品id   用户id
#define CopyProduct @"http://weixin.dome123.com/AllBeauty/ProudtDetail.html?productID=%@&id=%@"

//产品详情预览   产品id
#define ProductInfo @"http://weixin.dome123.com/AllBeauty/PreviewPage.html?productID=%@&id=null"

//店铺地址(用户分享) 店铺id
#define CopyShop @"http://weixin.dome123.com/AllBeauty/indexProduct.html?id=%@"

//查询订单
/*
    if(没有选择时间)
    {
        {shopid:店铺id,page:页码,@pagesize:显示数量,status:订单状态}
    }else{
        {shopid:店铺id,page:页码,@pagesize:显示数量,begin:开始时间,end:结束时间,status:订单状态}
    }
    订单状态 == 状态button.tag
 */
#define GetShopOrderList @"http://app.dome123.com/Handler.ashx?Action=GetShopOrderList&data=%@"

//订单详情 {orderid:订单id}
#define OrderDetail @"http://app.dome123.com/Handler.ashx?Action=GetOrderDetail&data=%@"

//获取可抢订单 {page:页码,pagesize:显示数量}
#define GetOrderList @"http://app.dome123.com/Handler.ashx?Action=GetOrderList&data=%@"

//抢单 {shopid:店铺id,订单id}
#define SetOrderList @"http://app.dome123.com/Handler.ashx?Action=SetOrder&data=%@"

//获取我的收入 {uid:用户id}
#define GetIncome @"http://app.dome123.com/Handler.ashx?Action=GetBenefitAccount&data=%@"

//获取收入详情 {@"uid":用户id,@"page":页码,@"pagesize":显示数量}  //测试 shopid : dome88888888
#define GetBenefit @"http://app.dome123.com/Handler.ashx?Action=GetBenefitList&data=%@"

//获取客户列表 {@"shopid:店铺id",@"page:页码",@"pagesize:显示数量"}
#define GetCustomer @"http://app.dome123.com/Handler.ashx?Action=GetUserList&data=%@"

//获取客户详情 {@"shopid:店铺id",@"uid:用户id",@"page:页码",@"pagesize:显示数量"}
#define GetCustomerInfo @"http://app.dome123.com/Handler.ashx?Action=GetShopUsersOrderList&data=%@"

//二维码地址   用户id
#define RQCode @"http://app.dome123.com/web/registerPage.aspx?sid=%@"
#endif



//asdadasd
