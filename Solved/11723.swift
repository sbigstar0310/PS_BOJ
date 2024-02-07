// #11723

import Foundation

class FileIO {
    @inline(__always) private var buffer: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()) + [0], byteIdx = 0
    
    @inline(__always) private func readByte() -> UInt8 {
        defer { byteIdx += 1 }
        return buffer.withUnsafeBufferPointer { $0[byteIdx] }
    }
    
    @inline(__always) func readInt() -> Int {
        var number = 0, byte = readByte(), isNegative = false
        while byte == 10 || byte == 32 { byte = readByte() }
        if byte == 45 { byte = readByte(); isNegative = true }
        while 48...57 ~= byte { number = number * 10 + Int(byte - 48); byte = readByte() }
        return number * (isNegative ? -1 : 1)
    }
    
    @inline(__always) func readStirngSum() -> Int {
        var byte = readByte()
        while byte == 10 || byte == 32 { byte = readByte() }
        var sum = Int(byte)
        while byte != 10 && byte != 32 && byte != 0 { byte = readByte(); sum += Int(byte) }
        return sum - Int(byte)
    }
    
    @inline(__always) private func write(_ output: String) {
        FileHandle.standardOutput.write(output.data(using: .utf8)!)
    }
}

let fileIO = FileIO()
let M = fileIO.readInt()
var bit = 0
var resultString = ""

for _ in 1...M {
  let code = fileIO.readStirngSum()
  
  switch code {
  case 297:
    let x = fileIO.readInt()
    bit |= (1 << x)
  case 654:
    let x = fileIO.readInt()
    bit &= ~(1 << x)
  case 510:
    let x = fileIO.readInt()
    bit & (1 << x) != 0 ? resultString.append("1\n") : resultString.append("0\n")
  case 642:
    let x = fileIO.readInt()
    bit ^= (1 << x)
  case 313:
    bit |= (~0)
  case 559:
    bit &= 0
  default:
    break
  }
}

print(resultString)
