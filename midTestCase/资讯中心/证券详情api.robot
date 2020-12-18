*** Settings ***
Resource          ../程序功能.robot

*** Keywords ***
机构评级
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/agencyRating
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

资产负债列表
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/balanceLiabilityList
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

资产负债图表
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/balanceSheet
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

现金流量列表
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/cashflowList
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

现金流量图表
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/cashflowSheet
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

公司概况
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/companyProfile
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

分红送股详情
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/detailsOfDividend
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

综合损益图表
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/incomeSheet
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

最新研报
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/latestReport
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

主要指标列表
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/mainIndicatorList
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

主要指标图表
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/mainIndicatorSheet
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

综合损益列表
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/multipleIncomeList
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

产品地区分布
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/productRegionDist
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}

目标价预测
    [Arguments]    ${data}
    ${api}    Set Variable    /open/info/stock/detail/targetPriceForecast
    ${res}    POST请求    ${server_address}${api}    ${data}
    [Return]    ${res}
