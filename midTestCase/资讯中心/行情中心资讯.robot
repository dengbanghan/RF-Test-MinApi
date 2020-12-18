*** Settings ***
Library           ../../Library/RFCommonLibrary/
Resource          ../程序功能.robot
Resource          ../校验功能.robot

*** Keywords ***
交易日历查询
    ${api}    Set Variable    /open/info/market/calendar
    ${res}    Get请求    ${server_address}${api}
    [Return]    ${res}

合约信息查询
    ${api}    Set Variable    /open/info/market/instr
    ${res}    Get请求    ${server_address}${api}
    [Return]    ${res}

查询合约信息更新
    ${value}    Set Variable    latestTime=2020-07-08T18:01:45.542715
    ${api}    Set Variable    /open/info/market/instr/latest?${value}
    ${res}    Get请求    ${server_address}${api}
    [Return]    ${res}
