*** Settings ***
Resource          ../../资金账户接口.robot

*** Test Cases ***
撤销-取款单
    ${field}    查询数据库    select a.order_id from (select *from withdrawal t where t.eddid_id='2f7634b7-25ae-4248-853e-8f9e9c1bed53')a order by a.created_date DESC ;
    ${order_id}    Search Dic KV    ${field}    order_id
    ${data}    Create Dictionary    orderId=${order_id}
    ${res}    撤销-取款单    ${data}
