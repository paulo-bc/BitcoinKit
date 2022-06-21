//
//  File.swift
//  
//
//  Created by Paulo on 21/06/2022.
//

import YenomBitcoinKit
import XCTest

class BaseTestCase: XCTestCase {

    override class func setUp() {
        super.setUp()
        YenomBitcoinKit.RIPEMD160.hashFunction = RIPEMD160.hash(message:)
    }
}
