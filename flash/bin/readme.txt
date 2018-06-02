index.html 提供了 html 怎麼嵌入 flash 並且設定好 flashvars 的範例

config.xml 設定後台路徑，在我的測試裡，我設定到 success.json 作為一個假的後台傳回值

您可以把 config.xml 中的

    <saveurl>success.json</saveurl>
	
改為
	
    <saveurl>fail.json</saveurl>
	
觀察其變化

base64Test.html 證明 flash 產出的 base64 code 是正確的，如果 server 無法轉出圖片