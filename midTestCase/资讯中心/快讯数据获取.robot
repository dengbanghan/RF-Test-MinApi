*** Settings ***
Library           ../../Library/RFCommonLibrary/
Resource          ../程序功能.robot
Resource          ../校验功能.robot

*** Keywords ***
快讯数据获取
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/news/fetch
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}
