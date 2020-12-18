*** Settings ***
Resource          ../../资金账户接口.robot

*** Test Cases ***
提交-内部转账单
    ${submitSource}    Set Variable    CP_H5
    ${data}    Create Dictionary    submitSource=${submitSource}    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040102    toTradeAccountType=FUTURES_MARGIN
    ${res}    提交-内部转账单    ${data}
    字典关键字校验    ${res}    msg    OK

Token的key为空
    执行sql语句    delete from transfer where eddid_id=${eddid_id};
    ${header}    Create Dictionary    Content-Type=application/json
    ${data}    Create Dictionary    submitSource=CP_H5    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
    ${res}    提交-内部转账单    ${data}    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

Token的value为空
    执行sql语句    delete from transfer where eddid_id=${eddid_id};
    ${header}    Create Dictionary    Content-Type=application/json    Authorization=
    ${data}    Create Dictionary    submitSource=CP_H5    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
    ${res}    提交-内部转账单    ${data}    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

提交来源-入参为正确
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM    UNKNOWN_SOURCE    CDMS
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from transfer where eddid_id='${eddid_id}';
        ${submitSource}    Get List Index Value    ${submitSource_list}    ${i}
        ${data1}    Create Dictionary    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-内部转账单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交来源-入参为错误
    ${submitSource_list}    Create List    \    UNKNOWN
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from transfer where eddid_id='${eddid_id}';
        ${submitSource}    Get List Index Value    ${submitSource_list}    ${i}
        ${data1}    Create Dictionary    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-内部转账单    ${data}
        字典关键字校验    ${res}    msg    &{errMsg}[null]
    END

转出交易账号类型(不包含黄金)-入参为正确
    ${fromTradeAccountType_list}    Create List    SECURITIES_MARGIN    SECURITIES_AYERS_CASH    FUTURES_MARGIN    FUTURES_DAYTRADING_MARGIN    MF    MT5
    ${list_length}    Evaluate    len(${fromTradeAccountType_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from transfer where eddid_id='${eddid_id}';
        ${fromTradeAccountType}    Get List Index Value    ${fromTradeAccountType_list}    ${i}
        ${field}    查询数据库    select trade_account_id_number from trade_account where eddid_id='${eddid_id}' and trade_account_id_type='${fromTradeAccountType}';
        ${fromTradeAccountNumber}    Search Dic KV    ${field}    trade_account_id_number
        ${data1}    Create Dictionary    fromAmount=100    fromCurrency=USD    fromTradeAccountNumber=${fromTradeAccountNumber}    submitSource=CP_H5    toTradeAccountNumber=2020040101    toTradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    fromTradeAccountType=${fromTradeAccountType}
        ${res}    提交-内部转账单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

转出交易账号类型(黄金)-不支持内部转账
    执行sql语句    delete from transfer where eddid_id=${eddid_id};
    ${data}    Create Dictionary    submitSource=CP_H5    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040104    fromTradeAccountType=BULLION_MARGIN    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
    ${res}    提交-内部转账单    ${data}
    字典关键字校验    ${res}    msg    现货黄金不支持内部转帐

转出交易账号类型-入参为错误
    ${fromTradeAccountType_list}    Create List    \    UNKNOWN
    ${list_length}    Evaluate    len(${fromTradeAccountType_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from transfer where eddid_id='${eddid_id}';
        ${fromTradeAccountType}    Get List Index Value    ${fromTradeAccountType_list}    ${i}
        ${field}    查询数据库    select trade_account_id_number from trade_account where eddid_id='${eddid_id}' and trade_account_id_type='${fromTradeAccountType}';
        ${fromTradeAccountNumber}    Search Dic KV    ${field}    trade_account_id_number
        ${data1}    Create Dictionary    fromAmount=100    fromCurrency=USD    fromTradeAccountNumber=${fromTradeAccountNumber}    submitSource=CP_H5    toTradeAccountNumber=2020040101    toTradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    fromTradeAccountType=${fromTradeAccountType}
        ${res}    提交-内部转账单    ${data}
        字典关键字校验    ${res}    msg    &{errMsg}[null]
    END

转入交易账号类型(不包括黄金)-入参为正确
    ${toTradeAccountType_list}    Create List    SECURITIES_MARGIN    SECURITIES_AYERS_CASH    FUTURES_MARGIN    FUTURES_DAYTRADING_MARGIN    MF    MT5
    ${list_length}    Evaluate    len(${toTradeAccountType_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from transfer where eddid_id='${eddid_id}';
        ${toTradeAccountType}    Get List Index Value    ${toTradeAccountType_list}    ${i}
        ${field}    查询数据库    select trade_account_id_number from trade_account where eddid_id='${eddid_id}' and trade_account_id_type='${toTradeAccountType}';
        ${toTradeAccountNumber}    Search Dic KV    ${field}    trade_account_id_number
        ${data1}    Create Dictionary    fromAmount=100    fromCurrency=USD    toTradeAccountNumber=${toTradeAccountNumber}    submitSource=CP_H5    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    toTradeAccountType=${toTradeAccountType}
        log    ${data}
        ${res}    提交-内部转账单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

转入交易账号类型(黄金)-不支持内部转账
    执行sql语句    delete from transfer where eddid_id=${eddid_id};
    ${data}    Create Dictionary    submitSource=CP_H5    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040103    fromTradeAccountType=FUTURES_MARGIN    toTradeAccountNumber=2020040104    toTradeAccountType=BULLION_MARGIN
    ${res}    提交-内部转账单    ${data}
    字典关键字校验    ${res}    msg    现货黄金不支持内部转帐

转入交易账号类型-入参为错误
    ${toTradeAccountType_list}    Create List    \    UNKNOWN
    ${list_length}    Evaluate    len(${toTradeAccountType_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from transfer where eddid_id='${eddid_id}';
        ${toTradeAccountType}    Get List Index Value    ${toTradeAccountType_list}    ${i}
        ${field}    查询数据库    select trade_account_id_number from trade_account where eddid_id='${eddid_id}' and trade_account_id_type='${toTradeAccountType}';
        ${toTradeAccountNumber}    Search Dic KV    ${field}    trade_account_id_number
        ${data1}    Create Dictionary    fromAmount=100    fromCurrency=USD    toTradeAccountNumber=${toTradeAccountNumber}    submitSource=CP_H5    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    toTradeAccountType=${toTradeAccountType}
        log    ${data}
        ${res}    提交-内部转账单    ${data}
        字典关键字校验    ${res}    msg    &{errMsg}[null]
    END

转出转入交易账号类型相同
    ${header}    Set Variable    Content-Type=application/json
    ${data}    Create Dictionary    submitSource=CP_H5    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040101    toTradeAccountType=SECURITIES_CASH
    ${res}    提交-内部转账单    ${data}
    字典关键字校验    ${res}    msg    扣款收款帐户不能相同

转出交易账号为MT5-货币为HKD-转出失败
    ${fromCurrency_list}    Create List    HKD    CNY
    ${list_length}    Evaluate    len(${fromCurrency_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from transfer where eddid_id='${eddid_id}';
        ${fromCurrency}    Get List Index Value    ${fromCurrency_list}    ${i}
        ${data1}    Create Dictionary    fromAmount=100    submitSource=CP_H5    fromTradeAccountNumber=2020040105    fromTradeAccountType=MT5    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
        ${data}    Set To Dictionary    ${data1}    fromCurrency=${fromCurrency}
        ${res}    提交-内部转账单    ${data}
        字典关键字校验    ${res}    msg    外汇仅支持USD转出
    END

转出货币-入参为正确
    ${fromCurrency_list}    Create List    HKD    USD    CNY
    ${list_length}    Evaluate    len(${fromCurrency_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from transfer where eddid_id='${eddid_id}';
        ${fromCurrency}    Get List Index Value    ${fromCurrency_list}    ${i}
        ${data1}    Create Dictionary    fromAmount=100    submitSource=CP_H5    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
        ${data}    Set To Dictionary    ${data1}    fromCurrency=${fromCurrency}
        ${res}    提交-内部转账单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

转出货币-入参为错误
    ${fromCurrency_list}    Create List    \    UNKNOWN
    ${list_length}    Evaluate    len(${fromCurrency_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from transfer where eddid_id='${eddid_id}';
        ${fromCurrency}    Get List Index Value    ${fromCurrency_list}    ${i}
        ${data1}    Create Dictionary    fromAmount=100    submitSource=CP_H5    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
        ${data}    Set To Dictionary    ${data1}    fromCurrency=${fromCurrency}
        ${res}    提交-内部转账单    ${data}
        字典关键字校验    ${res}    msg    &{errMsg}[null]
    END

转出金额为负数
    执行sql语句    delete from transfer where eddid_id=${eddid_id};
    ${data}    Create Dictionary    submitSource=CP_H5    fromAmount=-100    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
    ${res}    提交-内部转账单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

转出金额等于0
    执行sql语句    delete from transfer where eddid_id=${eddid_id};
    ${data}    Create Dictionary    submitSource=CP_H5    fromAmount=0    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
    ${res}    提交-内部转账单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

转出金额为大于可转账额度

存在申请中的内部转账单再次提交
    执行sql语句    delete from transfer where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    submitSource=CP_H5    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
    ${res}    提交-内部转账单    ${data}
    ${res}    提交-内部转账单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[business_repeat]

存在已完成的内部转账单再次提交
    执行sql语句    delete from transfer where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    submitSource=CP_H5    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
    ${res}    提交-内部转账单    ${data}
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    审核内部转账为完成
    执行sql语句    update transfer set status='COMPLETED' where eddid_id='${eddid_id}';
    ${res}    提交-内部转账单    ${data}
    字典关键字校验    ${res}    msg    OK
