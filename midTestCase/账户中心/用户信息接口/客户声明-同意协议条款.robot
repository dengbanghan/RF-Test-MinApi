*** Settings ***
Resource          ../用户信息接口.robot

*** Test Cases ***
同意协议条款-type为PRIVACY_POLICY
    ${type}    Set Variable    PRIVACY_POLICY
    ${data}    Create Dictionary    type=${type}
    ${res}    客户声明-同意协议条款    ${data}
    数据库字段校验    select a.eddid_id,a.clause_code,a.status from agreement a where a.eddid_id='${eddid_id}';    ${eddid_id}|PRIVACY_POLICY|AGREE|    comment

同意协议条款-type为DARK_POOL
    ${type}    Set Variable    DARK_POOL
    ${data}    Create Dictionary    type=${type}
    ${res}    客户声明-同意协议条款    ${data}
    数据库字段校验    select a.eddid_id,a.clause_code,a.status from agreement a where a.eddid_id='${eddid_id}';    ${eddid_id}|DARK_POOL|AGREE|    comment

同意协议条款-type为CUSTOMER_STATEMENT
    ${type}    Set Variable    CUSTOMER_STATEMENT
    ${data}    Create Dictionary    type=${type}
    ${res}    客户声明-同意协议条款    ${data}
    数据库字段校验    select a.eddid_id,a.clause_code,a.status from agreement a where a.eddid_id='${eddid_id}';    ${eddid_id}|CUSTOMER_STATEMENT|AGREE|    comment

同意协议条款-type为任意值
    ${type}    Set Variable    aaa
    ${data}    Create Dictionary    type=${type}
    ${res}    客户声明-同意协议条款    ${data}
    字典关键字校验    ${res}    data    None

同意协议条款-type-key为空
    ${type}    Set Variable
    ${data}    Create Dictionary    type=${type}
    ${res}    客户声明-同意协议条款    ${data}
    字典关键字校验    ${res}    data    None

同意协议条款-type-value为空
    ${type}    Set Variable    CUSTOMER_STATEMENT
    ${data}    Create Dictionary    type=
    ${res}    客户声明-同意协议条款    ${data}
    字典关键字校验    ${res}    data    None
