*** Settings ***
Resource          ../../资金账户接口.robot

*** Test Cases ***
Token的key为空
    ${header}    create dictionary    Content-Type=application/json
    ${data}    Create Dictionary    submitSource=CP_H5    bankAccount=2020072201    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL
    ${res}    提交-取款单    ${data}    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

Token的value为空
    ${header}    create dictionary    Content-Type=application/json    Authorization=
    ${data}    Create Dictionary    submitSource=CP_H5    bankAccount=2020072201    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL
    ${res}    提交-取款单    ${data}    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

提交来源-入参为正确
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM    UNKNOWN_SOURCE    CDMS
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
        执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${data1}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-取款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交来源-入参为错误
    ${submitSource_list}    Create List    \    UNKNOWN
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
        执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${data1}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-取款单    ${data}
        字典关键字校验    ${res}    msg    &{errMsg}[null]
    END

交易账号类型(非境外)-入参为正确
    ${tradeAccountType_list}    Create List    SECURITIES_CASH    SECURITIES_MARGIN    SECURITIES_AYERS_CASH    FUTURES_MARGIN    FUTURES_DAYTRADING_MARGIN    MT5    MF    BULLION_MARGIN
    ${list_length}    Evaluate    len(${tradeAccountType_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${tradeAccountType}    getListIndexValue    ${tradeAccountType_list}    ${i}
        ${field}    查询数据库    select trade_account_id_number from trade_account where eddid_id='${eddid_id}' and trade_account_id_type='${tradeAccountType}';
        ${tradeAccountNumber}    Search Dic KV    ${field}    trade_account_id_number
        执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
        执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
        ${data1}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=${tradeAccountNumber}    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL    submitSource=CP_H5
        ${data}    Set To Dictionary    ${data1}    tradeAccountType=${tradeAccountType}
        log    ${data}
        ${res}    提交-取款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

交易账号类型(境外)-入参为正确
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=OVERSEA    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH    bankSwiftCode=BKCHHKHHXXX    enName=linda
    log    ${data}
    ${res}    提交-取款单    ${data}
    字典关键字校验    ${res}    msg    OK

取款银行类型(非境外)-OTHER-已存在银行
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=OTHER    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH
    log    ${data}
    ${res}    提交-取款单    ${data}
    字典关键字校验    ${res}    msg    OK

取款银行类型(非境外)-OTHER-不存在银行
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=202007270111    bankName=招商银行    bankType=OTHER    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH
    log    ${data}
    ${res}    提交-取款单    ${data}
    字典关键字校验    ${res}    msg    OK

取款银行类型(境外)-SETTLEMENT_ACCOUNT-已存在银行
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH
    log    ${data}
    ${res}    提交-取款单    ${data}
    字典关键字校验    ${res}    msg    OK

取款银行类型(非境外)-SETTLEMENT_ACCOUNT-不存在银行
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=202007270111    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH
    log    ${data}
    ${res}    提交-取款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[bank_null]

取款单类型-境外-入参为正确
    ${tradeAccountType_list}    Create List    SECURITIES_CASH    SECURITIES_MARGIN    SECURITIES_AYERS_CASH    FUTURES_MARGIN    FUTURES_DAYTRADING_MARGIN    MT5    MF    BULLION_MARGIN    INTERACTIVE_BROKER_INTEGRATED_MARGIN
    ${list_length}    Evaluate    len(${tradeAccountType_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${tradeAccountType}    getListIndexValue    ${tradeAccountType_list}    ${i}
        ${field}    查询数据库    select trade_account_id_number from trade_account where eddid_id='${eddid_id}' and trade_account_id_type='${tradeAccountType}';
        ${tradeAccountNumber}    Search Dic KV    ${field}    trade_account_id_number
        执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
        执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
        ${data1}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=${tradeAccountNumber}    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL    submitSource=CP_H5    bankSwiftCode=BKCHHKHHXXX    enName=linda
        ${data}    Set To Dictionary    ${data1}    tradeAccountType=${tradeAccountType}
        log    ${data}
        ${res}    提交-取款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

货币类型(非境外)-入参为正确
    ${withdrawalCurrency_list}    Create List    HKD
    ${list_length}    Evaluate    ${withdrawalCurrency_list}
    FOR    ${i}    IN RANGE    ${list_length}
        ${withdrawalCurrency}    Set Variable    ${withdrawalCurrency_list}[${i}]
        执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
        执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
        ${data1}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    withdrawalAmount=1200    tradeAccountType=SECURITIES_CASH    withdrawalType=LOCAL    submitSource=CP_H5
        ${data}    Set To Dictionary    ${data1}    withdrawalCurrency=${withdrawalCurrency}
        log    ${data}
        ${res}    提交-取款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

取款单类型-境外-银行账户swift code未填
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency='HKD'    withdrawalType=OVERSEA    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH    enName=linda
    log    ${data}
    ${res}    提交-取款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

取款单类型-境外-英文名未填
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=OVERSEA    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH    bankSwiftCode=BKCHHKHHXXX
    log    ${data}
    ${res}    提交-取款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

取款单类型-境内-swift code和英文名未填
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH
    log    ${data}
    ${res}    提交-取款单    ${data}
    字典关键字校验    ${res}    msg    OK

同一个交易账号存在未完成的取款申请，再次提交
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH
    log    ${data}
    ${res}    提交-取款单    ${data}
    字典关键字校验    ${res}    msg    OK

同一个交易账号存在已完成的取款申请，再次提交
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH
    log    ${data}
    ${res}    提交-取款单    ${data}
    字典关键字校验    ${res}    msg    OK

已存在未完成的证券交易账号取款申请，再次提交期货
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH
    log    ${data}
    ${res}    提交-取款单    ${data}
    字典关键字校验    ${res}    msg    OK
