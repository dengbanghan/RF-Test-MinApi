*** Settings ***
Resource          ../../资金账户接口.robot

*** Test Cases ***
内部转账最新记录
    ${res}    内部转账最新记录
    字典关键字校验    ${res}    msg    OK

Token得key为空
    ${header}    Create Dictionary    Content-Type=application/json
    ${res}    内部转账最新记录    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

Token的value为空
    ${header}    Create Dictionary    Content-Type=application/json    Authorization=
    ${res}    内部转账最新记录    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

未存在内部转账最新记录
    执行sql语句    delete from transfer where eddid_id='${eddid_id}';
    ${res}    内部转账最新记录
    字典关键字校验    ${res}    msg    OK

存在多条内部转账最新记录
    执行sql语句    delete from transfer where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    submitSource=CP_H5    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
    ${res}    提交-内部转账单    ${data}
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    审核内部转账为完成
    执行sql语句    update transfer set status='COMPLETED' where eddid_id='${eddid_id}';
    ${res}    提交-内部转账单    ${data}
    ${res}    内部转账最新记录
    字典关键字校验    ${res}    msg    OK

存在内部转账最新记录为完成
    执行sql语句    delete from transfer where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    submitSource=CP_H5    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
    ${res}    提交-内部转账单    ${data}
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    审核内部转账为完成
    执行sql语句    update transfer set status='COMPLETED' where eddid_id='${eddid_id}';
    ${res}    内部转账最新记录
    字典关键字校验    ${res}    msg    OK

存在内部转账最新记录为处理中
    执行sql语句    delete from transfer where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    submitSource=CP_H5    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
    ${res}    提交-内部转账单    ${data}
    ${res}    内部转账最新记录
    字典关键字校验    ${res}    msg    OK

存在内部转账最新记录为失败
    执行sql语句    delete from transfer where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    submitSource=CP_H5    fromAmount=100    fromCurrency=HKD    fromTradeAccountNumber=2020040101    fromTradeAccountType=SECURITIES_CASH    toTradeAccountNumber=2020040103    toTradeAccountType=FUTURES_MARGIN
    ${res}    提交-内部转账单    ${data}
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    审核内部转账为完成
    执行sql语句    update transfer set status='FAILURE' where eddid_id='${eddid_id}';
    ${res}    内部转账最新记录
    字典关键字校验    ${res}    msg    OK
