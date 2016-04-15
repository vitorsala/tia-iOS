//
//  TIAServer.swift
//  MackTIA
//
//  Created by Joaquim Pessoa Filho on 14/04/16.
//  Copyright © 2016 Mackenzie. All rights reserved.
//

import Foundation
import Alamofire


enum ServiceURL:String {
    case Login          = "https://www3.mackenzie.com.br/tia/tia_mobile/ping.php"
    case Grades         = "https://www3.mackenzie.com.br/tia/tia_mobile/notas.php"
    case Absence        = "https://www3.mackenzie.com.br/tia/tia_mobile/faltas.php"
    case ClassSchedule  = "https://www3.mackenzie.com.br/tia/tia_mobile/horarios.php"
}

class TIAServer {
    
    // MARK: Singleton Methods
    static let sharedInstance = TIAServer()
    
    private init() {
        if let path = NSBundle.mainBundle().pathForResource("token", ofType: "plist") {
            let tokenDict = NSDictionary(contentsOfFile: path)
            self.token_part1 = tokenDict!.valueForKey("part_1") as! String
            self.token_part2 = tokenDict!.valueForKey("part_2") as! String
        } else {
            print(#function, "There are a problem in token.plist")
            self.token_part1 = ""
            self.token_part2 = ""
        }
    }
    
    // MARK: Security Parameters and Methods
    var credentials:(tia:String,password:String,campus:String)?
    private var token_part1:String
    private var token_part2:String
    
    private func makeToken() -> String {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: date)
        
        var day = "\(components.day)"
        var month = "\(components.month)"
        let year = "\(components.year)"
        
        if (components.day < 10) {
            day = "0\(day)"
        }
        
        if (components.month < 10) {
            month = "0\(month)"
        }
        
        let token = "\(self.token_part1)\(month)\(year)\(day)\(self.token_part2)"
        
        return token.md5
    }
    
    
    // MARK: Server Communication
    
    private func getRequestParameters() -> [String:String] {
        let parameters = [
            "mat": self.credentials?.tia ?? " ",
            "pass": self.credentials?.password ?? " ",
            "token": self.makeToken()
        ]
        
        return parameters
    }
    
    func sendRequet(service:ServiceURL, completionHandler:(jsonData:AnyObject?, error: ErrorCode?) -> Void) {
        
        if Reachability.isConnectedToNetwork() == false {
            completionHandler(jsonData: nil, error: ErrorCode.NoInternetConnection)
        }
        
        Alamofire.request(.POST, service.rawValue, parameters: self.getRequestParameters()).responseJSON { response in
            print(#function, response)
            
            if response.result.error != nil {
                print(#function, response.result.error)
                // TODO: Validar que este erro só acontecerá caso o dominio esteja errado
                completionHandler(jsonData: nil, error: ErrorCode.DomainNotFound)
            } else {
                completionHandler(jsonData: response.result.value, error: nil)
            }
        }
    }
}