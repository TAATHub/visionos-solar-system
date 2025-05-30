import Foundation
import RealityKit

/// 天体の情報を格納する構造体
struct CelestialBody {
    let name: String
    let radius: Float // 太陽を基準とした相対サイズ
    let orbitRadius: Float // 太陽からの距離（AU単位を基に調整）
    let orbitPeriod: Float // 地球を1.0とした相対的な公転周期
    let rotationPeriod: Float // 自転周期（時間）
    let axialTilt: Float // 軸の傾斜（度）
    let color: SIMD3<Float> // RGB色
    let description: String // 天体の説明文
}

/// 太陽系の天体データ
struct SolarSystemData {
    static let earthOrbitPeriod: Float = 30 // 地球の公転周期を30秒に設定
    static let earthRotationPeriod: Float = 1.0 // 地球の自転周期を0.1秒に設定
    
    static let celestialBodies: [CelestialBody] = [
        // 太陽
        CelestialBody(
            name: "Sun",
            radius: 1.0,
            orbitRadius: 0.0,
            orbitPeriod: 0.0,
            rotationPeriod: earthRotationPeriod * 25.4, // 太陽の自転周期：約25.4日
            axialTilt: 7.25,
            color: SIMD3<Float>(1.0, 0.8, 0.0), // 黄色
            description: "太陽系の中心にある恒星で、核融合により膨大なエネルギーを生み出しています。\n表面温度は約5,500度で、太陽系のすべての天体に光と熱を供給しています。\n地球の約109倍の直径を持ち、質量は太陽系全体の99.8%を占めます。"
        ),
        
        // 水星
        CelestialBody(
            name: "Mercury",
            radius: 0.383,
            orbitRadius: 1.5,
            orbitPeriod: earthOrbitPeriod * 0.24,
            rotationPeriod: earthRotationPeriod * 58.6,
            axialTilt: 0.03,
            color: SIMD3<Float>(0.7, 0.7, 0.7), // グレー
            description: "太陽に最も近い惑星で、昼夜の温度差が非常に激しい環境です。\n大気がほとんどないため、隕石の衝突跡が多数残っています。\n昼間は430度、夜間は-170度という極端な温度変化を経験します。"
        ),
        
        // 金星
        CelestialBody(
            name: "Venus",
            radius: 0.949,
            orbitRadius: 2.0,
            orbitPeriod: earthOrbitPeriod * 0.62,
            rotationPeriod: earthRotationPeriod * 243.0,
            axialTilt: 177.4,
            color: SIMD3<Float>(1.0, 0.8, 0.4), // 淡い黄色
            description: "地球とほぼ同じ大きさですが、極端な温室効果により表面温度は約460度です。\n分厚い二酸化炭素の大気に覆われ、硫酸の雲に包まれています。\n自転が非常に遅く、1日が243地球日もかかる珍しい惑星です。"
        ),
        
        // 地球
        CelestialBody(
            name: "Earth",
            radius: 1.0,
            orbitRadius: 2.5,
            orbitPeriod: earthOrbitPeriod,
            rotationPeriod: earthRotationPeriod,
            axialTilt: 23.4,
            color: SIMD3<Float>(0.2, 0.5, 1.0), // 青
            description: "現在知られている唯一の生命が存在する惑星です。\n液体の水が豊富で、大気中の酸素により多様な生命が育まれています。\n月という大きな衛星を持ち、潮汐力により海洋の動きが生まれています。"
        ),
        
        // 火星
        CelestialBody(
            name: "Mars",
            radius: 0.532,
            orbitRadius: 3.0,
            orbitPeriod: earthOrbitPeriod * 1.88,
            rotationPeriod: earthRotationPeriod * 1.03,
            axialTilt: 25.2,
            color: SIMD3<Float>(0.8, 0.3, 0.1), // 赤
            description: "赤い惑星として知られ、酸化鉄により表面が赤く見えます。\n極地には氷が存在し、かつて水が流れていた痕跡が発見されています。\n太陽系最大の火山オリンポス山があり、高さは約21kmに達します。"
        ),
        
        // 木星
        CelestialBody(
            name: "Jupiter",
            radius: 11.21,
            orbitRadius: 4.5,
            orbitPeriod: earthOrbitPeriod * 11.86,
            rotationPeriod: earthRotationPeriod * 0.41,
            axialTilt: 3.1,
            color: SIMD3<Float>(0.9, 0.7, 0.4), // オレンジ茶色
            description: "太陽系最大のガス惑星で、79個以上の衛星を持ちます。\n大赤斑と呼ばれる巨大な嵐が数百年間続いており、太陽系の掃除機的役割を果たしています。\nガリレオ衛星として知られる4つの大きな衛星は、1610年にガリレオによって発見されました。"
        ),
        
        // 土星
        CelestialBody(
            name: "Saturn",
            radius: 9.45,
            orbitRadius: 6.0,
            orbitPeriod: earthOrbitPeriod * 29.46,
            rotationPeriod: earthRotationPeriod * 0.45,
            axialTilt: 26.7,
            color: SIMD3<Float>(0.9, 0.9, 0.7), // 淡い黄色
            description: "美しいリングシステムで有名なガス惑星です。\n密度が水よりも小さく、82個以上の衛星を持っています。\nリングは主に氷の粒子で構成されており、厚さはわずか数十メートルという薄さです。"
        ),
        
        // 天王星
        CelestialBody(
            name: "Uranus",
            radius: 4.01,
            orbitRadius: 7.5,
            orbitPeriod: earthOrbitPeriod * 84.01,
            rotationPeriod: earthRotationPeriod * 0.72,
            axialTilt: 97.8,
            color: SIMD3<Float>(0.4, 0.8, 0.9), // 青緑
            description: "横倒しに自転する珍しい惑星で、メタンにより青緑色に見えます。\n薄いリングを持ち、27個の衛星があります。\n軸の傾きが98度もあるため、84年の公転周期中に極地が42年間太陽を向き続けます。"
        ),
        
        // 海王星
        CelestialBody(
            name: "Neptune",
            radius: 3.88,
            orbitRadius: 9.0,
            orbitPeriod: earthOrbitPeriod * 164.8,
            rotationPeriod: earthRotationPeriod * 0.67,
            axialTilt: 28.3,
            color: SIMD3<Float>(0.2, 0.3, 0.9), // 濃い青
            description: "太陽系で最も外側にある惑星で、時速2,100kmの強風が吹いています。\nメタンにより美しい青色をしており、14個の衛星を持ちます。\n1846年に数学的計算により存在が予測され、その後に望遠鏡で発見された初の惑星です。"
        )
    ]
} 
