# CareemAssessment
This sample app has been developed for Careem to asses my coding skills.
The app fetches a list of popular movies from themoviedb.org using their api.

## Features
- Display a list of movies
- Filter movies locally on release date.
- Filter movies via api based on genre.
- View Detail page by tapping a movie.

## Getting Started

### Preqeuisites
- Download and install Xcode. Preferably xcode 11.1 or above
- Git must be installed on mac. [Install Git on Mac](https://www.atlassian.com/git/tutorials/install-git).
- Minimum target is set to iOS 12 so app will not run on device having an iOS less than 12.0
- App is built for iphone family only meaning no ipad support.

### Cloning the Repo
- Use git clone to download this sample. [Git Clone](https://www.atlassian.com/git/tutorials/setting-up-a-repository/git-clone).
- Link to repo [clone](https://github.com/RajeelTintash/CareemAssessment.git)
- Optional you can manually download as zip.

### Running the app
- Open the project using the *CareemAssessment.xcodeproj* file.
- Run the project by selecting a simulator.
- Optional to run on a device please enter your apple id info in xcode-> preferences ->accounts.

## Using the app
- When run the app opens and fetches a list of movies.
- Filters can be applied and cleared by using the buttons in the top left and right corners.
- Tapping on a movie opens its detail page.
- Supports endless fetching of movie pages (upto 10000 pages) while not filtering by scrolling to the bottom of the list.
- App moniters the phone language and changing the phone language will fetch results from the api in the phone's selected langauge.
- Optional the app does not support a seperate UI for landscape orientation but is built using auto laypout so same layout will work if rotated to landscape mode.

## Technical Details
- The app does not use any third party code, library or sdk.

### Architecture
- The app uses MVVM architecture.
- The network layer is created based on protcolo oriented principles
- Internet Reachability is monitered via Network Path Moniter which requires iOS 12 and above.

### Directory Structure
- AppSource group contains The UI, NetworkLayer and Utilities grousps which contain their repective code.

### Unit Tests
- The app includes unit testing to test api's and generation of DTO's

### Build Details
- Built using Xcode 11.1 GM Seed
- Deplopyment target 12.0.
- Built for iphone only.
- Tested on iphone X.
- Tested in iphone 8 Simulator.

## Author
- **Syed Rajeel Amjad** [Profile](https://www.linkedin.com/in/rajeel-amjad/)

## License
- See [License.md](https://github.com/RajeelTintash/CareemAssessment/blob/master/LICENSE)
