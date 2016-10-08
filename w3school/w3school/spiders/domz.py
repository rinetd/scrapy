# -*- coding: utf-8 -*-
import scrapy


class DomzSpider(scrapy.Spider):
    name = "domz"
    allowed_domains = ["domz.com"]
    start_urls = (
        'http://www.domz.com/',
    )

    def parse(self, response):
        pass
