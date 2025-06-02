import RealityKit
import Foundation

/// 軌道運動を処理するSystem
struct OrbitSystem: System {
    static let query = EntityQuery(where: .has(OrbitComponent.self))
    
    init(scene: RealityKit.Scene) {}
    
    func update(context: SceneUpdateContext) {
        let deltaTime = Float(context.deltaTime)
        
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            guard var orbitComponent = entity.components[OrbitComponent.self] else { continue }
            
            // 角度を更新
            orbitComponent.currentAngle += orbitComponent.angularVelocity * deltaTime
            
            // 2πを超えたら正規化
            if orbitComponent.currentAngle >= 2.0 * .pi {
                orbitComponent.currentAngle -= 2.0 * .pi
            }
            
            // 新しい位置を計算
            let x = orbitComponent.radius * cos(orbitComponent.currentAngle)
            let z = -orbitComponent.radius * sin(orbitComponent.currentAngle)
            
            // Y軸回転の場合の位置計算（他の軸にも対応可能）
            let newPosition = SIMD3<Float>(x, 0, z) + orbitComponent.centerPosition
            
            // エンティティの位置を更新
            entity.position = newPosition
            
            // コンポーネントを更新
            entity.components[OrbitComponent.self] = orbitComponent
        }
    }
} 