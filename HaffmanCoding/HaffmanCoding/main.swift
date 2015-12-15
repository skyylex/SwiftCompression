//
//  main.swift
//  HaffmanCoding
//
//  Created by Yury Lapitsky on 12/9/15.
//  Copyright © 2015 skyylex. All rights reserved.
//

import Foundation


let text = "MIT License"
let builder = HaffmanTreeBuilder(text: text)
let tree = builder.buildTree()

if let encodingMap = tree?.generateEncodingMap(), decodingMap = tree?.generateDecodingMap(), haffmanTree = tree {
    /// Validation of the encoding/decoding
    print("Validation of the tree: " + String(haffmanTree.validate()))
    
    print("Encoding map: " + String(encodingMap))
    
    var dataStorage = [[Bit]]()
    
    print ("Source text symbols count: " + String(text.characters.count))
    for char in text.characters {
        let key = String(char)
        if let value = encodingMap[char] {
            var digits = value.characters.map { $0 == "0" ? Bit.Zero : Bit.One }
            dataStorage.append(digits)
        }
    }
    
    let encodedInfo = BitsCoder.transform(dataStorage)
    
    print("Compressed amount: \(encodedInfo.bytes.count * bytesInUInt32)")
    
    let decodedString = BitsDecoder.decode(encodedInfo.bytes, decodingMap: decodingMap, digitsLeft:encodedInfo.digitsLeft)
    print(decodedString!)
}