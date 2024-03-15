# COVID-19 SEIRD Model for Poland

This project implements a SEIRD (Susceptible-Exposed-Infected-Recovered-Deceased) model to simulate the spread of COVID-19 in Poland. SEIRD models are an extension of the classic SIR (Susceptible-Infected-Recovered) model, adding an "Exposed" compartment to account for the incubation period of the virus.

## Overview

The project consists of several MATLAB scripts:

- `covid.m`: Main script to run the SEIRD model without any pandemics policy.
- `odefunc.m`: Function defining the system of ordinary differential equations (ODEs) for the SEIRD model.
- `CvidPolicy.m`: Script to simulate the impact of a public health policy, such as social distancing, on the spread of the virus.

## SEIRD Model

The SEIRD model is based on the following compartments:

- **S (Susceptible)**: Individuals who are susceptible to the virus.
- **E (Exposed)**: Individuals who have been exposed to the virus but are not yet infectious.
- **I (Infected)**: Infectious individuals who can transmit the virus.
- **R (Recovered)**: Individuals who have recovered from the virus and are immune.
- **D (Deceased)**: Individuals who have died from the virus.

## Running the Model

1. Ensure you have MATLAB installed.
2. Run `main.m` to execute the SEIRD model and Monte Carlo simulations.
3. Results will be plotted, showing the predicted spread of COVID-19 in Poland.

## Notes

Feel free to change model simulation parameters. In this model I inserted data from Polish government website.

## References

- [SEIRD Model](https://en.wikipedia.org/wiki/Compartmental_models_in_epidemiology#SEIRD_model)
- [MATLAB](https://www.mathworks.com/products/matlab.html)

## Disclaimer

This model is for educational purposes only and should not be used as a basis for real-world decisions without further validation and expert consultation.

Feel free to contribute, report issues, or suggest improvements!
