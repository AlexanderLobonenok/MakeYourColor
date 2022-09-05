//
//  Services.swift
//  MakeYourColorApp
//
//  Created by Alexander Lobonenok on 5.09.22.
//

import UIKit

final class Services {
    static func rgbConvert(_ number: String?) -> Float {
        if let number = number {
            return (Float(number) ?? 0 > 1) ? 1 : Float(number) ?? 0
        }
        return 0
    }
}
