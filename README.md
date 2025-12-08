# CST8916 Final Project: Real-time Monitoring System for Rideau Canal Skateway

## Name: Kylath Mamman George

## Student Number: 041198835

## Repository Links

| Repository Name | Repository Link |
|----------|----------|
| Main Documentation Repository   | <https://github.com/KylathGeorge/CST8916-final-project>  |
| Sensor Simulation Repository    | <https://github.com/KylathGeorge/rideau-canal-sensor-simulation>   |
| Web Dashboard Repository    | <https://github.com/KylathGeorge/rideau-canal-dashboard>   |

## Scenario Overview

### Problem Statement

The National Capital Commission needs a real-time data streaming and visualization system to improve skater safety as currently there is no such system to collect and visualize data.

### System Objectives

1. Simulate IoT sensors at three locations—Dow's Lake, Fifth Avenue, and the National Arts Centre (NAC)—to monitor:

   - Ice Thickness (cm)
   - Surface Temperature (°C)
   - Snow Accumulation (cm)
   - External Temperature (°C)

2. Process sensor data in real-time using Azure Stream Analytics with 5-minute aggregation windows.

3. Store processed data in Azure Cosmos DB for fast, low-latency access.

4. Archive historical data in Azure Blob Storage for long-term retention and analysis.

5. Present live data through a web dashboard hosted on Azure App Service for real-time monitoring.

## System Architecture

### Diagram

![image info](/architecture/remote_data_architecture.png)

### Data flow explanation

### Azure Services used

