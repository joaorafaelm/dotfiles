import io
import logging
import os

import requests
from dotenv import load_dotenv
from PIL import Image

load_dotenv()
logging.basicConfig(level=logging.DEBUG)

def main(prompt):

    TOKEN = os.getenv("CLIP_DROP_TOKEN")
    request = requests.post('https://clipdrop-api.co/text-to-image/v1',
      files = {
          'prompt': (None, prompt, 'text/plain')
      },
      headers = { 'x-api-key': TOKEN}
    )
    request.raise_for_status()
    image = Image.open(io.BytesIO(request.content))
    filename = f"latest.jpg"
    image.save(filename)


if __name__ == "__main__":
    prompt = input()
    main(prompt)
