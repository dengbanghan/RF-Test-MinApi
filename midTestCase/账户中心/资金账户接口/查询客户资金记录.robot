*** Settings ***
Resource          ../资金账户接口.robot

*** Test Cases ***
查询客户资金记录
    ${endTime}    Set Variable    endTime=2020-07-28T14:16:30
    ${startTime}    Set Variable    startTime=2019-01-01T14:16:30
    ${pageIndex}    Set Variable    pageIndex=1
    ${pageSize}    Set Variable    pageSize=30
    ${tradeRecord}    Set Variable    tradeRecord=DEPOSIT_RECORD
    ${tradeAccountType}    Set Variable    tradeAccountType=SECURITIES_CASH
    ${res}    查询客户资金记录    ${endTime}    ${startTime}    ${pageIndex}    ${pageSize}    ${tradeRecord}    ${tradeAccountType}
    字典关键字校验    ${res}    msg    OK
