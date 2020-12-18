*** Settings ***
Resource          ../程序功能.robot

*** Keywords ***
获取用户行情权限
    [Arguments]    ${platform}
    ${api}    Set Variable    /open/account/eddid/market-rights?${platform}
    ${res}    Get请求    ${server_address}${api}
    [Return]    ${res}

实时行情服务-申请列表-主页
    ${api}    Set Variable    /open/account/trade/quote-service
    ${res}    GET请求    ${server_address}${api}
    [Return]    ${res}

提交-实时行情服务单
