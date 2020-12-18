*** Settings ***
Resource          ../行情中心资讯.robot
Resource          ../../校验功能.robot

*** Test Cases ***
查询合约信息更新
    ${res}    查询合约信息更新
    字典关键字校验    ${res}    msg    OK
