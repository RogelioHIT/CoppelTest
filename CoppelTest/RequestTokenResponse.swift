//
//  RequestTokenResponse.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import Foundation

/* Sample
{
  "success": true,
  "expires_at": "2016-08-26 17:04:39 UTC",
  "request_token": "ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd"
}
*/
struct RequestTokenResponse: Decodable {
    let success: Bool!
    let expires_at: String!
    let request_token: String!
}
