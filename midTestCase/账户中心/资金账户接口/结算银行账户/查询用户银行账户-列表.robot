*** Test Cases ***
查询用户银行账户-列表
    执行sql语句    delete from settlement_account_images where id =(SELECT id from settlement_account where eddid_id='${eddid_id}')
    执行sql语句    delete from settlement_account where eddid_id='${eddid_id}';
    ${images}    Create List    1
    ${data}    Create Dictionary    images=${images}    bankAccount=2020072701    bankName=招商银行    currency=HKD    submitSource=CP_H5
    ${res}    添加-用户银行卡    ${data}
    执行sql语句    update account_center_db.settlement_account \ set status='SUCCESS' where eddid_id='${eddid_id}';
    ${res}    查询用户银行账户-列表
    字典关键字校验    ${res}    msg    OK

查询用户银行账户-列表-Token的value为空
    ${header}    Create Dictionary    Content-Type=application/json    Authorization=
    ${res}    查询用户银行账户-列表    ${header}
    字典关键字校验    ${res}    msg    &{errMsg}[token_null]

查询用户银行账户-列表-Token的key为空
    ${header}    Create Dictionary    Content-Type=application/json
    ${res}    查询用户银行账户-列表    ${header}
    字典关键字校验    ${res}    msg    &{errMsg}[token_null]
