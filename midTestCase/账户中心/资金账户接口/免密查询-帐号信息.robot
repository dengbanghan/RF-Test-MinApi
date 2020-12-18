*** Settings ***
Resource          ../资金账户接口.robot

*** Test Cases ***
单个查询
    ${data}    Create Dictionary    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH
    ${data_list}    Create List    ${data}
    ${res}    免密查询-帐号信息    ${data_list}
    字典关键字校验    ${res}    msg    OK
    ${res_data}    Search Dic KV    ${res}    data
    ${res_data_length}    Evaluate    len(${res_data})
    ${data_list_length}    Evaluate    len(${data_list})
    两值校验    返回账号数量    ${res_data_length}    ${data_list_length}

单个查询-校验交易账号
    ${data}    Create Dictionary    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH
    ${data_list}    Create List    ${data}
    ${res}    免密查询-帐号信息    ${data_list}
    字典关键字校验    ${res}    msg    OK
    ${res_data}    Search Dic KV    ${res}    data
    ${res_data_length}    Evaluate    len(${res_data})
    ${data_list_length}    Evaluate    len(${data_list})
    两值校验    返回账号数量    ${res_data_length}    ${data_list_length}
    字典关键字校验    ${res_data}[0]    tradeAccountNumber    &{trade}[securitiesNum]

单个查询-校验交易账号类型
    ${data}    Create Dictionary    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH
    ${data_list}    Create List    ${data}
    ${res}    免密查询-帐号信息    ${data_list}
    字典关键字校验    ${res}    msg    OK
    ${res_data}    Search Dic KV    ${res}    data
    ${res_data_length}    Evaluate    len(${res_data})
    ${data_list_length}    Evaluate    len(${data_list})
    两值校验    返回账号数量    ${res_data_length}    ${data_list_length}
    字典关键字校验    ${res_data}[0]    tradeAccountType    SECURITIES_CASH

批量查询
    ${data1}    Create Dictionary    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH
    ${data2}    Create Dictionary    tradeAccountNumber=&{trade}[futuresNum]    tradeAccountType=FUTURES_MARGIN
    ${data_list}    Create List    ${data1}    ${data2}
    ${res}    免密查询-帐号信息    ${data_list}
    字典关键字校验    ${res}    msg    OK
    ${res_data}    Search Dic KV    ${res}    data
    ${res_data_length}    Evaluate    len(${res_data})
    ${data_list_length}    Evaluate    len(${data_list})
    两值校验    返回账号数量    ${res_data_length}    ${data_list_length}

批量查询-校验交易账号
    ${data1}    Create Dictionary    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH
    ${data2}    Create Dictionary    tradeAccountNumber=&{trade}[futuresNum]    tradeAccountType=FUTURES_MARGIN
    ${data_list}    Create List    ${data1}    ${data2}
    ${res}    免密查询-帐号信息    ${data_list}
    字典关键字校验    ${res}    msg    OK
    ${res_data}    Search Dic KV    ${res}    data
    ${res_data_length}    Evaluate    len(${res_data})
    ${data_list_length}    Evaluate    len(${data_list})
    两值校验    返回账号数量    ${res_data_length}    ${data_list_length}
    字典关键字校验    ${res_data}[0]    tradeAccountNumber    &{trade}[securitiesNum]
    字典关键字校验    ${res_data}[1]    tradeAccountNumber    &{trade}[futuresNum]

批量查询-校验交易账号类型
    ${data1}    Create Dictionary    tradeAccountNumber=&{trade}[securitiesNum]    tradeAccountType=SECURITIES_CASH
    ${data2}    Create Dictionary    tradeAccountNumber=&{trade}[futuresNum]    tradeAccountType=FUTURES_MARGIN
    ${data_list}    Create List    ${data1}    ${data2}
    ${res}    免密查询-帐号信息    ${data_list}
    字典关键字校验    ${res}    msg    OK
    ${res_data}    Search Dic KV    ${res}    data
    ${res_data_length}    Evaluate    len(${res_data})
    ${data_list_length}    Evaluate    len(${data_list})
    两值校验    返回账号数量    ${res_data_length}    ${data_list_length}
    字典关键字校验    ${res_data}[0]    tradeAccountType    SECURITIES_CASH
    字典关键字校验    ${res_data}[1]    tradeAccountType    FUTURES_MARGIN
