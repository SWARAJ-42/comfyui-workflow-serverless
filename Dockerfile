# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# The workflow only contains unknown_registry custom nodes with no aux_id (GitHub repo) information,
# so they could not be resolved or installed automatically. If you have GitHub repos for these,
# add RUN git clone lines like:
# RUN git clone https://github.com/<owner>/<repo> /comfyui/custom_nodes/<repo>
# Skipping the following unknown_registry nodes (no aux_id provided):
# - SaveAnimatedWEBP
# - SaveWEBM
# - CLIPVisionLoader
# - WanImageToVideo
# - CLIPVisionEncode
# - ModelSamplingSD3
# - LoraLoaderModelOnly

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/diffusion_models/wan2.1_i2v_480p_14B_fp16.safetensors --relative-path models/diffusion_models --filename wan2.1_i2v_480p_14B_fp16.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors --relative-path models/text_encoders --filename umt5_xxl_fp8_e4m3fn_scaled.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors --relative-path models/vae --filename wan_2.1_vae.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors --relative-path models/clip_vision --filename clip_vision_h.safetensors
# RUN # Could not find URL for gamesprite_2d_running163.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
