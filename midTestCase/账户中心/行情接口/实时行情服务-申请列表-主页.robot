*** Settings ***
Resource          ../行情接口.robot

*** Test Cases ***
实时行情服务-申请列表-主页
    ${res}    实时行情服务-申请列表-主页
    字典关键字校验    ${res}    msg    OK
