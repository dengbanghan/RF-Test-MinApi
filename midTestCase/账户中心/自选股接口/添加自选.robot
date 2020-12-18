*** Settings ***
Resource          ../自选股接口.robot
Resource          ../../业务参数.robot

*** Test Cases ***
添加自选-成功添加
    ${code_input}    Set Variable    MCH2012
    ${data}    Create Dictionary    code=${code_input}    name=小国企指数2012    exchangeType=&{optional}[exchangeType]    marketTab=&{optional}[marketTab]    marketType=&{optional}[marketType]
    ${res}    添加自选    ${data}
    ${marketTab}    Set Variable    marketTab=FUTURE
    ${query}    查询自选    ${marketTab}
    ${datas}    searchDicKV    ${query}    datas
    ${code}    getListIndexValue    ${datas}    0
    字典关键字校验    ${code}    code    ${code_input}

添加自选-添加失败-code-key为空
    ${data}    Create Dictionary    name=国企指数2009    exchangeType=&{optional}[exchangeType]    marketTab=&{optional}[marketTab]    marketType=&{optional}[marketType]
    ${res}    添加自选    ${data}
    字典关键字校验    ${res}    data    None

添加自选-添加失败-code-value为空
    ${data}    Create Dictionary    code=    name=国企指数2009    exchangeType=&{optional}[exchangeType]    marketTab=&{optional}[marketTab]    marketType=&{optional}[marketType]
    ${res}    添加自选    ${data}
    字典关键字校验    ${res}    data    None

添加自选-添加失败-exchangeType-key为空
    ${code_input}    Set Variable    HHI2009
    ${data}    Create Dictionary    code=${code_input}    name=国企指数2009    marketTab=&{optional}[marketTab]    marketType=&{optional}[marketType]
    ${res}    添加自选    ${data}
    字典关键字校验    ${res}    data    None

添加自选-添加失败-exchangeType-value为空
    ${code_input}    Set Variable    HHI2009
    ${data}    Create Dictionary    code=${code_input}    name=国企指数2009    exchangeType=    marketTab=&{optional}[marketTab]    marketType=&{optional}[marketType]
    ${res}    添加自选    ${data}
    字典关键字校验    ${res}    data    None

添加自选-添加失败-marketTab-key为空
    ${code_input}    Set Variable    HHI2009
    ${data}    Create Dictionary    code=${code_input}    name=国企指数2009    exchangeType=&{optional}[exchangeType]    marketType=&{optional}[marketType]
    ${res}    添加自选    ${data}
    字典关键字校验    ${res}    data    None

添加自选-添加失败-marketTab-value为空
    ${code_input}    Set Variable    HHI2009
    ${data}    Create Dictionary    code=${code_input}    name=国企指数2009    exchangeType=&{optional}[exchangeType]    marketType=&{optional}[marketType]    marketTab=
    ${res}    添加自选    ${data}
    字典关键字校验    ${res}    data    None

添加自选-添加失败-name-key为空
    ${code_input}    Set Variable    HHI2009
    ${data}    Create Dictionary    code=${code_input}    exchangeType=&{optional}[exchangeType]    marketTab=&{optional}[marketTab]    marketType=&{optional}[marketType]
    ${res}    添加自选    ${data}
    字典关键字校验    ${res}    data    None

添加自选-添加失败-name-value为空
    ${code_input}    Set Variable    HHI2009
    ${data}    Create Dictionary    code=${code_input}    name=    exchangeType=&{optional}[exchangeType]    marketTab=&{optional}[marketTab]    marketType=&{optional}[marketType]
    ${res}    添加自选    ${data}
    字典关键字校验    ${res}    data    None

添加自选-非必要参数key为空
    ${code_input}    Set Variable    HHI2009
    ${data}    Create Dictionary    code=${code_input}    name=国企指数2009    exchangeType=&{optional}[exchangeType]    marketTab=&{optional}[marketTab]
    ${res}    添加自选    ${data}
    ${marketTab}    Set Variable    marketTab=FUTURE
    ${query}    查询自选    ${marketTab}
    ${datas}    searchDicKV    ${query}    datas
    ${code}    getListIndexValue    ${datas}    0
    字典关键字校验    ${code}    code    ${code_input}
