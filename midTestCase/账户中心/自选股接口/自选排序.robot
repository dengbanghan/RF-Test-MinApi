*** Settings ***
Resource          ../自选股接口.robot

*** Test Cases ***
自选排序-置顶
    #批量添加自选
    ${code}    Create List    MCH2007    MCH2008    MCH2009    MCH2012
    ${name}    Create List    小国企指数2007    小国企指数2008    小国企指数2009    小国企指数2012
    ${res}    批量添加自选    ${code}    ${name}
    #查询自选获取数组中的no
    ${marketTab}    Set Variable    marketTab=FUTURE
    ${query}    查询自选    ${marketTab}
    ${datas}    Search Dic KV    ${query}    datas
    ${no_1}    Get List Index Value    ${datas}    2
    ${sourceNo}    Search Dic KV    ${no_1}    no
    #目标no为1
    ${targetNo}    Evaluate    int(0)
    ${data}    Create Dictionary    marketTab=ALL    sourceNo=${sourceNo}    targetNo=${0}
    ${data_List}    Create List    ${data}
    ${res}    自选排序    ${data_List}
    字典关键字校验    ${res}    msg    OK
