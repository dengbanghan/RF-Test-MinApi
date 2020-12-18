*** Settings ***
Resource          ../../资金账户接口.robot

*** Test Cases ***
Token的key为空
    ${header}    create dictionary    Content-Type=application/json
    ${res}    存款最新记录    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

Token的value为空
    ${header}    create dictionary    Content-Type=application/json    Authorization=
    ${res}    存款最新记录    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

未存在存款最新记录
    执行sql语句    delete from deposit where eddid_id='${eddid_id}';
    ${res}    存款最新记录
    字典关键字校验    ${res}    msg    OK

存在多条存款最新记录
    执行sql语句    delete from deposit where eddid_id='${eddid_id}';
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
    ${res}    存款最新记录
    字典关键字校验    ${res}    msg    OK
