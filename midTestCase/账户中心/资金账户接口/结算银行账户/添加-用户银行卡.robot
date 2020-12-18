*** Settings ***
Resource          ../../资金账户接口.robot

*** Test Cases ***
添加-用户银行卡-提交来源-入参为正确
    ${submitSource_list}    Create List    CP_H5    CP_WEB    CRM    UNKNOWN_SOURCE
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from settlement_account_images where id =(SELECT id from settlement_account where eddid_id='${eddid_id}')
        执行sql语句    delete from settlement_account where eddid_id='${eddid_id}';
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${images}    Create List    1
        ${data1}    Create Dictionary    images=${images}    bankAccount=2020072701    bankName=招商银行    currency=HKD
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    添加-用户银行卡    ${data}
        字典关键字校验    ${res}    msg    OK
    END

添加-用户银行卡-提交来源-入参为错误
    ${submitSource_list}    Create List    \    UNKNOWN
    ${list_length}    Evaluate    len(${submitSource_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${submitSource}    Set Variable    ${submitSource_list}[${i}]
        ${images}    Create List    1
        ${data1}    Create Dictionary    images=${images}    bankAccount=2020072701    bankName=招商银行    currency=HKD
        ${data}    Set To Dictionary    ${data1}    submitSource=${submitSource}
        ${res}    添加-用户银行卡    ${data}
        字典关键字校验    ${res}    msg    &{errMsg}[null]
    END

添加-用户银行卡-提交来源key为空
    ${images}    Create List    1
    ${data}    Create Dictionary    images=${images}    bankAccount=2020072701    bankName=招商银行    currency=HKD
    ${res}    添加-用户银行卡    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

添加-用户银行卡-提交来源value为空
    ${images}    Create List    1
    ${data}    Create Dictionary    images=${images}    submitSource=    bankAccount=2020072701    bankName=招商银行    currency=HKD
    ${res}    添加-用户银行卡    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

添加-用户银行卡-货币-入参为正确
    ${currency_list}    Create List    HKD    USD    CNY    EUR    JPY    AUD    CAD    CHF    CNH    MYR    SGD    TWD
    ${list_length}    Evaluate    len(${currency_list})
    FOR    ${i}    IN RANGE    ${list_length}
        执行sql语句    delete from settlement_account_images where id =(SELECT id from settlement_account where eddid_id='${eddid_id}')
        执行sql语句    delete from settlement_account where eddid_id='${eddid_id}';
        ${currency}    Set Variable    ${currency_list}[${i}]
        ${images}    Create List    1
        ${data1}    Create Dictionary    images=${images}    bankAccount=2020072701    bankName=招商银行    currency=HKD    submitSource=CP_H5
        ${data}    Set To Dictionary    ${data1}    currency=${currency}
        ${res}    添加-用户银行卡    ${data}
        字典关键字校验    ${res}    msg    OK
    END

添加-用户银行卡-货币-入参为错误
    ${currency_list}    Create List    \    TT
    ${list_length}    Evaluate    len(${currency_list})
    FOR    ${i}    IN RANGE    ${list_length}
        ${currency}    Set Variable    ${currency_list}[${i}]
        ${images}    Create List    1
        ${data1}    Create Dictionary    images=${images}    bankAccount=2020072701    bankName=招商银行    currency=HKD    submitSource=CP_H5
        ${data}    Set To Dictionary    ${data1}    currency=${currency}
        ${res}    添加-用户银行卡    ${data}
        字典关键字校验    ${res}    msg    &{errMsg}[null]
    END

添加-用户银行卡-货币key为空
    ${images}    Create List    1
    ${data}    Create Dictionary    images=${images}    bankAccount=2020072701    bankName=招商银行    submitSource=CP_H5
    ${res}    添加-用户银行卡    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

添加-用户银行卡-货币value为空
    ${images}    Create List    1
    ${data}    Create Dictionary    images=${images}    bankAccount=2020072701    bankName=招商银行    currency=    submitSource=CP_H5
    ${res}    添加-用户银行卡    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

添加-用户银行卡-银行证明照片key为空
    ${data}    Create Dictionary    submitSource=CP_H5    bankAccount=2020072201    bankName=招商银行    currency=HKD
    ${res}    添加-用户银行卡    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

添加-用户银行卡-银行证明照片value为空
    ${data}    Create Dictionary    submitSource=CP_H5    images=    bankAccount=2020072201    bankName=招商银行    currency=HKD
    ${res}    添加-用户银行卡    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

添加-用户银行卡-银行名称-不存在的
    ${images}    Create List    1
    ${data}    Create Dictionary    submitSource=CP_H5    images=${images}    bankAccount=2020072201    currency=HKD    bankName=平安银行
    ${res}    添加-用户银行卡    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

添加-用户银行卡-银行名称key为空
    ${images}    Create List    1
    ${data}    Create Dictionary    submitSource=CP_H5    images=${images}    bankAccount=2020072201    currency=HKD
    ${res}    添加-用户银行卡    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

添加-用户银行卡-银行名称value为空
    ${images}    Create List    1
    ${data}    Create Dictionary    submitSource=CP_H5    images=${images}    bankAccount=2020072201    bankName=    currency=HKD
    ${res}    添加-用户银行卡    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

添加-用户银行卡-银行账户-不存在
    ${images}    Create List    1
    ${data}    Create Dictionary    submitSource=CP_H5    images=${images}    bankName=招商银行    currency=HKD    bankAccount=20200728001
    ${res}    添加-用户银行卡    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

添加-用户银行卡-银行账户key为空
    ${images}    Create List    1
    ${data}    Create Dictionary    submitSource=CP_H5    images=${images}    bankName=招商银行    currency=HKD
    ${res}    添加-用户银行卡    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

添加-用户银行卡-银行账户value为空
    ${images}    Create List    1
    ${data}    Create Dictionary    submitSource=CP_H5    images=${images}    bankAccount=    bankName=招商银行    currency=HKD
    ${res}    添加-用户银行卡    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[null]

添加-用户银行卡-Token的key为空
    ${header}    Create Dictionary    Content-Type=application/json
    ${images}    Create List    1
    ${data}    Create Dictionary    images=${images}    submitSource=CP_H5    bankAccount=2020072701    bankName=招商银行    currency=HKD
    ${res}    添加-用户银行卡    ${data}    ${header}
    字典关键字校验    ${res}    msg    &{errMsg}[token_null]

添加-用户银行卡-Token的value为空
    ${header}    Create Dictionary    Content-Type=application/json    Authorization=
    ${images}    Create List    1
    ${data}    Create Dictionary    images=${images}    submitSource=CP_H5    bankAccount=2020072701    bankName=招商银行    currency=HKD
    ${res}    添加-用户银行卡    ${data}    ${header}
    字典关键字校验    ${res}    msg    &{errMsg}[token_null]

添加-用户银行卡-重复提交
    执行sql语句    delete from settlement_account_images where id =(SELECT id from settlement_account where eddid_id='${eddid_id}')
    执行sql语句    delete from settlement_account where eddid_id='${eddid_id}';
    ${images}    Create List    1
    ${data}    Create Dictionary    images=${images}    submitSource=CP_H5    bankAccount=2020072701    bankName=招商银行    currency=HKD
    ${res}    添加-用户银行卡    ${data}
    字典关键字校验    ${res}    msg    &{errMsg}[business_repeat]
