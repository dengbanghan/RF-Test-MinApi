*** Settings ***
Resource          ../行情中心资讯.robot
Resource          ../../校验功能.robot

*** Test Cases ***
交易日历查询
    ${res}    交易日历查询
    字典关键字校验    ${res}    msg    OK
