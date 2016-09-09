# -*- coding: utf-8 -*-
import scrapy
from bs4 import BeautifulSoup
from scrapy import log
import threading
import MySQLdb
from datetime import date, timedelta
import re
from spider_news_all.items import SpiderNewsAllItem

class ZqrbSpider(scrapy.Spider):
    name = "zqrb"
    allowed_domains = ["zqrb.ccstock.cn"]
    start_urls = (
        'http://zqrb.ccstock.cn/html/2015-06/13/node_2.htm',
    )
    handle_httpstatus_list = [404]

    FLAG_INTERRUPT = False
    SELECT_NEWS_BY_TITLE_AND_URL = "SELECT * FROM news_all WHERE title='%s' AND url='%s'"

    lock = threading.RLock()
    conn=MySQLdb.connect(host='mysql',user='root', passwd='root', db='news', autocommit=True)
    conn.set_character_set('utf8')
    cursor = conn.cursor()
    cursor.execute('SET NAMES utf8;')
    cursor.execute('SET CHARACTER SET utf8;')
    cursor.execute('SET character_set_connection=utf8;')

    URL_TEMPLATE = 'http://zqrb.ccstock.cn/html/%s-%s/%s/node_2.htm'
    day = timedelta(1)
    now = date.today()

    def is_news_not_saved(self, title, url):
        if self.FLAG_INTERRUPT:
            self.lock.acquire()
            rows = self.cursor.execute(self.SELECT_NEWS_BY_TITLE_AND_URL % (title, url))
            if rows > 0:
                log.msg("News saved all finished.", level=log.INFO)
                return False
            else:
                return True
            self.lock.release()
        else:
            return True

    def parse_news(self, response):
        log.msg("Start to parse news " + response.url, level=log.INFO)
        item = SpiderNewsAllItem()
        day = title = _type = keywords = url = article = ''
        url = response.url
        day = response.meta['day']
        title = response.meta['title']
        response = response.body
        soup = BeautifulSoup(response)
        try:
            article = soup.find(id='ozoom').text.strip()
        except:
            log.msg("News " + title + " dont has article!", level=log.INFO)
        item['title'] = title
        item['day'] = day
        item['_type'] = _type
        item['url'] = url
        item['keywords'] = keywords
        item['article'] = article
        item['site'] = u'证券日报'
        return item

    def parse(self, response):
    	url = response.url
        url_base = url.split('node')[0]
        str_now = self.now.strftime('%Y%m%d')
        self.now = self.now - self.day
        next_parse = []
        if (str_now == '20070917'):
            pass
        else:
            if (self.now != (date.today() - self.day)) and (response.status == 200):
                try:
                    response = response.body
                    soup = BeautifulSoup(response)
                    items = soup.find_all(class_=re.compile('vote_content12px'))
                    for i in range(0, len(items)):
                        item_url = url_base + items[i]['href']
                        title = items[i].text.strip()
                        if not self.is_news_not_saved(title, item_url):
                            return next_parse
                        next_parse.append(self.make_requests_from_url(item_url).replace(callback=self.parse_news, meta={'day': (self.now + self.day).strftime('%Y%m%d'), 'title': title}))
                except:
                    log.msg("Page " + url + " parse error!", level=log.ERROR)
            _date = self.now.strftime('%Y%m%d')
            url = self.URL_TEMPLATE % (_date[0:4], _date[4:6], _date[6:8])
            log.msg("Start to parse page " + url, level=log.INFO)
            next_parse.append(self.make_requests_from_url(url))
            return next_parse
