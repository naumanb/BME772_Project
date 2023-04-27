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

<img width="654" alt="Capture" src="https://user-images.githubusercontent.com/15255699/234984534-6ee588ec-d7a4-4d4a-970a-0f63996a8c5c.PNG">

## Preprocessing

Channels 'FP1-F7', 'FP1-F3', 'FP2-F4', 'FT9-FT10', 'FT10-T8' were most expressive in regards to certain features.

### Taking average of expressive signals:
<img width="381" alt="averaged" src="https://user-images.githubusercontent.com/15255699/234983814-f2266bc0-5686-4b56-9741-e70c8a67ebcc.PNG">

### Normalizing averaged signal:
<img width="370" alt="Normalize" src="https://user-images.githubusercontent.com/15255699/234983812-683276ab-4945-4624-9453-935f14159f52.PNG">

### Extracting Delta Band:
<img width="361" alt="deltaBand" src="https://user-images.githubusercontent.com/15255699/234983810-5ecf1b72-0504-42cd-acdc-0a4017173e2e.PNG">

## Extracting Features:
- Root Mean Square (RMS)
<img width="377" alt="rms" src="https://user-images.githubusercontent.com/15255699/234983807-d2f77d7f-1947-4b34-88a4-f4094fbd1f2e.PNG">
- Max Power Spectral Density (PDS)
<img width="377" alt="pds" src="https://user-images.githubusercontent.com/15255699/234983819-79d3af3e-93bb-4199-94fd-75caa2ce5aa0.PNG">
- Mean Power Spectral Density
<img width="371" alt="pdsmean" src="https://user-images.githubusercontent.com/15255699/234983818-5ef76376-990b-4482-ba38-34e72be5ee58.PNG">

## Classification
- Linear Discriminant Analysis Classifier
- 10-fold Cross-Validation

CV Accuracy: ![image](https://user-images.githubusercontent.com/15255699/234988178-f239caf7-4412-461e-93f9-fb65232ec739.png)










