# [PyPI - the Python Package Index](https://pypi.python.org/pypi)
# docker run -it --rm --name scrapy --link mysql:mysql -v "$PWD":/app rinetd/scrapy:2.7 "$@"
# Installing collected packages: idna, pyasn1, six, enum34, ipaddress, pycparser, cffi, cryptography, pyOpenSSL, queuelib, cssselect, lxml, attrs, pyasn1-modules, service-identity, w3lib, zope.interface, Twisted, PyDispatcher, parsel, scrapy
# Successfully installed PyDispatcher-2.0.5 Twisted-16.4.0 attrs-16.1.0 cffi-1.8.2 cryptography-1.5 cssselect-0.9.2 enum34-1.1.6 idna-2.1 ipaddress-1.0.16 lxml-3.6.4 parsel-1.0.3 pyOpenSSL-16.1.0 pyasn1-0.1.9 pyasn1-modules-0.0.8 pycparser-2.14 queuelib-1.4.2 scrapy-1.1.2 service-identity-16.0.0 six-1.10.0 w3lib-1.15.0 zope.interface-4.3.2
# pip install html5lib ::是一个 Ruby 和 Python 用来解析 HTML 文档的类库 https://github.com/html5lib/html5lib-python
# pip install beautifulsoup4 ::是一个处理Python HTML/XML的模块[](https://www.crummy.com/software/BeautifulSoup/bs4/doc.zh/)
# pip install html2text ::是一个Convert HTML to Markdown-formatted text 将html文件转成markdown文件
# pip install mysql-python  ::是一个ImportError: No module named MySQLdb `import MySQLdb`
# 图片库的支持  apt-get install libjpeg-dev libfreetype6-dev zlib1g-dev
# pip install Pillow  ::Pillow is the Python Imaging Library to support the ImagesPipeline.
FROM python:2.7

RUN set -xe \
    && pip install --upgrade pip  \
    && pip install scrapy

# RUN apt-get update && apt-get install -y python-mysqldb && rm -rf /var/lib/apt/lists/*

RUN set -xe \
    && pip install html5lib \
    && pip install beautifulsoup4

RUN set -xe \
    && pip install html2text \
    && pip install mysql-python

RUN groupadd -g 1000 user && \
    useradd -m -g user -u 1000 user

USER user
VOLUME /app
WORKDIR /app

ENTRYPOINT ["scrapy"]

CMD ["--help"]
