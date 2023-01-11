//
//  ContentView.swift
//  42-swifty-companion
//
//  Created by Loic Fourmaux on 22/12/2022.
//

import SwiftUI

struct user: Codable{
    var login : String
    var correction_point : Int
    var wallet : Int
    var image: userImage
    var id: Int
    var projects_users : [projectInfo]
    var displayname : String
    var cursus_users : [cursus]
    var campus : [campus]
}

private var client_id: String {
  get {
    // 1
    guard let filePath = Bundle.main.path(forResource: "apiKeys", ofType: "plist") else {
      fatalError("Couldn't find file 'apiKeys.plist'. Check the apiKeys-Sample.plist file.")
    }
    // 2
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "CLIENT_ID") as? String else {
      fatalError("Couldn't find key 'CLIENT_ID' in 'apiKeys'.")
    }
    return value
  }
}

private var client_secret: String {
  get {
    // 1
    guard let filePath = Bundle.main.path(forResource: "apiKeys", ofType: "plist") else {
      fatalError("Couldn't find file 'apiKeys.plist'.")
    }
    // 2
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "CLIENT_SECRET") as? String else {
      fatalError("Couldn't find key 'CLIENT_SECRET' in 'apiKeys'.")
    }
    return value
  }
}


struct ContentView: View {
    @State private var text = ""
    @State var token : intraToken?
    @State var showUserInfo : Bool = false
    @State var userToDisplay : user?
    @State private var isEditing = false
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                ZStack{
                    Color("Primary").ignoresSafeArea()
                    Text("Search a 42 student").font(.system(size: 26, weight: .bold, design: .monospaced)).padding(.bottom, 150)
                    HStack{
                        TextField("Search user", text: $text)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .padding(.vertical,12)
                            .background(Color("secondBlue"))
                            .cornerRadius(20)
                            .padding(.horizontal, 15)
                            .disableAutocorrection(true)
                            .onSubmit {
                                getUserInfo(token: token!.access_token, input: text)
                            self.text = ""
                            self.showUserInfo = true
                            }
                    }
                }.onAppear{
                    userToDisplay = nil
                }
            }.navigationDestination(isPresented: $showUserInfo) {
                if (userToDisplay?.displayname != nil){
                    UserView(userInfos: userToDisplay)
                }
                else {
                    UserNotFoundView()
                }
            }
        }.onAppear(perform: getIntraToken)
    }
    
    func getIntraToken() {
        if (self.token != nil && self.token!.expires_in > 60){
            return
        }
        var done : Bool = false
        let url = URL(string: "https://api.intra.42.fr/oauth/token")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let postString = "grant_type=client_credentials&client_id=\(client_id)&client_secret=\(client_secret)";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            if let data = data  {
                let jsonDecoder = JSONDecoder()
                do {
                    let parsedJSON = try jsonDecoder.decode(intraToken.self, from: data)
                    self.token = parsedJSON
                } catch {
                    print(error)
                }
                done = true
            }
        }
        task.resume()
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while !done
    }
    
    func getUserInfo(token: String, input: String){
        print("in getUser \(token)")
        var done : Bool = false
        let sanitizedInput : String = input.replacingOccurrences(of: " ", with: "")
        let url = URL(string: "https://api.intra.42.fr/v2/users/" + sanitizedInput.lowercased())
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            if let data = data  {
                let jsonDecoder = JSONDecoder()
                do {
                    let parsedJSON = try jsonDecoder.decode(user.self, from: data)
                    self.userToDisplay = parsedJSON
                } catch {
                    print(error)
                }
                done = true
            }
        }
        task.resume()
        repeat {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        } while !done
    }
}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
