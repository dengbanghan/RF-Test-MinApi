*** Settings ***
Resource          ../市场Tab页信息.robot

*** Test Cases ***
市场主页信息-平台信息为IOS
    ${platform}    Set Variable    platform=IOS
    ${tabName}    Set Variable    tabName=future
    ${res}    市场主页信息    ${platform}    ${tabName}
    字典关键字校验    ${res}    msg    OK

市场主页信息-平台信息为Android
    ${platform}    Set Variable    platform=Android
    ${tabName}    Set Variable    tabName=future
    ${res}    市场主页信息    ${platform}    ${tabName}
    字典关键字校验    ${res}    msg    OK

市场主页信息-平台信息为PC
    ${platform}    Set Variable    platform=PC
    ${tabName}    Set Variable    tabName=future
    ${res}    市场主页信息    ${platform}    ${tabName}
    字典关键字校验    ${res}    msg    OK

市场主页信息-平台信息为Web
    ${platform}    Set Variable    platform=Web
    ${tabName}    Set Variable    tabName=future
    ${res}    市场主页信息    ${platform}    ${tabName}
    字典关键字校验    ${res}    msg    OK

市场主页信息-非必要参数key为空
    ${platform}    Set Variable    platform=Web
    ${tabName}    Set Variable
    ${res}    市场主页信息    ${platform}    ${tabName}
    字典关键字校验    ${res}    msg    OK

市场主页信息-非必要参数value为空
    ${platform}    Set Variable    platform=Web
    ${tabName}    Set Variable    tabName=
    ${res}    市场主页信息    ${platform}    ${tabName}
    字典关键字校验    ${res}    msg    OK

市场主页信息-展示页签为不可用值
    ${tabName}    生成随机小写字母    6
    ${platform}    Set Variable    platform=Web
    ${tabName}    Set Variable    tabName=${tabName}
    ${res}    市场主页信息    ${platform}    ${tabName}
    字典关键字校验    ${res}    msg    &{errMsg}[null]
