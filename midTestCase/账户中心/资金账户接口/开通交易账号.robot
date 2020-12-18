*** Settings ***
Documentation     1. 交易账号类型为：BULLION_MARGIN和MF 提示功能尚未实现；
...               2. 交易账号类型为：INTERACTIVE_BROKER_INTEGRATED_MARGIN 需要境外用户才可以申请，暂未编写用例；
...               3. 交易账户类型为：SECURITIES_AYERS_CASH（全权委托证券(现金)）这个类型不能提交，由CRM那边处理
Resource          ../资金账户接口.robot

*** Test Cases ***
提交开通帐号单-提交来源-入参为正确
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM    CDMS    UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    DELETE FROM account_center_db.securities_cash_application WHERE eddid_id='${eddid_id}'
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${data}    Create Dictionary    agreement=false    infoIsSame=true    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data}    submitSource=${submitSource}
        ${res}    提交-开通交易帐号单    ${data}
        字典关键字校验    ${res}    msg    OK
        ${order_id}    Search Dic KV    ${res}    orderId
        数据库字段校验    select order_id from account_center_db.securities_cash_application where eddid_id='${eddid_id}'    ${order_id}|    orderId
    END

提交开通帐号单-提交来源-入参为错误
    ${submitSource_list}    Create List    /    UNKNOWN
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    DELETE FROM account_center_db.securities_cash_application WHERE eddid_id='${eddid_id}'
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${data}    Create Dictionary    agreement=false    infoIsSame=true    tradeAccountType=SECURITIES_CASH
        ${data}    Set To Dictionary    ${data}    submitSource=${submitSource}
        ${res}    提交-开通交易帐号单    ${data}
        字典关键字校验    ${res}    msg    &{errMsg}[null]
    END

提交开通帐号单-不同意协议
    执行sql语句    DELETE FROM account_center_db.securities_cash_application WHERE eddid_id='${eddid_id}'
    ${type}    Set Variable    SECURITIES_CASH
    ${data}    Create Dictionary    agreement=false    infoIsSame=true    tradeAccountType=${type}    submitSource=CP_H5
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id,agreement from account_center_db.securities_cash_application where eddid_id='${eddid_id}'    ${order_id}|0|    orderId

提交开通帐号单-同意协议
    执行sql语句    DELETE FROM account_center_db.securities_cash_application WHERE eddid_id='${eddid_id}'
    ${type}    Set Variable    SECURITIES_CASH
    ${data}    Create Dictionary    agreement=true    infoIsSame=true    tradeAccountType=${type}    submitSource=CP_H5
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id,agreement from account_center_db.securities_cash_application where eddid_id='${eddid_id}'    ${order_id}|1|    orderId

提交开通帐号单-资料一致
    执行sql语句    DELETE FROM account_center_db.securities_cash_application WHERE eddid_id='${eddid_id}'
    ${type}    Set Variable    SECURITIES_CASH
    ${data}    Create Dictionary    agreement=false    infoIsSame=true    tradeAccountType=${type}    submitSource=CP_H5
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id,info_is_same from account_center_db.securities_cash_application where eddid_id='${eddid_id}'    ${order_id}|1|    orderId

提交开通帐号单-资料不一致
    执行sql语句    DELETE FROM account_center_db.securities_cash_application WHERE eddid_id='${eddid_id}'
    ${type}    Set Variable    SECURITIES_CASH
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id,info_is_same from account_center_db.securities_cash_application where eddid_id='${eddid_id}'    ${order_id}|0|    orderId

提交开通帐号单-交易账号类型-证券现金
    Comment    \    # 数据库名    # 证券现金表
    ${db}    Create List    account_center_db    securities_cash_application
    执行sql语句    DELETE FROM ${db}[0].${db}[1] WHERE eddid_id='${eddid_id}'
    ${type}    Set Variable    SECURITIES_CASH
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|    orderId
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    accountType    ${type}

提交开通帐号单-交易账号类型-证券保证金
    Comment    \    # 数据库名    # 证券保证金表    # 有关保证金关联的表    # 关联表里的orderId
    ${db}    Create List    account_center_db    securities_margin_application    related_margin_account    securities_margin_application_order_id
    #先删除外键关联表里的数据
    执行sql语句    delete from ${db}[0].${db}[2] where ${db}[3]=(select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}')
    #才能删除证券保证金表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #relatedMarginAccounts为列表，需要先定义后再拼接到body中    #保证金必送relatedMarginAccounts
    ${relatedMarginAccounts}    Create Dictionary    accountHolder=自己    accountNumber=2020043001    checked=true    relatedName=中国银行
    ${relatedMarginAccounts_list}    Create List    ${relatedMarginAccounts}
    ${type}    Set Variable    SECURITIES_MARGIN
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5    relatedMarginAccounts=${relatedMarginAccounts_list}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|    orderId
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    accountType    ${type}

提交开通帐号单-交易账号类型-证券保证金-不送relatedMarginAccounts
    Comment    \    # 数据库名    # 证券保证金表    # 有关保证金关联的表    # 关联表里的orderId
    ${db}    Create List    account_center_db    securities_margin_application    related_margin_account    securities_margin_application_order_id
    #先删除外键关联表里的数据
    执行sql语句    delete from ${db}[0].${db}[2] where ${db}[3]=(select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}')
    #才能删除证券保证金表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    ${type}    Set Variable    SECURITIES_MARGIN
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    证券(保证金),参数错误
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|    orderId

提交开通帐号单-交易账号类型-证券保证金-relatedMarginAccounts里的非必要值为空
    Comment    \    # 数据库名    # 证券保证金表    # 有关保证金关联的表    # 关联表里的orderId
    ${db}    Create List    account_center_db    securities_margin_application    related_margin_account    securities_margin_application_order_id
    #先删除外键关联表里的数据
    执行sql语句    delete from ${db}[0].${db}[2] where ${db}[3]=(select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}')
    #才能删除证券保证金表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #relatedMarginAccounts为列表，需要先定义后再拼接到body中    #保证金必送relatedMarginAccounts
    ${relatedMarginAccounts}    Create Dictionary    accountHolder=    accountNumber=    checked=true    relatedName=
    ${relatedMarginAccounts_list}    Create List    ${relatedMarginAccounts}
    ${type}    Set Variable    SECURITIES_MARGIN
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5    relatedMarginAccounts=${relatedMarginAccounts_list}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|    orderId

提交开通帐号单-交易账号类型-证券保证金-checked的值为空
    Comment    \    # 数据库名    # 证券保证金表    # 有关保证金关联的表    # 关联表里的orderId
    ${db}    Create List    account_center_db    securities_margin_application    related_margin_account    securities_margin_application_order_id
    #先删除外键关联表里的数据
    执行sql语句    delete from ${db}[0].${db}[2] where ${db}[3]=(select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}')
    #才能删除证券保证金表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #relatedMarginAccounts为列表，需要先定义后再拼接到body中    #保证金必送relatedMarginAccounts
    ${relatedMarginAccounts}    Create Dictionary    accountHolder=自己    accountNumber=2020043001    checked=    relatedName=中国银行
    ${relatedMarginAccounts_list}    Create List    ${relatedMarginAccounts}
    ${type}    Set Variable    SECURITIES_MARGIN
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5    relatedMarginAccounts=${relatedMarginAccounts_list}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    证券(保证金),参数错误
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|    orderId

提交开通帐号单-交易账号类型-期货保证金
    Comment    \    # 数据库名    # 期货保证金表
    ${db}    Create List    account_center_db    futures_margin_application
    #删除期货保证金表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #relatedMarginAccounts为列表，需要先定义后再拼接到body中    #保证金必送relatedMarginAccounts
    ${relatedMarginAccounts}    Create Dictionary    accountHolder=自己    accountNumber=2020043002    checked=true    relatedName=中国银行
    ${relatedMarginAccounts_list}    Create List    ${relatedMarginAccounts}
    ${type}    Set Variable    FUTURES_MARGIN
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5    relatedMarginAccounts=${relatedMarginAccounts_list}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|    orderId
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    accountType    ${type}

提交开通帐号单-交易账号类型-期货保证金-不送relatedMarginAccounts
    Comment    \    # 数据库名    # 期货保证金表
    ${db}    Create List    account_center_db    futures_margin_application
    #删除期货保证金表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    ${type}    Set Variable    FUTURES_MARGIN
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|    orderId
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    accountType    ${type}

提交开通帐号单-交易账号类型-期货保证金-relatedMarginAccounts里的非必要值为空
    Comment    \    # 数据库名    # 期货保证金表
    ${db}    Create List    account_center_db    futures_margin_application
    #删除期货保证金表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #relatedMarginAccounts为列表，需要先定义后再拼接到body中    #保证金必送relatedMarginAccounts
    ${relatedMarginAccounts}    Create Dictionary    accountHolder=    accountNumber=    checked=true    relatedName=
    ${relatedMarginAccounts_list}    Create List    ${relatedMarginAccounts}
    ${type}    Set Variable    FUTURES_MARGIN
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5    relatedMarginAccounts=${relatedMarginAccounts_list}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|    orderId
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    accountType    ${type}

提交开通帐号单-交易账号类型-期货保证金-checked的值为空
    Comment    \    # 数据库名    # 期货保证金表
    ${db}    Create List    account_center_db    futures_margin_application
    #删除期货保证金表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #relatedMarginAccounts为列表，需要先定义后再拼接到body中    #保证金必送relatedMarginAccounts
    ${relatedMarginAccounts}    Create Dictionary    accountHolder=自己    accountNumber=2020043002    checked=    relatedName=中国银行
    ${relatedMarginAccounts_list}    Create List    ${relatedMarginAccounts}
    ${type}    Set Variable    FUTURES_MARGIN
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5    relatedMarginAccounts=${relatedMarginAccounts_list}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|    orderId
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    accountType    ${type}

提交开通帐号单-交易账号类型-全权委托证券(现金)
    Comment    \    # 数据库名    # 证券现金表
    ${db}    Create List    account_center_db    securities_ayers_cash_application
    #删除证券现金表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #investment和relatedMarginAccounts这两个参数分别为节点和列表，所以需要先定义后再拼接到body中
    ${investment}    Create Dictionary    experience=    purpose=    riskTolerance=
    ${relatedMarginAccounts}    Create Dictionary    accountHolder=    accountNumber=    checked=true    relatedName=
    ${relatedMarginAccounts_list}    Create List    ${relatedMarginAccounts}
    ${type}    Set Variable    SECURITIES_AYERS_CASH
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5    investment=${investment}    relatedMarginAccounts=${relatedMarginAccounts_list}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|    orderId
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    accountType    ${type}

提交开通帐号单-交易账号类型-期货日内保证金
    Comment    \    # 数据库名    # 期货日内保证金表
    ${db}    Create List    account_center_db    futures_day_trading_margin_application
    #删除期货日内保证金表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #relatedMarginAccounts这个参数为列表，所以需要先定义后再拼接到body中
    ${relatedMarginAccounts}    Create Dictionary    accountHolder=自己    accountNumber=2020043002    checked=true    relatedName=中国银行
    ${relatedMarginAccounts_list}    Create List    ${relatedMarginAccounts}
    ${type}    Set Variable    FUTURES_DAYTRADING_MARGIN
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5    relatedMarginAccounts=${relatedMarginAccounts_list}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id,info_is_same from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|0|    orderId
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    accountType    ${type}

提交开通帐号单-交易账号类型-期货日内保证金-不送relatedMarginAccounts
    Comment    \    # 数据库名    # 期货日内保证金表
    ${db}    Create List    account_center_db    futures_day_trading_margin_application
    #删除期货日内保证金表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    ${type}    Set Variable    FUTURES_DAYTRADING_MARGIN
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id,info_is_same from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|0|    orderId
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    accountType    ${type}

提交开通帐号单-交易账号类型-期货日内保证金-relatedMarginAccounts里的非必要值为空
    Comment    \    # 数据库名    # 期货日内保证金表
    ${db}    Create List    account_center_db    futures_day_trading_margin_application
    #删除期货日内保证金表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #relatedMarginAccounts这个参数为列表，所以需要先定义后再拼接到body中
    ${relatedMarginAccounts}    Create Dictionary    accountHolder=    accountNumber=    checked=true    relatedName=
    ${relatedMarginAccounts_list}    Create List    ${relatedMarginAccounts}
    ${type}    Set Variable    FUTURES_DAYTRADING_MARGIN
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5    relatedMarginAccounts=${relatedMarginAccounts_list}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id,info_is_same from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|0|    orderId
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    accountType    ${type}

提交开通帐号单-交易账号类型-期货日内保证金-checked的值为空
    Comment    \    # 数据库名    # 期货日内保证金表
    ${db}    Create List    account_center_db    futures_day_trading_margin_application
    #删除期货日内保证金表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #relatedMarginAccounts这个参数为列表，所以需要先定义后再拼接到body中
    ${relatedMarginAccounts}    Create Dictionary    accountHolder=自己    accountNumber=2020043002    checked=    relatedName=中国银行
    ${relatedMarginAccounts_list}    Create List    ${relatedMarginAccounts}
    ${type}    Set Variable    FUTURES_DAYTRADING_MARGIN
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5    relatedMarginAccounts=${relatedMarginAccounts_list}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id,info_is_same from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|0|    orderId
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    accountType    ${type}

提交开通帐号单-交易账号类型-外汇
    Comment    \    # 数据库名    # MT5表
    ${db}    Create List    account_center_db    foreign_exchange_application
    #删除MT5表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #investment参数为节点，所以需要先定义后再拼接到body中
    ${investment}    Create Dictionary    experience=十年    purpose=赚钱    riskTolerance=高
    ${type}    Set Variable    MT5
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_WEB    investment=${investment}
    log    ${data}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|    orderId
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_WEB
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    accountType    ${type}

提交开通帐号单-交易账号类型-外汇-H5
    [Documentation]    交易账号类型为MT5时，submitSource送CP_H5不会返回数据，因为MT5不支持H5操作
    Comment    \    # 数据库名    # MT5表
    ${db}    Create List    account_center_db    foreign_exchange_application
    #删除MT5表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #investment参数为节点，所以需要先定义后再拼接到body中
    ${investment}    Create Dictionary    experience=十年    purpose=赚钱    riskTolerance=高
    ${type}    Set Variable    MT5
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5    investment=${investment}
    log    ${data}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    数据库字段校验    select order_id from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${order_id}|    orderId

提交开通帐号单-交易账号类型-外汇-不送investment
    [Documentation]    MT类型为外汇，外汇必须要送investment
    Comment    \    # 数据库名    # MT5表
    ${db}    Create List    account_center_db    foreign_exchange_application
    #删除MT5表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #investment参数为节点，所以需要先定义后再拼接到body中
    ${investment}    Create Dictionary    experience=十年    purpose=赚钱    riskTolerance=高
    ${type}    Set Variable    MT5
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_WEB
    log    ${data}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    外汇,参数错误

提交开通帐号单-交易账号类型-外汇-investment里的值为空
    [Documentation]    MT类型为外汇，外汇必须要送investment
    Comment    \    # 数据库名    # MT5表
    ${db}    Create List    account_center_db    foreign_exchange_application
    #删除MT5表里的数据
    执行sql语句    delete from ${db}[0].${db}[1] where eddid_id='${eddid_id}'
    #investment参数为节点，所以需要先定义后再拼接到body中
    ${investment}    Create Dictionary    experience=    purpose=    riskTolerance=
    ${type}    Set Variable    MT5
    #拼接完成的body入参
    ${data}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_WEB    investment=${investment}
    log    ${data}
    ${res}    提交-开通交易帐号单    ${data}
    字典关键字校验    ${res}    msg    外汇,参数错误

申请记录-提交来源-入参为正确
    ${submitSource_list}    Create List    submitSource=CP_H5    submitSource=CP_WEB    submitSource=CRM    submitSource=CDMS    submitSource=UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${submitSource}    IN RANGE    ${list_length}
        ${res}    开通交易账号申请记录    ${submitSource_list}[${submitSource}]
        字典关键字校验    ${res}    msg    OK
    END

申请记录-提交来源-入参为错误
    ${submitSource_list}    Create List    \    submitSource=    submitSource=UNKNOWN
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${submitSource}    IN RANGE    ${list_length}
        ${res}    开通交易账号申请记录    ${submitSource_list}[${submitSource}]
        字典关键字校验    ${res}    msg    &{err_msg}[null]
    END

申请记录-Token的key为空
    ${header}    create dictionary    Content-Type=application/json
    ${res}    开通交易账号申请记录    header=${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

申请记录-Token的value为空
    ${header}    create dictionary    Content-Type=application/json    Authorization=
    ${res}    开通交易账号申请记录    header=${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

申请记录-申请状态-SUBMITTED
    Comment    \    # 数据库名    # 证券现金表
    ${db}    Create List    account_center_db    securities_cash_application
    执行sql语句    DELETE FROM ${db}[0].${db}[1] WHERE eddid_id='${eddid_id}'
    ${type}    Set Variable    SECURITIES_CASH
    ${data_req}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5
    Comment    先提交开通账号申请，返回orderId
    ${res}    提交-开通交易帐号单    ${data_req}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    通过数据库修改状态
    ${status}    Set Variable    SUBMITTED
    执行sql语句    update ${db}[0].${db}[1] set `status`='${status}' where eddid_id='${eddid_id}'
    Comment    再通过orderId校验申请记录
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    数据库字段校验    select `status` from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${status}|    Ststus
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    status    ${status}

申请记录-申请状态-CHECKING
    Comment    \    # 数据库名    # 证券现金表
    ${db}    Create List    account_center_db    securities_cash_application
    执行sql语句    DELETE FROM ${db}[0].${db}[1] WHERE eddid_id='${eddid_id}'
    ${type}    Set Variable    SECURITIES_CASH
    ${data_req}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5
    Comment    先提交开通账号申请，返回orderId
    ${res}    提交-开通交易帐号单    ${data_req}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    通过数据库修改状态
    ${status}    Set Variable    CHECKING
    执行sql语句    update ${db}[0].${db}[1] set `status`='${status}' where eddid_id='${eddid_id}'
    Comment    再通过orderId校验申请记录
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    数据库字段校验    select `status` from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${status}|    Ststus
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    status    ${status}

申请记录-申请状态-PASS
    Comment    \    # 数据库名    # 证券现金表
    ${db}    Create List    account_center_db    securities_cash_application
    执行sql语句    DELETE FROM ${db}[0].${db}[1] WHERE eddid_id='${eddid_id}'
    ${type}    Set Variable    SECURITIES_CASH
    ${data_req}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5
    Comment    先提交开通账号申请，返回orderId
    ${res}    提交-开通交易帐号单    ${data_req}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    通过数据库修改状态
    ${status}    Set Variable    PASS
    执行sql语句    update ${db}[0].${db}[1] set `status`='${status}' where eddid_id='${eddid_id}'
    Comment    再通过orderId校验申请记录
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    数据库字段校验    select `status` from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${status}|    Ststus
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    status    ${status}

申请记录-申请状态-SUCCESS
    Comment    \    # 数据库名    # 证券现金表
    ${db}    Create List    account_center_db    securities_cash_application
    执行sql语句    DELETE FROM ${db}[0].${db}[1] WHERE eddid_id='${eddid_id}'
    ${type}    Set Variable    SECURITIES_CASH
    ${data_req}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5
    Comment    先提交开通账号申请，返回orderId
    ${res}    提交-开通交易帐号单    ${data_req}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    通过数据库修改状态
    ${status}    Set Variable    SUCCESS
    执行sql语句    update ${db}[0].${db}[1] set `status`='${status}' where eddid_id='${eddid_id}'
    Comment    再通过orderId校验申请记录
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    数据库字段校验    select `status` from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${status}|    Ststus
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    status    ${status}

申请记录-申请状态-REJECT
    Comment    \    # 数据库名    # 证券现金表
    ${db}    Create List    account_center_db    securities_cash_application
    执行sql语句    DELETE FROM ${db}[0].${db}[1] WHERE eddid_id='${eddid_id}'
    ${type}    Set Variable    SECURITIES_CASH
    ${data_req}    Create Dictionary    agreement=true    infoIsSame=false    tradeAccountType=${type}    submitSource=CP_H5
    Comment    先提交开通账号申请，返回orderId
    ${res}    提交-开通交易帐号单    ${data_req}
    字典关键字校验    ${res}    msg    OK
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    通过数据库修改状态
    ${status}    Set Variable    REJECT
    执行sql语句    update ${db}[0].${db}[1] set `status`='${status}' where eddid_id='${eddid_id}'
    Comment    再通过orderId校验申请记录
    ${res1}    开通交易账号申请记录    submitSource=submitSource=CP_H5
    数据库字段校验    select `status` from ${db}[0].${db}[1] where eddid_id='${eddid_id}'    ${status}|    Ststus
    ${data_list}    Search Dic KV    ${res1}    data
    从数组中校验值    ${data_list}    ${order_id}    status    ${status}

申请记录-交易账户类型-SECURITIES_CASH
    ${submitSource}    Set Variable    submitSource=CP_H5
    ${res}    开通交易账号申请记录    ${submitSource}
    ${data_list}    Search Dic KV    ${res}    data
    ${data}    getListIndexValue    ${data_list}    0
    字典关键字校验    ${data}    accountType    SECURITIES_CASH

申请记录-校验创建时间
    ${submitSource}    Set Variable    submitSource=CP_H5
    执行sql语句    update account_center_db.securities_cash_application set `status`='REJECT' where eddid_id='${eddid_id}'
    ${res}    开通交易账号申请记录    ${submitSource}
    ${data_list}    Search Dic KV    ${res}    data
    ${data}    getListIndexValue    ${data_list}    0
    ${created_date}    Search Dic KV    ${data}    createdDate
    数据库字段校验    select created_date from account_center_db.securities_cash_application where eddid_id='${eddid_id}'    ${created_date}|    createdDate
