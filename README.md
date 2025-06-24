# Abstract
* Conducted frequency analysis using FFT to identify noise characteristics, which informed the selection and subsequent design of a digital Butterworth low-pass filter using MATLAB.
* Optimised filter parameters and performed comprehensive frequency response analysis, utilising visualisations of time and frequency domain signals (before and after filtering) and Bode diagrams to confirm the number of poles and cut-off frequency, ensuring attenuating unwanted frequencies while preserving the quality of signals.
* **GitHub**: https://github.com/lenxium/DigiButterworthLPF

# Sampling
Digital filter passes analogue data to a processor that runs algorithms to digitally filter the data. Since all subsequent processing is digital, so the audio source [analogue input, denoted as x(t)] must first be sampled at a uniform rate f_s = 1/T_s. This sampling process [sometimes referred to as Analogue to Digital Converter(ADC)] transforms the continuous-time signal into discrete-time by recording its voltage amplitude at regular intervals. 

To get accurate analogue signals via ADC, the sampling rate (f_s) must be at least twice the maximum frequency (f_max) to avoid aliasing according to Nyquist’s theorem. Thus, an anti-aliasing low-pass filter with cut-off frequency f_c = f_s/2 should be applied before ADC.

# Frequency Analysis
Sound wave can be mathematically modelled as sinusoidal functions v(t)=v_pcos(wt+θ) since it periodically varies in air pressure. The given audio signals are composed of multiple sinusoidal componentes of different amplitudes and phases, as described by Fourier series theory:
![image](https://github.com/user-attachments/assets/dba00464-a9db-42ab-8b3e-81cf6cce1b1a)

Where X_k is the amplitude and phase of each sinusoidal function. 

For sampled signals x[n] = x(xT_s), Discrete Fourier Transform (DFT) used to form frequency spectrum:
![image](https://github.com/user-attachments/assets/6257be80-deb7-4348-b8e0-30ec198a3a93)

The big O notation of DFT is O(N^2), which is less efficient than Fast Fourier Transform (O(NlogN)), thus FFT is used to find the unwanted frequencies:
![image](https://github.com/user-attachments/assets/f8cb0e69-8914-407c-97c5-57b8243bac1f)

The nature of noise in the audio determines which filter should be used, as demonstrated on the frequency spectrum formed by FFT of MATLAB, the noise signals have very high frequencies (i.e. buzzer), the Low Pass Filter allows signals below a specified cut-off frequency to pass while attenuating higher frequencies. 

# Audio Filtering
To achieve Low Pass Filter, a Butterworth filter (a type of IIR filter) is used since it maximally flats magnitude response in the passband as illustrated below:
![image](https://github.com/user-attachments/assets/21780245-01b7-498a-b3a1-d5a6fc20c36e)

The transfer function is: 
![image](https://github.com/user-attachments/assets/17448784-9e37-4a8f-923c-369b09723d32)

Where n is the filter order (sets the roll-off of 20n dB/dec), w_c = 2*pi*f_c (cut-off angular frequency).
![image](https://github.com/user-attachments/assets/14ea5aba-6be3-434a-bbd4-8e25326013ba)

# Results
![image](https://github.com/user-attachments/assets/cc09aba3-07a3-4896-b1e3-bd499333ea2a)
![image](https://github.com/user-attachments/assets/71e157ef-3434-455a-be7c-ed66f0e4d476)

# Reference
[1] H. Austerlitz, Data Acquisition Techniques Using PCs, 2nd ed.Boston, MA, USA: Butterworth-Heinemann, 2003.
[2] Anthony Croft & Robert Davison, Mathematics for Engineers, Pearson Education, 5th ed., 2019. 
[3] A. Croft, R. Davison, M. Hargreaves, and J. Flint, Engineering Mathematics: A Foundation for Electronic, Electrical, Communications and Systems Engineers, 5th ed. Harlow, U.K.: Pearson Education, 2012. 

