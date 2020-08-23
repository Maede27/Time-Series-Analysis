# Time-Series-Analysis
Gross Domestic Product (GDP) is one of the most widely used measures of an economy's output or production. It is defined as the total value of goods and services produced within a country's borders in a specific time period — monthly, quarterly or annually. 
GDP allows policymakers, economists and business to analyze the impact of economic shocks such as a spike in oil price, as well as tax and spending plans, on the overall economy and on specific components of it. Therefore, the analysis of GDP fluctuations during the time is mandatory for governments in order to predict the future condition of their economy.
# ARIMA
ARIMA stands for auto-regressive integrated moving average and is specified by these three order parameters: (p, d, q). An auto regressive (AR(p)) component is referring to the use of past values in the regression equation for the series Y. The auto-regressive parameter p specifies the number of lags used in the model . The d represents the degree of differencing in the integrated (I(d)) component. Differencing a series involves simply subtracting its current and previous values d times. Often, differencing is used to stabilize the series when the stationarity assumption is not met. A moving average (MA(q)) component represents the error of the model as a combination of previous error terms.
# Analysis of stationarity
A stationary process is a stochastic process whose parameters such as mean and variance do not change over time. Before fitting ARIMA model to the data, the stationarity of
the data must be checked.
# ACF and PACF Plots
ACF plots display correlation between a series and its lags. In addition to suggesting the order of differencing, ACF plots can help in determining the order of the M A (q) model.
Partial autocorrelation plots (PACF), as the name suggests, display correlat ion between a variable and its lags that is not explained by previous lags. PACF plots are useful when
determining the order of the AR(p) model.
