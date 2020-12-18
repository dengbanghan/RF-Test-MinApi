*** Settings ***
Resource          ../../资金账户接口.robot

*** Test Cases ***
提交-换汇单
    ${submitSource}    Set Variable    CP_H5
    ${data}    Create Dictionary    submitSource=${submitSource}    exchangeAmount=50    exchangeCurrency=USD    fromCurrency=HKD    toCurrency=USD    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
    ${res}    提交-换汇单    ${data}

Token的key为空
    ${header}    Create Dictionary    Content-Type=application/json
    ${submitSource}    Set Variable    CP_H5
    ${data}    Create Dictionary    submitSource=${submitSource}    exchangeAmount=50    exchangeCurrency=USD    fromCurrency=HKD    toCurrency=USD    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
    ${res}    提交-换汇单    ${data}    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

Token的value为空
    ${header}    Create Dictionary    Content-Type=application/json    Authorization=
    ${submitSource}    Set Variable    CP_H5
    ${data}    Create Dictionary    submitSource=${submitSource}    exchangeAmount=50    exchangeCurrency=USD    fromCurrency=HKD    toCurrency=USD    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
    ${res}    提交-换汇单    ${data}    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

提交来源-入参为正确
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM    UNKNOWN_SOURCE    CDMS
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${submitSource}    Get List Index Value    ${submitSource_list}    ${i}
        ${data1}    Create Dictionary    exchangeAmount=50    exchangeCurrency=USD    fromCurrency=HKD    toCurrency=USD    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-换汇单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交来源-入参为错误
    ${submitSource_list}    Create List    \    UNKNOWN
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${submitSource}    Get List Index Value    ${submitSource_list}    ${i}
        ${data1}    Create Dictionary    exchangeAmount=50    exchangeCurrency=USD    fromCurrency=HKD    toCurrency=USD    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-换汇单    ${data}
        字典关键字校验    ${res}    msg    &{errMsg}[null]
    END

交易账号-入参为正确

交易账号入参为错误
