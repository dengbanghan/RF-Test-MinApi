*** Settings ***
Resource          ../证券详情api.robot
Resource          stock_parameter.robot

*** Test Cases ***
查询港股-所有报告
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=&{securityCode}[HK_STOCK]    timeTypeCode=ALL_REPORT
    ${res}    现金流量列表    ${data}
    字典关键字校验    ${res}    msg    OK

查询港股-年报
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=&{securityCode}[HK_STOCK]    timeTypeCode=YEAR_REPORT
    ${res}    现金流量列表    ${data}
    字典关键字校验    ${res}    msg    OK

查询港股-半年报
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=&{securityCode}[HK_STOCK]    timeTypeCode=HALF_YEAR_REPORT
    ${res}    现金流量列表    ${data}
    字典关键字校验    ${res}    msg    OK

查询港股-第一季度报
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=&{securityCode}[HK_STOCK]    timeTypeCode=FIRST_QUARTER_REPORT
    ${res}    现金流量列表    ${data}
    字典关键字校验    ${res}    msg    OK

查询港股-第三季度报
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=&{securityCode}[HK_STOCK]    timeTypeCode=THIRD_QUARTER_REPORT
    ${res}    现金流量列表    ${data}
    字典关键字校验    ${res}    msg    OK
