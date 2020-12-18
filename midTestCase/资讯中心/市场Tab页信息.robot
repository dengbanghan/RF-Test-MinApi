*** Settings ***
Resource          ../程序功能.robot

*** Keywords ***
市场主页信息
    [Arguments]    ${platform}    ${tabName}
    ${api}    Set Variable    /open/info/home/market/tabs?${platform}&${tabName}
    ${res}    Get请求    ${server_address}${api}
    [Return]    ${res}
