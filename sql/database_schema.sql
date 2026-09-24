CREATE DATABASE IF NOT EXISTS toyota_analytics;

USE toyota_analytics;

-- ANNUAL SALES

CREATE TABLE fact_global_sales (
    year SMALLINT PRIMARY KEY,
    sales BIGINT NOT NULL
);

CREATE TABLE fact_regional_sales (
    year SMALLINT NOT NULL,
    region VARCHAR(100) NOT NULL,
    sales BIGINT NOT NULL,
    PRIMARY KEY (year, region)
);

-- ANNUAL ELECTRIFICATION

CREATE TABLE fact_global_electrified_sales (
    year SMALLINT NOT NULL,
    powertrain VARCHAR(30) NOT NULL,
    sales BIGINT NOT NULL,
    PRIMARY KEY (year, powertrain)
);

CREATE TABLE fact_regional_electrified_sales (
    year SMALLINT NOT NULL,
    region VARCHAR(100) NOT NULL,
    electrified_sales BIGINT NOT NULL,
    PRIMARY KEY (year, region)
);

-- ANNUAL PRODUCTION

CREATE TABLE fact_global_production (
    year SMALLINT PRIMARY KEY,
    production BIGINT NOT NULL
);

CREATE TABLE fact_regional_production (
    year SMALLINT NOT NULL,
    production_scope VARCHAR(30) NOT NULL,
    production BIGINT NOT NULL,
    PRIMARY KEY (year, production_scope)
);

-- H1 SALES

CREATE TABLE fact_h1_global_sales (
    period_year SMALLINT PRIMARY KEY,
    sales BIGINT NOT NULL
);

CREATE TABLE fact_h1_regional_sales (
    period_year SMALLINT NOT NULL,
    region VARCHAR(100) NOT NULL,
    sales BIGINT NOT NULL,
    PRIMARY KEY (period_year, region)
);

-- H1 ELECTRIFICATION

CREATE TABLE fact_h1_electrified_sales (
    period_year SMALLINT NOT NULL,
    powertrain VARCHAR(30) NOT NULL,
    sales BIGINT NOT NULL,
    PRIMARY KEY (period_year, powertrain)
);

CREATE TABLE fact_h1_regional_electrified_sales (
    period_year SMALLINT NOT NULL,
    region VARCHAR(100) NOT NULL,
    electrified_sales BIGINT NOT NULL,
    PRIMARY KEY (period_year, region)
);

-- H1 PRODUCTION

CREATE TABLE fact_h1_regional_production (
    period_year SMALLINT NOT NULL,
    production_scope VARCHAR(30) NOT NULL,
    production BIGINT NOT NULL,
    PRIMARY KEY (period_year, production_scope)
);

-- PRODUCT / MODEL SALES

CREATE TABLE fact_major_model_sales (
    model VARCHAR(100) PRIMARY KEY,
    sales_thousands DECIMAL(10,3) NOT NULL
);

CREATE TABLE fact_regional_model_sales (
    region VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    sales_thousands DECIMAL(10,3) NOT NULL,
    PRIMARY KEY (region, model)
);

-- POWERTRAIN SALES

CREATE TABLE fact_global_powertrain_sales (
    powertrain VARCHAR(30) PRIMARY KEY,
    sales_thousands DECIMAL(10,3) NOT NULL
);

CREATE TABLE fact_regional_powertrain_sales (
    region VARCHAR(100) NOT NULL,
    powertrain VARCHAR(30) NOT NULL,
    sales_thousands DECIMAL(10,3) NOT NULL,
    PRIMARY KEY (region, powertrain)
);

-- VEHICLE SPECIFICATIONS

CREATE TABLE dim_vehicle_specs (
    vehicle_spec_id INT AUTO_INCREMENT PRIMARY KEY,
    make_group VARCHAR(100),
    make VARCHAR(100),
    model VARCHAR(100),
    generation VARCHAR(150),
    gen_year_start SMALLINT,
    gen_year_end SMALLINT,
    engine_label VARCHAR(150),
    fuel_type VARCHAR(100),
    cylinders INT,
    displacement_cc DECIMAL(10,2),
    power_hp DECIMAL(10,2),
    torque_nm DECIMAL(10,2),
    transmission VARCHAR(500),
    drivetrain VARCHAR(100),
    fuel_economy_combined_l100 DECIMAL(10,2),
    length_mm DECIMAL(10,2),
    width_mm DECIMAL(10,2),
    height_mm DECIMAL(10,2),
    wheelbase_mm DECIMAL(10,2),
    curb_weight_kg DECIMAL(10,2),
    powertrain_category VARCHAR(30)
);
