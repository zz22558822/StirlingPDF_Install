# StirlingPDF_Install
## StirlingPDF 一鍵安裝腳本

---

## 安裝步驟

### 1. 下載檔案

```bash
sudo wget https://github.com/zz22558822/StirlingPDF_Install/releases/download/v1.1.0/StirlingPDF_Install.sh
sudo wget https://github.com/zz22558822/StirlingPDF_Install/releases/download/v1.1.0/StirlingPDF_data.zip
````

### 2. 更改壓縮檔權限為 777

```bash
sudo chmod 777 StirlingPDF_data.zip
```

### 3. 解壓縮 ZIP 檔案

```bash
sudo unzip StirlingPDF_data.zip
```

### 4. 更改解壓後檔案與資料夾權限為 777

```bash
sudo chmod -R 777 img
sudo chmod -R 777 footer.html
```
