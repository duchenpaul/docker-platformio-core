FROM python:3.9.0-slim

ENV APP_VERSION="5.1.0" \
    APP="platformio-core"

LABEL app.name="${APP}" \
    app.version="${APP_VERSION}" \
    maintainer="Sebastian Glahn <hi@sgla.hn>"

COPY compile_ino.sh /root/compile_ino.sh

RUN pip install -U platformio && \
    mkdir -p /workspace && \
    mkdir -p /.platformio && \
    chmod a+rwx /.platformio && \
    apt update && apt install -y git libclang-dev && apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && pip install clang

RUN git clone https://gitee.com/duchenpaul/ino2cpp.git && \
    cd ino2cpp && sed -i "s/import platform/import platform;clang.cindex.Config.set_library_file('/usr/lib/llvm-7/lib/libclang.so')/g" ino2cpp.py && \
    ln -s ino2cpp.py /usr/bin/ino2cpp

WORKDIR /workspace

# CMD ["platformio", "run", "-t", "upload"]
CMD ["bash", "/root/compile_ino.sh"]
