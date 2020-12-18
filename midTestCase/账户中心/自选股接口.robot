*** Settings ***
Resource          ../程序功能.robot

*** Keywords ***
查询自选
    [Arguments]    ${marketTab}
    ${api}    Set Variable    /open/account/eddid/optional/query?${marketTab}
    ${res}    GET请求    ${server_address}${api}
    [Return]    ${res}

添加自选
    [Arguments]    ${data}
    ${api}    Set Variable    /open/account/eddid/optional/add
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

移除自选
    [Arguments]    ${no}
    Comment    ${no}    Set Variable    2274
    Comment    ${query}    查询自选
    Comment    ${datas}    Search Dic KV    ${query}    datas
    Comment    ${no}    Get List Index Value    ${datas}    0
    ${api}    Set Variable    /open/account/eddid/optional/remove?no=${no}
    ${res}    GET请求    ${server_address}${api}
    [Return]    ${res}

自选排序
    [Arguments]    ${data}
    ${api}    Set Variable    /open/account/eddid/optional/permute
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

查询默认自选
    [Arguments]    ${marketTab}
    ${api}    Set Variable    /open/account/eddid/optional/queryDefault?${marketTab}
    ${res}    GET请求    ${server_address}${api}
    [Return]    ${res}

批量添加自选
    [Arguments]    ${code}    ${name}
    [Documentation]    入参为两个list类型，参考如下：
    ...    ${code} Create List HHI2007 HHI2008
    ...    ${name} Create List 国企指数2007 国企指数2008
    ${list_length}    Evaluate    len(${code})
    FOR    ${i}    IN RANGE    ${list_length}
        ${data}    Create Dictionary    code=${code}[${i}]    name=${name}[${i}]    exchangeType=&{optional}[exchangeType]    marketTab=&{optional}[marketTab]    marketType=&{optional}[marketType]
        ${res}    添加自选    ${data}
    END
    log    ${res}
