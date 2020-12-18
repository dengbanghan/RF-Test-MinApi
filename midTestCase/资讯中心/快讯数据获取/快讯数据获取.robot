*** Settings ***
Resource          ../快讯数据获取.robot

*** Test Cases ***
快讯数据获取-非必要参数key为空
    ${data}    Create Dictionary    apiType=news-qh
    ${res}    快讯数据获取    ${data}
    字典关键字校验    ${res}    msg    OK

快讯数据获取-非必要参数value为空
    ${category}    Create List
    ${data}    Create Dictionary    apiType=news-qh    category=${category}    country=CN    data_type=    date=    indicator_id=    limit=    max_time=    min_time=    offset=
    ${res}    快讯数据获取    ${data}
    字典关键字校验    ${res}    msg    OK

快讯数据获取-apiType为news-qh
    ${data}    Create Dictionary    apiType=news-qh
    ${res}    快讯数据获取    ${data}
    字典关键字校验    ${res}    msg    OK

快讯数据获取-apiType为news-hkus
    ${data}    Create Dictionary    apiType=news-hkus
    ${res}    快讯数据获取    ${data}
    字典关键字校验    ${res}    msg    OK

快讯数据获取-apiType的key值为空
    ${data}    Create Dictionary
    ${res}    快讯数据获取    ${data}
    字典关键字校验    ${res}    msg    &{err_msg}[null]

快讯数据获取-apiType的value值为空
    ${data}    Create Dictionary    apiType=
    ${res}    快讯数据获取    ${data}
    字典关键字校验    ${res}    msg    &{err_msg}[null]
