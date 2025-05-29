import SwiftUI
import RealityKit

struct ImmersiveView: View {

    var body: some View {
        RealityView { content in
            // ECSシステムを登録
            OrbitSystem.registerSystem()
            RotationSystem.registerSystem()
            
            // 太陽系の天体を作成
            for (index, body) in SolarSystemData.celestialBodies.enumerated() {
                let entity = createCelestialBody(body)
                
                // 太陽以外の惑星には軌道コンポーネントを追加
                if body.name != "Sun" {
                    let orbitComponent = OrbitComponent(
                        radius: body.orbitRadius,
                        axis: [0, 1, 0],
                        period: TimeInterval(body.orbitPeriod),
                        centerPosition: [0, 1, 0]
                    )
                    entity.components.set(orbitComponent)
                    
                    // 初期位置を軌道上に設定
                    let angle = Float(index) * (2.0 * .pi / Float(SolarSystemData.celestialBodies.count - 1))
                    let x = body.orbitRadius * cos(angle)
                    let z = body.orbitRadius * sin(angle)
                    entity.position = [x, 1.0, z]
                } else {
                    // 太陽は中心に配置
                    entity.position = [0, 1, 0]
                }
                
                // 自転コンポーネントを追加
                let rotationComponent = RotationComponent(
                    axis: [0, 1, 0],
                    period: TimeInterval(body.rotationPeriod),
                    axialTilt: body.axialTilt
                )
                entity.components.set(rotationComponent)
                
                content.add(entity)
            }
        }
    }
    
    /// 天体のEntityを作成するヘルパー関数
    private func createCelestialBody(_ body: CelestialBody) -> Entity {
        let entity = Entity()
        
        // サイズを調整
        let baseRadius: Float = body.name == "Sun" ? body.radius : body.radius * 0.05 // 惑星は見やすくするために小さく調整
        
        // 球体メッシュを作成
        let sphereMesh = MeshResource.generateSphere(radius: baseRadius)
        
        // マテリアルを作成
        var material = SimpleMaterial()
        // SIMD4を使用してRGBAを直接設定
        material.color = SimpleMaterial.BaseColor(tint: .init(
            red: CGFloat(body.color.x),
            green: CGFloat(body.color.y),
            blue: CGFloat(body.color.z),
            alpha: 1.0
        ))
        material.metallic = 0.0
        
        // ModelComponentを追加
        entity.components.set(ModelComponent(mesh: sphereMesh, materials: [material]))
        
        return entity
    }
}

#if DEBUG
struct ImmersiveView_Previews: PreviewProvider {
    static var previews: some View {
        ImmersiveView()
            .environment(AppModel())
    }
}
#endif
