# Rick and morty internship app
## About app
Simple App displaying list of rick and morty characters. Data is fetched from  [rick and morty api]([https://www.genome.gov/](https://rickandmortyapi.com/)).
After clicking on character from list, user is redirected to screen with more details.

![image](https://github.com/Jbak12/R-MMoatable/assets/87420610/e1be6bc0-45f7-4be0-821b-77926875f44d)
![image](https://github.com/Jbak12/R-MMoatable/assets/87420610/7c948187-662a-4af4-bc47-1d299b03b4eb)

App handles errors from API and then presents Alert with given error message. App also lets user to reload data if something went wrong by dragging view.

![image](https://github.com/Jbak12/R-MMoatable/assets/87420610/f02b4ba5-f7fa-408c-a365-e84ad53f8ae1)
![image](https://github.com/Jbak12/R-MMoatable/assets/87420610/9abcbe47-7e17-4737-a78d-ff09868cf048)

Additionally, user can see info about app and rick and morty series by clicking info icon in right top corner of home view.

![image](https://github.com/Jbak12/R-MMoatable/assets/87420610/45b9f7f3-06ec-4c3b-bec3-5fb4fa047454)

## Tech stack and deployment target
App was written in swift and swiftUI, no external frameworks were used. App was developed in xcode 15.4 and using swift 5.9. Minimum deployment target for this app is ios 17.0. App utilizes new async await concurrency model for performing asynchronous and concurrent operations
## Architecture and structure.
App was developed using **MVVM(Model-View-ViewModel)** architectural pattern. Navigation in app was performed using NavigationStack. Factory method pattern was used for dependency injection and more flexible and scalable code.
For fetching data from Api app uses DataService class. For this cimplexity of app this one class is sufficient, but for better scalability it would be good approach to use some ApiManager class for fetching items using one generic function. 
