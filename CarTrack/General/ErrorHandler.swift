//
//  ErrorHandler.swift
//  CarTrack
//
//  Created by SCTT CDMS on 6/5/21.
//

import Foundation

enum TextFieldValidationError: Error {
    case userNameEmpty
    case pwdNameEmpty
}

enum AuthenticationError: Error {
    case credentialNotMatch
    case noRecordExist
    case featchingDataFailed
    case success
}

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

