//
//  Font+Extensions.swift
//  Krypton
//
//  Created by Marco Margarucci on 08/09/23.
//

import Foundation
import SwiftUI

extension Font {
    
    public static var body: Font {
        return Font.custom("LexendDeca-Regular", size: 14)
    }
    
    public static var bodySemiBold: Font {
        return Font.custom("LexendDeca-SemiBold", size: 14)
    }
    
    public static var bodySemiBoldSmall: Font {
        return Font.custom("LexendDeca-SemiBold", size: 12)
    }
    
    public static var button: Font {
        return Font.custom("LexendDeca-SemiBold", size: 14)
    }
    
    public static var smallButton: Font {
        return Font.custom("LexendDeca-SemiBold", size: 12)
    }
    
    public static var caption: Font {
        return Font.custom("LexendDeca-Regular", size: 10)
    }
    
    public static var tabBar: Font {
        return Font.custom("LexendDeca-Regular", size: 12)
    }
    
    public static var info: Font {
        return Font.custom("LexendDeca-Regular", size: 10)
    }
    
    public static var infoLarge: Font {
        return Font.custom("LexendDeca-Regular", size: 16)
    }
    
    public static var settings: Font {
        return Font.custom("LexendDeca-Regular", size: 16)
    }
    
    public static var title: Font {
        return Font.custom("LexendDeca-Bold", size: 23)
    }
    
    public static var subTitle: Font {
        return Font.custom("LexendDeca-Regular", size: 14)
    }

    public static var pageTitle: Font {
        return Font.custom("LexendDeca-SemiBold", size: 33)
    }
    
    public static var textField: Font {
        return Font.custom("LexendDeca-SemiBold", size: 15)
    }
}
