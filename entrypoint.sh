#!/bin/bash

# 定义域名数组
domains=("todolist.jimmy512.com" "nuxt3-intro.jimmy512.com" "main-sql.jimmy512.com")

# 循环遍历域名数组
for domain in "${domains[@]}"; do
    echo "Processing domain: $domain"
    
    # 检查证书是否存在，如果不存在则尝试获取
    if [ ! -f "/etc/letsencrypt/live/$domain/fullchain.pem" ]; then
        echo "Certificate for $domain not found, attempting to obtain a new certificate..."
        certbot certonly --nginx -d $domain --non-interactive --agree-tos -m jimmyy5121@gmail.com --webroot-path=/usr/share/nginx/html
        
        if [ $? -eq 0 ]; then
            echo "Successfully obtained certificate for $domain"
        else
            echo "Failed to obtain certificate for $domain"
        fi
    else
        echo "Certificate for $domain already exists, attempting to renew..."
        certbot renew
        
        if [ $? -eq 0 ]; then
            echo "Successfully renewed certificates"
        else
            echo "Failed to renew certificates"
        fi
    fi
done

echo "All domains processed."

# 启动 Nginx
nginx -g 'daemon off;'

# 除錯用,tail 命令保持容器运行，不立即启动 Nginx
# tail -f /dev/null
