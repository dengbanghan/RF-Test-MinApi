*** Settings ***
Resource          ../行情中心资讯.robot
Resource          ../../校验功能.robot

*** Test Cases ***
查询合约信息
    ${res}    合约信息查询
    字典关键字校验    ${res}    msg    OK
