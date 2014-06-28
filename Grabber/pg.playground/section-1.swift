// Playground - noun: a place where people can play

import Cocoa

var aa: Array<AnyObject> = [1, 2, 4, "ds"]

func fn (obj: AnyObject) -> (AnyObject, AnyObject) {
    if obj is Int {
        return ("", "")
    }
    return (obj, obj)
}

aa.map(fn)

var s = ""
s.utf16count
