//
//  LoginModel.swift
//  CarTrack
//
//  Created by SCTT CDMS on 6/5/21.
//

import Foundation

struct LoginRequest : Encodable {
    let userName, password: String
}
