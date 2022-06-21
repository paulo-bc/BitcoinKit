//
//  TransactionSignerTests.swift
//  
//  Copyright © 2019 BitcoinKit developers
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

import XCTest
@testable import YenomBitcoinKit

class TransactionSignerTests: BaseTestCase {
    func testSign() {
        // Transaction on Bitcoin Cash Mainnet
        // TxID : 96ee20002b34e468f9d3c5ee54f6a8ddaa61c118889c4f35395c2cd93ba5bbb4
        // https://explorer.bitcoin.com/bch/tx/96ee20002b34e468f9d3c5ee54f6a8ddaa61c118889c4f35395c2cd93ba5bbb4

        let plan = TransactionPlan(unspentTransactions: [unspentTransaction], amount: 600, fee: 226, change: 4325)
        let toAddress = try! BitcoinAddress(cashaddr: "bitcoincash:qpmfhhledgp0jy66r5vmwjwmdfu0up7ujqcp07ha9v")
        let changeAddress = try! BitcoinAddress(cashaddr: "bitcoincash:qz0q3xmg38sr94rw8wg45vujah7kzma3cskxymnw06")
        let tx = TransactionBuilder.build(from: plan, toAddress: toAddress, changeAddress: changeAddress)

        let privKey = try! PrivateKey(wif: "L1WFAgk5LxC5NLfuTeADvJ5nm3ooV3cKei5Yi9LJ8ENDfGMBZjdW")
        let signer = TransactionSigner(unspentTransactions: plan.unspentTransactions, transaction: tx, sighashHelper: BCHSignatureHashHelper(hashType: .ALL))
        let signedTx = try! signer.sign(with: [privKey])
        let expected: Data = Data(hex: "0100000001e28c2b955293159898e34c6840d99bf4d390e2ee1c6f606939f18ee1e2000d05020000006b483045022100b70d158b43cbcded60e6977e93f9a84966bc0cec6f2dfd1463d1223a90563f0d02207548d081069de570a494d0967ba388ff02641d91cadb060587ead95a98d4e3534121038eab72ec78e639d02758e7860cdec018b49498c307791f785aa3019622f4ea5bffffffff0258020000000000001976a914769bdff96a02f9135a1d19b749db6a78fe07dc9088ace5100000000000001976a9149e089b6889e032d46e3b915a3392edfd616fb1c488ac00000000")
        XCTAssertEqual(signedTx.serialized(), expected)
        XCTAssertEqual(signedTx.txID, "96ee20002b34e468f9d3c5ee54f6a8ddaa61c118889c4f35395c2cd93ba5bbb4")
    }

    func testSignWithDustMixing() {
        // Transaction on Bitcoin Cash Mainnet
        // TxID : 96ee20002b34e468f9d3c5ee54f6a8ddaa61c118889c4f35395c2cd93ba5bbb4
        // https://explorer.bitcoin.com/bch/tx/96ee20002b34e468f9d3c5ee54f6a8ddaa61c118889c4f35395c2cd93ba5bbb4

        let plan = TransactionPlan(unspentTransactions: [unspentTransaction], amount: 600, fee: 226, change: 4325)
        let toAddress = try! BitcoinAddress(cashaddr: "bitcoincash:qpmfhhledgp0jy66r5vmwjwmdfu0up7ujqcp07ha9v")
        let changeAddress = try! BitcoinAddress(cashaddr: "bitcoincash:qz0q3xmg38sr94rw8wg45vujah7kzma3cskxymnw06")
        let tx = TransactionBuilder.build(from: plan, toAddress: toAddress, changeAddress: changeAddress, dustMixing: dustMixing)

        let privKey = try! PrivateKey(wif: "L1WFAgk5LxC5NLfuTeADvJ5nm3ooV3cKei5Yi9LJ8ENDfGMBZjdW")
        let signer = TransactionSigner(unspentTransactions: plan.unspentTransactions, transaction: tx, sighashHelper: BCHSignatureHashHelper(hashType: .ALL))
        let signedTx = try! signer.sign(with: [privKey])
        let expected: Data = Data(hex: "0100000002e28c2b955293159898e34c6840d99bf4d390e2ee1c6f606939f18ee1e2000d05020000006b483045022100f14a599e0d7bb8607041d7057d8c0f878a3e545250f2413683ed4769cffe3a3802201077f6d9d98d77392496face208d6a74ca83516fbb31d0156d47a620fa8effc54121038eab72ec78e639d02758e7860cdec018b49498c307791f785aa3019622f4ea5bffffffff4bef756159e10ae422958c6d5bb2574dfb3c86eedf2b78bfc5b5ddc347caa62e0000000000ffffffff0358020000000000001976a914769bdff96a02f9135a1d19b749db6a78fe07dc9088ace5100000000000001976a9149e089b6889e032d46e3b915a3392edfd616fb1c488ac22020000000000001976a914280f8f72d8292fae434ac6a464bf1e9bf84e20f288ac00000000")
        XCTAssertEqual(signedTx.serialized(), expected)
        XCTAssertEqual(signedTx.txID, "fad52e27400a94f7bfcbd3daca6cf68d804e2babcabf2ab4b260d21971dce6ae")
    }

    private var unspentTransaction: UnspentTransaction {
        // TransactionOutput
        let prevTxLockScript = Data(hex: "76a914aff1e0789e5fe316b729577665aa0a04d5b0f8c788ac")
        let prevTxOutput = TransactionOutput(value: 5151, lockingScript: prevTxLockScript)

        // TransactionOutpoint
        let prevTxID = "050d00e2e18ef13969606f1ceee290d3f49bd940684ce39898159352952b8ce2"
        let prevTxHash = Data(Data(hex: prevTxID).reversed())
        let prevTxOutPoint = TransactionOutPoint(hash: prevTxHash, index: 2)

        // UnspentTransaction
        let unspentTransaction = UnspentTransaction(output: prevTxOutput,
                                                    outpoint: prevTxOutPoint)
        return unspentTransaction
    }

    private var dustMixing: DustMixing {
        // TransactionOutput
        let prevTxLockScript = Data(hex: "00")
        let prevTxOutput = TransactionOutput(value: 546, lockingScript: prevTxLockScript)

        // TransactionOutpoint
        let prevTxID = "2ea6ca47c3ddb5c5bf782bdfee863cfb4d57b25b6d8c9522e40ae1596175ef4b"
        let prevTxHash = Data(Data(hex: prevTxID).reversed())
        let prevTxOutPoint = TransactionOutPoint(hash: prevTxHash, index: 0)

        // UnspentTransaction
        let unspentTransaction = UnspentTransaction(output: prevTxOutput,
                                                    outpoint: prevTxOutPoint)
        return DustMixing(
            unspentTransaction: unspentTransaction,
            amount: 546,
            outputScript: "76a914280f8f72d8292fae434ac6a464bf1e9bf84e20f288ac"
        )
    }
}

//{
//    "tx_hash": "4bef756159e10ae422958c6d5bb2574dfb3c86eedf2b78bfc5b5ddc347caa62e",
//    "tx_hash_big_endian": "2ea6ca47c3ddb5c5bf782bdfee863cfb4d57b25b6d8c9522e40ae1596175ef4b",
//    "tx_index": 0,
//    "tx_output_n": 189,
//    "script": "00",
//    "value": 546,
//    "value_hex": "00000222",
//    "confirmations": 1,
//    "output_script": "76a914280f8f72d8292fae434ac6a464bf1e9bf84e20f288ac",
//    "lock_secret": "b9ee9342e5f44ccdaaeba07ddb917f3a"
//}
