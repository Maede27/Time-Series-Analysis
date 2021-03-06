Data <- read.table(file.choose(), sep =",", header = TRUE)
# split date column into three separate columns(month,day,year) and then merge them into the original data-frame 
realdate<-as.Date(Data$date,format="%d-%m-%Y")
 dfdate <- data.frame(date=realdate)
year=as.numeric (format(realdate,"%Y"))
month=as.numeric (format(realdate,"%m"))
day=as.numeric (format(realdate,"%d"))

#merge them into the original data-frame
Data_1<-cbind(Data,day,month,year)
colnames(Data_1)
fix(Data_1)
library('ggplot2')
library('forecast')
library('tseries')
Data$date = as.Date(Data_1$date,format="%d-%m-%Y")
plot2 <- ggplot(Data_1, aes(date, gdp, group = 1)) +
         geom_point() +
         geom_line() +
         labs(x = "Date", y = "GDP", 
              title = "Gross domestic product growth rate")
plot2

#analysis of seasonality, trend, and cycle (decomposing the data)
timeseries= ts(na.omit(Data_1$gdp), frequency=5)
decomp = stl(timeseries, s.window="periodic")
deseasonal_gdp <- seasadj(decomp)
plot(decomp)
#Stationarity and nonStationarity
adf.test(timeseries, alternative = "stationary") # The series is not stationary 
#Autocorrelations
Acf(timeseries, main='')
Pacf(timeseries, main='')

#Differencing of order 1 terms
timeseries_d1 = diff(deseasonal_gdp, differences = 1)
plot(timeseries_d1)
adf.test(timeseries_d1, alternative = "stationary")
#ACF and PACF plots for differenced data
Acf(timeseries_d1, main='ACF for Differenced Series')
Pacf(timeseries_d1, main='PACF for Differenced Series')

#ARIMA Model
model<-auto.arima(deseasonal_gdp, seasonal=FULSE)
model
tsdisplay(residuals(model), lag.max=35, main='(0,1,1) Model Residuals')

#ARIMA Model_2
Model_2 = arima(deseasonal_gdp, order=c(0,1,5))
Model_2
tsdisplay(residuals(Model_2), lag.max=35, main='Seasonal Model Residuals')

#Forcasting the future data
ForC <- forecast(Model_2, h=5)
plot(ForC)
#Cross validation for final model (ARIMA(0,1,5)) 

train = Data_1[1:27,1]
test = Data_1[28:34, 1]
fit = Arima(train, order=c(0,1,5))
preds = as.vector(forecast(fit, h = length(test))$mean)
RMSE = sqrt(mean((preds - as.vector(test)) ^ 2))
RMSE
fcast <- forecast(fit,h=5)
plot(fcast, main=" ")
lines(ts(deseasonal_gdp))

#Linear regression
fitreg <- lm(Data_1$gdp ~  Data_1$year +Data_1$month  , data=Data_1)
summary(fitreg )
coefficients(fitreg )

#Cross Validation for Linear Regression
library('DAAG')
cv.lm(data=Data_1, fitreg, m=5)
