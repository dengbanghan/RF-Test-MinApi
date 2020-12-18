*** Settings ***
Resource          ../资金账户接口.robot

*** Test Cases ***
提交产品单-提交来源-入参为正确
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM    CDMS    UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    DELETE FROM account_center_db.structured_product_application WHERE eddid_id='${eddid_id}';
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${data}    Create Dictionary    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data}    submitSource=${submitSource}
        ${res}    提交-结构性产品单    ${data}
        字典关键字校验    ${res}    msg    OK
        ${order_id}    Search Dic KV    ${res}    orderId
        数据库字段校验    select order_id from account_center_db.structured_product_application t where t.eddid_id='${eddid_id}'    ${order_id}|    orderId
    END

提交产品单-提交来源-入参为错误
    ${submitSource_list}    Create List    \    UNKNOWN
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${data}    Create Dictionary    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data}    submitSource=${submitSource}
        ${res}    提交-结构性产品单    ${data}
        字典关键字校验    ${res}    msg    &{err_msg}[null]
    END

提交产品单-期货交易账号
    执行sql语句    DELETE FROM account_center_db.structured_product_application WHERE eddid_id='${eddid_id}'
    ${data}    Create Dictionary    submitSource=CP_H5    tradeAccountNumber=2020043002    tradeAccountType=FUTURES_MARGIN
    ${res}    提交-结构性产品单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from account_center_db.structured_product_application t where t.eddid_id='${eddid_id}'    ${order_id}|    orderId

提交产品单-Token的key为空
    ${header}    create dictionary    Content-Type=application/json
    ${data}    Create Dictionary    submitSource=UNKNOWN_SOURCE    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH
    ${res}    提交-结构性产品单    ${data}    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]
    数据库字段校验    select order_id from account_center_db.structured_product_application t where t.eddid_id='${eddid_id}'    None|    orderId

提交产品单-Token的value为空
    ${header}    create dictionary    Content-Type=application/json    Authorization=
    ${data}    Create Dictionary    submitSource=UNKNOWN_SOURCE    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH
    ${res}    提交-结构性产品单    ${data}    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]
    数据库字段校验    select order_id from account_center_db.structured_product_application t where t.eddid_id='${eddid_id}'    None|    orderId

提交产品单-重复提交
    执行sql语句    DELETE FROM account_center_db.structured_product_application WHERE eddid_id='${eddid_id}'
    ${data}    Create Dictionary    submitSource=CP_H5    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH
    ${res}    提交-结构性产品单    ${data}
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from account_center_db.structured_product_application t where t.eddid_id='${eddid_id}'    ${order_id}|    orderId
    ${res}    提交-结构性产品单    ${data}
    字典关键字校验    ${res}    msg    &{err_msg}[business_repeat]
    数据库字段校验    select order_id from account_center_db.structured_product_application t where t.eddid_id='${eddid_id}'    ${order_id}|    orderId

提交产品单-错误的交易账号
    ${data}    Create Dictionary    submitSource=CP_H5    tradeAccountNumber=202004300123    tradeAccountType=SECURITIES_CASH
    ${res}    提交-结构性产品单    ${data}
    字典关键字校验    ${res}    msg    &{err_msg}[trade_num_err]

提交产品单-交易账号与类型不一致
    ${data}    Create Dictionary    submitSource=CP_H5    tradeAccountNumber=2020043001    tradeAccountType=FUTURES_MARGIN
    ${res}    提交-结构性产品单    ${data}
    字典关键字校验    ${res}    msg    &{err_msg}[trade_num_err]

提交产品单-交易账号的key为空
    ${data}    Create Dictionary    submitSource=CP_H5    tradeAccountType=SECURITIES_CASH
    ${res}    提交-结构性产品单    ${data}
    字典关键字校验    ${res}    msg    &{err_msg}[null]

提交产品单-交易账号的value为空
    ${data}    Create Dictionary    submitSource=CP_H5    tradeAccountNumber=    tradeAccountType=SECURITIES_CASH
    ${res}    提交-结构性产品单    ${data}
    字典关键字校验    ${res}    msg    &{err_msg}[null]

提交产品单-错误的交易账号类型
    ${data}    Create Dictionary    submitSource=CP_H5    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITI
    ${res}    提交-结构性产品单    ${data}
    字典关键字校验    ${res}    msg    &{err_msg}[null]

提交产品单-交易账号类型的key为空
    ${data}    Create Dictionary    submitSource=CP_H5    tradeAccountNumber=&{trade}[securitiesNum]
    ${res}    提交-结构性产品单    ${data}
    字典关键字校验    ${res}    msg    &{err_msg}[null]

提交产品单-交易账号类型的value为空
    ${data}    Create Dictionary    submitSource=CP_H5    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=
    ${res}    提交-结构性产品单    ${data}
    字典关键字校验    ${res}    msg    &{err_msg}[null]

开通状态-状态为SUBMITTED
    ${data}    Create Dictionary    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH    submitSource=CP_H5
    执行sql语句    DELETE FROM account_center_db.structured_product_application WHERE eddid_id='${eddid_id}'
    ${res_submit}    提交-结构性产品单    ${data}
    ${order_id}    Search Dic KV    ${res_submit}    orderId
    ${res_select}    结构性产品单-开通状态
    字典关键字校验    ${res_select}    isOpenStructuredProduct    submitted
    数据库字段校验    select order_id,`status` from account_center_db.structured_product_application t where t.eddid_id='${eddid_id}'    ${order_id}|SUBMITTED|    Status

开通状态-状态为NONACTIVATED
    执行sql语句    DELETE FROM account_center_db.structured_product_application WHERE eddid_id='${eddid_id}'
    ${res}    结构性产品单-开通状态
    字典关键字校验    ${res}    isOpenStructuredProduct    nonactivated
    数据库字段校验    select `status` from account_center_db.structured_product_application t where t.eddid_id='${eddid_id}'    None|    Status

开通状态-状态为OPENED
    ${data}    Create Dictionary    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH    submitSource=CP_H5
    执行sql语句    DELETE FROM account_center_db.structured_product_application WHERE eddid_id='${eddid_id}'
    ${res_submit}    提交-结构性产品单    ${data}
    ${order_id}    Search Dic KV    ${res_submit}    orderId
    执行sql语句    UPDATE account_center_db.structured_product_application SET `status`='OPENED';
    ${res_select}    结构性产品单-开通状态
    字典关键字校验    ${res_select}    isOpenStructuredProduct    opened
    数据库字段校验    select order_id,`status` from account_center_db.structured_product_application t where t.eddid_id='${eddid_id}'    ${order_id}|OPENED|    Status

开通状态-状态为FAILURE
    ${data}    Create Dictionary    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH    submitSource=CP_H5
    执行sql语句    DELETE FROM account_center_db.structured_product_application WHERE eddid_id='${eddid_id}'
    ${res_submit}    提交-结构性产品单    ${data}
    ${order_id}    Search Dic KV    ${res_submit}    orderId
    执行sql语句    UPDATE account_center_db.structured_product_application SET `status`='FAILURE';
    ${res_select}    结构性产品单-开通状态
    字典关键字校验    ${res_select}    isOpenStructuredProduct    failure
    数据库字段校验    select order_id,`status` from account_center_db.structured_product_application t where t.eddid_id='${eddid_id}'    ${order_id}|FAILURE|    Status

开通状态-Token的key为空
    ${header}    create dictionary    Content-Type=application/json
    ${res}    结构性产品单-开通状态    header=${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

开通状态-Token的value为空
    ${header}    create dictionary    Content-Type=application/json    Authorization=
    ${res}    结构性产品单-开通状态    header=${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]
