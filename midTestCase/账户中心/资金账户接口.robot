*** Settings ***
Resource          ../程序功能.robot

*** Keywords ***
查询用户银行账户-列表
    [Arguments]    ${header}=${header_default}
    ${api}    Set Variable    /open/account/fund/banks
    ${res}    GET请求    ${server_address}${api}    ${header}
    [Return]    ${res}

查询货币汇率
    [Arguments]    ${tradeAccountNumber}    ${tradeAccountType}
    ${api}    Set Variable    /open/account/fund/currency-exchange/rate?${tradeAccountNumber}&${tradeAccountType}
    ${res}    GET请求    ${server_address}${api}
    [Return]    ${res}

换汇最新记录
    ${api}    Set Variable    /open/account/fund/currency-exchange/application/records
    ${res}    GET请求    ${server_address}${api}
    [Return]    ${res}

提交-存款单
    [Arguments]    ${data}
    ${api}    Set Variable    /open/account/fund/deposit/application
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

存款最新记录
    [Arguments]    ${header}=${header_default}
    ${api}    Set Variable    /open/account/fund/deposit/application/records
    ${res}    GET请求    ${server_address}${api}    ${header}
    [Return]    ${res}

查询艾德银行账户-列表
    [Arguments]    ${depositType}    ${type}
    ${api}    Set Variable    /open/account/fund/eddid/banks?${depositType}&${type}
    ${res}    GET请求    ${server_address}${api}
    [Return]    ${res}

查询客户资金记录
    [Arguments]    ${endTime}    ${pageIndex}    ${pageSize}    ${startTime}    ${tradeRecord}    ${tradeAccountType}
    ${api}    Set Variable    /open/account/fund/fund-records?${endTime}&${pageIndex}&${pageSize}&${startTime}&${tradeRecord}&${tradeAccountType}
    ${res}    GET请求    ${server_address}${api}
    [Return]    ${res}

添加-用户银行卡
    [Arguments]    ${data}    ${header}=${header_default}
    ${api}    Set Variable    /open/account/fund/settlement/account/application
    ${res}    POST请求    ${server_address}${api}    ${data}    ${header}
    [Return]    ${res}

（用户）银行卡添加记录-列表
    [Arguments]    ${header}=${header_default}
    ${api}    Set Variable    /open/account/fund/settlement/account/records
    ${res}    GET请求    ${server_address}${api}    ${header}
    [Return]    ${res}

提交子账户申请-主页
    ${api}    Set Variable    /open/account/fund/sub-account/application

子账户申请记录
    [Arguments]    ${header}=${header_default}
    ${api}    Set Variable    /open/account/fund/sub-account/application/records
    ${res}    GET请求    ${server_address}${api}    ${header}
    [Return]    ${res}

提交-内部转账单
    [Arguments]    ${data}    ${header}=${header_default}
    ${api}    Set Variable    /open/account/fund/transfer/application
    ${res}    POST请求    ${server_address}${api}    ${data}    ${header}
    [Return]    ${res}

内部转账最新记录
    [Arguments]    ${header}=${header_default}
    ${api}    Set Variable    /open/account/fund/transfer/application/records
    ${res}    GET请求    ${server_address}${api}    ${header}
    [Return]    ${res}

撤销-内部转账单
    [Arguments]    ${data}
    ${api}    Set Variable    /open/account/fund/transfer/cancel
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

提交-取款单
    [Arguments]    ${data}    ${header}=${header_default}
    ${api}    Set Variable    /open/account/fund/withdrawal/application
    ${res}    POST请求    ${server_address}${api}    ${data}    ${header}
    [Return]    ${res}

取款最新记录
    [Arguments]    ${header}=${header_default}
    ${api}    Set Variable    /open/account/fund/withdrawal/application/records
    ${res}    GET请求    ${server_address}${api}    ${header}
    [Return]    ${res}

撤销-取款单
    [Arguments]    ${data}
    ${api}    Set Variable    /open/account/fund/withdrawal/cancel
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

提交-换汇单
    [Arguments]    ${data}    ${header}=${header_default}
    ${api}    Set Variable    /open/account/fund/currency-exchange/application
    ${res}    POST请求    ${server_address}${api}    ${data}    ${header}
    [Return]    ${res}

业务申请-其他交易账户-列表
    [Arguments]    ${submitSource}=    ${header}=${header_default}
    ${api}    Set Variable    /open/account/trade/other-trade-accounts?${submitSource}
    ${res}    GET请求    ${server_address}${api}    ${header}
    [Return]    ${res}

提交-结构性产品单
    [Arguments]    ${data}    ${header}=${header_default}
    ${api}    Set Variable    /open/account/trade/structured-product/application
    ${res}    POST请求    ${server_address}${api}    ${data}    ${header}
    [Return]    ${res}

结构性产品单-开通状态
    [Arguments]    ${header}=${header_default}
    ${api}    Set Variable    /open/account/trade/structured-product/status
    ${res}    GET请求    ${server_address}${api}    ${header}
    [Return]    ${res}

提交-子账户申请单
    [Arguments]    ${data}    ${header}=${header_default}
    ${api}    Set Variable    /open/account/fund/sub-account/application
    ${res}    POST请求    ${server_address}${api}    ${data}    ${header}
    [Return]    ${res}

提交-开通交易帐号单
    [Arguments]    ${data}    ${header}=${header_default}
    ${api}    Set Variable    /open/account/trade/trade-account/application
    ${res}    POST请求    ${server_address}${api}    ${data}    ${header}
    [Return]    ${res}

银行子账户申请-主页
    [Arguments]    ${header}=${header_default}
    ${api}    Set Variable    /open/account/fund/sub-account/home
    ${res}    GET请求    ${server_address}${api}    ${header}
    [Return]    ${res}

开通交易账号申请记录
    [Arguments]    ${submitSource}=    ${header}=${header_default}
    ${api}    Set Variable    /open/account/trade/trade-account/application/records?${submitSource}
    ${res}    GET请求    ${server_address}${api}    ${header}
    [Return]    ${res}

提交-停用或关闭交易账户
    [Arguments]    ${data}    ${header}=${header_default}
    ${api}    Set Variable    /open/account/trade/trade-account-stop/application
    ${res}    POST请求    ${server_address}${api}    ${data}    ${header}
    [Return]    ${res}

停用或关闭交易账户-申请记录
    [Arguments]    ${header}=${header_default}
    ${api}    Set Variable    /open/account/trade/trade-account-stop/application/records
    ${res}    GET请求    ${server_address}${api}    ${header}
