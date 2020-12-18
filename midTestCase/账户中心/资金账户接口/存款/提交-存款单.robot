*** Settings ***
Resource          ../../资金账户接口.robot

*** Test Cases ***
提交-存款单-提交来源-入参为正确
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM    UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${depositImages}    Create List    1
        ${data1}    Create Dictionary    depositImages=${depositImages}    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-存款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交-存款单-提交来源-入参为错误
    ${submitSource_list}    Create List    \    UNKNOWN
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${depositImages}    Create List    1
        ${data1}    Create Dictionary    depositImages=${depositImages}    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-存款单    ${data}
        字典关键字校验    ${res}    msg    &{errMsg}[null]
    END

提交-存款单-提交来源-value为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    submitSource=
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-存款单-提交来源-key为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-存款单-交易账号类型-证券入参为正确
    ${tradeAccountType_list}    Create List    SECURITIES_CASH    SECURITIES_MARGIN    SECURITIES_AYERS_CASH
    ${list_length}    Evaluate    len(${tradeAccountType_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${tradeAccountType}    getListIndexValue    ${tradeAccountType_list}    ${i}
        ${field}    查询数据库    select trade_account_id_number from trade_account where eddid_id='${eddid_id}' and trade_account_id_type='${tradeAccountType}';
        ${tradeAccountNumber}    Search Dic KV    ${field}    trade_account_id_number
        ${depositImages}    Create List    1
        ${data1}    Create Dictionary    depositImages=${depositImages}    beneficiaryAccount=016-478-783313006    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    submitSource=CP_H5
        ${data}    Set To Dictionary    ${data1}    tradeAccountType=${tradeAccountType}    tradeAccountNumber=${tradeAccountNumber}
        log    ${data}
        ${res}    提交-存款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交-存款单-交易账号类型-期货入参为正确
    ${tradeAccountType_list}    Create List    FUTURES_MARGIN    FUTURES_DAYTRADING_MARGIN
    ${list_length}    Evaluate    len(${tradeAccountType_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${tradeAccountType}    getListIndexValue    ${tradeAccountType_list}    ${i}
        ${field}    查询数据库    select trade_account_id_number from trade_account where eddid_id='${eddid_id}' and trade_account_id_type='${tradeAccountType}';
        ${tradeAccountNumber}    Search Dic KV    ${field}    trade_account_id_number
        ${depositImages}    Create List    1
        ${data1}    Create Dictionary    tradeAccountNumber=2020040101    beneficiaryAccount=016-478-000324487    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    submitSource=CP_H5
        ${data}    Set To Dictionary    ${data1}    tradeAccountType=${tradeAccountType}    tradeAccountNumber=${tradeAccountNumber}
        log    ${data}
        ${res}    提交-存款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交-存款单-交易账号类型-外汇黄金入参为正确
    ${tradeAccountType_list}    Create List    MT5    MF    BULLION_MARGIN
    ${list_length}    Evaluate    len(${tradeAccountType_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${tradeAccountType}    getListIndexValue    ${tradeAccountType_list}    ${i}
        ${field}    查询数据库    select trade_account_id_number from trade_account where eddid_id='${eddid_id}' and trade_account_id_type='${tradeAccountType}';
        ${tradeAccountNumber}    Search Dic KV    ${field}    trade_account_id_number
        ${depositImages}    Create List    1
        ${data1}    Create Dictionary    tradeAccountNumber=2020040101    beneficiaryAccount=072-722-502-013475    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    submitSource=CP_H5
        ${data}    Set To Dictionary    ${data1}    tradeAccountType=${tradeAccountType}    tradeAccountNumber=${tradeAccountNumber}
        log    ${data}
        ${res}    提交-存款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交-存款单-交易账号类型-IB入参为正确
    ${tradeAccountType_list}    Create List    INTERACTIVE_BROKER_INTEGRATED_MARGIN
    ${list_length}    Evaluate    len(${tradeAccountType_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${tradeAccountType}    getListIndexValue    ${tradeAccountType_list}    ${i}
        ${field}    查询数据库    select trade_account_id_number from trade_account where eddid_id='${eddid_id}' and trade_account_id_type='${tradeAccountType}';
        ${tradeAccountNumber}    Search Dic KV    ${field}    trade_account_id_number
        ${depositImages}    Create List    1
        ${data1}    Create Dictionary    tradeAccountNumber=2020040101    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    submitSource=CP_H5
        ${data}    Set To Dictionary    ${data1}    tradeAccountType=${tradeAccountType}    tradeAccountNumber=${tradeAccountNumber}
        log    ${data}
        ${res}    提交-存款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交-存款单-交易账号类型-入参为错误
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositType=ATM_TRANSFER_DEPOSIT    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    submitSource=CP_H5    tradeAccountNumber=2020040101    tradeAccountType=12
    log    ${data}
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-存款单-交易账号类型-value为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositType=ATM_TRANSFER_DEPOSIT    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    submitSource=CP_H5    tradeAccountNumber=2020040101    tradeAccountType=
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-存款单-交易账号类型-key为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositType=ATM_TRANSFER_DEPOSIT    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    submitSource=CP_H5    tradeAccountNumber=2020040101
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-存款单-交易账号号码-不存在的
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositType=ATM_TRANSFER_DEPOSIT    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    submitSource=CP_H5    tradeAccountNumber=2020040100    tradeAccountType=SECURITIES_CASH
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[trade_num_err]

提交-存款单-交易账号号码-value为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositType=ATM_TRANSFER_DEPOSIT    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    submitSource=CP_H5    tradeAccountNumber=    tradeAccountType=SECURITIES_CASH
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-存款单-交易账号号码-key为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositType=ATM_TRANSFER_DEPOSIT    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-存款单-汇入货币-入参为正确
    ${remittanceCurrency_list}    Create List    HKD    USD    CNY
    ${list_length}    Evaluate    len(${remittanceCurrency_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${remittanceCurrency}    Get List Index Value    ${remittanceCurrency_list}    ${i}
        ${field}    查询数据库    select bank_account_number from eddid_bank_account where bank_type='SECURITIES' and key_name='DBS' and currency='${remittanceCurrency}';
        ${beneficiaryAccount}    Search Dic KV    ${field}    bank_account_number
        ${depositImages}    Create List    1
        ${data1}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    remittanceCurrency=${remittanceCurrency}    beneficiaryAccount=${beneficiaryAccount}
        ${res}    提交-存款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交-存款单-汇入货币-入参为错误
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=aa    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-存款单-汇入货币-value为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-存款单-汇入货币-key为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[un_error]

提交-存款单-汇款银行类型-OTHER-已存在银行
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=OTHER    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    OK

提交-存款单-汇款银行类型-OTHER-不存在银行
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=20200727022    remittanceBankName=招商银行    remittanceBankType=OTHER    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    OK

提交-存款单-汇款银行类型-SETTLEMENT_ACCOUNT-已存在银行
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    OK

提交-存款单-汇款银行类型-SETTLEMENT_ACCOUNT-不存在银行
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=20200727022    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[bank_not]

提交-存款单-汇款银行类型-value为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-存款单-汇款银行类型-key为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-存款单-汇款银行名称-value为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    log    ${data}
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-存款单-汇款银行名称-key为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    log    ${data}
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-存款单-汇款银行账户-value为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[bank_null]

提交-存款单-汇款银行账户-key为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[bank_null]

提交-存款单-汇入金额-value为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[un_error]

提交-存款单-汇入金额-key为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[un_error]

提交-存款单-存款类型-入参为正确
    ${depositType_list}    Create List    ONLINE_BANK_DEPOSIT    ATM_TRANSFER_DEPOSIT    BANK_TRANSFER_DEPOSIT    CHEQUE_DEPOSIT    ALIPAY_DEPOSIT    FPS_DEPOSIT
    ${list_length}    Evaluate    len(${depositType_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${depositType}    Set Variable    ${depositType_list}[${i}]
        ${depositImages}    Create List    1
        ${data1}    Create Dictionary    depositImages=${depositImages}    beneficiaryAccount=016-478-783313006    submitSource=CP_H5    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    depositType=${depositType}
        ${res}    提交-存款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交-存款单-存款类型-入参为错误
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM    UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${depositImages}    Create List    1
        ${data1}    Create Dictionary    depositImages=${depositImages}    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-存款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交-存款单-存款类型-value为空
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM    UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${depositImages}    Create List    1
        ${data1}    Create Dictionary    depositImages=${depositImages}    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-存款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交-存款单-存款类型-key为空
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM    UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${depositImages}    Create List    1
        ${data1}    Create Dictionary    depositImages=${depositImages}    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-存款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交-存款单-存款单照片-key为空
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM    UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${depositImages}    Create List    1
        ${data1}    Create Dictionary    depositImages=${depositImages}    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-存款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交-存款单-存款单照片-value为空
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM    UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${depositImages}    Create List    1
        ${data1}    Create Dictionary    depositImages=${depositImages}    beneficiaryAccount=016-478-783313006    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-存款单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交-存款单-收款银行账户-不存在
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    OK

提交-存款单-收款银行账户-value为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    OK

提交-存款单-收款银行账户-key为空
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    submitSource=CP_H5    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    remittanceCurrency=HKD    beneficiaryAccount=016-478-783313006
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    OK

提交-存款单-存款类型-SUB_ACCOUNT_DEPOSIT-不存在子账户
    ${depositImages}    Create List    1
    ${data}    Create Dictionary    depositImages=${depositImages}    beneficiaryAccount=016-478-783313006    submitSource=CP_H5    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    depositType=SUB_ACCOUNT_DEPOSIT
    ${res}    提交-存款单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[bank_null]

提交-存款单-存款类型-SUB_ACCOUNT_DEPOSIT-存在子账户
    Comment    删除该用户下的子账户及子账户
    执行sql语句    delete from bank_subaccount where eddid_id='${eddid_id}';
    Comment    提交-子账户申请
    ${submitSource}    Set Variable    CP_H5
    ${data}    Create Dictionary    submitSource=${submitSource}    advanceAmount=500    currency=HKD
    ${res}    提交-子账户申请单    ${data}
    Comment    查询申请的子账户的order_id
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    审核子账户申请为中国银行
    执行sql语句    update bank_subaccount set status='COMPLETED',sub_bank_account='12345',alias_address='ICBC Tower, 3 Garden Road, Central, Hong Kong',bank_key='ICBC',sub_bank_name='中国银行（香港）有限公司',payee_name='艾莉莎',sub_bank_swift_code='BKCHHKHHXXX' where eddid_id='${eddid_id}' and order_id='${order_id}';
    ${filed}    执行sql语句    select sub_bank_account from bank_subaccount where eddid_id=${eddid_id} and order_id=${order_id};
    ${beneficiaryAccount}    Search Dic KV    ${filed}    sub_bank_account
    ${data}    Create Dictionary    depositImages=${depositImages}    beneficiaryAccount=${beneficiaryAccount}    submitSource=CP_H5    remittanceAmount=1000    remittanceBankAccount=2020072701    remittanceBankName=招商银行    remittanceBankType=SETTLEMENT_ACCOUNT    remittanceCurrency=HKD    depositType=ATM_TRANSFER_DEPOSIT    tradeAccountNumber=2020040101    tradeAccountType=SECURITIES_CASH    depositType=SUB_ACCOUNT_DEPOSIT
    ${depositImages}    Create List    1
    ${res}    提交-存款单    ${data}
    Comment    字典关键字校验    ${res}    msg    &{errMsg}[bank_null]
