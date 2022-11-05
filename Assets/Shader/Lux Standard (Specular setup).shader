Shader "Lux Standard (Specular setup)" {
	Properties {
		[Toggle(GEOM_TYPE_BRANCH_DETAIL)] _UseMixMapping ("Use Mix Mapping", Float) = 0
		[Toggle(GEOM_TYPE_LEAF)] _MixMappingControl ("Use Detail Map to controle Mix Mapping ", Float) = 0
		[Toggle(EFFECT_HUE_VARIATION)] _DoubleSided ("Double Sided", Float) = 0
		_Lighting ("Lighting", Float) = 0
		_Color ("Color", Vector) = (1,1,1,1)
		_MainTex ("Albedo", 2D) = "white" {}
		_Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
		_DiffuseScatteringEnabled ("Diffuse Scattering Enabled", Float) = 0
		_DiffuseScatteringCol ("Diffuse Scattering Color", Vector) = (0,0,0,0)
		_DiffuseScatteringBias ("Scatter Bias", Range(0, 0.5)) = 0
		_DiffuseScatteringContraction ("Scatter Contraction", Range(1, 10)) = 8
		_DiffuseScatteringCol2 ("Diffuse Scattering Color2", Vector) = (0,0,0,0)
		_DiffuseScatteringBias2 ("Scatter Bias", Range(0, 0.5)) = 0
		_DiffuseScatteringContraction2 ("Scatter Contraction", Range(1, 10)) = 8
		_Glossiness ("Smoothness", Range(0, 1)) = 0.5
		_SpecColor ("Specular", Vector) = (0.2,0.2,0.2,1)
		_SpecGlossMap ("Specular", 2D) = "white" {}
		_BumpScale ("Scale", Float) = 1
		_BumpMap ("Normal Map", 2D) = "bump" {}
		_Parallax ("Height Scale", Range(0.005, 0.1)) = 0.02
		_ParallaxMap ("Height Map", 2D) = "black" {}
		_UVRatio ("UV Ratio", Vector) = (1,1,0,0)
		_ParallaxTiling ("Parallax Tiling", Float) = 1
		[Toggle(EFFECT_BUMP)] _UsePOM ("Use POM", Float) = 0
		_LinearSteps ("Linear Steps", Range(4, 64)) = 20
		_OcclusionStrength ("Strength", Range(0, 1)) = 1
		_OcclusionMap ("Occlusion", 2D) = "white" {}
		_EmissionColor ("Color", Vector) = (0,0,0,1)
		_EmissionMap ("Emission", 2D) = "white" {}
		_DetailMask ("Detail Mask", 2D) = "white" {}
		_DetailAlbedoMap ("Detail Albedo x2", 2D) = "grey" {}
		_DetailNormalMapScale ("Scale", Float) = 1
		_DetailNormalMap ("Normal Map", 2D) = "bump" {}
		_Color2 ("Color 2", Vector) = (1,1,1,1)
		_Glossiness2 ("Smoothness", Range(0, 1)) = 0.5
		_SpecColor2 ("Specular", Vector) = (0.2,0.2,0.2,1)
		_SpecGlossMap2 ("Specular", 2D) = "white" {}
		[Enum(UV0,0,UV1,1)] _UVSec ("UV Set for secondary textures", Float) = 0
		[Toggle(GEOM_TYPE_BRANCH)] _UseCombinedMap ("Use combined Map", Float) = 0
		_CombinedMap ("Combined Map", 2D) = "white" {}
		_TranslucencyStrength ("Translucency", Range(0, 1)) = 0.5
		_ScatteringPower ("Scattering Power", Range(0, 8)) = 4
		[Enum(Disabled,0,Enabled,1)] _Snow ("Snow", Float) = 0
		[Enum(Local Space,0,World Space,1)] _SnowMapping ("Mapping", Float) = 0
		_SnowAccumulation ("Snow Accumulation", Vector) = (0,1,0,0)
		_SnowSlopeDamp ("Snow Slope Damp", Range(0, 2)) = 0.75
		_SnowTiling ("Snow Tiling", Vector) = (2,2,0,0)
		_SnowNormalStrength ("Snow Normal Strength", Range(0, 2)) = 1
		_SnowMaskTiling ("Snow Mask Tiling", Vector) = (0.3,0.3,0,0)
		_SnowDetailTiling ("Snow Detail Tiling", Vector) = (4,4,0,0)
		_SnowDetailStrength ("Snow Detail Strength", Range(0, 1)) = 0.3
		_SnowOpacity ("Snow Opacity", Range(0, 1)) = 0.5
		[Enum(None,0,Simple,1,Ripples,2,Flow,3,Full,4)] _Wetness ("Wetness and Rain", Float) = 0
		[Enum(Vertex Color,0,Heightmap(R),1)] _PuddleMask ("Puddlemask", Float) = 0
		_PuddleMaskTiling ("Puddle Mask Tiling", Float) = 1
		_WaterSlopeDamp ("Water Slope Damp", Range(0, 1)) = 0.5
		_Lux_FlowNormalTiling ("Flow Normal Tiling", Float) = 2
		_Lux_FlowSpeed ("Flow Speed", Range(0, 2)) = 0.05
		_Lux_FlowInterval ("Flow Interval", Range(0, 8)) = 1
		_Lux_FlowRefraction ("Flow Refraction", Range(0, 0.1)) = 0.02
		_Lux_FlowNormalStrength ("Flow Normal Strength", Range(0, 2)) = 1
		_WaterColor ("Water Color", Vector) = (0,0,0,0)
		_WaterAccumulationCracksPuddles ("Water Accumulation in Cracks and Puddles", Vector) = (0,1,0,1)
		_WaterColor2 ("Water Color 2", Vector) = (0,0,0,0)
		_WaterAccumulationCracksPuddles2 ("Water Accumulation in Cracks and Puddles", Vector) = (0,1,0,1)
		_SyncWaterOfMaterials ("Sync Water Of Materials", Float) = 0
		[HideInInspector] _Mode ("__mode", Float) = 0
		[HideInInspector] _SrcBlend ("__src", Float) = 1
		[HideInInspector] _DstBlend ("__dst", Float) = 0
		[HideInInspector] _ZWrite ("__zw", Float) = 1
		[HideInInspector] _Cull ("__cull", Float) = 3
		[HideInInspector] _CullShadowPass ("__cull", Float) = 3
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _Color;
		struct Input
		{
			float2 uv_MainTex;
		};
		
		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	Fallback "VertexLit"
	//CustomEditor "LuxStandardShaderGUI"
}