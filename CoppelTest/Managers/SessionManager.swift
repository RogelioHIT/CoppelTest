//
//  SessionManager.swift
//  CoppelTest
//
//  Created by Rogelio on 09/07/22.
//

import Foundation

class SessionManager {
    static let shared: SessionManager = SessionManager()
    
    private var sessionId: String?
    private var configuraion: TMDBConfiguration?
    
    private init() {}
    
    func updateSessionId(_ sessionId: String) {
        self.sessionId = sessionId
    }
    
    func updateConfiguration(_ configuration: TMDBConfiguration) {
        self.configuraion = configuration
    }
    
    func getImagesConfiguration() -> TMDBImageConfiguration? {
        return self.configuraion?.images
    }
}
