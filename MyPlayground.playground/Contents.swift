import UIKit
var seconds = 0
var minutes = 0
var hours = 0
var elapsedTime = 5000

let elapsedMinutes = Int(elapsedTime)/60
let elapsedSeconds = Double(elapsedTime).truncatingRemainder(dividingBy: 60.0)

seconds += Int(elapsedSeconds)

if (elapsedMinutes >= 60) {
    minutes = Int(Double(elapsedMinutes).truncatingRemainder(dividingBy: 60.0))
    hours += (elapsedMinutes / 60)
} else {
    minutes += elapsedMinutes
}
print("\(seconds) seconds added, \(minutes), minutes added, \(hours) hours added")
