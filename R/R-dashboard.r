library(httr)
library(tidyverse)
library(dplyr)
library(httr2)
library(ggplot2)
library(readr)
library(plotly)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

#Concentration of this data analysis involves exploring CO2(carbon dioxide) levels across different countries , regions and
#possible factors that influence CO2 emissions . 
#every indicator is taken from WorldBank.

#for importing the data i used request function from httr2 package , for  getting request from worldbank based on specific URL
#request is saved in req variable 
#once request is executed , checked and converted , than variables are chosen and combined with tibble()
#also code converts  year values into numeric format with as.numeric()
#every following indicator was imported this way



#1 indicator - CO2 emission kt 
#this  variable shows us total CO2 emission per year  , per country in kiloton , which is unit of measurement for CO2
req <-request("https://api.worldbank.org/v2/country/GBR;DEU;IRL;SVN;USA;CAN;EGY;IRQ;SAU;LBN;CHN;AUS;THA;NZL/indicator/EN.ATM.CO2E.KT?per_page=1200&format=json&date=2000:2014")
req
req_dry_run(req)
response <- req_perform(req)
response
resp_status(response)
resp_status_desc(response)
result <- resp_body_json(response)
result <- result[[2]]

#result
Country <- unlist(lapply(result, '[[', "countryiso3code"))

CountryName <- unlist(lapply(result, function(x) x[["country"]][["value"]]))
Year <- unlist(lapply(result, '[[', "date"))
CO2_emmision_kt <- unlist(lapply(result, '[[', "value"))
view(CO2_emmision_kt)
CO2<-tibble(Country, Year, CO2_emmision_kt, CountryName)
CO2$Year<-as.numeric(CO2$Year)






#2 indicator - CO2 emissions from manufacturing industries % - in percent

req <-request("https://api.worldbank.org/v2/country/GBR;DEU;IRL;SVN;USA;CAN;EGY;IRQ;SAU;LBN;CHN;AUS;THA;NZL/indicator/EN.CO2.MANF.ZS?per_page=1200&format=json&date=2000:2014")
req
req_dry_run(req)
response <- req_perform(req)
response
resp_status(response)
resp_status_desc(response)
result <- resp_body_json(response)
result <- result[[2]]

#result
Country <- unlist(lapply(result, '[[', "countryiso3code"))

CountryName <- unlist(lapply(result, function(x) x[["country"]][["value"]]))
Year <- unlist(lapply(result, '[[', "date"))
emission_from_manufacturing <- unlist(lapply(result, '[[', "value"))
view(emission_from_manufacturing)
man<-tibble(Country, Year, emission_from_manufacturing, CountryName)
man$Year<-as.numeric(man$Year)



#3 indicator- population total , for each country

req <-request("https://api.worldbank.org/v2/country/GBR;DEU;IRL;SVN;USA;CAN;EGY;IRQ;SAU;LBN;CHN;AUS;THA;NZL/indicator/SP.POP.TOTL?per_page=1200&format=json&date=2000:2016")
req
req_dry_run(req)
response <- req_perform(req)
response
resp_status(response)
resp_status_desc(response)
result <- resp_body_json(response)
result <- result[[2]]

#result
Country <- unlist(lapply(result, '[[', "countryiso3code"))

CountryName <- unlist(lapply(result, function(x) x[["country"]][["value"]]))
Year <- unlist(lapply(result, '[[', "date"))
population_total <- unlist(lapply(result, '[[', "value"))
view(population_total)
POP<-tibble(Country, Year, population_total, CountryName)
POP$Year<-as.numeric(POP$Year)



# 4  indicator-  manufacturing % of GDP , this incidactor show us contribution of manufacturing sector to country's GDP

req <-request("https://api.worldbank.org/v2/country/GBR;DEU;IRL;SVN;USA;CAN;EGY;IRQ;SAU;LBN;CHN;AUS;THA;NZL/indicator/NV.IND.MANF.ZS?per_page=1200&format=json&date=2004:2014")
req
req_dry_run(req)
response <- req_perform(req)
response
resp_status(response)
resp_status_desc(response)
result <- resp_body_json(response)
result <- result[[2]]

#result
Country <- unlist(lapply(result, '[[', "countryiso3code"))

CountryName <- unlist(lapply(result, function(x) x[["country"]][["value"]]))
Year <- unlist(lapply(result, '[[', "date"))
manufacturing_percentage_GDP <- unlist(lapply(result, '[[', "value"))
view(manufacturing_percentage_GDP)
man_gdp<-tibble(Country, Year,manufacturing_percentage_GDP, CountryName)
man_gdp$Year<-as.numeric(man_gdp$Year)




#5 indicator  - CO2 emission per capital
req <-request("https://api.worldbank.org/v2/country/GBR;DEU;IRL;SVN;USA;CAN;EGY;IRQ;SAU;LBN;CHN;AUS;THA;NZL/indicator/EN.ATM.CO2E.PC?per_page=1200&format=json&date=2000:2014")
req
req_dry_run(req)
response <- req_perform(req)
response
resp_status(response)
resp_status_desc(response)
result <- resp_body_json(response)
result <- result[[2]]

#result
Country <- unlist(lapply(result, '[[', "countryiso3code"))

CountryName <- unlist(lapply(result, function(x) x[["country"]][["value"]]))
Year <- unlist(lapply(result, '[[', "date"))
emission_per_capital <- unlist(lapply(result, '[[', "value"))
view(CO2_emmision_kt)
per<-tibble(Country, Year, emission_per_capital, CountryName)
per$Year<-as.numeric(per$Year)




# 6 indicator  - Energy use (kg of oil equivalent per capital)
req <-request("https://api.worldbank.org/v2/country/GBR;DEU;IRL;SVN;USA;CAN;EGY;IRQ;SAU;LBN;CHN;AUS;THA;NZL/indicator/EG.USE.PCAP.KG.OE?per_page=1200&format=json&date=2000:2014")
req
req_dry_run(req)
response <- req_perform(req)
response
resp_status(response)
resp_status_desc(response)
result <- resp_body_json(response)
result <- result[[2]]

#result
Country <- unlist(lapply(result, '[[', "countryiso3code"))

CountryName <- unlist(lapply(result, function(x) x[["country"]][["value"]]))
Year <- unlist(lapply(result, '[[', "date"))
energy_usage_per_capital <- unlist(lapply(result, '[[', "value"))
view(CO2_emmision_kt)
energy<-tibble(Country, Year, energy_usage_per_capital, CountryName)
energy$Year<-as.numeric(energy$Year)



#now that all indicators are imported i am going to create dataframe with merge function to merge tibbles together
#i used merge() for combining  two tibbles  based on a common columns , which are:Year , Country and CountryName.



CO2_effects <- merge(CO2, man, by = c("Year", "Country", "CountryName"), all = TRUE)
CO2_effects <- merge(CO2_effects, POP, by = c("Year", "Country", "CountryName"), all = TRUE)
CO2_effects <- merge(CO2_effects, man_gdp, by = c("Year", "Country", "CountryName"), all = TRUE)
CO2_effects <- merge(CO2_effects, energy, by = c("Year", "Country", "CountryName"), all = TRUE)
CO2_effects <- merge(CO2_effects, per, by = c("Year", "Country", "CountryName"), all = TRUE)

# View the merged dataframe
view(CO2_effects)


#do i have any NAs??
anyNA(CO2_effects)

# i do have Nas because after importing data from 2000-2016 and than changing some variables , it appeared that
#some countries didn't have data from 2000-2003 , and from 2015-2016
#so i decided to reduce data 
#i used filter() from dplyr package

CO2_effects <- CO2_effects %>%
  filter(Year != 2000 & Year != 2001 , Year!=2002 , Year!=2003 , Year!=2015  , Year!=2016)
view(CO2_effects)
anyNA(CO2_effects)

#i also decided to add column  - Regions for grouping Countries that later i am going to use for my analysis
#i use case_when() from dplyr package , for multiple conditions


CO2_effects <- CO2_effects %>%
  mutate(Regions = case_when(
    Country %in% c("GBR", "DEU", "IRL", "SVN") ~ "Europe & Central Asia",
    Country %in% c("EGY", "IRQ", "SAU", "LBN") ~ "Middle East & North Africa",
    Country %in% c("CHN", "AUS", "THA", "NZL") ~ "East Asia & Pacific",
    Country %in% c("USA", "CAN") ~ "North America",
    TRUE ~ "false"
  ))

view(CO2_effects)


#for the next step i factored regions


CO2_effects$Regions <- factor(CO2_effects$Regions , levels =c("East Asia & Pacific" ,"North America", "Europe & Central Asia" , "Middle East & North Africa") , ordered=TRUE)


#finally , after creating dataframe from indicators i have total of 10 variables , my data covers years 2004-2014
# dataframe include 14 countries , i chose them from 4 regions for the analysis to be diverse and accurate  . 
#my data has total 10 column and 154 observation
#after filtering years  , data no longer has NAs


#Research questions


#research question N1

#How did CO2 emissions_kt change from 2000-2014? , this will be include on tab1 . 

#i wanted to show generally how did CO2 emission reduced or increased from 2000-2014 
#for this question i am going to use line chart  , because i want to show trend and pattern of CO2 emission.
#because i want to show emission per year , and years in my data include multiple countries
#i am going to sum up CO2 emissions from every country in each year 
# i used CO2 emission in kilotons  , kiloton is unit of measurement.

#i used group_by() to  group data(CO2_effects) by variable - Year , so that i will perform analysis based on each unique value of Year
#than i used summarize() to sum up emission each year and save it in a result(emission_each_year)
#i used piping %>% from dplyr for sequencing operations

emission_per_year<- CO2_effects  %>%
  group_by(Year) %>%
  summarize(emission_each_year=sum(CO2_emmision_kt))

 view(emission_per_year)

 
#plotting - using ggplot for visualization from ggplot2 package
#on X axis goes Year  , and on Y axis goes emission_each_year which i divided by 1000 for better perception.
 #this is time-series analysis , base on numeric variable in absolute number. 
 
change<- ggplot(data=emission_per_year) + aes(x=Year , y=emission_each_year/1000)+
  geom_line(color="red")+
  labs(x = "years" , y="emission from manufacturing") +
  ggtitle("changes in CO2 emission 2004-2014")+
  theme(plot.title = element_text(size = 12 , face = "bold"),
        axis.title= element_text(size = 11 , face = "bold"))+
  scale_x_continuous(breaks = seq(2004 , 2014 , by = 1), limits = c(2004 , 2014))

#i also added mouse-over tooltip
ggplotly(change)
  
#trend of a line is positive and it shows  drastic increase of emissions from 2004-2014.

# i wanted to show from year to year which period had the most increase in emission
#i added new new column to emission_per_year tibble,called difference in which i performed simple mathematical expression
#for 11 years  , i substracted current year's emission from following year's emission.

emission_per_year<- CO2_effects  %>%
  group_by(Year) %>%
  summarize(emission_each_year=sum(CO2_emmision_kt))%>%
  mutate(difference =c(
    emission_per_year$emission_each_year[1]- emission_per_year$emission_each_year[1],
    emission_per_year$emission_each_year[2] - emission_per_year$emission_each_year[1],
    emission_per_year$emission_each_year[3] - emission_per_year$emission_each_year[2],
    emission_per_year$emission_each_year[4] - emission_per_year$emission_each_year[3],
    emission_per_year$emission_each_year[5] - emission_per_year$emission_each_year[4],
    emission_per_year$emission_each_year[6] - emission_per_year$emission_each_year[5],
    emission_per_year$emission_each_year[7] - emission_per_year$emission_each_year[6],
    emission_per_year$emission_each_year[8] - emission_per_year$emission_each_year[7],
    emission_per_year$emission_each_year[9] - emission_per_year$emission_each_year[8],
    emission_per_year$emission_each_year[10] - emission_per_year$emission_each_year[9],
    emission_per_year$emission_each_year[11] - emission_per_year$emission_each_year[10]
  ))

view(emission_per_year)

# now i will arrange them by difference to show which row included highest number in difference
#this will show me result in console.
arrange(emission_per_year , difference , descending=TRUE)

#from 2010 -2011 emission increased the most by 1135173 kiloton



#research question N2 . 
    
#Is there a correlation with the population,  of a country and CO2 emission_kt?
#with a hypothesis , if country has larger population CO2 emission will be more.
# i will use scatter plot to show correlation with population on x axis and emission on y axis
#i divided population by 1000 for numbers on plot to be more understandable


#plotting
# this study is about correlation between 2 numerical discrete variables .(both in absolute numbers) 

pop<- ggplot(data=CO2_effects)+aes(x=population_total/100000 , y=CO2_emmision_kt/1000, fill=CountryName)+
  geom_point( size=2)+
  labs(x = "total population" , y="CO2 emission(kt)")+
  ggtitle("relationship between population and CO2 emission")+
  theme_minimal()+
  theme(plot.title = element_text(size = 14, face = "bold"))

ggplotly(pop)

#i wanted to show correlation coefficient
cor(CO2_effects$population_total, CO2_effects$CO2_emmision_kt)
#coefficient is 0.9016213 - which indicates strong positive relationship , when population grows , emission also grows.
#but than i filled scatter with Countrynames and that gave me different visual. 
#only china has visible correlation ,in other countries lines ar practically vertical.
#there might be other factors that influence Co2 emission with population. 

#i did not indclude this in my dashboard!!!!






#research question N3 - is there a correlation between manufacturing % and emission from manufacturing %
#i wanted  to see the relationship between how industrialized the country is and CO2 emission from it
#i chose the contribution of manufacturing sector to GDP in percentage as an indicator to show the degree of 
#industrialization of a country , because the degree of contribution from manufacturing sector is logical expression
#of country's industrialization . for second variable i chose emission from manufacturing , because it has the same base as first variable
#both variables are expressed in percentages. 

#plotting
# this analysis show correlation between 2 numerical variables(continuous , both in percentages)
M<- ggplot(data=CO2_effects)+aes(x=manufacturing_percentage_GDP, y=emission_from_manufacturing , color=CountryName)+
  geom_point( size=2)+
  labs(x = "manufacturing 5 of GDP" , y="emission from manufactuting")+
  ggtitle("relationship between manufacturing % and emission from manufacturing")+
  theme_minimal()+
  theme(plot.title = element_text(size = 14, face = "bold"))

ggplotly(M)

#correlation was not visible after filling points with country names  , there are vertical lines. 

#i did not include this in dashboard but kept the code!!!




#research question N4- showing emissions per region every year , this will be displayed on tab 2. 

#first i grouped data by Year and regions , and than summed up Co2 emissions in kilotons.

third <- CO2_effects %>%
  group_by(Year , Regions) %>%
  summarize(summary=sum(CO2_emmision_kt))


#plotting
#i have regions on x axis  , sum of emissions on y axis and regions as grouping variable that i added with fill
#with stat="identity" , i specified that heights of bars should be determined by summary/100
#than i created multiple facets for each year with facet_wrap()
#names on x axis were too big so i removed them by axis.text.x = element_blank() , because with colors you can already see the difference between regions.

# this analysis shows how CO2_emission (kt)  discrete variable is changing through categorical variable year, filled with regions(categorical variable) 
# chart shows distribution of CO2 emission through regions  and years . 

R<- ggplot(data=third)+aes(x=Regions , y=summary/100 , fill=Regions)+
  geom_bar(stat="identity" , color="black") +
  ggtitle("Emissions per region from 2000-2014")+
  facet_wrap(~Year , nrow=3) +
  theme(axis.text.x = element_blank() , 
        axis.text.y=element_text(size=10) , 
        plot.title = element_text(size=20,face="bold"))

ggplotly(R)
  
#plus i also wanted to see which Region emitted the most each year , i wanted to visualize it separately 
#this will also be displayed on tab 2 . 
  
#first , i grouped data by year and after i filtered df based on highest values each year . 
max_emission <- CO2_effects%>%
  group_by(Year ) %>%
  filter(CO2_emmision_kt == max(CO2_emmision_kt))
view(max_emission)


#plotting
#chart chows distribution of CO2 emission and how it is spread based on Regions and year . 

P<- ggplot(max_emission)+aes(x = Year, y =CO2_emmision_kt/100 , fill=Regions)+
  geom_bar(stat = "identity" , color="black")+
  labs(x = "Year",
       y = "CO2 Emission (kilotons)",
       fill = "Region")+
  ggtitle("Region with the Highest CO2 Emissions Each Year (2000-2014)")+
  theme(axis.text.x = element_text(size=10) , 
        axis.text.y=element_text(size=10) , 
        plot.title = element_text(size=20,face="bold"))+
  scale_x_continuous(breaks = seq(2004,2014 , by=1),limits = c(2003 , 2015))
                                 
ggplotly(P)
#from 2004 - 2014 East Asia and Pacific region  emitted the most except for year -2004 where leader is north america


# i also wanted to understand which country emitted the most CO2  , so i would understand contribution of each to Regions.
# this will also be displayed on tab2 . 
max_emission_2<- CO2_effects%>%
  group_by(Year) %>%
  filter(CO2_emmision_kt == max(CO2_emmision_kt))


#chart chows distribution of CO2 emission and how it is spread based on Countries and year . 

c<- ggplot(data=max_emission_2)+ aes(x = Year, y =CO2_emmision_kt/1000 ,fill = Country) +
  geom_bar(stat = "identity") +
  labs(  x = "Year",
         y = "CO2 Emission (kilotons)",
         fill = "Country")+
  ggtitle("Country with the Highest CO2 Emissions Each Year (2000-2014)")+
  theme(axis.text.x = element_text(size=10) , 
        axis.text.y=element_text(size=10) , 
        plot.title = element_text(size=20,face="bold"))+
  scale_x_continuous(breaks = seq(2004,2014 , by=1),limits = c(2003 , 2015))

 ggplotly(c)
#from 2005-2014 china emitted the most CO2 , in 2004 USA was the leader . china is the largest contributor for East Asia and pacific region
 


#research question N5-is there correlation between energy use and emission per capital
 #this plot will be displayed on tab 3  . 
#i took energy usage per capital as X , and emission per capital on Y

# both variables are continuous variables , they vary depending on factors , analysis shows correlation . 

cor<- ggplot(data=CO2_effects)+aes(x=energy_usage_per_capital , y=emission_per_capital , color=CountryName)+
  geom_point( size=2)+
  labs(x = "energy per capital" , y="emission per capital")+
  ggtitle("Relationship between energy consumption and emission per capital")+
  theme_minimal()+
  theme(plot.title = element_text(size = 14, face = "bold"))

ggplotly(cor)
#there is a strong positive relationship between these two variables

correl<-  cor(CO2_effects$energy_usage_per_capital , CO2_effects$emission_per_capital)
view(correl)
# correlation coefficient is  - 0.94748


#research question N6 , this will be displayed on tab 4 . 
#because manufacturing sector is important contributor to CO2 emissions i wanted to visualize
#average emissions from manufacturing  sector over the years for each region.
#i will use line chart fro time-series analysis  , with each region represented by a different colored line.

# i am using emission from manufacturing which is represented as percentage(CO2 emission % from total emission from manufacturing sector)
# so we can regard it as continuous variable . 
manufacturing <- CO2_effects %>%
  group_by(Year  , Regions) %>%
  summarise(av=mean(emission_from_manufacturing))
view(manufacturing)

L<- ggplot(data=manufacturing) +aes(x=Year , y=av, color=Regions)+
  geom_line(size=1)+
  labs(x = "years" , y="emission from manufacturing") +
  ggtitle("changes in CO2 emission from manufacturing for regions")+
  theme(plot.title = element_text(size = 12 , face = "bold"),
        axis.title= element_text(size = 11 , face = "bold"))+
  scale_x_continuous(breaks = seq(2004 , 2014 , by = 1), limits = c(2004 , 2014))

ggplotly(L)
# east Asia and pacific has most emissions from manufacturing



#same for countries , this will also be displayed at tab 4 . 

K<- CO2_effects %>%
  group_by(Year , CountryName)%>%
  summarise(AV=mean(emission_from_manufacturing))
            
            
            
view(K)

Count<- ggplot(data=K)+aes(x=Year , y=AV , color=CountryName)+
  geom_line(size=1)+
  labs(x = "years" , y="emission from manufacturing") +
  ggtitle("changes in CO2 emission from manufacturing for countries")+
  theme(plot.title = element_text(size = 12 , face = "bold"),
        axis.title= element_text(size = 11 , face = "bold"))+
  scale_x_continuous(breaks = seq(2004 , 2014 , by = 1), limits = c(2004 , 2014))

ggplotly(Count)





#now i am going to put my code in UI function to display my dashboard. 

# with dashboardPage i created a dashboard  with header, sidebar, and body.
#with dashboardHeader i wrote a title of the dashboard ("CO2 Effects").
#with dashboardSidebar contains  (uiOutput("sidebarInput")) that will provide  inputs based on the chosen tab.
#dashboardBody includes  tabsetPanel that chooses  between different tabs based on  selection (id = "tabs").
# i have total 4 different tabs

ui <- dashboardPage(
  dashboardHeader(title = "CO2 Effects"),
  dashboardSidebar(
    uiOutput("sidebarInput")
  ),
  dashboardBody(
    tabsetPanel(
      id = "tabs",
      tabPanel("CO2 emission change from 2004-2014", value = "tab1",
               h2("Change"),
               plotlyOutput("CO2Plot"),
               infoBox(
                 div(
                   style = "max-height: 150px; overflow-y: auto; font-size: 12px;",
                   "This line chart shows how CO2 emissions in kilotons changed from 2004-2014 , kiloton is unit of measurement for CO2 emission , for this analysis i summed up emissions from 14 different countries per year and displayed output , trend of a line is positive and it shows  drastic increase of emissions from 2004-2014, place your cursor to show the values."
                 ),
                 width = 12,
                 icon = icon("info-circle"),
                 title = "Info"
               )),
      tabPanel("CO2 emission per Region 2004-2014", value = "tab2",
               h2("Each Year"),
               plotlyOutput("RegionPlot"),
               infoBox(
                 div(
                   style = "max-height: 150px; overflow-y: auto; font-size: 12px;",
                 "This analysis shows what was the amout of emission in kilotons each year from 2004-2014 including every region in my dataset , plus i also wanted to see which Region and country  emitted the most each year , i wanted to visualize it separately , choose charts to display ,  place your cursor to see values."
                 ),
                 width = 12,
                 icon = icon("info-circle"),
                 title = "Info"
               )),
      tabPanel("Energy and Emission", value = "tab3",
               h2("Energy And Emission Per Capital"),
               plotlyOutput("energyPlot"),
               infoBox(
                 div(
                   style = "max-height: 150px; overflow-y: auto; font-size: 12px;",
                   "This analysis shows correlation between energy consumption per capital and emission per capital , there is a strong positive relationship between these two variables , place the cursor on dots to see values."
                 ),
                 width = 12,
                 icon = icon("info-circle"),
                 title = "Info"
               )),
      tabPanel("Emission from manufacturing", value = "tab4",
               h2("Manufacturing"),
               plotlyOutput("manufacturingPlot"),
               infoBox(
                 div(
                   style = "max-height: 150px; overflow-y: auto; font-size: 12px;",
                   "This analysis focuses on CO2 emission from manufacturing sector as a percentage , i chose emission from manufacturing , because manufacturing sector is on of the largest contributors to CO2 emission in general, place the cursor on lines to see values."
                 ),
                 width = 12,
                 icon = icon("info-circle"),
                 title = "Info"
               ))
    )
  )
)

server <- function(input, output, session) {
  Perr <- reactive({
    CO2_effects %>%
      filter(Year >= input$year_slider_tab1[1] & Year <= input$year_slider_tab1[2]) %>%
      group_by(Year) %>%
      summarise(emission_each_year = sum(CO2_emmision_kt))
  })
  
  third <- reactive({
    req(input$chart_choice)
    if (input$chart_choice == "Emissions per Region") {
      CO2_effects %>%
        group_by(Year, Regions) %>%
        summarise(summary = sum(CO2_emmision_kt))
    } else if (input$chart_choice == "Region with Highest Emissions") {
      CO2_effects %>%
        group_by(Year) %>%
        filter(CO2_emmision_kt == max(CO2_emmision_kt)) %>%
        select(Year, Regions, CO2_emmision_kt)
    } else if (input$chart_choice == "Country with Highest Emissions") {
      CO2_effects%>%
        group_by(Year) %>%
        filter(CO2_emmision_kt == max(CO2_emmision_kt))
    }
  })
  
  cor <- reactive({
    CO2_effects
  })
  
  manufacturing <- reactive({
    if (input$region_country == "Regions") {
      CO2_effects %>%
        filter(Year >= input$year_slider_tab4[1] & Year <= input$year_slider_tab4[2]) %>%
        group_by(Year  , Regions) %>%
        summarise(av=mean(emission_from_manufacturing))
    } else if (input$region_country == "Countries") {
      CO2_effects %>%
        filter(Year >= input$year_slider_tab4[1] & Year <= input$year_slider_tab4[2]) %>%
        group_by(Year , CountryName)%>%
        summarise(AV=mean(emission_from_manufacturing))
    }
  })
  
  output$CO2Plot <- renderPlotly({
    res1 <-  Perr() %>%
      ggplot(aes(x = Year, y = emission_each_year/ 1000)) +
      geom_line(color = "red") +
      labs(x = "Years", y = "CO2 Emission (kilotons)") +
      ggtitle("Changes in CO2 emission 2004-2014") +
      theme(plot.title = element_text(size = 12, face = "bold"),
            axis.title = element_text(size = 11, face = "bold")) +
      scale_x_continuous(breaks = seq(2004, 2014, by = 1), limits = c(2004, 2014))
    ggplotly(res1)
  })
  
  output$RegionPlot <- renderPlotly({
    req(input$chart_choice)
    if (input$chart_choice == "Emissions per Region") {
      third_data <- third()
      plot <- third_data %>%
        ggplot(aes(x = Regions, y = summary / 100, fill = Regions)) +
        geom_bar(stat = "identity", color = "black") +
        ggtitle("Emissions per region from 2000-2014") +
        facet_wrap(~Year, nrow = 3) +
        theme(axis.text.x = element_blank(),
              axis.text.y = element_text(size = 10),
              plot.title = element_text(size = 20, face = "bold"))
    } else if (input$chart_choice == "Region with Highest Emissions") {
      third_data <- third()
      plot <- third_data %>%
        ggplot(aes(x = Year, y = CO2_emmision_kt / 100, fill = Regions)) +
        geom_bar(stat = "identity", color = "black") +
        labs(x = "Year", y = "CO2 Emission (kilotons)", fill = "Region") +
        ggtitle("Region with the Highest CO2 Emissions Each Year (2000-2014)") +
        theme(axis.text.x = element_text(size = 10),
              axis.text.y = element_text(size = 10),
              plot.title = element_text(size = 20, face = "bold")) +
        scale_x_continuous(breaks = seq(2004, 2014, by = 1), limits = c(2003, 2015))
    } else if (input$chart_choice == "Country with Highest Emissions") {
      third_data <- third()
      plot <- third_data %>%
        ggplot(aes(x = Year, y =CO2_emmision_kt/1000 ,fill = Country)) +
        geom_bar(stat = "identity") +
        labs(  x = "Year",
               y = "CO2 Emission (kilotons)",
               fill = "Country")+
        ggtitle("Country with the Highest CO2 Emissions Each Year (2000-2014)")+
        theme(axis.text.x = element_text(size=10) , 
              axis.text.y=element_text(size=10) , 
              plot.title = element_text(size=20,face="bold"))+
        scale_x_continuous(breaks = seq(2004,2014 , by=1),limits = c(2003 , 2015))
    }
    
    ggplotly(plot)
  })
  
  output$energyPlot <- renderPlotly({
    cor() %>%
      ggplot(aes(x = energy_usage_per_capital, y = emission_per_capital, color = CountryName)) +
      geom_point(size = 2) +
      labs(x = "Energy per capita", y = "Emission per capita") +
      ggtitle("Relationship between energy consumption and emission per capita") +
      theme_minimal() +
      theme(plot.title = element_text(size = 14, face = "bold"))
  })
  
  output$manufacturingPlot <- renderPlotly({
    req(input$region_country)
    if (input$region_country == "Regions") {
      manufacturing() %>%
        ggplot(aes(x=Year , y=av, color=Regions))+
        geom_line(size=1)+
        labs(x = "years" , y="emission from manufacturing") +
        ggtitle("changes in CO2 emission from manufacturing for regions")+
        theme(plot.title = element_text(size = 12 , face = "bold"),
              axis.title= element_text(size = 11 , face = "bold"))+
        scale_x_continuous(breaks = seq(2004 , 2014 , by = 1), limits = c(2004 , 2014))
    } else if (input$region_country == "Countries") {
      manufacturing() %>%
        ggplot(aes(x=Year , y=AV , color=CountryName))+
        geom_line(size=1)+
        labs(x = "years" , y="emission from manufacturing") +
        ggtitle("changes in CO2 emission from manufacturing for countries")+
        theme(plot.title = element_text(size = 12 , face = "bold"),
              axis.title= element_text(size = 11 , face = "bold"))+
        scale_x_continuous(breaks = seq(2004 , 2014 , by = 1), limits = c(2004 , 2014))
    }
  })
  
  output$sidebarInput <- renderUI({
    if (input$tabs == "tab1") {
      tagList(
        sliderInput("year_slider_tab1", "Select Year:",
                    min = 2004, max = 2014, value = c(2004, 2014), step = 1)
      )
    } else if (input$tabs == "tab2") {
      selectInput("chart_choice", "Choose Chart:",
                  choices = c("Emissions per Region", "Region with Highest Emissions", "Country with Highest Emissions"))
    } else if (input$tabs == "tab4") {
      tagList(
        selectInput("region_country", "Choose Region/Country:",
                    choices = c("Regions", "Countries")),
        sliderInput("year_slider_tab4", "Select Year:",
                    min = 2004, max = 2014, value = c(2004, 2014), step = 1)
      )
    }
  })
  
}

shinyApp(ui = ui, server = server)


#I used conditionals for displaying different charts with different values.
