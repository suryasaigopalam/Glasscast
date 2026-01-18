//
//  AuthenView.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 18/01/26.
//

import SwiftUI

struct AuthenView: View {
    @State var authenMode = AuthenMode.SignIn
    var body: some View {
        switch authenMode {
        case .SignIn:
            SignInView(authenMode: $authenMode)
        case .SignUp:
            SignUpView(authenMode: $authenMode)
        }
    }
}

#Preview {
    AuthenView()
        .environment(ViewModel())
}
