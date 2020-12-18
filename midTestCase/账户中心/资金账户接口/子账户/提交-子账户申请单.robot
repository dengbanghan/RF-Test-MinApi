*** Settings ***
Resource          ../../资金账户接口.robot

*** Test Cases ***
提交来源入参为正确
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM    CDMS    UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from bank_subaccount where eddid_id='${eddid_id}';
        ${submitSource}    getListIndexValue    ${submitSource_list}    ${i}
        ${data1}    Create Dictionary    advanceAmount=500    currency=HKD
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-子账户申请单    ${data}
        字典关键字校验    ${res}    msg    OK
    END

提交来源-入参错误
    ${data}    Create Dictionary    submitSource=UNKNOWN    advanceAmount=500    currency=HKD
    ${res}    提交-子账户申请单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

未存在子账户存在处理中申请能再次申请子账户
    执行sql语句    delete from bank_subaccount where eddid_id='${eddid_id}';
    ${submitSource}    Set Variable    CP_H5
    ${data}    Create Dictionary    submitSource=${submitSource}    advanceAmount=500    currency=HKD
    ${res}    提交-子账户申请单    ${data}
    ${res}    提交-子账户申请单    ${data}
    字典关键字校验    ${res}    msg    OK

存在子账户中国银行可以再次申请子账户
    Comment    删除该用户下的子账户及子账户
    执行sql语句    delete from bank_subaccount where eddid_id='${eddid_id}';
    Comment    提交-子账户申请
    ${submitSource}    Set Variable    CP_H5
    ${data}    Create Dictionary    submitSource=${submitSource}    advanceAmount=500    currency=HKD
    ${res}    提交-子账户申请单    ${data}
    Comment    查询申请的子账户的order_id
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    审核子账户申请为中国银行
    执行sql语句    update bank_subaccount set status='COMPLETED',sub_bank_account='12345',alias_address='ICBC Tower, 3 Garden Road, Central, Hong Kong',bank_key='BOC',sub_bank_name='中国银行（香港）有限公司',payee_name='艾莉莎',sub_bank_swift_code='BKCHHKHHXXX' where eddid_id='${eddid_id}' and order_id='${order_id}';
    ${res}    提交-子账户申请单    ${data}
    字典关键字校验    ${res}    msg    OK

存在子账户非中国银行不可以申请子账户
    Comment    删除该用户下的子账户及子账户
    执行sql语句    delete from bank_subaccount where eddid_id='${eddid_id}';
    Comment    提交-子账户申请
    ${submitSource}    Set Variable    CP_H5
    ${data}    Create Dictionary    submitSource=${submitSource}    advanceAmount=500    currency=HKD
    ${res}    提交-子账户申请单    ${data}
    Comment    查询申请的子账户的order_id
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    审核子账户申请为非中国银行
    执行sql语句    update bank_subaccount set status='COMPLETED',sub_bank_account='07212345',alias_address='ICBC Tower, 3 Garden Road, Central, Hong Kong',bank_key='ICBC',sub_bank_name='中国工商银行（香港）有限公司',payee_name='艾莉莎',sub_bank_swift_code='UBHKHKHH' where eddid_id='${eddid_id}' and order_id='${order_id}';
    ${res}    提交-子账户申请单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[doing]

存在子账户中国银行存在处理中申请不可以再次申请子账户
    Comment    删除该用户下的子账户及子账户
    执行sql语句    delete from bank_subaccount where eddid_id='${eddid_id}';
    Comment    提交-子账户申请
    ${submitSource}    Set Variable    CP_H5
    ${data}    Create Dictionary    submitSource=${submitSource}    advanceAmount=500    currency=HKD
    ${res}    提交-子账户申请单    ${data}
    Comment    查询申请的子账户的order_id
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    审核子账户申请为中国银行
    执行sql语句    update bank_subaccount set status='COMPLETED',sub_bank_account='12345',alias_address='ICBC Tower, 3 Garden Road, Central, Hong Kong',bank_key='BOC',sub_bank_name='中国银行（香港）有限公司',payee_name='艾莉莎',sub_bank_swift_code='BKCHHKHHXXX' where eddid_id='${eddid_id}' and order_id='${order_id}';
    ${res}    提交-子账户申请单    ${data}
    ${res}    提交-子账户申请单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[doing]

提交-子账户申请单-提交来源-value为空
    ${data}    Create Dictionary    submitSource=    advanceAmount=500    currency=HKD
    ${res}    提交-子账户申请单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-子账户申请单-提交来源-key为空
    ${data}    Create Dictionary    advanceAmount=500    currency=HKD
    ${res}    提交-子账户申请单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-子账户申请单-预存款金额-value为空
    ${data}    Create Dictionary    submitSource=CP_H5    advanceAmount=    currency=HKD
    ${res}    提交-子账户申请单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-子账户申请单-预存款金额-key为空
    ${data}    Create Dictionary    submitSource=CP_H5    currency=HKD
    ${res}    提交-子账户申请单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-子账户申请单-银行币种-value为空
    ${data}    Create Dictionary    submitSource=CP_H5    advanceAmount=500    currency=
    ${res}    提交-子账户申请单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

提交-子账户申请单-银行币种-key为空
    ${data}    Create Dictionary    submitSource=    advanceAmount=500
    ${res}    提交-子账户申请单    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

Token的key为空
    ${header}    create dictionary    Content-Type=application/json
    ${data}    Create Dictionary    submitSource=CP_H5    advanceAmount=500    currency=HKD
    ${res}    提交-子账户申请单    ${data}    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

Token的value为空
    ${header}    create dictionary    Content-Type=application/json
    ${data}    Create Dictionary    submitSource=CP_H5    advanceAmount=500    currency=HKD
    ${res}    提交-子账户申请单    ${data}    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]
