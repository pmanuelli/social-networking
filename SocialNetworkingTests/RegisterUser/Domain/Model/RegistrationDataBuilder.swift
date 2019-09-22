
@testable import SocialNetworking

class RegistrationDataBuilder {
    
    private var username = "mjkeenan"
    
    func withUsername(_ username: String) -> RegistrationDataBuilder {
        self.username = username
        return self
    }
    
    func build() -> RegistrationData {
        return RegistrationData(username: username, password: "password",
                                givenName: "Maynard James", familyName: "Keenan")
    }
}
