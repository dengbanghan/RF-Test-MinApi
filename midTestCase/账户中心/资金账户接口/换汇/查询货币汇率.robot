*** Settings ***
Resource          ../../资金账户接口.robot

*** Test Cases ***
查询货币汇率
    ${tradeAccountNumber}    Set Variable    tradeAccountNumber=2020040101
    ${tradeAccountType}    Set Variable    tradeAccountType=SECURITIES_CASH
    ${res}    查询货币汇率    ${tradeAccountNumber}    ${tradeAccountType}
    字典关键字校验    ${res}    msg    OK
