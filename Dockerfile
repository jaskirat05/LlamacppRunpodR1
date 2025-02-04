FROM --platform=linux/amd64 runpod/pytorch:2.0.1-py3.10-cuda11.8.0-devel

WORKDIR /workspace

COPY /workspace /workspace

RUN pip install runpod

ENV CUDA_DOCKER_ARCH=all
ENV LLAMA_CUBLAS=1
RUN CMAKE_ARGS="-DGGML_CUDA=ON" FORCE_CMAKE=1 pip install llama-cpp-python

# Download DeepSeek model files
RUN for i in $(seq -f "%05g" 1 15); do \
    wget -P workspace https://huggingface.co/unsloth/DeepSeek-R1-GGUF/resolve/main/DeepSeek-R1-Q8_0/DeepSeek-R1-Q8_0-${i}-of-00015.gguf; \
done

# for local test
# RUN pip install llama-cpp-python==0.1.78

CMD ["/bin/bash"]

# CMD ["python", "-u", "handle.py"]