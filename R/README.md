# **CO2 Emissions Analysis Dashboard**

## **Overview**
An interactive Shiny dashboard that analyzes CO2 emissions and their contributing factors across 14 countries from 4 different regions (2004-2014). The dashboard explores relationships between CO2 emissions, population, energy consumption, manufacturing sector contribution, and regional patterns through comprehensive data visualizations.

## **Features**
* **Temporal Analysis**: Interactive line charts showing CO2 emission trends over time
* **Regional Comparison**: Bar charts displaying emissions across different geographical regions
* **Correlation Analysis**: Scatter plots examining relationships between emissions and various indicators
* **Manufacturing Impact**: Analysis of manufacturing sector's contribution to CO2 emissions
* **Interactive Filtering**: Dynamic year range selection and chart type switching
* **Responsive Design**: Clean, modern dashboard interface with detailed information panels

## **Countries & Regions Covered**

### **Europe & Central Asia**
United Kingdom (GBR), Germany (DEU), Ireland (IRL), Slovenia (SVN)

### **Middle East & North Africa** 
Egypt (EGY), Iraq (IRQ), Saudi Arabia (SAU), Lebanon (LBN)

### **East Asia & Pacific**
China (CHN), Australia (AUS), Thailand (THA), New Zealand (NZL)

### **North America**
United States (USA), Canada (CAN)

## **Data Sources**
All indicators are sourced from the World Bank API:
- CO2 emissions (kt)
- CO2 emissions from manufacturing industries (%)
- Population (total)
- Manufacturing value added (% of GDP)
- CO2 emissions per capita
- Energy use (kg of oil equivalent per capita)

## **Research Questions Addressed**

1. **How did CO2 emissions change from 2004-2014?**
   - Time-series analysis showing emission trends
   - Identification of periods with highest emission increases

2. **What is the relationship between population and CO2 emissions?**
   - Correlation analysis between country population and total emissions
   - Statistical correlation coefficient: 0.90 (strong positive relationship)

3. **How do manufacturing indicators relate to emissions?**
   - Analysis of manufacturing sector's GDP contribution vs. manufacturing emissions
   - Regional patterns in industrial emission patterns

4. **Which regions and countries are the highest emitters?**
   - Year-by-year analysis of top-emitting regions and countries
   - China identified as largest contributor from 2005-2014

5. **What is the correlation between energy use and emissions per capita?**
   - Strong positive relationship with correlation coefficient: 0.95
   - Per capita analysis normalizing for population differences

6. **How do manufacturing emissions vary by region and country?**
   - Temporal analysis of manufacturing sector emissions
   - East Asia & Pacific identified as highest manufacturing emitter

## **Installation & Setup**

### **Prerequisites**
* R (version 4.0 or higher)
* RStudio (recommended)

### **Required Packages**
```r
install.packages(c(
  "httr",
  "httr2", 
  "tidyverse",
  "dplyr",
  "ggplot2",
  "readr",
  "plotly",
  "shiny",
  "shinydashboard",
  "shinydashboardPlus"
))
```

### **Running the Application**
1. Clone this repository or download the R script
2. Open the project in RStudio
3. Install required packages (if not already installed)
4. Run the application:
   ```r
   # Run the entire script or use:
   shinyApp(ui = ui, server = server)
   ```
5. The dashboard will open in your default web browser

## **Usage Guide**

### **Tab 1: CO2 Emission Changes (2004-2014)**
- Use the year slider to filter the time range
- Hover over the line chart to see exact emission values
- Observe the overall upward trend in global emissions

### **Tab 2: Regional Emissions Analysis** 
- Select from three chart types:
  - "Emissions per Region": Faceted bar charts by year
  - "Region with Highest Emissions": Annual top emitter by region
  - "Country with Highest Emissions": Annual top emitter by country
- Interactive tooltips provide detailed information

### **Tab 3: Energy-Emission Correlation**
- Scatter plot showing relationship between energy use and emissions per capita
- Color-coded by country for easy identification
- Demonstrates strong positive correlation (r = 0.95)

### **Tab 4: Manufacturing Emissions**
- Toggle between regional and country-level analysis
- Adjust year range with the slider
- Line charts show temporal trends in manufacturing emissions

## **Technical Implementation**

### **Data Processing**
- **API Integration**: World Bank API calls using `httr2` package
- **Data Cleaning**: Removal of years with incomplete data (2000-2003, 2015-2016)
- **Data Merging**: Combination of multiple indicators using `merge()` function
- **Regional Classification**: Custom region assignment using `case_when()`

### **Visualization Framework**
- **Base Graphics**: `ggplot2` for static visualizations
- **Interactivity**: `plotly` for enhanced user interaction
- **Dashboard Framework**: `shinydashboard` with responsive layout
- **UI Components**: Dynamic sidebar inputs based on selected tabs

### **Key Technical Features**
- Reactive data filtering based on user inputs
- Conditional rendering of different chart types
- Responsive design with information boxes
- Optimized data processing for smooth interactivity

## **Key Insights**

### **Global Trends**
- **Dramatic Increase**: CO2 emissions showed consistent upward trend from 2004-2014
- **Peak Growth Period**: 2010-2011 saw the largest year-over-year increase (1,135,173 kt)

### **Regional Patterns**
- **East Asia & Pacific**: Highest emitting region (2005-2014), primarily driven by China
- **Manufacturing Dominance**: East Asia & Pacific leads in manufacturing-related emissions
- **Historical Leadership**: North America was the top emitter only in 2004

### **Correlation Findings**
- **Population-Emissions**: Strong correlation (r = 0.90) at country level
- **Energy-Emissions**: Very strong correlation (r = 0.95) for per capita metrics
- **Manufacturing Impact**: Significant contributor to regional emission patterns

## **Data Quality & Limitations**
- **Time Period**: Limited to 2004-2014 due to data availability
- **Country Coverage**: 14 countries selected for regional diversity
- **Missing Data**: Years 2000-2003 and 2015-2016 excluded due to incomplete records
- **API Dependency**: Real-time data fetching requires internet connection

## **Future Enhancements**
- Extend analysis to more recent years (2015-present)
- Include additional countries and regions
- Add predictive modeling capabilities
- Implement data export functionality
- Include additional environmental indicators (methane, renewable energy usage)
- Add economic context (GDP, trade data)

## **Author**
**Ioane Meparishvili**  

## **Contact**
Ioane Meparishvili - meparishvili.ioane.work@gmail.com
