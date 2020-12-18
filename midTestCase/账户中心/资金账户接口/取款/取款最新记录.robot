*** Settings ***
Resource          ../../资金账户接口.robot

*** Test Cases ***
取款最新记录
    ${res}    取款最新记录

Token的key为空
    ${header}    create dictionary    Content-Type=application/json
    ${res}    取款最新记录    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

Token的value为空
    ${header}    create dictionary    Content-Type=application/json    Authorization=
    ${res}    取款最新记录    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

未存在取款最新记录
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${res}    取款最新记录
    字典关键字校验    ${res}    msg    OK

存在任一一个交易账号取款最新记录
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH
    log    ${data}
    ${res}    提交-取款单    ${data}
    ${res}    取款最新记录
    字典关键字校验    ${res}    msg    OK

存在香港银行账户取款最新记录
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=LOCAL    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH
    log    ${data}
    ${res}    提交-取款单    ${data}
    ${res}    取款最新记录
    字典关键字校验    ${res}    msg    OK

存在非香港银行账户取款最新记录
    执行sql语句    delete from withdrawal_images where order_id =(SELECT order_id from withdrawal where eddid_id='${eddid_id}');
    执行sql语句    delete from withdrawal where eddid_id='${eddid_id}';
    ${data}    Create Dictionary    bankAccount=2020072701    bankName=招商银行    bankType=SETTLEMENT_ACCOUNT    tradeAccountNumber=2020040101    withdrawalAmount=1200    withdrawalCurrency=HKD    withdrawalType=OVERSEA    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH    bankSwiftCode=BKCHHKHHXXX    enName=linda
    log    ${data}
    ${res}    提交-取款单    ${data}
    ${res}    取款最新记录
    字典关键字校验    ${res}    msg    OK
