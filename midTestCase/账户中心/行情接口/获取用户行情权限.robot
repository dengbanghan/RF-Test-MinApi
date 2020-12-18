*** Settings ***
Resource          ../行情接口.robot

*** Test Cases ***
获取用户行情权限-平台信息为IOS
    ${platform}    Set Variable    platform=IOS
    ${res}    获取用户行情权限    ${platform}
    字典关键字校验    ${res}    msg    OK

获取用户行情权限-平台信息为Android
    ${platform}    Set Variable    platform=Android
    ${res}    获取用户行情权限    ${platform}
    字典关键字校验    ${res}    msg    OK

获取用户行情权限-平台信息为PC
    ${platform}    Set Variable    platform=PC
    ${res}    获取用户行情权限    ${platform}
    字典关键字校验    ${res}    msg    OK

获取用户行情权限-平台信息为Web
    ${platform}    Set Variable    platform=Web
    ${res}    获取用户行情权限    ${platform}
    字典关键字校验    ${res}    msg    OK

获取用户行情权限-平台信息为H5
    ${platform}    Set Variable    platform=H5
    ${res}    获取用户行情权限    ${platform}
    字典关键字校验    ${res}    msg    OK

获取用户行情权限-非必要参数key为空
    ${platform}    Set Variable
    ${res}    获取用户行情权限    ${platform}
    字典关键字校验    ${res}    msg    OK

获取用户行情权限-非必要参数value为空
    ${platform}    Set Variable    platform=
    ${res}    获取用户行情权限    ${platform}
    字典关键字校验    ${res}    msg    OK
