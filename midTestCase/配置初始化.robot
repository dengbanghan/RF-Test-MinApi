*** Settings ***
Resource          程序功能.robot

*** Keywords ***
初始化认证中心数据
    [Arguments]    ${authMode}=code    ${phone_num}=${new_phone_num}    ${device_id}=${new_device_id}
    [Documentation]    不填写入参时，默认会注册一个新的手机号码，默认会送随机的手机号码和随机的设备ID；
    ...    ${authMode}=passwd时，会读取配置文件里的手机号码；
    log    ==========初始化认证中心数据开始==========
    ${auth_server_address}    Set Variable    &{auth}[server_address]
    ${auth_info}    Set Variable    &{auth}[auth_info]
    Set Global Variable    ${auth_server_address}
    Set Global Variable    ${auth_info}
    ${access_token}    Run Keyword If    '${authMode}'=='passwd'    获取Token-登录密码
    ...    ELSE IF    '${authMode}'=='code'    手机号注册    ${phone_num}    ${device_id}
    Set Global Variable    ${access_token}
    ${eddid_id}    获取Eddid_id    ${phone_num}
    Set Global Variable    ${eddid_id}
    log    认证中心请求地址：${auth_server_address}
    log    eddid_id：${eddid_id}
    log    ==========初始化认证中心数据完成==========

初始化MySQL数据库
    log    ==========初始化MySQL数据库开始==========
    ${mysql_host}    Set Variable    &{config}[mysql_host]
    ${mysql_port}    Set Variable    &{config}[mysql_port]
    ${mysql_user}    Set Variable    &{config}[mysql_user]
    ${mysql_pwd}    Set Variable    &{config}[mysql_pwd]
    ${mysql_db}    Set Variable    &{config}[mysql_db]
    Set Global Variable    ${mysql_host}
    Set Global Variable    ${mysql_port}
    Set Global Variable    ${mysql_user}
    Set Global Variable    ${mysql_pwd}
    Set Global Variable    ${mysql_db}
    配置MySQL数据库    ${mysql_host}    ${mysql_port}    ${mysql_user}    ${mysql_pwd}    ${mysql_db}
    log    ==========初始化MySQL数据库完成==========

初始化默认header
    log    ==========初始化默认header开始==========
    ${header_default}    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${access_token}
    Set Global Variable    ${header_default}
    log    ==========初始化默认header完成==========

初始化MongoDB数据库
    log    ==========初始化MongoDB数据库开始==========
    ${mongodb_host}    Set Variable    &{mongodb}[host]
    ${mongodb_port}    Set Variable    &{mongodb}[port]
    ${mongodb_user}    Set Variable    &{mongodb}[user_name]
    ${mongodb_pwd}    Set Variable    &{mongodb}[password]
    ${mongodb_db}    Set Variable    &{mongodb}[db_name]
    ${collection_name}    Set Variable    &{mongodb}[collection_name]
    Set Global Variable    ${mongodb_host}
    Set Global Variable    ${mongodb_port}
    Set Global Variable    ${mongodb_user}
    Set Global Variable    ${mongodb_pwd}
    Set Global Variable    ${mongodb_db}
    Set Global Variable    ${collection_name}
    配置MongoDB数据库    ${mongodb_host}    ${mongodb_port}    ${mongodb_user}    ${mongodb_pwd}    ${mongodb_db}    ${collection_name}
    log    ==========初始化MongoDB数据库完成==========
