#!/bin/bash

# 1. 安裝 Docker
echo "正在安裝 Docker..."
sudo apt update
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# 2. 安裝指定 Docker 並啟動容器
echo "正在設置 Docker 容器..."
sudo docker run -d \
  -p 80:8080 \
  -v $(pwd)/trainingData:/usr/share/tessdata \
  -v $(pwd)/extraConfigs:/configs \
  -v $(pwd)/logs:/logs \
  -v $(pwd)/customFiles:/customFiles \
  -v $(pwd)/customHTMLFiles:/customHTMLFiles \
  -e DOCKER_ENABLE_SECURITY=false \
  -e INSTALL_BOOK_AND_ADVANCED_HTML_OPS=false \
  -e LANGS=zh_TW \
  -e UI_APPNAME="PDF Tools" \
  -e UI_APPNAMENAVBAR="PDF Tools" \
  -e UI_DESCRIPTION="Avin PDF 工具" \
  --name PDF-Tools \
  frooodle/s-pdf:latest

# 3. 建立並設定資料夾權限
echo "正在建立資料夾並設置權限..."
sudo mkdir -p customFiles/templates/fragments
sudo chmod -R 777 customFiles/templates/fragments
sudo chmod -R 777 customHTMLFiles

# 4. 下載檔案到 trainingData 資料夾
echo "正在將檔案下載並放置到 trainingData 資料夾..."
sudo chmod -R 777 trainingData/
wget https://github.com/tesseract-ocr/tessdata/raw/4.1.0/chi_sim.traineddata -P trainingData/
wget https://github.com/tesseract-ocr/tessdata/raw/4.1.0/chi_tra.traineddata -P trainingData/

# 5.複製 footer.html 到 /customFiles/templates/fragments
cp footer.html customFiles/templates/fragments/

# 6.複製 favicon.svg 到 /customFiles/static (改放到img資料夾統一複製)
# cp favicon.svg customFiles/static/
# cp favicon.ico customFiles/static/
# cp favicon-32x32.png customFiles/static/
# cp favicon-16x16.png customFiles/static/
# cp favicon.png customFiles/static/
# cp apple-touch-icon.png customFiles/static/
cp img/* customFiles/static/

# 7. 編輯 yml 文件
echo "正在編輯 settings.yml 檔案..."
sudo sed -i 's/customHTMLFiles: false/customHTMLFiles: true/' $(pwd)/extraConfigs/settings.yml
sudo sed -i "s/homeDescription: ''/homeDescription: 'Avin PDF 工具'/" $(pwd)/extraConfigs/settings.yml
sudo sed -i "s/defaultLocale: en-US/defaultLocale: zh-TW/" $(pwd)/extraConfigs/settings.yml


# 8. 重新啟動 Docker 容器
echo "正在重新啟動 Docker 容器..."
sudo docker restart PDF-Tools

# 9. 設置 Docker 容器開機自動啟動
echo "正在設置 Docker 容器開機自動啟動..."
sudo docker update --restart unless-stopped PDF-Tools

echo "設置完成。"