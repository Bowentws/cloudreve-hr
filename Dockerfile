FROM debian:stable-slim
ENV DEBIAN_FRONTEND noninteractive

ADD conf.ini /root/cloudreve/conf.ini
# 付费版需要下载许可证，删除下方的#
ADD key.bin /root/cloudreve/key.bin
ADD run.sh /root/cloudreve/run.sh
ADD aria2.conf /root/aria2/aria2.conf
ADD trackers-list-aria2.sh /root/aria2/trackers-list-aria2.sh
RUN apt-get update \
    && apt-get install wget curl aria2 sudo unzip -y

# 使用付费版,删除#号，普通版要加#
RUN wget -qO cloudreve.tar.gz https://link.jscdn.cn/sharepoint/aHR0cHM6Ly8wdnNzNi1teS5zaGFyZXBvaW50LmNvbS86dTovZy9wZXJzb25hbC9ib3dlbmJfMHZzczZfb25taWNyb3NvZnRfY29tL0VWQ3BwYmJkQ01CUHBoQkV1RHdfbW13QkRjaTZKaXNLZVR4dms1dzNGSFlPYVE_ZT1kOXZlQXM.gz \
    && wget -qO /root/aria2/dht.dat https://github.com/P3TERX/aria2.conf/raw/master/dht.dat \
    && wget -qO /root/aria2/dht6.dat https://github.com/P3TERX/aria2.conf/raw/master/dht6.dat


# 使用普通版，要使用付费版，普通版前要加#
#RUN wget -qO cloudreve.tar.gz https://github.com/aaro-n/file/raw/master/cloudreve/cloudreve.tar.gz
RUN ls -al /root/cloudreve
RUN ls -al
RUN sudo tar -xzvf /root/cloudreve/cloudreve.tar.gz -C /root/cloudreve
#RUN  cp cloudreve /root/cloudreve
RUN touch /root/aria2/aria2.session /root/aria2/aria2.log
RUN tar -zxvf cloudreve.tar.gz -C /root/cloudreve
RUN chmod +x /root/cloudreve/cloudreve \
    && chmod +x /root/cloudreve/run.sh \
    && chmod +x /root/cloudreve/run.sh
RUN mkdir -p /root/Download
CMD /root/cloudreve/run.sh
