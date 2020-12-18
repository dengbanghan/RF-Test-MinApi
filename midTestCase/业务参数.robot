*** Variables ***
&{config}         server_address=https://route-service-develop.eddid.com.cn:1443    mysql_host=rm-wz94r73is5gxn6it59o.mysql.rds.aliyuncs.com    mysql_port=3306    mysql_user=eddid_dev    mysql_pwd=eddid@123    mysql_db=account_center_qa
&{optional}       exchangeType=HKFE    marketTab=FUTURE    marketType=HK_FUTURES
&{mongodb}        host=dds-wz9bd1678ca7e0e41718-pub.mongodb.rds.aliyuncs.com    port=3717    user_name=new-cs-user-qa    password=tPuAPI8X5w8nTWUL    db_name=new-common-service-qa    collection_name=messages
&{errMsg}         null=非常抱歉，你的请求参数有误    list_null=[]    token_null=非常抱歉，你好像还没有登录哦    token_err=access_token无效    business_repeat=业务申请中，不可重复申请    trade_num_err=交易帐号不存在    un_error=未知错误    bank_null=银行卡不存在    doing=还有处理中的申请
&{tradeNum}       secCash=2020043001    secMargin=2020043002    futMargin=2020043003    bullionMargin=2020043004    interBrokerIntegr=2020043005    secAyersCash=2020043006    futDayTradeMargin=2020043007    MT5=2020043008    MF=2020043009
&{tradeType}      secCash=SECURITIES_CASH    futMargin=FUTURES_MARGIN    secMargin=SECURITIES_MARGIN    bullionMargin=BULLION_MARGIN    interBrokerIntegr=INTERACTIVE_BROKER_INTEGRATED_MARGIN    secAyersCash=SECURITIES_AYERS_CASH    futDayTradeMargin=FUTURES_DAYTRADING_MARGIN    MT5=MT5    MF=MF
&{auth}           server_address=https://eddid-auth-center-develop.eddid.com.cn:1443    auth_info=Basic dGVzdGFwcDI6YWJjZA==    phone_num=8617722527464    auth_password=han920929    device_id=366ebd35971e1929
