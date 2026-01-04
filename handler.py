import multiprocessing as mp
import os
import json
from boto3_utils import download_s3_file, upload_s3_file
from utils import now_local_str
import uuid
from infinitetalk_comfy_reusable import infinitetalk_comfyui_generation_pipeline as generate

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

def infinite_talk_worker(image_s3_key: str, audio_s3_key: str, text_prompt: str):
    try:
        
        bucket_name = os.getenv("S3_BUCKET_NAME")
        
        if not bucket_name:
            raise RuntimeError("S3_BUCKET_NAME environment variable is not set")
        
        output_path = os.path.join(BASE_DIR, "output")
        
        os.makedirs(output_path, exist_ok=True)

        
        print("Downloding image from s3", now_local_str())
        
        image_path = download_s3_file(
            bucket=bucket_name,
            key=image_s3_key,
            local_path=output_path
        )
        
        print("Downloding audio from s3", now_local_str())
        
        audio_path = download_s3_file(
            bucket=bucket_name,
            key=audio_s3_key,
            local_path=output_path
        )
        

        
        print("Generating video...", now_local_str())
        
        negative_prompt="bright tones, overexposed, static, blurred details, subtitles, style, works, paintings, images, static, overall gray, worst quality, low quality, JPEG compression residue, ugly, incomplete, extra fingers, poorly drawn hands, poorly drawn faces, deformed, disfigured, misshapen limbs, fused fingers, still picture, messy background, three legs, many people in the background, walking backwards"
        
        ouput_video_prefix = f"InfiniTalk_{uuid.uuid4().hex}"
        
        generate(
            local_image_name_input_folder=image_path,
            local_audio_name_input_folder=audio_path,
            posivite_prompt=text_prompt,
            negative_prompt=negative_prompt,
            output_video_width=360,
            output_video_height=400,
            output_video_prefix=ouput_video_prefix,
        )
        
        generated_video_path_matches = [
            os.path.join(output_path, f)
            for f in os.listdir(output_path)
            if f.startswith(ouput_video_prefix) and os.path.isfile(os.path.join(output_path, f))
        ]
        
        if len(generated_video_path_matches) != 1:
            raise RuntimeError(
                f"Expected exactly 1 video, found {len(generated_video_path_matches)}"
            )

        generated_video_path = generated_video_path_matches[0]
        
        print("Generated video:", generated_video_path)
        
        upload_s3_file(
            local_path=generated_video_path,
            bucket=bucket_name,
        )
            
        generated_video_name = os.path.basename(generated_video_path)
        s3_url = f"https://{bucket_name}.s3.amazonaws.com/{generated_video_name}"
        
        print("Job completed.", now_local_str())
        print("Generated video S3 URL:", s3_url)
        
        return({
            "status": "completed",
            "s3_url": s3_url
        })

    except Exception as e:
        print(f"Error in infinite_talk_worker: {e}")
        
        return({
            "status": "error",
            "error": str(e)
        })

    finally:
        os.remove(image_path)
        os.remove(audio_path)
        os.remove(generated_video_path)

