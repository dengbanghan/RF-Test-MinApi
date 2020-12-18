*** Settings ***
Resource          ../资金账户接口.robot

*** Test Cases ***
查询艾德银行账户-列表
    ${depositType}    Set Variable    ATM_TRANSFER_DEPOSIT
    ${type}    Set Variable    SECURITIES_CASH
    ${res}    查询艾德银行账户-列表    depositType=${depositType}    type=${type}
    字典关键字校验    ${res}    msg    OK

查询列表-存款类型为子账户-交易账号类型value为空
    ${depositType}    Set Variable    depositType=SUB_ACCOUNT_DEPOSIT
    ${type}    Set Variable    type=
    ${res}    查询艾德银行账户-列表    ${depositType}    ${type}
    字典关键字校验    ${res}    msg    OK

查询列表-存款类型为子账户-交易账号类型key为空
    ${depositType}    Set Variable    depositType=SUB_ACCOUNT_DEPOSIT
    ${type}    Set Variable
    ${res}    查询艾德银行账户-列表    ${depositType}    ${type}
    字典关键字校验    ${res}    msg    OK

查询列表-存款类型为FPS-交易账号类型value为空
    ${depositType}    Set Variable    depositType=FPS_DEPOSIT
    ${type}    Set Variable    type=
    ${res}    查询艾德银行账户-列表    ${depositType}    ${type}
    字典关键字校验    ${res}    msg    &{err_msg}[null]

查询列表-存款类型为FPS-交易账号类型key为空
    ${depositType}    Set Variable    depositType=FPS_DEPOSIT
    ${type}    Set Variable
    ${res}    查询艾德银行账户-列表    ${depositType}    ${type}
    字典关键字校验    ${res}    msg    OK
