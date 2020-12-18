*** Settings ***
Resource          ../证券详情api.robot
Resource          stock_parameter.robot

*** Test Cases ***
查询港股
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=&{securityCode}[HK_STOCK]    pageIndex=1    pageSize=20
    ${res}    分红送股详情    ${data}
    字典关键字校验    ${res}    msg    OK

查询美股
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=&{securityCode}[US_STOCK]    pageIndex=1    pageSize=20
    ${res}    分红送股详情    ${data}
    字典关键字校验    ${res}    msg    OK

查询港期
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=&{securityCode}[HK_FUTURES]    pageIndex=1    pageSize=20
    ${res}    分红送股详情    ${data}
    字典关键字校验    ${res}    msg    OK

查询外期
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=&{securityCode}[GLOBAL_FUTURES]    pageIndex=1    pageSize=20
    ${res}    分红送股详情    ${data}
    字典关键字校验    ${res}    msg    OK
