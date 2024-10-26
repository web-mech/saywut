import whisper
import torch
from pyannote.audio import Pipeline

# Step 1: Load Whisper model for transcription
device = "cuda" if torch.cuda.is_available() else "cpu"
whisper_model = whisper.load_model("base", device=device)

# Step 2: Load PyAnnote pipeline for speaker diarization
# Note: You'll need a Hugging Face API token to use PyAnnote's pre-trained models
pipeline = Pipeline.from_pretrained("pyannote/speaker-diarization", use_auth_token="your_huggingface_token")

# Step 3: Perform speaker diarization with PyAnnote
audio_file = "foo.mp3"
diarization = pipeline(audio_file)

# Step 4: Transcribe audio using Whisper
transcription_result = whisper_model.transcribe(audio_file)

# Step 5: Combine diarization and transcription
# Initialize an empty list to store speaker-separated transcriptions
speaker_transcriptions = []

# Iterate over each segment from diarization
for segment in diarization.itertracks(yield_label=True):
    start_time = segment[0].start
    end_time = segment[0].end
    speaker = segment[2]

    # Find the Whisper transcription segments within the PyAnnote segment time range
    segment_texts = []
    for text_segment in transcription_result["segments"]:
        if text_segment["start"] >= start_time and text_segment["end"] <= end_time:
            segment_texts.append(text_segment["text"])
    
    # Combine texts for the current speaker segment
    full_text = " ".join(segment_texts)
    speaker_transcriptions.append(f"{speaker} [{start_time:.2f} - {end_time:.2f}]: {full_text}")

# Step 6: Output the speaker-separated transcription
for speaker_text in speaker_transcriptions:
    print(speaker_text)
