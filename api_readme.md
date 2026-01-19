### How to start

```bash
python -m uvicorn api:app --host 0.0.0.0 --port 8012
```

or with fastapi dev server

```bash
python -m fastapi dev api.py --host 0.0.0.0 --port 8012
```

### Test

```json
{
  "text_prompt": "A woman is talking to camera.",
  "image_s3_key": "unnamed.jpg",
  "audio_s3_key": "0dc37762-b89e-4284-9093-3f594c77e87f.wav",
  "chat_id": "test_chat_001"
}
```

# Generation process

Initial audio:

[audio](https://index-tts-infinite-talk-gen.s3.us-east-1.amazonaws.com/9186a33c-2726-4ba9-a73c-5fa0912a94f5-King_Von_Took_Her_To_The_O_Tiktok_Remix_Slowed_%26_Reverb_Zep3ex3lvsm.wav)

<audio controls src="https://index-tts-infinite-talk-gen.s3.us-east-1.amazonaws.com/9186a33c-2726-4ba9-a73c-5fa0912a94f5-King_Von_Took_Her_To_The_O_Tiktok_Remix_Slowed_%26_Reverb_Zep3ex3lvsm.wav">
    Your browser does not support the audio element.
</audio>

Initial image:

![Initial character](https://index-tts-infinite-talk-gen.s3.us-east-1.amazonaws.com/AgACAgIAAxkBAAIBWGlqnHk3ptYWMwqa7K6OM0kXmz_tAAKsDWsb5qRYSxAeqV5M3WxaAQADAgADeAADOAQ.jpg)

Generated audio:

[generated audio](https://index-tts-infinite-talk-gen.s3.us-east-1.amazonaws.com/cffdf5ab-4498-4785-bd2d-76c63a42a5a5-King_Von_Took_Her_To_The_O_Tiktok_Remix_Slowed_%26_Reverb_Zep3ex3lvsm.wav)

<audio controls src="https://index-tts-infinite-talk-gen.s3.us-east-1.amazonaws.com/9186a33c-2726-4ba9-a73c-5fa0912a94f5-King_Von_Took_Her_To_The_O_Tiktok_Remix_Slowed_%26_Reverb_Zep3ex3lvsm.wav">
    Your browser does not support the audio element.
</audio>

Generated video:

[Character talking](https://index-tts-infinite-talk-gen.s3.us-east-1.amazonaws.com/InfiniTalk_854658cb35b240909af5512a993a879b_00001-audio.mp4)

<video controls src="https://index-tts-infinite-talk-gen.s3.us-east-1.amazonaws.com/InfiniTalk_854658cb35b240909af5512a993a879b_00001-audio.mp4" width="600">
    Your browser does not support the video tag.
</video>
