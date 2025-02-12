<h1>CO2 Emissions Per Capita Data Visualization</h1>

<h3>Overview</h3>

This R script processes and visualizes CO2 emissions per capita for a selection of countries from 1950 to 2022. The data is sourced from the file co2_pcap.csv, and the countries of interest include the G7 nations: USA, Canada, France, Germany, Italy, Japan, and the UK. The resulting plot shows the progression of CO2 emissions over time for each of these countries.
The visualization is saved as a PNG file named visualization.png with the following title: "G7 Countries CO2 Emissions per/Capita Progression 1950 - 2022".
Dependencies

The script uses the following R packages:
<p>tidyverse: A collection of R packages for data manipulation and visualization.</p>
<p>ggplot2: A package for creating high-quality plots and visualizations.</p>

You can install the required packages using the following commands if not already installed:
<pre>
  <code>
    install.packages("tidyverse")
    install.packages("ggplot2")
  </code>
</pre>

<h3>Script Breakdown</h3>

1. Data Import and Preparation

The co2_pcap.csv file is read into a data frame called data.
<pre>
  <code>
    data <- read_csv("co2_pcap.csv")
  </code>
</pre>

The script selects the columns related to the countries and the years between 1950 and 2022 from the dataset.
<pre>
  <code>
    data <- data |> select(country, "1950":"2022")
  </code>
</pre>


2. Data Cleaning

This line ensures that the data from certain years (2003, 2004, 2005, 2006, 2011, 2012, 2013) are treated as numeric values (doubles), while suppressing warnings.
<pre>
  <code>
    data[, c("2003", "2004", "2005", "2006", "2011", "2012", "2013")] <- suppressWarnings(lapply(data[,c("2003", "2004", "2005", "2006", "2011", "2012", "2013")], as.double))
  </code>
</pre>

Rows with missing values are removed from the dataset.
<pre>
  <code>
    data_clean <- na.omit(data)
  </code>
</pre>


3. Data Transformation

The data is pivoted from a wide format to a long format. Each year becomes a separate row, and the CO2 
emissions are stored in the co2_emissions column.
The data is grouped by country and arranged by year.
<pre>
  <code>
    data_clean <- data_clean |> pivot_longer(
    cols = -country,
    names_to = "year",
    values_to = "co2_emissions") |> 
    group_by(country) |> 
    arrange(country, year)
  </code>
</pre>

The year column is converted to a numeric type (double). The dataset is filtered to include only the G7 
countries (USA, Canada, France, Germany, Italy, Japan, and the UK).
<pre>
  <code>
    data_clean <- data_clean |> 
    mutate(year = as.double(year)) |> 
    filter(country %in% c("USA", "Canada", "France", "Germany", "Italy", "Japan", "UK"))
  </code>
</pre>


4. Data Visualization
   
A line plot is created using ggplot2 to visualize the CO2 emissions per capita over time for the selected countries.
The plot is customized with a color scale, a title, axis labels, and a classic theme.
<pre>
  <code>
    p <- ggplot(data_clean, aes(x = year, y = co2_emissions, group = country, color = country)) +
    geom_line() +
    scale_fill_viridis_d() +
    ggtitle("G7 Countries CO2 Emissions p/Capita Progression 1950 - 2022") +
    labs(
      x = "Year",
      y = "CO2 Emissions in Tonnes"
    ) +
    theme_classic()
  </code>
</pre>


6. Saving the Plot

The plot is saved as a PNG file (visualization.png) with the specified dimensions (2700x1800 pixels).
<pre>
  <code>
    ggsave(
    "visualization.png",
    plot = p,
    width = 2700,
    height = 1800,
    units = "px"
    )
  </code>
</pre>

<h3>Output</h3>

The script produces a line graph showing the trends of CO2 emissions per capita for the G7 countries between 1950 and 2022, which is saved in the visualization.png file.

<h3>Usage</h3>

<ul>
  <li>Ensure you have the required libraries installed.</li>
  <li>Place the co2_pcap.csv dataset in your working directory.</li>
  <li>Run the script to process the data and generate the plot.</li>
  <li>The plot will be saved as visualization.png in your working directory.</li>
</ul>


<h3>Notes</h3>

The script focuses on the CO2 emissions per capita for a subset of countries (G7). You may modify the list of countries in the filter function to include others as needed.

