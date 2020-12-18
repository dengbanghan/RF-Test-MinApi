*** Settings ***
Resource          ../程序功能.robot

*** Keywords ***
用户信息、交易帐号信息
    [Arguments]    ${platform}    ${header}=${header_default}
    ${api}    Set Variable    /open/account/eddid/info?${platform}
    ${res}    GET请求    ${server_adress}${api}    ${header}
    [Return]    ${res}

客户声明-同意协议条款
    [Arguments]    ${data}    ${header}=${header_default}
    ${api}    Set Variable    /open/account/eddid/agreement/agree
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

个人中心-帐号信息
    [Arguments]    ${submitSource}=    ${header}=${header_default}
    ${api}    Set Variable    /open/account/trade/query-account-info?${submitSource}
    ${res}    GET请求    ${server_address}${api}    ${header}
    [Return]    ${res}

个人中心-提交-风险取向问卷单
