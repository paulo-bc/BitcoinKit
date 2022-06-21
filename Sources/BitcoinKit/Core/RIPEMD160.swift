//
//  File.swift
//  
//
//  Created by Paulo on 21/06/2022.
//

import Foundation

public final class RIPEMD160 {
    public static var hashFunction: ((Data) -> Data)?

    static func hash(message: Data) -> Data {
        hashFunction!(message)
    }
}
