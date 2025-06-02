import SwiftUI

struct SettingsView: View {
    @Environment(AppModel.self) private var appModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        @Bindable var appModel = appModel
        
        NavigationView {
            VStack(spacing: 24) {
                // Immersion Style設定
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("没入スタイル")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("Mixed: 現実世界と仮想空間が混在、Full: 完全に仮想空間に没入")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Picker("Immersion Style", selection: $appModel.selectedImmersionStyleOption) {
                        ForEach(AppModel.ImmersionStylePickerOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.vertical, 8)
                
                Divider()
                
                // 軌道線表示設定
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("軌道線を表示")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("惑星の軌道を線で表示します")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $appModel.showOrbits)
                        .toggleStyle(SwitchToggleStyle())
                }
                .padding(.vertical, 8)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .navigationTitle("設定")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("完了") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
//        .presentationDetents([.medium])
//        .presentationDragIndicator(.visible)
    }
}

#Preview {
    SettingsView()
        .environment(AppModel())
} 
