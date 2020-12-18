*** Settings ***
Resource          ../用户信息接口.robot

*** Test Cases ***
帐号信息-提交来源-入参为正确
    ${submitSource_list}    Create List    submitSource=CP_H5    submitSource=CP_WEB    submitSource=CRM    submitSource=CDMS    submitSource=UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${submitSource}    IN RANGE    ${list_length}
        ${res}    个人中心-帐号信息    ${submitSource_list}[${submitSource}]
        字典关键字校验    ${res}    msg    OK
    END

帐号信息-提交来源-入参为错误
    ${submitSource_list}    Create List    \    submitSource=    submitSource=WEB
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${submitSource}    IN RANGE    ${list_length}
        ${res}    个人中心-帐号信息    ${submitSource_list}[${submitSource}]
        字典关键字校验    ${res}    msg    &{errMsg}[null]
    END

账号信息-Token的key为空
    ${header}    create dictionary    Content-Type=application/json
    ${res}    个人中心-帐号信息    header=${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

账号信息-Token的value为空
    ${header}    create dictionary    Content-Type=application/json    Authorization=
    ${res}    个人中心-帐号信息    header=${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

账号信息-Token无效
    ${header}    create dictionary    Content-Type=application/json    Authorization=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJ0ZXN0YXBwMiIsImV4cCI6MTU5NjE4NTI2MSwic3ViIjoiMGJhYWEyOGUtZGQxOC00NDg2LTg2ZDMtNTQ1MTkzMDdmMGFhIiwic2NvcGUiOiJiYXNpYyJ9.HKfFHBIxA-qG6DX_WYtYykKcINDnXGshUGICQ_s2OxIusjSc94DBnFdXXMYGqdMbF_j_88CUh6hvuZE96rYhbA0Pm6KWUHdhBb1xmsh7zDTVFqfEqCmsYPLH70TZG9ZGu73zJgZNWo6-44T8csuJx6nKBw3CwyhRvnwExUKj47w
    ${res}    个人中心-帐号信息    header=${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_err]

账号信息-交易账号-证券现金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeType}[secCash]    tradeAccountNumber    &{tradeNum}[secCash]
    数据库字段校验    select ${db}[tradeNum] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeType]='&{tradeType}[secCash]'    &{tradeNum}[secCash]|    证券现金交易账号

账号信息-交易账号-证券保证金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeType}[secMargin]    tradeAccountNumber    &{tradeNum}[secMargin]
    数据库字段校验    select ${db}[tradeNum] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeType]='&{tradeType}[secMargin]'    &{tradeNum}[secMargin]|    证券保证金交易账号

账号信息-交易账号-期货保证金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeType}[futMargin]    tradeAccountNumber    &{tradeNum}[futMargin]
    数据库字段校验    select ${db}[tradeNum] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeType]='&{tradeType}[futMargin]'    &{tradeNum}[futMargin]|    期货保证金交易账号

账号信息-交易账号-金条保证金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeType}[bullionMargin]    tradeAccountNumber    &{tradeNum}[bullionMargin]
    数据库字段校验    select ${db}[tradeNum] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeType]='&{tradeType}[bullionMargin]'    &{tradeNum}[bullionMargin]|    金条保证金交易账号

账号信息-交易账号-互动经纪综合保证金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeType}[interBrokerIntegr]    tradeAccountNumber    &{tradeNum}[interBrokerIntegr]
    数据库字段校验    select ${db}[tradeNum] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeType]='&{tradeType}[interBrokerIntegr]'    &{tradeNum}[interBrokerIntegr]|    互动经纪综合保证金交易账号

账号信息-交易账号-全权委托证券现金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeType}[secAyersCash]    tradeAccountNumber    &{tradeNum}[secAyersCash]
    数据库字段校验    select ${db}[tradeNum] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeType]='&{tradeType}[secAyersCash]'    &{tradeNum}[secAyersCash]|    全权委托证券现金交易账户

账号信息-交易账号-期货日内交易保证金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeType}[futDayTradeMargin]    tradeAccountNumber    &{tradeNum}[futDayTradeMargin]
    数据库字段校验    select ${db}[tradeNum] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeType]='&{tradeType}[futDayTradeMargin]'    &{tradeNum}[futDayTradeMargin]|    期货日内交易保证金交易账号

账号信息-交易账号-MT5外汇
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeType}[MT5]    tradeAccountNumber    &{tradeNum}[MT5]
    数据库字段校验    select ${db}[tradeNum] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeType]='&{tradeType}[MT5]'    &{tradeNum}[MT5]|    MT5外汇交易账号

账号信息-交易账号-MF外汇
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeType}[MF]    tradeAccountNumber    &{tradeNum}[MF]
    数据库字段校验    select ${db}[tradeNum] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeType]='&{tradeType}[MF]'    &{tradeNum}[MF]|    MF外汇交易账号

账号信息-交易账号类型-证券现金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[secCash]    tradeAccountType    &{tradeType}[secCash]
    数据库字段校验    select ${db}[tradeType] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secCash]'    &{tradeType}[secCash]|    证券现金交易账号类型

账号信息-交易账号类型-证券保证金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[secMargin]    tradeAccountType    &{tradeType}[secMargin]
    数据库字段校验    select ${db}[tradeType] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secMargin]'    &{tradeType}[secMargin]|    证券保证金交易账号类型

账号信息-交易账号类型-期货保证金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[futMargin]    tradeAccountType    &{tradeType}[futMargin]
    数据库字段校验    select ${db}[tradeType] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futMargin]'    &{tradeType}[futMargin]|    期货保证金交易账号类型

账号信息-交易账号类型-金条保证金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    log    ${res_data}
    从数组中校验值    ${res_data}    &{tradeNum}[bullionMargin]    tradeAccountType    &{tradeType}[bullionMargin]
    数据库字段校验    select ${db}[tradeType] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[bullionMargin]'    &{tradeType}[bullionMargin]|    金条保证金交易账号类型

账号信息-交易账号类型-互动经纪综合保证金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    log    ${res_data}
    从数组中校验值    ${res_data}    &{tradeNum}[interBrokerIntegr]    tradeAccountType    &{tradeType}[interBrokerIntegr]
    数据库字段校验    select ${db}[tradeType] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[interBrokerIntegr]'    &{tradeType}[interBrokerIntegr]|    互动经纪综合保证金交易账号类型

账号信息-交易账号类型-全权委托证券现金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    log    ${res_data}
    从数组中校验值    ${res_data}    &{tradeNum}[secAyersCash]    tradeAccountType    &{tradeType}[secAyersCash]
    数据库字段校验    select ${db}[tradeType] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secAyersCash]'    &{tradeType}[secAyersCash]|    全权委托证券现金交易账号类型

账号信息-交易账号类型-期货日内交易保证金
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    log    ${res_data}
    从数组中校验值    ${res_data}    &{tradeNum}[futDayTradeMargin]    tradeAccountType    &{tradeType}[futDayTradeMargin]
    数据库字段校验    select ${db}[tradeType] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futDayTradeMargin]'    &{tradeType}[futDayTradeMargin]|    期货日内交易保证金交易账号类型

账号信息-交易账号类型-MT5外汇
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    log    ${res_data}
    从数组中校验值    ${res_data}    &{tradeNum}[MT5]    tradeAccountType    &{tradeType}[MT5]
    数据库字段校验    select ${db}[tradeType] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MT5]'    &{tradeType}[MT5]|    MT5外汇交易账号类型

账号信息-交易账号类型-MF外汇
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    tradeType=trade_account_id_type
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    log    ${res_data}
    从数组中校验值    ${res_data}    &{tradeNum}[MF]    tradeAccountType    &{tradeType}[MF]
    数据库字段校验    select ${db}[tradeType] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MF]'    &{tradeType}[MF]|    MF外汇交易账号类型

账号信息-证券现金交易账号状态-OPEN
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    OPEN
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secCash]'    #数据库更新证券现金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[secCash]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secCash]'    ${status}|    证券现金交易账号状态

账号信息-证券保证金交易账号状态-OPEN
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    OPEN
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secCash]'    #数据库更新证券保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[secMargin]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secMargin]'    ${status}|    证券保证金交易账号状态

账号信息-期货保证金交易账号状态-OPEN
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    OPEN
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futMargin]'    #数据库更新期货保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[futMargin]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futMargin]'    ${status}|    期货保证金交易账号状态

账号信息-金条保证金交易账号状态-OPEN
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    OPEN
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[bullionMargin]'    #数据库更新金条保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[bullionMargin]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[bullionMargin]'    ${status}|    金条保证金交易账号状态

账号信息-互动经纪综合保证金交易账号状态-OPEN
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    OPEN
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[interBrokerIntegr]'    #数据库更新互动经纪综合保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[interBrokerIntegr]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[interBrokerIntegr]'    ${status}|    互动经纪综合保证金交易账号状态

账号信息-全权委托证券现金交易账号状态-OPEN
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    OPEN
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secAyersCash]'    #数据库更新全权委托证券现金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[secAyersCash]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secAyersCash]'    ${status}|    全权委托证券现金交易账号状态

账号信息-期货日内交易保证金交易账号状态-OPEN
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    OPEN
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futDayTradeMargin]'    #数据库更新期货日内交易保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[futDayTradeMargin]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futDayTradeMargin]'    ${status}|    期货日内交易保证金交易账号状态

账号信息-MT5外汇交易账号状态-OPEN
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    OPEN
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MT5]'    #数据库更新MT5外汇交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[MT5]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MT5]'    ${status}|    MT5外汇交易账号状态

账号信息-MF外汇交易账号状态-OPEN
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    OPEN
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MF]'    #数据库更新MF外汇交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[MF]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MF]'    ${status}|    MF外汇交易账号状态

账号信息-证券现金交易账号状态-STOP
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    STOP
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secCash]'    #数据库更新证券现金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[secCash]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secCash]'    ${status}|    证券现金交易账号状态

账号信息-证券保证金交易账号状态-STOP
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    STOP
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secCash]'    #数据库更新证券保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[secMargin]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secMargin]'    ${status}|    证券保证金交易账号状态

账号信息-期货保证金交易账号状态-STOP
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    STOP
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futMargin]'    #数据库更新期货保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[futMargin]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futMargin]'    ${status}|    期货保证金交易账号状态

账号信息-金条保证金交易账号状态-STOP
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    STOP
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[bullionMargin]'    #数据库更新金条保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[bullionMargin]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[bullionMargin]'    ${status}|    金条保证金交易账号状态

账号信息-互动经纪综合保证金交易账号状态-STOP
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    STOP
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[interBrokerIntegr]'    #数据库更新互动经纪综合保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[interBrokerIntegr]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[interBrokerIntegr]'    ${status}|    互动经纪综合保证金交易账号状态

账号信息-全权委托证券现金交易账号状态-STOP
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    STOP
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secAyersCash]'    #数据库更新全权委托证券现金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[secAyersCash]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secAyersCash]'    ${status}|    全权委托证券现金交易账号状态

账号信息-期货日内交易保证金交易账号状态-STOP
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    STOP
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futDayTradeMargin]'    #数据库更新期货日内交易保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[futDayTradeMargin]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futDayTradeMargin]'    ${status}|    期货日内交易保证金交易账号状态

账号信息-MT5外汇交易账号状态-STOP
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    STOP
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MT5]'    #数据库更新MT5外汇交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[MT5]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MT5]'    ${status}|    MT5外汇交易账号状态

账号信息-MF外汇交易账号状态-STOP
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    STOP
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MF]'    #数据库更新MF外汇交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[MF]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MF]'    ${status}|    MF外汇交易账号状态

账号信息-证券现金交易账号状态-CLOSE
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    CLOSE
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secCash]'    #数据库更新证券现金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[secCash]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secCash]'    ${status}|    证券现金交易账号状态

账号信息-证券保证金交易账号状态-CLOSE
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    CLOSE
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secCash]'    #数据库更新证券保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[secMargin]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secMargin]'    ${status}|    证券保证金交易账号状态

账号信息-期货保证金交易账号状态-CLOSE
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    CLOSE
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futMargin]'    #数据库更新期货保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[futMargin]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futMargin]'    ${status}|    期货保证金交易账号状态

账号信息-金条保证金交易账号状态-CLOSE
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    CLOSE
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[bullionMargin]'    #数据库更新金条保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[bullionMargin]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[bullionMargin]'    ${status}|    金条保证金交易账号状态

账号信息-互动经纪综合保证金交易账号状态-CLOSE
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    CLOSE
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[interBrokerIntegr]'    #数据库更新互动经纪综合保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[interBrokerIntegr]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[interBrokerIntegr]'    ${status}|    互动经纪综合保证金交易账号状态

账号信息-全权委托证券现金交易账号状态-CLOSE
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    CLOSE
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secAyersCash]'    #数据库更新全权委托证券现金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[secAyersCash]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[secAyersCash]'    ${status}|    全权委托证券现金交易账号状态

账号信息-期货日内交易保证金交易账号状态-CLOSE
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    CLOSE
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futDayTradeMargin]'    #数据库更新期货日内交易保证金交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[futDayTradeMargin]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[futDayTradeMargin]'    ${status}|    期货日内交易保证金交易账号状态

账号信息-MT5外汇交易账号状态-CLOSE
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    CLOSE
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MT5]'    #数据库更新MT5外汇交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[MT5]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MT5]'    ${status}|    MT5外汇交易账号状态

账号信息-MF外汇交易账号状态-CLOSE
    [Documentation]    由于交易账户状态修改需要CRM审核，所以用例里直接修改数据库进行测试
    ${db}    Create Dictionary    db=account_center_db    tb=trade_account    tradeNum=trade_account_id_number    status=status
    ${status}    Set Variable    CLOSE
    执行sql语句    update ${db}[db].${db}[tb] set status='${status}' where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MF]'    #数据库更新MF外汇交易账号的状态
    ${res}    个人中心-帐号信息    submitSource=submitSource=CP_WEB
    ${res_data}    Search Dic KV    ${res}    data
    从数组中校验值    ${res_data}    &{tradeNum}[MF]    status    ${status}
    数据库字段校验    select ${db}[status] from ${db}[db].${db}[tb] where eddid_id='${eddid_id}' and ${db}[tradeNum]='&{tradeNum}[MF]'    ${status}|    MF外汇交易账号状态
