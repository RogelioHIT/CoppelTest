//
//  SessionManager.swift
//  CoppelTest
//
//  Created by Rogelio on 09/07/22.
//

import Foundation

class SessionManager {
    static let shared: SessionManager = SessionManager()
    
    var sessionId: String?
    var configuraion: TMDBConfiguration?
    
    private init() {}
    
    func updateSessionId(_ sessionId: String) {
        self.sessionId = sessionId
    }
    
    func updateConfiguration(_ configuration: TMDBConfiguration) {
        self.configuraion = configuration
    }
}
