import Foundation
import RealityKit
import SwiftUI

@Observable
class SolarSystemModel {
    
    /// 太陽系全体のエンティティを作成するメソッド
    func createSolarSystem() -> Entity {
        let solarSystemEntity = Entity()
        
        // 太陽系の天体を作成
        for (index, body) in SolarSystemData.celestialBodies.enumerated() {
            let entity = createCelestialBody(body)
            
            // タッチ機能を追加
            entity.components.set(InputTargetComponent())
            let collisionRadius = max(0.1, body.name == "Sun" ? body.radius : body.radius * 0.05)
            entity.components.set(CollisionComponent(shapes: [.generateSphere(radius: collisionRadius)]))
            
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
            
            solarSystemEntity.addChild(entity)
        }
        
        solarSystemEntity.position = [0, 0.5, 0]
        solarSystemEntity.scale *= 0.25
        
        return solarSystemEntity
    }
    
    /// 天体のEntityを作成するヘルパー関数
    private func createCelestialBody(_ body: CelestialBody) -> Entity {
        let entity = Entity()
        
        // エンティティに名前を設定（タップ時の識別用）
        entity.name = body.name
        
        // サイズを調整
        let baseRadius: Float = body.name == "Sun" ? body.radius : body.radius * 0.05 // 惑星は見やすくするために小さく調整
        
        // 球体メッシュを作成
        let sphereMesh = MeshResource.generateSphere(radius: baseRadius)
        
        // マテリアルを作成
        var material = UnlitMaterial()
        
        // AssetsからImage Setを読み込んでテクスチャとして設定
        if let textureResource = try? TextureResource.load(named: body.name) {
            material.color = SimpleMaterial.BaseColor(texture: MaterialParameters.Texture(textureResource))
        } else {
            // 画像が見つからない場合はフォールバックとして元の色を使用
            material.color = SimpleMaterial.BaseColor(tint: .init(
                red: CGFloat(body.color.x),
                green: CGFloat(body.color.y),
                blue: CGFloat(body.color.z),
                alpha: 1.0
            ))
        }
        
        // ModelComponentを追加
        entity.components.set(ModelComponent(mesh: sphereMesh, materials: [material]))
        
        // 軸の傾きを事前に設定
        let tiltRadians = body.axialTilt * .pi / 180.0
        let tiltRotation = simd_quatf(angle: tiltRadians, axis: SIMD3<Float>(1, 0, 0)) // X軸周りに傾ける
        entity.orientation = tiltRotation
        
        // 土星の場合はリングを追加
        if body.name == "Saturn" {
            let ringEntity = Entity.createSaturnRings(planetRadius: baseRadius)
            entity.addChild(ringEntity)
        }
        
        return entity
    }
    
    /// タップされたエンティティから天体情報を取得してAppModelを更新するメソッド
    @MainActor
    func handleCelestialBodyTap(entity: Entity, appModel: AppModel) {
        // エンティティの名前から天体を特定
        for body in SolarSystemData.celestialBodies {
            if entity.name == body.name {
                appModel.selectedCelestialBodyData = body
                break
            }
        }
    }
} 
