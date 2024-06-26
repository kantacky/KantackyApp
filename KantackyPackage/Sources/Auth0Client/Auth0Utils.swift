import Auth0
import Foundation

public enum Auth0Utils {
    static let path = Bundle.module.path(forResource: "Auth0", ofType: "plist")!
    static let configurations = NSDictionary(contentsOfFile: path)!
    static let clientId = configurations.value(forKey: "ClientId") as! String
    static let domain = configurations.value(forKey: "Domain") as! String

    public static let authentication = Auth0.authentication(clientId: clientId, domain: domain)
    public static let credentialsManager = Auth0.CredentialsManager(authentication: authentication)
}
