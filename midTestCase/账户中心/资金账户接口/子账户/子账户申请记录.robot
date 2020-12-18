*** Settings ***
Resource          ../../资金账户接口.robot

*** Test Cases ***
Token的key为空
    ${header}    create dictionary    Content-Type=application/json
    ${res}    子账户申请记录    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

Token的value为空
    ${header}    create dictionary    Content-Type=application/json    Authorization=
    ${res}    子账户申请记录    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

未存在子账户申请记录
    Comment    删除该用户的所有子账户申请记录
    执行sql语句    delete from bank_subaccount where eddid_id='${eddid_id}';
    ${res}    子账户申请记录
    字典关键字校验    ${res}    msg    OK

存在多条子账户申请记录
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from bank_subaccount where eddid_id='${eddid_id}';
        ${submitSource}    getListIndexValue    ${submitSource_list}    ${i}
        ${data1}    Create Dictionary    advanceAmount=500    currency=HKD
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    提交-子账户申请单    ${data}
        字典关键字校验    ${res}    msg    OK
    END
    ${res}    子账户申请记录
    字典关键字校验    ${res}    msg    OK

存在子账户申请记录状态为完成
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
    ${res}    子账户申请记录
    字典关键字校验    ${res}    msg    OK

存在子账户申请记录状态为处理中
    Comment    删除该用户下的子账户及子账户
    执行sql语句    delete from bank_subaccount where eddid_id='${eddid_id}';
    Comment    提交-子账户申请
    ${submitSource}    Set Variable    CP_H5
    ${data}    Create Dictionary    submitSource=${submitSource}    advanceAmount=500    currency=HKD
    ${res}    提交-子账户申请单    ${data}
    ${res}    子账户申请记录
    字典关键字校验    ${res}    msg    OK

存在子账户申请记录状态为失败
    Comment    删除该用户下的子账户及子账户
    执行sql语句    delete from bank_subaccount where eddid_id='${eddid_id}';
    Comment    提交-子账户申请
    ${submitSource}    Set Variable    CP_H5
    ${data}    Create Dictionary    submitSource=${submitSource}    advanceAmount=500    currency=HKD
    ${res}    提交-子账户申请单    ${data}
    Comment    查询申请的子账户的order_id
    ${order_id}    Search Dic KV    ${res}    orderId
    Comment    审核子账户申请为中国银行
    执行sql语句    update bank_subaccount set status='FAILURE'where eddid_id='${eddid_id}' and order_id='${order_id}';
    ${res}    子账户申请记录
    字典关键字校验    ${res}    msg    OK
