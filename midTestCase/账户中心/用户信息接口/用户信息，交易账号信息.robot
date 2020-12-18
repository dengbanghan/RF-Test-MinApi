*** Settings ***
Resource          ../用户信息接口.robot

*** Test Cases ***
用户，交易账号信息-platform为IOS
    ${platform}    Set Variable    platform=IOS
    ${res}    用户信息、交易帐号信息    ${platform}
