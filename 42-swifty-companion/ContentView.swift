//
//  ContentView.swift
//  42-swifty-companion
//
//  Created by Loic Fourmaux on 22/12/2022.
//

import SwiftUI

struct campus : Codable{
    var id : Int
    var name : String
}
struct skill : Codable{
    var id : Int
    var name : String
    var level : Float
}
struct intraToken: Codable{
    var access_token : String
    var token_type : String
    var scope : String
    var created_at : Int
    var expires_in : Int
}

struct sizes:Codable{
    var large : String
    var medium : String
    var small : String
    var micro : String
}

struct userImage: Codable{
    var link : String
    var versions : sizes
}
struct project: Codable{
    var id : Int
    var name : String
}
struct projectInfo: Codable{
    var id : Int
    var final_mark : Int?
    var status : String
    var project : project
}

struct cursus : Codable{
    var level : Float
    var skills : [skill]
}
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

struct ContentView: View {
    @State private var text = ""
    @State var token : String = ""
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
                        TextField("Login of the user ...", text: $text)
                            .padding(7)
                            .padding(.vertical,12)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal, 10)
                            .shadow(color: Color("Shadow"), radius: 15, x:0, y: 0)
                            .onTapGesture {
                                self.isEditing = true
                            }
                        
                        if isEditing {
                            Button(action: {
                                self.isEditing = false
                                if (token == ""){
                                        getIntraToken()
                                    }
                                    getUserInfo(token: token, input: text)
                                    self.text = ""
                                    self.showUserInfo = true
                            }) {
                                Text("Search")
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                        }
                    }
                }
            }.navigationDestination(isPresented: $showUserInfo) {
                UserView(userInfos: userToDisplay)
            }
        }
    }
    
    func getIntraToken() {
        var done : Bool = false
        let url = URL(string: "https://api.intra.42.fr/oauth/token")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        let postString = "grant_type=client_credentials&client_id=u-s4t2ud-32c9b111c399d43e31e905dfb3ebaab6fa19eda176410322a0f188a362cc0b96&client_secret=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";
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
                    print("1st \(parsedJSON.access_token)")
                    self.token = parsedJSON.access_token
                    print("2nd \(token)")
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
        var done : Bool = false
        let url = URL(string: "https://api.intra.42.fr/v2/users/" + input.lowercased())
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
                    print(parsedJSON)
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
