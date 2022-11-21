#  WheatherApp

An iOS an application in swift that shows the tommorow's weather for specific cities using the OpenWeatherMap (https://openweathermap.org/current) REST API.

#### Requirements : 
Swift 4.1, Xcode 11 above

#### Overview : 
In this project I have display tommorow's wheather forecast and details using MVVM architecture and along with some unit test cases.

#### Classes uses: 
* **ForecastViewController** : Display daily forecast details weather in listview. 
* **WheatherDetailViewController** : Display wheather more info in detail.

#### ViewModel: 
* **WheatherViewModel** : Logic to fetch data from server and perform operations.
* **WheatherWorker** : Worker is responsible to fetch data from network client and pass to view model.

'#### Network: 
* **NetworkClient** : Generic network Api call class.

#### Testing :
 ##### Unit test :
   **WheatherViewModelTest** : Testing fetch data from worker and operations on data like filter.
   **WheatherWorkerTest** : Testing wheather forecast api network call.


Thinks not able to complete :
 UI - User interface is compatible for all devices.(In Storyboard not set contraint properly)
