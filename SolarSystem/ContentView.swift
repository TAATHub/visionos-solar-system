import SwiftUI
import RealityKit

struct ContentView: View {
    @Environment(AppModel.self) private var appModel
    @State private var showingSettings = false

    var body: some View {
        @Bindable var appModel = appModel
        
        VStack(spacing: 0) {
            // 天体情報表示部分
            if let selectedBodyData = appModel.selectedCelestialBodyData,
               let selectedBody = selectedBodyData as? CelestialBody {
                VStack(spacing: 16) {
                    Text(selectedBody.japaneseName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(selectedBody.description)
                        .font(.body)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 40)
            } else {
                Text("天体をタッチして詳細を表示")
                    .foregroundColor(.secondary)
                    .frame(maxHeight: .infinity)
            }
            
            Spacer(minLength: 0)

            ToggleImmersiveSpaceButton()
                .padding(.top, 40)
        }
        .padding(64)
        .frame(width: 800, height: 600)
        .overlay(alignment: .topTrailing) {
            Button(action: {
                showingSettings = true
            }) {
                Image(systemName: "gearshape.fill")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            .padding(40)
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
