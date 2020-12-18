*** Settings ***
Resource          ../../资金账户接口.robot

*** Test Cases ***
未存在子账户-响应标识为True
    Comment    #未存在子账户，响应标识为True
    执行sql语句    delete from bank_subaccount where eddid_id='${eddid_id}';
    ${res}    银行子账户申请-主页
    字典关键字校验    ${res}    isCanApplication    True

未存在子账户存在处理中申请-响应标识为True
    Comment    删除该用户下的子账户及子账户
    执行sql语句    delete from bank_subaccount where eddid_id='${eddid_id}';
    Comment    提交-子账户申请
    ${submitSource}    Set Variable    CP_H5
    ${data}    Create Dictionary    submitSource=${submitSource}    advanceAmount=500    currency=HKD
    ${res}    提交-子账户申请单    ${data}
    ${res}    银行子账户申请-主页
    字典关键字校验    ${res}    isCanApplication    True

存在子账户中国银行-响应标识为True
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
    ${res}    银行子账户申请-主页
    字典关键字校验    ${res}    isCanApplication    True

存在子账户非中国银行-响应标识为False
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
    ${res}    银行子账户申请-主页
    字典关键字校验    ${res}    isCanApplication    False

存在子账户中国银行存在处理中申请-响应标识为False
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
    ${res}    银行子账户申请-主页
    字典关键字校验    ${res}    isCanApplication    False

Token的key为空
    ${header}    create dictionary    Content-Type=application/json
    ${res}    银行子账户申请-主页    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]

Token的value为空
    ${header}    create dictionary    Content-Type=application/json    Authorization=
    ${res}    银行子账户申请-主页    ${header}
    字典关键字校验    ${res}    msg    &{err_msg}[token_null]
