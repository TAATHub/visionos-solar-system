import Foundation
import RealityKit
import SwiftUI

extension Entity {
    
    /// 土星のリングを作成するメソッド
    /// - Parameter planetRadius: 惑星の半径
    /// - Returns: リングエンティティ
    static func createSaturnRings(planetRadius: Float) -> Entity {
        let ringEntity = Entity()
        
        // 複数のリング層を作成（土星のA、B、Cリングを模擬）
        // 実際の土星のリングの色に近づける（茶色がかった金色）
        let ringLayers = [
            (innerRadius: planetRadius * 1.2, outerRadius: planetRadius * 1.8, alpha: Float(0.7), red: Float(0.8), green: Float(0.7), blue: Float(0.5)), // Cリング
            (innerRadius: planetRadius * 1.9, outerRadius: planetRadius * 2.3, alpha: Float(0.9), red: Float(0.9), green: Float(0.8), blue: Float(0.6)), // Bリング（最も明るい）
            (innerRadius: planetRadius * 2.4, outerRadius: planetRadius * 2.8, alpha: Float(0.6), red: Float(0.7), green: Float(0.6), blue: Float(0.4))  // Aリング
        ]
        
        for (_, layer) in ringLayers.enumerated() {
            let layerEntity = createRingLayer(
                innerRadius: layer.innerRadius,
                outerRadius: layer.outerRadius,
                alpha: layer.alpha,
                red: layer.red,
                green: layer.green,
                blue: layer.blue,
                segments: 64
            )
            ringEntity.addChild(layerEntity)
        }
        
        return ringEntity
    }
    
    /// 個別のリング層を作成するヘルパーメソッド
    /// - Parameters:
    ///   - innerRadius: 内側の半径
    ///   - outerRadius: 外側の半径
    ///   - alpha: 透明度
    ///   - red: 赤色成分
    ///   - green: 緑色成分
    ///   - blue: 青色成分
    ///   - segments: セグメント数
    /// - Returns: リング層エンティティ
    private static func createRingLayer(innerRadius: Float, outerRadius: Float, alpha: Float, red: Float, green: Float, blue: Float, segments: Int) -> Entity {
        let layerEntity = Entity()
        
        // リングメッシュを手動で作成（両面レンダリング対応）
        var vertices: [SIMD3<Float>] = []
        var indices: [UInt32] = []
        var normals: [SIMD3<Float>] = []
        
        // 頂点を生成（上面）
        for i in 0...segments {
            let angle = Float(i) * 2.0 * .pi / Float(segments)
            let cos = cosf(angle)
            let sin = sinf(angle)
            
            // 内側の頂点
            vertices.append(SIMD3<Float>(innerRadius * cos, 0, innerRadius * sin))
            normals.append(SIMD3<Float>(0, 1, 0))
            
            // 外側の頂点
            vertices.append(SIMD3<Float>(outerRadius * cos, 0, outerRadius * sin))
            normals.append(SIMD3<Float>(0, 1, 0))
        }
        
        // 下面用の頂点を追加（両面レンダリング用）
        let topVertexCount = vertices.count
        for i in 0...segments {
            let angle = Float(i) * 2.0 * .pi / Float(segments)
            let cos = cosf(angle)
            let sin = sinf(angle)
            
            // 内側の頂点（下面）
            vertices.append(SIMD3<Float>(innerRadius * cos, 0, innerRadius * sin))
            normals.append(SIMD3<Float>(0, -1, 0))
            
            // 外側の頂点（下面）
            vertices.append(SIMD3<Float>(outerRadius * cos, 0, outerRadius * sin))
            normals.append(SIMD3<Float>(0, -1, 0))
        }
        
        // 上面のインデックスを生成
        for i in 0..<segments {
            let base = UInt32(i * 2)
            
            // 最初の三角形
            indices.append(base)
            indices.append(base + 2)
            indices.append(base + 1)
            
            // 二番目の三角形
            indices.append(base + 1)
            indices.append(base + 2)
            indices.append(base + 3)
        }
        
        // 下面のインデックスを生成（法線が逆向き）
        for i in 0..<segments {
            let base = UInt32(topVertexCount + i * 2)
            
            // 最初の三角形（逆順）
            indices.append(base)
            indices.append(base + 1)
            indices.append(base + 2)
            
            // 二番目の三角形（逆順）
            indices.append(base + 1)
            indices.append(base + 3)
            indices.append(base + 2)
        }
        
        // MeshDescriptorを作成
        var descriptor = MeshDescriptor()
        descriptor.positions = MeshBuffers.Positions(vertices)
        descriptor.normals = MeshBuffers.Normals(normals)
        descriptor.primitives = .triangles(indices)
        
        // メッシュを生成（エラーハンドリング付き）
        let ringMesh: MeshResource
        do {
            ringMesh = try MeshResource.generate(from: [descriptor])
        } catch {
            // フォールバック：シンプルなトーラスを使用
            ringMesh = MeshResource.generateSphere(radius: (innerRadius + outerRadius) / 2)
        }
        
        // リング用のマテリアルを作成（半透明、両面レンダリング）
        var ringMaterial = SimpleMaterial()
        ringMaterial.color = SimpleMaterial.BaseColor(tint: .init(
            red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: CGFloat(alpha)
        ))
        ringMaterial.metallic = 0.0
        ringMaterial.roughness = 0.9
        // 両面レンダリングを有効にする
        ringMaterial.faceCulling = .none
        
        // ModelComponentを追加
        layerEntity.components.set(ModelComponent(mesh: ringMesh, materials: [ringMaterial]))
        
        return layerEntity
    }
    
    /// MilkyWayのImage Setを使ってskybox用のEntityを作成するメソッド
    /// - Returns: skyboxエンティティ
    static func createMilkyWaySkybox() -> Entity {
        let skyboxEntity = Entity()
        skyboxEntity.name = "skybox"
        
        // 大きな球体メッシュを作成（内側から見るため）
        let sphereMesh = MeshResource.generateSphere(radius: 1000.0)
        
        // MilkyWayテクスチャを読み込み
        guard let milkyWayTexture = try? TextureResource.load(named: "MilkyWay") else {
            print("MilkyWayテクスチャの読み込みに失敗しました")
            return skyboxEntity
        }
        
        // skybox用のマテリアルを作成
        var skyboxMaterial = UnlitMaterial()
        skyboxMaterial.color = .init(texture: .init(milkyWayTexture))
        
        // 内側から見えるように面を反転
        skyboxMaterial.faceCulling = .front
        
        // ModelComponentを設定
        skyboxEntity.components.set(ModelComponent(mesh: sphereMesh, materials: [skyboxMaterial]))
        
        return skyboxEntity
    }
    
    /// 各惑星の公転軌道を細い線として表示するメソッド
    /// - Returns: 全ての軌道線を含むエンティティ
    static func createPlanetOrbits() -> Entity {
        let orbitsEntity = Entity()
        orbitsEntity.name = "orbits"
        
        // 各惑星の軌道を作成（太陽以外）
        for body in SolarSystemData.celestialBodies {
            // 太陽は軌道がないのでスキップ
            guard body.name != "Sun" else { continue }
            
            // 軌道線を非常に細いリングとして作成
            let orbitLineEntity = createOrbitLine(
                radius: body.orbitRadius,
                alpha: 0.3, // 軌道線は控えめな透明度
                red: 0.6,
                green: 0.6,
                blue: 0.8,
                segments: 120 // 滑らかな円のために多くのセグメント
            )
            orbitLineEntity.name = "\(body.name)_orbit"
            orbitsEntity.addChild(orbitLineEntity)
        }
        
        return orbitsEntity
    }
    
    /// 個別の軌道線を作成するヘルパーメソッド
    /// - Parameters:
    ///   - radius: 軌道の半径
    ///   - alpha: 透明度
    ///   - red: 赤色成分
    ///   - green: 緑色成分
    ///   - blue: 青色成分
    ///   - segments: セグメント数
    /// - Returns: 軌道線エンティティ
    private static func createOrbitLine(radius: Float, alpha: Float, red: Float, green: Float, blue: Float, segments: Int) -> Entity {
        // 線の太さを決める（非常に細く）
        let lineWidth: Float = 0.005
        
        // createRingLayerを使って非常に細いリングを作成
        return createRingLayer(
            innerRadius: radius - lineWidth,
            outerRadius: radius + lineWidth,
            alpha: alpha,
            red: red,
            green: green,
            blue: blue,
            segments: segments
        )
    }
} 
