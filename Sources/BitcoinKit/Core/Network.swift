//
//  Network.swift
//
//  Copyright © 2018 Kishikawa Katsumi
//  Copyright © 2018 BitcoinKit developers
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public class Network {
    public static let mainnetBCH: Network = BCHMainnet()
    public static let testnetBCH: Network = BCHTestnet()
    static let mainnetBTC: Network = BTCMainnet()
    static let testnetBTC: Network = BTCTestnet()

    /// Network name i.e. livenet/testnet
    var name: String { fatalError("Network.name must be implemented.") }
    /// Network name alias i.e. mainnet/regtest
    var alias: String { fatalError("Network.alias must be implemented.") }
    /// Address Scheme
    var scheme: String { fatalError("Network.scheme must be implemented.") }
    /// BIP44 CoinType
    var coinType: CoinType { fatalError("Network.coinType must be implemented.") }

    /// pubkeyhash version byte
    var pubkeyhash: UInt8 { fatalError("Network.pubkeyhash must be implemented.") }
    /// privatekey version byte
    var privatekey: UInt8 { fatalError("Network.privatekey must be implemented.") }
    /// scripthash version byte
    var scripthash: UInt8 { fatalError("Network.scripthash must be implemented.") }
    /// xpubkey version byte
    var xpubkey: UInt32 { fatalError("Network.xpubkey must be implemented.") }
    /// xprivkey version byte
    var xprivkey: UInt32 { fatalError("Network.xprivkey must be implemented.") }

    /// Network magic
    var magic: UInt32 { fatalError("Network.magic must be implemented.") }
    /// Port number
    var port: UInt32 { fatalError("Network.port must be implemented.") }
    /// DNS seeds
    var dnsSeeds: [String] { fatalError("Network.dnsSeeds must be implemented.") }
    /// Genesis Block
    var genesisBlock: Data { fatalError("Network.genesisBlock must be implemented.") }

    fileprivate init() {}
}

extension Network: Equatable {
    // swiftlint:disable operator_whitespace
    public static func ==(lhs: Network, rhs: Network) -> Bool {
        return lhs.name == rhs.name
            && lhs.pubkeyhash == rhs.pubkeyhash
            && lhs.privatekey == rhs.privatekey
            && lhs.scripthash == rhs.scripthash
            && lhs.xpubkey == rhs.xpubkey
            && lhs.xprivkey == rhs.xprivkey
            && lhs.magic == rhs.magic
            && lhs.port == rhs.port
    }
}

class BTCMainnet: Mainnet {
    override var scheme: String {
        return "bitcoin"
    }
    override var magic: UInt32 {
        return 0xf9beb4d9
    }
    override var coinType: CoinType {
        return .btc
    }
    override var dnsSeeds: [String] {
        return [
            "seed.bitcoin.sipa.be",         // Pieter Wuille
            "dnsseed.bluematt.me",          // Matt Corallo
            "dnsseed.bitcoin.dashjr.org",   // Luke Dashjr
            "seed.bitcoinstats.com",        // Chris Decker
            "seed.bitnodes.io",             // Addy Yeow
            "bitseed.xf2.org",              // Jeff Garzik
            "seed.bitcoin.jonasschnelli.ch", // Jonas Schnelli
            "bitcoin.bloqseeds.net",        // Bloq
            "seed.ob1.io"                  // OpenBazaar
        ]
    }
}

class BTCTestnet: Testnet {
    override var scheme: String {
        return "bitcoin"
    }
    override var magic: UInt32 {
        return 0x0b110907
    }
    override var dnsSeeds: [String] {
        return [
            "testnet-seed.bitcoin.jonasschnelli.ch", // Jonas Schnelli
            "testnet-seed.bluematt.me",              // Matt Corallo
            "testnet-seed.bitcoin.petertodd.org",    // Peter Todd
            "testnet-seed.bitcoin.schildbach.de",    // Andreas Schildbach
            "bitcoin-testnet.bloqseeds.net"         // Bloq
        ]
    }
}

class BCHMainnet: Mainnet {
    override var scheme: String {
        return "bitcoincash"
    }
    override var magic: UInt32 {
        return 0xe3e1f3e8
    }
    override var coinType: CoinType {
        return .bch
    }
    override var dnsSeeds: [String] {
        return [
            "seed.bitcoinabc.org", // - Bitcoin ABC seeder
            "seed-abc.bitcoinforks.org", // - bitcoinforks seeders
            "btccash-seeder.bitcoinunlimited.info", // - BU seeder
            "seed.bitprim.org", // - Bitprim
            "seed.deadalnix.me", // - Amaury SÉCHET
            "seeder.criptolayer.net" // - criptolayer.net
        ]
    }
}

class BCHTestnet: Testnet {
    override var scheme: String {
        return "bchtest"
    }
    override var magic: UInt32 {
        return 0xf4e5f3f4
    }
    override var dnsSeeds: [String] {
        return [
            "testnet-seed.bitcoinabc.org",
            "testnet-seed-abc.bitcoinforks.org",
            "testnet-seed.bitprim.org",
            "testnet-seed.deadalnix.me",
            "testnet-seeder.criptolayer.net"
        ]
    }
}

class Mainnet: Network {
    override var name: String {
        return "livenet"
    }
    override var alias: String {
        return "mainnet"
    }
    override var pubkeyhash: UInt8 {
        return 0x00
    }
    override var privatekey: UInt8 {
        return 0x80
    }
    override var scripthash: UInt8 {
        return 0x05
    }
    override var xpubkey: UInt32 {
        return 0x0488b21e
    }
    override var xprivkey: UInt32 {
        return 0x0488ade4
    }
    override var port: UInt32 {
        return 8333
    }
    // These hashes are genesis blocks' ones
    override var genesisBlock: Data {
        return Data(Data(hex: "000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f").reversed())
    }
}

class Testnet: Network {
    override var name: String {
        return "testnet"
    }
    override var alias: String {
        return "regtest"
    }
    override var coinType: CoinType {
        return .testnet
    }
    override var pubkeyhash: UInt8 {
        return 0x6f
    }
    override var privatekey: UInt8 {
        return 0xef
    }
    override var scripthash: UInt8 {
        return 0xc4
    }
    override var xpubkey: UInt32 {
        return 0x043587cf
    }
    override var xprivkey: UInt32 {
        return 0x04358394
    }
    override var port: UInt32 {
        return 18_333
    }
    override var genesisBlock: Data {
        return Data(Data(hex: "000000000933ea01ad0ee984209779baaec3ced90fa3f408719526f8d77f4943").reversed())
    }
}
