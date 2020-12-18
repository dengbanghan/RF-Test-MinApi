*** Settings ***
Resource          ../资金账户接口.robot

*** Test Cases ***
查询列表-提交来源-入参为正确
    ${submitSource_list}    Create List    submitSource=CP_H5    submitSource=CP_WEB    submitSource=CRM    submitSource=CDMS    submitSource=UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${submitSource}    IN RANGE    ${list_length}
        ${res}    业务申请-其他交易账户-列表    ${submitSource_list}[${submitSource}]
        字典关键字校验    ${res}    msg    OK
    END

查询列表-提交来源-入参为错误
    ${submitSource_list}    Create List    \    submitSource=    submitSource=UNKNOWN
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${submitSource}    IN RANGE    ${list_length}
        ${res}    业务申请-其他交易账户-列表    ${submitSource_list}[${submitSource}]
        字典关键字校验    ${res}    msg    &{err_msg}[null]
    END

查询列表-Token的key为空
    ${header}    create dictionary    Content-Type=application/json
    ${res}    业务申请-其他交易账户-列表    header=${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

查询列表-Token的value为空
    ${header}    create dictionary    Content-Type=application/json    Authorization=
    ${res}    业务申请-其他交易账户-列表    header=${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]
