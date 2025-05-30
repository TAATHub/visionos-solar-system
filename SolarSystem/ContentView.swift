import SwiftUI
import RealityKit
// import RealityKitContent

struct ContentView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
        VStack(spacing: 40) {
            if let selectedBodyData = appModel.selectedCelestialBodyData,
               let selectedBody = selectedBodyData as? CelestialBody {
                VStack(spacing: 16) {
                    Text(selectedBody.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("基本情報")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Text("半径:")
                            Text("\(String(format: "%.2f", selectedBody.radius))倍 (地球比)")
                        }
                        
                        if selectedBody.name != "Sun" {
                            HStack {
                                Text("軌道半径:")
                                Text("\(String(format: "%.1f", selectedBody.orbitRadius)) AU")
                            }
                            
                            HStack {
                                Text("公転周期:")
                                Text("\(String(format: "%.2f", selectedBody.orbitPeriod))年 (地球比)")
                            }
                        }
                        
                        HStack {
                            Text("自転周期:")
                            Text("\(String(format: "%.1f", selectedBody.rotationPeriod))時間")
                        }
                        
                        HStack {
                            Text("軸の傾斜:")
                            Text("\(String(format: "%.1f", selectedBody.axialTilt))度")
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 5)
            } else {
                Text("天体をタッチして詳細を表示")
                    .foregroundColor(.secondary)
            }

            ToggleImmersiveSpaceButton()
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
