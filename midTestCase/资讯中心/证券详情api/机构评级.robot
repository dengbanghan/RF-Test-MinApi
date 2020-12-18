*** Settings ***
Resource          ../证券详情api.robot
Resource          stock_parameter.robot

*** Test Cases ***
港股-评级数量-6个月内-买入
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    买入
    Comment    评级占比判断    ${res}    6    ${securityCode}

港股-评级数量-6个月内-增持
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    增持

港股-评级数量-6个月内-中性
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    中性

港股-评级数量-6个月内-减持
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    减持

港股-评级数量-6个月内-卖出
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    卖出

港股-评级数量-3个月内-买入
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    买入
    Comment    评级占比判断    ${res}    6    ${securityCode}

港股-评级数量-3个月内-增持
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    增持

港股-评级数量-3个月内-中性
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    中性

港股-评级数量-3个月内-减持
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    减持

港股-评级数量-3个月内-卖出
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    卖出

港股-评级数量-1个月内-买入
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    买入
    Comment    评级占比判断    ${res}    6    ${securityCode}

港股-评级数量-1个月内-增持
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    增持

港股-评级数量-1个月内-中性
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    中性

港股-评级数量-1个月内-减持
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    减持

港股-评级数量-1个月内-卖出
    ${securityCode}    Set Variable    &{securityCode}[HK_STOCK]
    ${data}    Create Dictionary    marketType=HK_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    卖出

美股-评级数量-6个月内-买入
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    买入
    Comment    评级占比判断    ${res}    6    ${securityCode}

美股-评级数量-6个月内-增持
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    增持

美股-评级数量-6个月内-中性
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    中性

美股-评级数量-6个月内-减持
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    减持

美股-评级数量-6个月内-卖出
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    卖出

美股-评级数量-3个月内-买入
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    买入
    Comment    评级占比判断    ${res}    6    ${securityCode}

美股-评级数量-3个月内-增持
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    增持

美股-评级数量-3个月内-中性
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    中性

美股-评级数量-3个月内-减持
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    减持

美股-评级数量-3个月内-卖出
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    卖出

美股-评级数量-1个月内-买入
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    买入
    Comment    评级占比判断    ${res}    6    ${securityCode}

美股-评级数量-1个月内-增持
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    增持

美股-评级数量-1个月内-中性
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    中性

美股-评级数量-1个月内-减持
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    减持

美股-评级数量-1个月内-卖出
    ${securityCode}    Set Variable    &{securityCode}[US_STOCK]
    ${data}    Create Dictionary    marketType=US_STOCK    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    卖出

港期-评级数量-6个月内-买入
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    买入
    Comment    评级占比判断    ${res}    6    ${securityCode}

港期-评级数量-6个月内-增持
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    增持

港期-评级数量-6个月内-中性
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    中性

港期-评级数量-6个月内-减持
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    减持

港期-评级数量-6个月内-卖出
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    卖出

港期-评级数量-3个月内-买入
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    买入
    Comment    评级占比判断    ${res}    6    ${securityCode}

港期-评级数量-3个月内-增持
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    增持

港期-评级数量-3个月内-中性
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    中性

港期-评级数量-3个月内-减持
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    减持

港期-评级数量-3个月内-卖出
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    卖出

港期-评级数量-1个月内-买入
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    买入
    Comment    评级占比判断    ${res}    6    ${securityCode}

港期-评级数量-1个月内-增持
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    增持

港期-评级数量-1个月内-中性
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    中性

港期-评级数量-1个月内-减持
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    减持

港期-评级数量-1个月内-卖出
    ${securityCode}    Set Variable    &{securityCode}[HK_FUTURES]
    ${data}    Create Dictionary    marketType=HK_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    卖出

外期-评级数量-6个月内-买入
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    买入
    Comment    评级占比判断    ${res}    6    ${securityCode}

外期-评级数量-6个月内-增持
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    增持

外期-评级数量-6个月内-中性
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    中性

外期-评级数量-6个月内-减持
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    减持

外期-评级数量-6个月内-卖出
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    卖出

外期-评级数量-3个月内-买入
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    6    ${securityCode}    买入
    Comment    评级占比判断    ${res}    6    ${securityCode}

外期-评级数量-3个月内-增持
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    增持

外期-评级数量-3个月内-中性
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    中性

外期-评级数量-3个月内-减持
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    减持

外期-评级数量-3个月内-卖出
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    3    ${securityCode}    卖出

外期-评级数量-1个月内-买入
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    买入
    Comment    评级占比判断    ${res}    6    ${securityCode}

外期-评级数量-1个月内-增持
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    增持

外期-评级数量-1个月内-中性
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    中性

外期-评级数量-1个月内-减持
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    减持

外期-评级数量-1个月内-卖出
    ${securityCode}    Set Variable    &{securityCode}[GLOBAL_FUTURES]
    ${data}    Create Dictionary    marketType=GLOBAL_FUTURES    securityCode=${securityCode}
    ${res}    机构评级    ${data}
    字典关键字校验    ${res}    msg    OK
    评级数量判断    ${res}    1    ${securityCode}    卖出

*** Keywords ***
评级数量判断
    [Arguments]    ${res}    ${month}    ${securityCode}    ${sratingname}
    [Documentation]    3个参数：
    ...    1. ${res} 请求返回的所有参数；
    ...    2. ${month} 查询的月份数；
    ...    3. ${securityCode} 股票代码；
    ...    4. ${sratingname} 评级名称，可选：买入、增持、中性、减持、卖出
    ${agencyNum_rsp}    searchDicKV    ${res}    agencyNum
    ${month_index}    Run Keyword If    '${month}'=='6'    Set Variable    0
    ...    ELSE IF    '${month}'=='3'    Set Variable    1
    ...    ELSE IF    '${month}'=='1'    Set Variable    2
    ${months}    Set Variable    ${agencyNum_rsp}[${month_index}]
    ${sratingnames}    Run Keyword If    '${sratingname}'=='买入'    Set Variable    买入|Buy
    ...    ELSE    Set Variable    ${sratingname}
    ${srating_index}    Run Keyword If    '${sratingname}'=='买入'    Set Variable    0
    ...    ELSE IF    '${sratingname}'=='增持'    Set Variable    1
    ...    ELSE IF    '${sratingname}'=='中性'    Set Variable    2
    ...    ELSE IF    '${sratingname}'=='减持'    Set Variable    3
    ...    ELSE IF    '${sratingname}'=='卖出'    Set Variable    4
    ${srating}    查询数据库    SELECT COUNT(*) FROM &{db_conf}[db_dc_hi].&{db_conf}[tb_basinfo] WHERE SECURITYCODE='${securityCode}' AND SRATINGNAME regexp '${sratingnames}' AND \ REPORTDATE>=(SELECT DATE_ADD(CURDATE(), INTERVAL -${month} MONTH) FROM DUAL);
    ${agencyNum_sql}    searchDicKV    ${srating}    COUNT(*)
    两值校验    近${month}个月${sratingname}评级    ${months}[${srating_index}]    ${agencyNum_sql}

评级占比判断
    [Arguments]    ${res}    ${month}    ${securityCode}
    [Documentation]    3个参数：
    ...    1. ${res} 请求返回的所有参数；
    ...    2. ${month} 查询的月份数；
    ...    3. ${securityCode} 股票代码；
    ${agencyRatio_rsp}    searchDicKV    ${res}    agencyRatio
    ${month_index}    Run Keyword If    '${month}'=='6'    Set Variable    0
    ...    ELSE IF    '${month}'=='3'    Set Variable    1
    ...    ELSE IF    '${month}'=='1'    Set Variable    2
    ${months}    Set Variable    ${agencyRatio_rsp}[${month_index}]
    ${sratingname_list}    Create List    买入    增持    中性    减持    卖出
    ${list_length}    Evaluate    len(${sratingname_list})
    ${total}    查询数据库    SELECT COUNT(*) FROM &{db_conf}[db_dc_hi].&{db_conf}[tb_basinfo] WHERE SECURITYCODE='${securityCode}' AND SRATINGNAME is not Null AND REPORTDATE>=(SELECT DATE_ADD(CURDATE(), INTERVAL -${month} MONTH) FROM DUAL);
    FOR    ${i}    IN RANGE    ${list_length}
        ${srating}    查询数据库    SELECT COUNT(*) FROM &{db_conf}[db_dc_hi].&{db_conf}[tb_basinfo] WHERE SECURITYCODE='${securityCode}' AND SRATINGNAME LIKE '%${sratingname_list}[${i}]%' AND \ REPORTDATE>=(SELECT DATE_ADD(CURDATE(), INTERVAL -${month} MONTH) FROM DUAL);
        ${agencyRatio_sql}    searchDicKV    ${srating}    COUNT(*)
        两值校验    近${month}个月${sratingname_list}[${i}]评级    ${months}[${i}]    ${agencyRatio_sql}
    END
