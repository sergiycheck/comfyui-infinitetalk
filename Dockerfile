
ARG RUNPOD_VERSION=1.0.3
ARG CUDA_VERSION=cu1281
ARG TORCH_VERSION=torch280
ARG UBUNTU_VERSION=ubuntu2404


FROM alpine/git AS builder

WORKDIR /build/custom_nodes

RUN git clone --depth 1 https://github.com/Fannovel16/comfyui_controlnet_aux.git \
 && git clone --depth 1 https://github.com/kijai/ComfyUI-KJNodes.git \
 && git clone --depth 1 https://github.com/Comfy-Org/ComfyUI-Manager.git \
 && git clone --depth 1 https://github.com/kijai/ComfyUI-MelBandRoFormer.git \
 && git clone --depth 1 https://github.com/kijai/ComfyUI-segment-anything-2.git \
 && git clone --depth 1 https://github.com/un-seen/comfyui-tensorops.git \
 && git clone --depth 1 https://github.com/pydn/ComfyUI-to-Python-Extension.git \
 && git clone --depth 1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git \
 && git clone --depth 1 https://github.com/kijai/ComfyUI-WanVideoWrapper.git


FROM runpod/pytorch:${RUNPOD_VERSION}-${CUDA_VERSION}-${TORCH_VERSION}-${UBUNTU_VERSION}


WORKDIR /tmp

COPY --from=builder /build/custom_nodes/comfyui_controlnet_aux/requirements.txt ./controlnet_aux.txt
COPY --from=builder /build/custom_nodes/ComfyUI-KJNodes/requirements.txt ./kjnodes.txt
COPY --from=builder /build/custom_nodes/ComfyUI-Manager/requirements.txt ./manager.txt
COPY --from=builder /build/custom_nodes/ComfyUI-MelBandRoFormer/requirements.txt ./melband.txt
COPY --from=builder /build/custom_nodes/ComfyUI-segment-anything-2/requirements.txt ./sam2.txt
COPY --from=builder /build/custom_nodes/comfyui-tensorops/requirements.txt ./tensorops.txt
COPY --from=builder /build/custom_nodes/ComfyUI-to-Python-Extension/requirements.txt ./to_python.txt
COPY --from=builder /build/custom_nodes/ComfyUI-VideoHelperSuite/requirements.txt ./videohelper.txt
COPY --from=builder /build/custom_nodes/ComfyUI-WanVideoWrapper/requirements.txt ./wanvideo.txt

RUN pip --no-cache-dir install -r controlnet_aux.txt \
 && pip --no-cache-dir install -r kjnodes.txt \
 && pip --no-cache-dir install -r manager.txt \
 && pip --no-cache-dir install -r melband.txt \
 && pip --no-cache-dir install -r sam2.txt \
 && pip --no-cache-dir install -r tensorops.txt \
 && pip --no-cache-dir install -r to_python.txt \
 && pip --no-cache-dir install -r videohelper.txt \
 && pip --no-cache-dir install -r wanvideo.txt \
 && pip --no-cache-dir install -U huggingface_hub \
 && pip --no-cache-dir install runpod \
 && pip --no-cache-dir install sageattention==2.2.0 --no-build-isolation \
 && rm -rf /tmp/*.txt /root/.cache/pip

WORKDIR /workspace/ComfyUI

# Copy ComfyUI project (assumes Dockerfile is at repo root)
COPY . .

# Copy custom nodes
COPY --from=builder /build/custom_nodes ./custom_nodes

# Create models directory and symlink
RUN mkdir -p /workspace/models \
 && ln -s /workspace/models /workspace/ComfyUI/models


CMD ["python", "main.py", "--listen", "0.0.0.0"]
