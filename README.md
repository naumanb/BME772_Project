# Seizure Detection using Raw EEG Data
This project aims to detect seizures in patients by analyzing raw EEG data. The data comprises of 23 EEG channels per subject, based on the 10-20 EEG sensor placement guide. The goal is to preprocess, filter, extract features, and classify the data to determine seizure events accurately.

## Data Composition
- 23 EEG channels (sensors) per subject based on the 10-20 EEG sensor placement guide
- Sampling rate: 256 samples per second
- Resolution: 16-bit per sample
- Naming convention: EEG_subjectXXX.mat
- 1 normal subject who did not suffer from a seizure at any time (EEG_subject000.mat)
- 19 subjects who have at least one seizure event (EEG_subject001.mat to EEG_subject020.mat)

## Pipeline



