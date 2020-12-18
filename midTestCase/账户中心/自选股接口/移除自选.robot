*** Settings ***
Resource          ../自选股接口.robot

*** Test Cases ***
移除自选-成功移除
    # 第一步添加自选
    ${code_input}    Set Variable    HSI2009
    ${data}    Create Dictionary    code=${code_input}    name=恒生指数2009    exchangeType=&{optional}[exchangeType]    marketTab=&{optional}[marketTab]    marketType=&{optional}[marketType]
    ${res}    添加自选    ${data}
    # 第二步查询自选获取no
    ${marketTab}    Set Variable    marketTab=FUTURE
    ${query}    查询自选    ${marketTab}
    ${datas}    searchDicKV    ${query}    datas
    ${no_0}    getListIndexValue    ${datas}    0
    ${no}    searchDicKV    ${no_0}    no
    # 第三步移除自选
    ${res}    移除自选    ${no}
    字典关键字校验    ${res}    msg    OK
    [Teardown]
