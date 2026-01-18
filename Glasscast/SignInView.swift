//
//  LoginView.swift
//  Glasscast
//
//  Created by Surya Sai Gopalam on 17/01/26.
//


import SwiftUI

struct SignInView: View {

    @Environment(\.colorScheme) private var colorScheme

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isAlert = false
    
    @Binding var authenMode:AuthenMode
    
   @Environment(ViewModel.self) var viewModel
    
    @State var success = false
    @State var error = ""

    var body: some View {
        ZStack {

            backgroundView

            VStack(spacing: 32) {

                headerView

                glassCard

                Spacer()
                if !error.isEmpty {
                    Text(error)
                }
              
                
            }
            .padding(.top, 60)
        }
        .alert(
                   "Authentication Failed",
                   isPresented: $isAlert
               ) {
                   Button("Try Again") {
                       isAlert = false
                   }
                   
               } message: {
                   Text(error)
               }
    }

    // MARK: - Background
    private var backgroundView: some View {
        LinearGradient(
            colors: colorScheme == .dark
                ? [Color.black, Color.gray.opacity(0.6)]
                : [Color.blue.opacity(0.7), Color.purple.opacity(0.6)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    // MARK: - Header
    private var headerView: some View {
        VStack(spacing: 6) {
            Text("Glasscast")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.primary)

            Text("Sign in to continue")
                .foregroundStyle(.secondary)
        }
        
    }

    // MARK: - Glass Card
    private var glassCard: some View {
        VStack(spacing: 18) {

            TextField("Email ID", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding()
                .glassEffect()

            SecureField("Password", text: $password)
                .padding()
                .glassEffect()

            Button {
                Task {
                    await Signin()
                }
            } label:{
                Text("Sign In")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(Color.blue.gradient)
            }
            .glassEffect()
            Text("(OR)")
                .fontWeight(.semibold)
            
            Button(action: SignUp) {
                Text("Sign Up")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(Color.red.gradient)
            }
            .glassEffect()
        }
        .padding(24)
        .glassEffect(in: RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(
                    colorScheme == .dark
                        ? Color.white.opacity(0.15)
                        : Color.white.opacity(0.25),
                    lineWidth: 1
                )
        )
        .padding(.horizontal)
    }

    // MARK: - Action
    private func Signin() async {
        print("Email:", email)
        print("Password:", password)
        do {
            try await viewModel.Authenticate(email: email, password: password, authenMode: .SignIn)
            error = "LogIn Success"
        }catch {
            self.isAlert = true
            self.error = error.localizedDescription
        }
    }
    
    private func SignUp() {
        authenMode = .SignUp
    }
}

#Preview("Light Mode") {
    SignInView(authenMode:.constant(AuthenMode.SignIn))
        .preferredColorScheme(.light)
        .environment(ViewModel())
}

#Preview("Dark Mode") {
    SignInView(authenMode:.constant(AuthenMode.SignIn))
        .environment(ViewModel())
        .preferredColorScheme(.dark)
}
