import os
from deepgram import DeepgramClient, SpeakOptions

DEEPGRAM_API_KEY = "DEEPGRAM_API_KEY"

dialogs = [
    {"text": "Hey, Sue, did you see this article?", "model": "aura-arcas-en"},
    {"text": "Yeah, I did. I don't think that's a very good idea. ...", "model": "aura-asteria-en"},
    {"text": "Really? You don't think it's a safety hazard, like they said?", "model": "aura-arcas-en"},
    {"text": "No—at least not during the day. I'm pretty sure both of those accidents happened at night, when it's harder to see cyclists. They didn't say that in the 'article.'", "model": "aura-asteria-en"},
    {"text": "Oh, that does make a difference.", "model": "aura-arcas-en"},
    {"text": "Sure it does. Maybe at night, with low visibility, there's a safety hazard. But I don't think there's any danger in the daytime...which is when most people need to move around and get to classes.", "model": "aura-asteria-en"},
    {"text": "Yeah, that makes sense.", "model": "aura-arcas-en"},
    {"text": "Besides, it's such a big campus, if they do this, it's going to be really hard to get around.", "model": "aura-asteria-en"},
    {"text": "Well, we can always take the bus I guess.", "model": "aura-arcas-en"},
    {"text": "But the buses only run once an hour.", "model": "aura-asteria-en"},
    {"text": "That's true. They're not very convenient.", "model": "aura-arcas-en"},
    {"text": "No, not at all. If people have to take the bus, we'll end up sitting around waiting for the next one all the time. And we're all too busy to waste our time doing that.", "model": "aura-asteria-en"}
]

def synthesize_and_save_audio(text, model, filename):
    try:
        deepgram = DeepgramClient(DEEPGRAM_API_KEY)
        options = SpeakOptions(model=model)
        response = deepgram.speak.v("1").save(filename, {"text": text}, options)
        if response.content_type == 'audio/mpeg':
            print(f"Audio saved to {filename}")
    except Exception as e:
        print(f"Exception: {e}")

def main():
    filenames = []
    for i, dialog in enumerate(dialogs):
        filename = f"dialog_{i}.mp3"
        synthesize_and_save_audio(dialog['text'], dialog['model'], filename)
        filenames.append(filename)

    # Concatenate all audio files into one using ffmpeg
    concat_command = f"ffmpeg -y -i \"concat:{'|'.join(filenames)}\" -acodec copy combined_audio.mp3"
    os.system(concat_command)
    print("All audio segments have been combined into 'combined_audio.mp3'.")

if __name__ == "__main__":
    main()