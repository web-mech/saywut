import whisper
import torch

# Load the Whisper model (e.g., "base") and ensure it runs on the CPU
device = "cpu" #"cuda" if torch.cuda.is_available() else "cpu"
model = whisper.load_model("base", device=device)

# Transcribe the audio file
result = model.transcribe("/Users/webmech/dev/dev916/cupcake/foo.mp3")

# Print the transcription text
print(result["text"])
