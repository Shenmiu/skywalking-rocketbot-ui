# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash

# 执行指令后，会先显示该指令及所下的参数。
set -x

# 若指令传回值不等于0，则立即退出shell。
set -e

ngx_upstream_file="/etc/nginx/nginx.conf"

pool_name="skywalkingLB"

skywalking_collector=${SKYWALKING_URL}

#skywalking_collector=localhost:1234,127.0.0.1:1235

 #pool对应ip地址列表,多个ip以逗号改开
pool_ip=`awk 'BEGIN{list="'${skywalking_collector}'";split(list,ip_list,",");for(ip in ip_list){print ip_list[ip];}}'`
for ip in ${pool_ip[*]};do
    echo "add ${pool_name} ${ip} in ${ngx_upstream_file}"
    sed -i '/upstream '${pool_name}'[^-]*{/a\\server '${ip}';' ${ngx_upstream_file}
done
echo -e "\033[31m ====add nginx.conf :==== \033[0m"
cat $ngx_upstream_file