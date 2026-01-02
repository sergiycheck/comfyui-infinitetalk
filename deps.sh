#!bin/sh

# first dependencies
pip install --upgrade pip setuptools wheel
pip install -r requirements.txt
pip install -U "huggingface_hub"
# sageattention install


# custom nodes
cd custom_nodes
git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git
git clone https://github.com/un-seen/comfyui-tensorops.git
git clone https://github.com/kijai/ComfyUI-MelBandRoFormer.git
git clone https://github.com/kijai/ComfyUI-segment-anything-2.git
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite
git clone https://github.com/kijai/ComfyUI-KJNodes.git
git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git
# installing dependencies for custom nodes
for d in */; do [ -f "$d/requirements.txt" ] && pip install -r "$d/requirements.txt"; done


# models
hf download Kijai/WanVideo_comfy_fp8_scaled InfiniteTalk/Wan2_1-InfiniteTalk-Single_fp8_e4m3fn_scaled_KJ.safetensors --local-dir models/diffusion_models/Wan2_1-InfiniteTalk-Single_fp8_e4m3fn_scaled_KJ.safetensors
hf download Kijai/WanVideo_comfy Wan2_1-I2V-14B-480P_fp8_e4m3fn.safetensors --local-dir models/diffusion_models/Wan2_1-I2V-14B-480P_fp8_e4m3fn.safetensors
hf download Kijai/MelBandRoFormer_comfy MelBandRoformer_fp16.safetensors --local-dir models/diffusion_models/MelBandRoformer_fp16.safetensors
hf download Kijai/WanVideo_comfy Wan2_1_VAE_bf16.safetensors --local-dir models/vae/Wan2_1_VAE_bf16.safetensors
hf download Comfy-Org/Wan_2.1_ComfyUI_repackaged split_files/clip_vision/clip_vision_h.safetensors --local-dir models/clip_vision/clip_vision_h.safetensors
hf download Kijai/WanVideo_comfy umt5-xxl-enc-bf16.safetensors --local-dir models/text_encoders
hf download Kijai/WanVideo_comfy Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors --local-dir models/loras/lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors
hf download Kijai/wav2vec2_safetensors wav2vec2-chinese-base_fp16.safetensors --local-dir models/wav2vec2/wav2vec2-chinese-base_fp16.safetensors