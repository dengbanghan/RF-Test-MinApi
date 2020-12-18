*** Settings ***
Library           Collections
Library           DateTime
Library           ../Library/RFCommonLibrary/

*** Keywords ***
字典关键字校验
    [Arguments]    ${dic}    ${key_word}    ${exp_value}
    ${act_value}    searchDicKV    ${dic}    ${key_word}
    Log    ==========字典校验${key_word}结果==========
    Log    实际值:${act_value}
    Log    预期值:${exp_value}
    Should Be Equal As Strings    ${act_value}    ${exp_value}
    Log    ==========字典校验${key_word}通过==========

两值校验
    [Arguments]    ${tiltle}    ${act_value}    ${exp_value}
    Log    ==========校验${tiltle}结果==========
    Log    实际值:${act_value}
    Log    预期值:${exp_value}
    Should Be Equal As Strings    ${act_value}    ${exp_value}
    Log    ==========校验${tiltle}通过==========

数据库字段校验
    [Arguments]    ${sql}    ${exp_value}    ${comment}    ${num}=1    ${second}=0.01
    Log    ==========数据库校验${comment}结果==========
    FOR    ${i}    IN RANGE    ${num}
        ${act_value}    checkSql    ${sql}
        ${x}    Evaluate    ${i}+1
        log    第${x}次校验
        Log    实际值:${act_value}
        Log    预期值:${exp_value}
        Exit For Loop If    "${act_value}"=="${exp_value}"
        sleep    ${second}s
        Should Be Equal As Strings    ${act_value}    ${exp_value}
    END
    Log    ==========数据库校验${comment}通过==========

数据库字段校验中文
    [Arguments]    ${sql}    ${exp_value}    ${comment}    ${num}=1    ${second}=0.01
    Log    ==========数据库校验${comment}结果==========
    FOR    ${i}    IN RANGE    ${num}
        ${act_value}    checkSqlUnicode    ${sql}
        ${x}    Evaluate    ${i}+1
        log    第${x}次校验
        Log    实际值:${act_value}
        Log    预期值:${exp_value}
        Exit For Loop If    "${act_value}"=="${exp_value}"
        sleep    ${second}s
        Should Be Equal As Strings    ${act_value}    ${exp_value}
    END
    Log    ==========数据库校验${comment}通过==========

数据库多条数据校验
    [Arguments]    ${sql}    ${exp_value}    ${comment}
    Log    ==========数据库校验${comment}结果==========
    ${sql_result}    getSqlMutilLine    ${sql}
    ${sql_result_length}    get length    ${sql_result}
    FOR    ${i}    IN RANGE    ${sql_result_length}
        ${sql_single}    Get List Index Value    ${sql_result}    ${i}
        ${exp_single}    Get List Index Value    ${exp_value}    ${i}
        ${exp_single_values}    Evaluate    ${exp_single}.values()
        ${exp_single_values_str}    Evaluate    [str(j) for j in ${exp_single_values}]
        Should Be True    set(${sql_single})==set(${exp_single_values_str})
    END
    Log    ==========数据库校验${comment}通过==========

从数组中校验值
    [Arguments]    ${list}    ${string}    ${key}    ${exp_value}    ${Comment}=${key}
    ${act_value}    getListValue    ${list}    ${string}    ${key}
    Log    ==========校验${Comment}结果==========
    Log    实际值:${act_value}
    Log    预期值:${exp_value}
    Should Be Equal As Strings    ${act_value}    ${exp_value}
    Log    ==========校验${Comment}通过==========
