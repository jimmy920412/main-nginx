## 簡介
此專案為最主要的nginx
透過反向代理轉發到其他 nginx 服務

## 運行
```sh=
docker-compose up -d --build
```

## 其他問題
#### 目前預設可能已經指向了 https
但如果是第一次建立https憑證時,  
需要先留 nginx http 80 通道給第三方做驗證,  
驗證沒問題後,letsencrpt 底下會有live資料夾,  
裡面才是取得後的憑證,  
此時才能把 nginx 443 的參數打開  

GPT 解釋:

1. 配置 Nginx 使其在 HTTP（80 端口）上響應 Let's Encrypt 的驗證請求。這通常涉及設置一個特定的伺服器塊（server block），以處理來自 /.well-known/acme-challenge 的請求。
2. 一旦 Nginx 配置完成，使用 Let's Encrypt 客戶端（如 Certbot）發起憑證申請。客戶端會自動處理與 Let's Encrypt 服務的交互，包括域名驗證。
3. 域名驗證成功後，Let's Encrypt 會發行 SSL/TLS 憑證，並將憑證及相關檔案儲存在伺服器的 live 資料夾中。
4. 獲得憑證後，您應該進一步配置 Nginx，使其能夠通過 HTTPS（443 端口）提供加密連接。這涉及設置另一個伺服器塊，並引用 live 資料夾中的憑證和私鑰文件。


#### AttributeError("can't set attribute") 錯誤
可以進入容器查看 cerbot版本
```sh=
certbot --version
```
如果是 2.1.0 版本 https憑證有機率構建失敗,
必須要升級到 certbot 2.3.0
參考以下文章
https://github.com/certbot/certbot/issues/9903
