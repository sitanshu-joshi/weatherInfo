# weatherInfo
This is an app based on weather &amp; forecast information with live data form weatherinfo.org.


# Install RestKit from cocoapods

sudo gem install cocoapods
/*
Wait for Process To be completed
after cocoapods installed
*/

pod setup
/*
Wait for Setup Completion
After Setup completed
*/

Move to Project Directory

touch podfile 

Add Platform and Third Party Framework with Version

platform :ios, '5.0'
pod 'RestKit', '~> 0.20.0'

Close Podfile

pod install
Wait for installation to be completed

Now RestKit is integrated in your Project. Open Workspace instead of xcodeproject.

# After Implemented weatherInfo app with RestKit:

