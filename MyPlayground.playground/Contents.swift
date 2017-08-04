//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let  dateString = "2017-08-06T07:00:00-04:00"

let formatter = DateFormatter()
formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
let x = formatter.date(from: dateString)

