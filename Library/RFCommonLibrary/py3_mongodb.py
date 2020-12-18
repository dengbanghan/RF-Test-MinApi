# -*- coding: utf-8 -*-
# @Time    : 2020/7/15
# @Author  : Administrator
# @Email   : dengbanghan@gmail.com
# @File    : py3_mongodb.py
# @Software: PyCharm

from pymongo import MongoClient


class MongodDB(object):
    def loadMongoDBConfig(self, host, port, user_name, password, db_name, collection_name):
        print("Loading MongoDB Config：\nHost：{}\nPort：{}\nUserName：{}\nPassword：{}\nDatabase：{}\nCollection：{}".format(host, port, user_name, password, db_name, collection_name))
        #传入数据库IP和端口号
        client = MongoClient(host, port)
        # 指定连接testdb数据库
        db = client[db_name]

        try:
            # 通过authenticate方法认证账号密码
            db.authenticate(user_name,password)
            print("连接MongoDB成功,数据库名称：{}".format(client.list_database_names()))
            # print(client.server_info())     # 打印连接信息
        except Exception as e:
            print("MongoDB连接失败，错误：{}".format(e))

        try:
            # 指定操作集合
            self.collection = db[collection_name]
        except Exception as e:
            print("指定操作集合失败：{}".format(e))

    def find_many(self, data, data_field={}):
        """ data_field 是指输出 操作者需要的字段"""
        if len(data_field):
            res = self.collection.find(data, data_field)
        else:
            res = self.collection.find(data)
        return res