//
//  SessionManager.swift
//  CoppelTest
//
//  Created by Rogelio on 09/07/22.
//

import Foundation

class SessionManager {
    static let shared: SessionManager = SessionManager()
    private let SESSION_ID_KEY = "session_id"
    
    private var sessionId: String?
    private var configuraion: TMDBConfiguration?
    
    private init() {
        sessionId = nil
        configuraion = nil
        sessionId = getSessionId()
    }
    
    func updateSessionId(_ sessionId: String) {
        self.sessionId = sessionId
        UserDefaults.standard.setValue(sessionId, forKey: SESSION_ID_KEY)
        UserDefaults.standard.synchronize()
    }
    
    func getSessionId() -> String? {
        if self.sessionId != nil {
            return self.sessionId
        }else {
            guard let savedSessionId = UserDefaults.standard.string(forKey: SESSION_ID_KEY) else {
                return nil
            }
            return savedSessionId
        }
    }
    
    func deleteSessionId() {
        self.sessionId = nil
        UserDefaults.standard.removeObject(forKey: SESSION_ID_KEY)
        UserDefaults.standard.synchronize()
    }
    
    func updateConfiguration(_ configuration: TMDBConfiguration) {
        self.configuraion = configuration
    }
    
    func getImagesConfiguration() -> TMDBImageConfiguration? {
        return self.configuraion?.images
    }
}
