# reference: https://plotly.com/r/choropleth-maps/

# import the two libraries needed.
# plotly for graphing, and rjson to open .json files
library(plotly)
library(rjson)

# the source of our map data 
url <- 'https://raw.githubusercontent.com/plotly/datasets/master/geojson-counties-fips.json'
# using json to open the map data
counties <- rjson::fromJSON(file=url)
# open a csv file with the data to populate our map
url2<- "https://raw.githubusercontent.com/plotly/datasets/master/fips-unemp-16.csv"
df <- read.csv(url2, colClasses=c(fips="character"))

# create a list with some of the map config data
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

# initialize our plotly object
fig <- plot_ly()

# create the basic map
fig <- fig %>% add_trace(
  type="choropleth",  # the type of plot we are creating
  geojson=counties, # reference the json file we opened
  locations=df$fips, # what value from the csv determines location on the map
  z=df$unemp, # what value from the csv is our z-axis
  colorscale="Viridis", # choosing a preset color scale
  zmin=0,
  zmax=12,
  marker=list(line=list(
    width=0)
  )
)

# add a title to the color bar
fig <- fig %>% colorbar(title = "Unemployment Rate (%)")
# add a title to the map
fig <- fig %>% layout(
  title = "2016 US Unemployment by County"
)

# utilize the list we created earlier in the plot
fig <- fig %>% layout(
  geo = g
)

# visualize the plot
fig
