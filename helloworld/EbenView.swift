//
//  EbenView.swift
//  helloworld
//
//  Created by erenkulaksiz on 12.12.2024.
//

import SwiftUI

struct EbenView: View {
    @State private var ipAddress: String? = ""
    
    var body: some View {
        VStack {
            ForEach(1...3, id: \.self) { x in
                Text("eben: \(x)")
            }
            if let ipAddress = ipAddress, !ipAddress.isEmpty {
                Text("IP Address: \(ipAddress)")
                    .foregroundColor(.blue)
            }
            Button(action: {
                Task {
                    await fetchIp()
                }
            }) {
                Text("Fetch IP")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }.padding()
    }
    
    private func fetchIp() async {
        let url = URL(string: "https://api.ipify.org?format=json")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let response = try? JSONDecoder().decode(IpResponse.self, from: data) {
                DispatchQueue.main.async {
                    ipAddress = response.ip
                }
            }
        } catch {
            print("Failed to fetch IP address: \(error)")
        }
    }
}

struct IpResponse: Codable {
    let ip: String
}
