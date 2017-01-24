# Voice recognition training data

The repository contains scripts to process public voice recognition training data sets into a format suitable to training.

Currently supported corpora: TED and LibriVox

Format: Directory structure with pairs of .wav file for the audio (16khz, 1 channel, 16-bit signed) and a .txt file for the transcription. Each .wav/.txt pair corresponds to a sentence or sentence part.

## Stats

Some stats on the resulting total corpus after running these scripts on all above corpora:

- 387002 labeled utterances in total
- all but 36 .wav files are shorter or equal 30 seconds
- all but 45 .txt files are shorter or equal 450 characters
