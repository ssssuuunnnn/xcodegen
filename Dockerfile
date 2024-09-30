FROM --platform=linux/amd64 swift:5.7
# FROM --platform=linux/arm64 swift:5.7

# 安裝必要的依賴
RUN apt-get update && apt-get install -y \
    libssl-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# 安裝 XcodeGen
RUN git clone https://github.com/yonaskolb/XcodeGen.git
WORKDIR /XcodeGen
RUN swift build -c release
RUN mv .build/release/xcodegen /usr/local/bin/
WORKDIR /
RUN rm -rf /XcodeGen

# 設置工作目錄
WORKDIR /app

# 複製 XcodeGen 專案配置檔案
COPY project.yml .

# 設定默認執行命令來生成 Xcode 專案
CMD ["xcodegen", "generate"]