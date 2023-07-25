FROM debian:stable-slim

ADD conf.ini /root/cloudreve/conf.ini
# 付费版需要下载许可证，删除下方的#
ADD key.bin /root/cloudreve/key.bin
ADD run.sh /root/cloudreve/run.sh
ADD aria2.conf /root/aria2/aria2.conf
ADD trackers-list-aria2.sh /root/aria2/trackers-list-aria2.sh
RUN apt-get update \
    && apt-get install wget curl aria2 -y

# 使用付费版,删除#号，普通版要加#
RUN wget -qO cloudreve.tar.gz https://link.jscdn.cn/sharepoint/aHR0cHM6Ly8wdnNzNi1teS5zaGFyZXBvaW50LmNvbS86dTovZy9wZXJzb25hbC9ib3dlbmJfMHZzczZfb25taWNyb3NvZnRfY29tL0VWQ3BwYmJkQ01CUHBoQkV1RHdfbW13QkRjaTZKaXNLZVR4dms1dzNGSFlPYVE_ZT1kOXZlQXM.gz
RUN wget -qO /root/aria2/dht.dat https://github.com/P3TERX/aria2.conf/raw/master/dht.dat
RUN wget -qO /root/aria2/dht6.dat https://github.com/P3TERX/aria2.conf/raw/master/dht6.dat
    
# 使用普通版，要使用付费版，普通版前要加#
#RUN wget -qO cloudreve.tar.gz https://github.com/aaro-n/file/raw/master/cloudreve/cloudreve.tar.gz
    
RUN tar -zxvf cloudreve.tar.gz -C /root/cloudreve
RUN chmod +x /root/cloudreve/cloudreve
RUN chmod +x /root/cloudreve/run.sh
RUN chmod +x /root/cloudreve/run.sh
RUN mkdir -p /root/Download
CMD /root/cloudreve/run.sh
