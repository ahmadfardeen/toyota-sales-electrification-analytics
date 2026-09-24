# Data

This folder contains the cleaned vehicle specification dataset used for the product-level analysis in the Toyota Sales & Electrification Analytics project.

## Dataset

### toyota_clean.xlsx

The cleaned Toyota vehicle specification dataset contains Toyota vehicle/engine configurations used to provide product context alongside Toyota sales data.

Key fields include:

- Model
- Generation
- Engine
- Fuel type
- Power
- Torque
- Transmission
- Drivetrain
- Fuel economy
- Vehicle dimensions
- Curb weight
- Powertrain category

## Powertrain Categories

Vehicle configurations were categorized as:

- ICE — Internal Combustion Engine
- HEV — Hybrid Electric Vehicle
- PHEV — Plug-in Hybrid Electric Vehicle
- BEV — Battery Electric Vehicle
- MHEV — Mild Hybrid Electric Vehicle

## Data Preparation

The dataset was filtered and cleaned using the Python notebook:

`python/toyotaxlsx_cleaning.ipynb`

The raw multi-make vehicle dataset was filtered to Toyota records and relevant vehicle-generation information was retained for the project.

## Important Note

This dataset provides vehicle specifications and configuration-level information. It does not represent Toyota's official sales volumes.

Toyota's official sales and production reports are used as the primary source for sales and production analysis.
