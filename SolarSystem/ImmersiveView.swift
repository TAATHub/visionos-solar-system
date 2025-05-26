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
            let sphereMesh = MeshResource.generateSphere(radius: 0.1)
            
            // 赤いSimpleMaterialを作成（non-metallic）
            var redMaterial = SimpleMaterial()
            redMaterial.color = .init(tint: .red)
            redMaterial.metallic = 0.0
            
            // ModelComponentを追加
            sphereEntity.components.set(ModelComponent(mesh: sphereMesh, materials: [redMaterial]))
            
            // 中心点となるエンティティを作成
            let centerEntity = Entity()
            centerEntity.position = [0, 1, 0]
            
            // 球体を中心エンティティの子として追加
            centerEntity.addChild(sphereEntity)
            
            // 球体の相対位置を設定（半径1.0の位置）
            sphereEntity.position = [1.0, 0, 0]
            sphereEntity.scale = [1.0, 1.0, 1.0]
            
            // 中心エンティティをコンテンツに追加
            content.add(centerEntity)
            
            // 円運動のアニメーション設定
            let rotationDuration: TimeInterval = 5.0 // 5秒で1周
            
            // Y軸周りの回転アニメーションを作成
            let rotationAnimation = FromToByAnimation<Transform>(
                from: Transform(rotation: simd_quatf(angle: 0, axis: [0, 1, 0]), translation: .init(0, 1, 0)),
                to: Transform(rotation: simd_quatf(angle: 2 * .pi, axis: [0, 1, 0]), translation: .init(0, 1, 0)),
                duration: rotationDuration,
                timing: .linear,
                bindTarget: .transform
            )
            
            // アニメーションをループするように設定
            let animationResource = try! AnimationResource.generate(with: rotationAnimation)
            
            // アニメーションを開始
            centerEntity.playAnimation(animationResource.repeat())        }
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
