import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)

                // Put skybox here.  See example in World project available at
                // https://developer.apple.com/
            }
            
            // 赤い球体のEntityを作成
            let sphereEntity = Entity()
            
            // プリミティブ球体のメッシュを作成
            let sphereMesh = MeshResource.generateSphere(radius: 0.5)
            
            // 赤いSimpleMaterialを作成（non-metallic）
            var redMaterial = SimpleMaterial()
            redMaterial.color = .init(tint: .red)
            redMaterial.metallic = 0.0
            
            // ModelComponentを追加
            sphereEntity.components.set(ModelComponent(mesh: sphereMesh, materials: [redMaterial]))
            
            // 位置とスケールを設定
            sphereEntity.position = [0, 1, 0]
            sphereEntity.scale = [1.0, 1.0, 1.0]
            
            // コンテンツに追加
            content.add(sphereEntity)
        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
