*** Test Cases ***
（用户）银行卡添加记录-列表
    ${images}    Create List    1
    ${data}    Create Dictionary    images=${images}    bankAccount=2020072701    bankName=招商银行    currency=HKD    submitSource=CP_H5
    ${res}    （用户）银行卡添加记录-列表
    字典关键字校验    ${res}    msg    OK

（用户）银行卡添加记录-列表-Token的value为空
    ${header}    Create Dictionary    Content-Type=application/json    Authorization=
    ${images}    Create List    1
    ${data}    Create Dictionary    images=${images}    bankAccount=2020072701    bankName=招商银行    currency=HKD    submitSource=CP_H5
    ${res}    （用户）银行卡添加记录-列表    ${header}
    字典关键字校验    ${res}    msg    &{errMsg}[token_null]

（用户）银行卡添加记录-列表-Token的key为空
    ${header}    Create Dictionary    Content-Type=application/json
    ${images}    Create List    1
    ${data}    Create Dictionary    images=${images}    bankAccount=2020072701    bankName=招商银行    currency=HKD    submitSource=CP_H5
    ${res}    （用户）银行卡添加记录-列表    ${header}
    字典关键字校验    ${res}    msg    &{errMsg}[token_null]
