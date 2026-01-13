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
