*** Settings ***
Resource          ../自选股接口.robot

*** Test Cases ***
查询默认自选-marketTab为ALL
    ${marketTab}    Set Variable    marketTab=ALL
    ${res}    查询默认自选    ${marketTab}
    字典关键字校验    ${res}    msg    OK

查询默认自选-marketTab为FUTURE
    ${marketTab}    Set Variable    marketTab=FUTURE
    ${res}    查询默认自选    ${marketTab}
    字典关键字校验    ${res}    msg    OK

查询默认自选-非必要参数key为空
    ${marketTab}    Set Variable    marketTab=ALL
    ${res}    查询默认自选    ${marketTab}
    字典关键字校验    ${res}    msg    OK

查询默认自选-非必要参数value为空
    ${marketTab}    Set Variable    marketTab=
    ${res}    查询默认自选    ${marketTab}
    字典关键字校验    ${res}    msg    OK
