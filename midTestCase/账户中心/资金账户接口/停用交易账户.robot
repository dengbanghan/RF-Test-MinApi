*** Settings ***
Resource          ../资金账户接口.robot

*** Test Cases ***
提交停用申请-提交来源-CP_H5
    Comment    执行sql语句    DELETE FROM account_center_db.structured_product_application WHERE eddid_id='${eddid_id}'
    ${data}    Create Dictionary    tradeAccountNumber=&{tradeNum}[futMargin]    action=STOP    agree=true    submitSource=CP_H5
    ${res}    提交-停用或关闭交易账户    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from account_center_db.structured_product_application where eddid_id='${eddid_id}'    ${order_id}|    orderId

提交停用申请-提交来源-非CP_H5
    ${submitSource_list}    Create List    CP_WEB    CRM    CDMS    UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        Comment    执行sql语句    DELETE FROM account_center_db.structured_product_application WHERE eddid_id='${eddid_id}'
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${data}    Create Dictionary    tradeAccountNumber=&{tradeNum}[futMargin]    action=STOP    agree=true
        ${data}    Set To Dictionary    ${data}    submitSource=${submitSource}
        ${res}    提交-停用或关闭交易账户    ${data}
        字典关键字校验    ${res}    msg    仅支持H5操作
    END

提交停用申请-提交来源-入参为错误
    ${submitSource_list}    Create List    \    UNKNOWN
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        Comment    执行sql语句    DELETE FROM account_center_db.structured_product_application WHERE eddid_id='${eddid_id}'
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${data}    Create Dictionary    tradeAccountNumber=&{trade}[futuresNum]    action=STOP    agree=true
        ${data}    Set To Dictionary    ${data}    submitSource=${submitSource}
        ${res}    提交-停用或关闭交易账户    ${data}
        字典关键字校验    ${res}    msg    &{err_msg}[null]
    END

申请记录-校验交易账号
    ${res}    停用或关闭交易账户-申请记录
    ${data_list}    Search Dic KV    ${res}    data
    ${data}    getListIndexValue    ${data_list}    0
    字典关键字校验    ${data}    accountNumber    &{trade}[futuresNum]
    数据库字段校验    select `trade_account_id_number` from account_center_db.trade_account_stop_application where eddid_id='${eddid_id}'    &{trade}[futuresNum]|    accountNumber

申请记录-校验交易账号类型
    ${res}    停用或关闭交易账户-申请记录
    ${data_list}    Search Dic KV    ${res}    data
    ${data}    getListIndexValue    ${data_list}    0
    字典关键字校验    ${data}    accountType    FUTURES_MARGIN
    数据库字段校验    select `trade_account_id_type` from account_center_db.trade_account_stop_application where eddid_id='${eddid_id}'    FUTURES_MARGIN|    accountType

申请记录-校验订单编号
    ${data}    Create Dictionary    tradeAccountNumber=&{trade}[futuresNum]    action=STOP    agree=true    submitSource=CP_H5
    ${res_stop}    提交-停用或关闭交易账户    ${data}
    ${orderId}    Search Dic KV    ${res_stop}    orderId
    ${res}    停用或关闭交易账户-申请记录
    ${data_list}    Search Dic KV    ${res}    data
    ${data}    getListIndexValue    ${data_list}    0
    字典关键字校验    ${data}    orderId    ${orderId}
    数据库字段校验    select `order_id` from account_center_db.trade_account_stop_application where eddid_id='${eddid_id}'    ${orderId}|    orderId

申请记录-状态-SUBMITTED
    执行sql语句    update account_center_db.trade_account_stop_application set `status`='SUBMITTED' where eddid_id='${eddid_id}'
    ${res}    停用或关闭交易账户-申请记录
    ${data_list}    Search Dic KV    ${res}    data
    ${data}    getListIndexValue    ${data_list}    0
    字典关键字校验    ${data}    status    SUBMITTED
    数据库字段校验    select `status` from account_center_db.trade_account_stop_application where eddid_id='${eddid_id}'    SUBMITTED|    Status

申请记录-状态-CHECKING
    执行sql语句    update account_center_db.trade_account_stop_application set `status`='CHECKING' where eddid_id='${eddid_id}'
    ${res}    停用或关闭交易账户-申请记录
    ${data_list}    Search Dic KV    ${res}    data
    ${data}    getListIndexValue    ${data_list}    0
    字典关键字校验    ${data}    status    CHECKING
    数据库字段校验    select `status` from account_center_db.trade_account_stop_application where eddid_id='${eddid_id}'    CHECKING|    Status

申请记录-状态-PASS
    执行sql语句    update account_center_db.trade_account_stop_application set `status`='PASS' where eddid_id='${eddid_id}'
    ${res}    停用或关闭交易账户-申请记录
    ${data_list}    Search Dic KV    ${res}    data
    ${data}    getListIndexValue    ${data_list}    0
    字典关键字校验    ${data}    status    PASS
    数据库字段校验    select `status` from account_center_db.trade_account_stop_application where eddid_id='${eddid_id}'    PASS|    Status

申请记录-状态-SUCCESS
    执行sql语句    update account_center_db.trade_account_stop_application set `status`='SUCCESS' where eddid_id='${eddid_id}'
    ${res}    停用或关闭交易账户-申请记录
    ${data_list}    Search Dic KV    ${res}    data
    ${data}    getListIndexValue    ${data_list}    0
    字典关键字校验    ${data}    status    SUCCESS
    数据库字段校验    select `status` from account_center_db.trade_account_stop_application where eddid_id='${eddid_id}'    SUCCESS|    Status

申请记录-状态-REJECT
    执行sql语句    update account_center_db.trade_account_stop_application set `status`='REJECT' where eddid_id='${eddid_id}'
    ${res}    停用或关闭交易账户-申请记录
    ${data_list}    Search Dic KV    ${res}    data
    ${data}    getListIndexValue    ${data_list}    0
    字典关键字校验    ${data}    status    REJECT
    数据库字段校验    select `status` from account_center_db.trade_account_stop_application where eddid_id='${eddid_id}'    REJECT|    Status
