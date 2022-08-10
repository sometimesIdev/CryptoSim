# CryptoSim
Another project adding some more advanced features than other projects here


This project is a basic crypto simulator.
It allows a user to track a crypto portfolio without actually having to spend real money and allows the user to track the investment.
Most assets and app design were originally provided by Nick Sarno.

## Basic Development features

### SwiftUI for the interface.
### An extended version of MVVM project architecture. (Not true MVVM)
### API calls to Coinbase API
### This project uses Core Data and user defaults for persistance.

Things that are not working correctly on this project.

  - The "x" button on the modal screens does not work.
  The reason for this is the design included a different way of dealing with modal screens that has since been depreciated.
  At the time of my execution of this project (about a year after it was first released) I probably would have just used a geometry reader for some of the header view animations.
  
  At the heart of the problem is the way the environment works with modals, and Nick's implementation worked fine when he made this project,
  but subsequent revisions to SwiftUI have deprecated the way he handled that feature, I just didn't see that I needed to fix that feature when
  I primarly was interested in extending my SwiftUI knowledge.

### If I was to go back and iterate on this project I would:

  - Add more data to the detail views. The coinbase API has a ton of data available that was not implemented.
  For instance, I would have added funcionality to track individual portfolio purchases over time.
  
  - Update the application to use newer Swift language features.
  I like that Nick used the Combine framework for keeping the data updated, but now that the new concurrency geatures are available in Swift.
  (including Actors & async/await I think that I would have taken the extra step to update the project to take advantage of them)
  
  - I think I also would have re-designed the way initial portfolio purchaes are done.
  The original project was not really intended as an app store release and I just find that the way you add crypto coins to your portfolio is a bit clunky
  
  


