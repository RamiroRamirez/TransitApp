# TransitApp

## Concept

This app was created to show a solution to implement a transit tool based in a JSon which includes different route options to go from one point to another in the city of Berlin

## Requirements

To be able to run this project you need to do the following on your command line:
 
    $> git clone https://github.com/RamiroRamirez/TransitApp.git
    $> cd TransitApp 
    $> pod install
    
The project was written in swift 3 (Xcode 8.2.1), for +iOS 8.1 in device/simulator.

## Considerations

This solution is just a sketch and some parts need to be improved. The important part during the development of this example was to show good practices and basic UX concepts. 

Some external libraries are being used as helpers, but the most part of the code was developed by me.

As I already mentioned, the route information is based in a hardcoded JSon integrated in the app, so no matter which address (start and endpoint) you type, you will get always the same result.

Some tests are included, but definitely not enough (with unittest, never is enough :))

Enjoy, and if you have some comments/suggestions to improve the code, feel free to ping me or create a PR.

Cheers!!
