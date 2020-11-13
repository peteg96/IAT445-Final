// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DEC/Custom Lighting/Custom Lighting Surface Detail"
{
	Properties
	{
		[Enum(Off,0,On,1)][Header(SHADER VERSION 1.0 STANDARD)][Header(DEBUG SETTINGS)]_ZWriteMode("ZWrite Mode", Int) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTest Mode", Int) = 4
		[Enum(None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15)]_ColorMask("Color Mask Mode", Int) = 15
		[Enum(UnityEngine.Rendering.CullMode)][Header(GLOBAL SETTINGS)]_CullMode("Cull Mode", Int) = 0
		[Header(MAP MAIN TEXTURE)]_Color("Albedo Tint", Color) = (1,1,1,1)
		[SingleLineTexture]_MainTex("Albedo Map", 2D) = "white" {}
		[Enum(UV0,0,UV1,1)]_Mian_UVSet("UV Set", Int) = 0
		_Brightness("Brightness", Range( 0 , 2)) = 1
		[Enum(Standard,0,Scale Independent,1)]_TillingMode("Tilling Mode", Int) = 0
		_TilingX("Tiling X", Float) = 1
		_TilingY("Tiling Y", Float) = 1
		_OffsetX("Offset X", Float) = 0
		_OffsetY("Offset Y", Float) = 0
		[NoScaleOffset][Normal][SingleLineTexture]_BumpMap("Normal Map", 2D) = "bump" {}
		_NormalStrength("Normal Strength", Float) = 1
		[SingleLineTexture]_SmoothnessMap("Smoothness Map", 2D) = "white" {}
		_SmoothnessStrength("Smoothness Strength", Range( 0 , 1)) = 0
		[Enum(Texture,0,Baked UV4,1)]_OcclusionSourceMode("Occlusion Source Mode", Int) = 1
		[SingleLineTexture]_OcclusionMap("Occlusion Map", 2D) = "white" {}
		_OcclusionStrengthAO("Occlusion Strength", Range( 0 , 1)) = 0.95
		[Enum(Off,0,Active,1)][Header(MAP DETAIL)]_EnableDetailMap("Enable Detail Map", Int) = 0
		_ColorDetail("Detail Tint", Color) = (1,1,1,0)
		[SingleLineTexture]_DetailAlbedoMap("Albedo Map", 2D) = "white" {}
		[Enum(UV0,0,UV1,1)]_Detail_UVSet("UV Set", Int) = 0
		_DetailBrightness("Detail Brightness", Range( 0 , 2)) = 1
		[Enum(Standard,0,Scale Independent,1)]_TillingModeDetail("Tilling Mode", Int) = 0
		_DetailTilingXDetail("Tiling X", Float) = 1
		_DetailTilingYDetail("Tiling Y", Float) = 1
		_DetailOffsetXDetail("Offset X", Float) = 0
		_DetailOffsetYDetail("Offset Y", Float) = 0
		[NoScaleOffset][Normal][SingleLineTexture]_DetailNormalMap("Normal Map", 2D) = "bump" {}
		_DetailNormalMapScale("Detail Normal Strength", Float) = 1
		_DetailBlendInfluence("Detail Blend Influence", Range( 0 , 3)) = 1
		_DetailBlendHeight("Detail Blend Height", Range( 0 , 1.25)) = 1
		_DetailBlendSmooth("Detail Blend Smooth", Range( 0.01 , 0.5)) = 0.35
		[Header (LIGHTING)]_IndirectStrengthDiffuse("Indirect Strength Diffuse", Range( 0 , 1)) = 0.5
		_IndirectStrengthSpecular("Indirect Strength Specular", Range( 0 , 1)) = 0.5
		_IndirectOcclusion("Indirect Occlusion", Range( 0 , 1)) = 0
		_IndirectSmoothness("Indirect Smoothness", Range( 0 , 1)) = 0
		[HDR]_SpecularColor("Specular Tint", Color) = (1,1,1,0.2117647)
		_Shininess("Specular Glossiness", Range( 0 , 1)) = 0
		_ShadowStrength("Shadow Strength", Range( 0 , 1)) = 0.42
		_ShadowSharpness("Shadow Sharpness", Range( 0.01 , 1)) = 1
		_ShadowOffset("Shadow Offset", Range( 0 , 1)) = 0
		[Enum(Off,0,Ramp,1,MatCap,2)][Header(TOON TEXTURE MAP)]_ToonMode("Toon Mode", Int) = 0
		[NoScaleOffset][SingleLineTexture]_ToonMap("Toon Map", 2D) = "white" {}
		_Saturation("Saturation", Range( 0 , 2)) = 1
		[HDR][Header(OUTLINE)]_OutlineTint("Outline Tint", Color) = (0.05098039,0.03137255,0.02352941,1)
		_OutlineThickness("Outline Thickness", Range( 0 , 0.5)) = 0
		[Enum(Off,0,Active,1)][Header(HIGHLIGHT)]_EnableHighlight("Enable Highlight", Int) = 0
		[HDR]_HighlightTint("Highlight Tint", Color) = (0.4941176,0.3372549,0.2509804,0.3529412)
		_HighlightStrength("Highlight Strength", Range( 0 , 1)) = 0.25
		_Speed("Speed", Range( 0 , 200)) = 60
		_SpeedMinLevel("Speed Min Level", Range( 0 , 1)) = 0.8
		_SpeedMaxLevel("Speed Max Level", Range( 0 , 1)) = 0.9
		[Enum(Off,0,Active,1)][Header (EMISSION)]_EmissionMode("Emission Mode", Int) = 0
		[HDR]_EmissionTint_01("Emission Tint", Color) = (0,0,0,1)
		_EmissionTintStrength_01("Emission Tint Strength", Range( 0 , 100)) = 1
		[HDR]_EmissionTint_02("Emission Tint", Color) = (0,0,0,1)
		_EmissionTintStrength_02("Emission Tint Strength", Range( 0 , 100)) = 1
		[HDR]_EmissionTintGlow("Emission Tint Glow", Color) = (0,0,0,1)
		_EmissionTintGlowStrength("Emission Tint Glow Strength", Range( 0 , 2)) = 0.3063261
		[SingleLineTexture]_EmissionMapMask("Emission Map Mask", 2D) = "white" {}
		[Enum(UV0,0,UV1,1)]_Emission_UVSet("UV Set", Int) = 0
		[Enum(Standard,0,Scale Independent,1)]_EmissionMask_TillingMode("Tilling Mode", Int) = 0
		_EmissionMask_TilingX("Tiling X", Float) = 1
		_EmissionMask_TilingY("Tiling Y", Float) = 1
		_EmissionMask_OffsetX("Offset X", Float) = 1
		_EmissionMask_OffsetY("Offset Y", Float) = 1
		[Enum(Off,0,Global,1,Local,2)][Header(WIND)]_WindMode("Wind Mode", Int) = 0
		[Header(WIND MODE GLOBAL)]_GlobalWindInfluenceOther("Wind Strength", Float) = 0.3
		[Header(WIND MODE LOCAL)]_LocalWindStrength("Wind Strength", Float) = 0.3
		_LocalWindPulse("Wind Pulse", Float) = 0.1
		_LocalWindDirection("Wind Direction", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		_LocalRandomWindOffset("Wind Random Offset", Float) = 0.2
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		#include "UnityShaderVariables.cginc"
		
		
		#pragma multi_compile_instancing
		#pragma instancing_options procedural:SetupNatureRenderer forwardadd
		#pragma multi_compile GPU_FRUSTUM_ON __
		#include "Nature Renderer.cginc"
		#pragma multi_compile_local _ NATURE_RENDERER
		#pragma multi_compile __ LOD_FADE_CROSSFADE
		
		struct Input
		{
			half filler;
		};
		uniform float4 _OutlineTint;
		uniform int _WindMode;
		uniform float _GlobalWindInfluenceOther;
		uniform float _WindStrength;
		uniform float _LocalWindStrength;
		uniform float _RandomWindOffset;
		uniform float _LocalRandomWindOffset;
		uniform float _WindPulse;
		uniform float _LocalWindPulse;
		uniform float _WindDirection;
		uniform float _LocalWindDirection;
		uniform float _OutlineThickness;
		
		float floatswitch( int m_switch, float m_Off, float m_Global, float m_Local )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Global;
			if(m_switch == 2)
				return m_Local;
			return m_Off;
		}


		float2 DirectionalEquation( float _WindDirection )
		{
			float d = _WindDirection * 0.0174532924;
			float xL = cos(d) + 1 / 2;
			float zL = sin(d) + 1 / 2;
			return float2(zL,xL);
		}


		float3 float3switch396_g3195( int m_switch, float3 m_Off, float3 m_Global, float3 m_Local )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Global;
			if(m_switch == 2)
				return m_Local;
			return m_Off;
		}


		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			int WindController383_g3195 = _WindMode;
			int m_switch396_g3195 = WindController383_g3195;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VAR_VERTEXPOSITION_MATRIX299_g3195 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 m_Off396_g3195 = VAR_VERTEXPOSITION_MATRIX299_g3195;
			float3 break156_g3195 = VAR_VERTEXPOSITION_MATRIX299_g3195;
			int m_switch390_g3195 = _WindMode;
			float m_Off390_g3195 = 1.0;
			float GLOBAL_WINDINFLUENCE340_g3195 = _WindStrength;
			float m_Global390_g3195 = ( _GlobalWindInfluenceOther * GLOBAL_WINDINFLUENCE340_g3195 );
			float m_Local390_g3195 = _LocalWindStrength;
			float localfloatswitch390_g3195 = floatswitch( m_switch390_g3195 , m_Off390_g3195 , m_Global390_g3195 , m_Local390_g3195 );
			float VAR_WindStrength129_g3195 = localfloatswitch390_g3195;
			int m_switch117_g3195 = _WindMode;
			float m_Off117_g3195 = 1.0;
			float GLOBAL_RANDOMWINDOFFSET339_g3195 = _RandomWindOffset;
			float m_Global117_g3195 = GLOBAL_RANDOMWINDOFFSET339_g3195;
			float m_Local117_g3195 = _LocalRandomWindOffset;
			float localfloatswitch117_g3195 = floatswitch( m_switch117_g3195 , m_Off117_g3195 , m_Global117_g3195 , m_Local117_g3195 );
			float VAR_WindOffset76_g3195 = localfloatswitch117_g3195;
			float4 transform288_g3195 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult210_g3195 = (float2(transform288_g3195.x , transform288_g3195.z));
			float dotResult271_g3195 = dot( appendResult210_g3195 , float2( 12.9898,78.233 ) );
			float lerpResult44_g3195 = lerp( 0.8 , ( ( VAR_WindOffset76_g3195 / 2.0 ) + 0.9 ) , frac( ( sin( dotResult271_g3195 ) * 43758.55 ) ));
			float VAR_RandomTime191_g3195 = ( _Time.x * lerpResult44_g3195 );
			float FUNC_Turbulence296_g3195 = ( sin( ( ( VAR_RandomTime191_g3195 * 40.0 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3195.z / 15.0 ) ) ) * 0.5 );
			int m_switch387_g3195 = _WindMode;
			float m_Off387_g3195 = 1.0;
			float GLOBAL_WINDPULSE342_g3195 = _WindPulse;
			float m_Global387_g3195 = GLOBAL_WINDPULSE342_g3195;
			float m_Local387_g3195 = _LocalWindPulse;
			float localfloatswitch387_g3195 = floatswitch( m_switch387_g3195 , m_Off387_g3195 , m_Global387_g3195 , m_Local387_g3195 );
			float VAR_WindPulse264_g3195 = localfloatswitch387_g3195;
			float FUNC_Angle148_g3195 = ( VAR_WindStrength129_g3195 * ( 1.0 + sin( ( ( ( ( VAR_RandomTime191_g3195 * 2.0 ) + FUNC_Turbulence296_g3195 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3195.z / 50.0 ) ) - ( v.color.r / 20.0 ) ) ) ) * sqrt( v.color.r ) * VAR_WindPulse264_g3195 );
			float VAR_SinA111_g3195 = sin( FUNC_Angle148_g3195 );
			float VAR_CosA243_g3195 = cos( FUNC_Angle148_g3195 );
			int m_switch389_g3195 = _WindMode;
			float m_Off389_g3195 = 1.0;
			float GLOBAL_WINDDIRECTION341_g3195 = _WindDirection;
			float m_Global389_g3195 = GLOBAL_WINDDIRECTION341_g3195;
			float m_Local389_g3195 = _LocalWindDirection;
			float localfloatswitch389_g3195 = floatswitch( m_switch389_g3195 , m_Off389_g3195 , m_Global389_g3195 , m_Local389_g3195 );
			float _WindDirection178_g3195 = localfloatswitch389_g3195;
			float2 localDirectionalEquation178_g3195 = DirectionalEquation( _WindDirection178_g3195 );
			float2 break74_g3195 = localDirectionalEquation178_g3195;
			float VAR_xLerp173_g3195 = break74_g3195.x;
			float lerpResult232_g3195 = lerp( break156_g3195.x , ( ( break156_g3195.y * VAR_SinA111_g3195 ) + ( break156_g3195.x * VAR_CosA243_g3195 ) ) , VAR_xLerp173_g3195);
			float3 break99_g3195 = VAR_VERTEXPOSITION_MATRIX299_g3195;
			float3 break201_g3195 = VAR_VERTEXPOSITION_MATRIX299_g3195;
			float VAR_zLerp206_g3195 = break74_g3195.y;
			float lerpResult104_g3195 = lerp( break201_g3195.z , ( ( break201_g3195.y * VAR_SinA111_g3195 ) + ( break201_g3195.z * VAR_CosA243_g3195 ) ) , VAR_zLerp206_g3195);
			float3 appendResult197_g3195 = (float3(lerpResult232_g3195 , ( ( break99_g3195.y * VAR_CosA243_g3195 ) - ( break99_g3195.z * VAR_SinA111_g3195 ) ) , lerpResult104_g3195));
			float3 FUNC_vertexPos132_g3195 = appendResult197_g3195;
			float3 m_Global396_g3195 = FUNC_vertexPos132_g3195;
			float3 m_Local396_g3195 = FUNC_vertexPos132_g3195;
			float3 localfloat3switch396_g3195 = float3switch396_g3195( m_switch396_g3195 , m_Off396_g3195 , m_Global396_g3195 , m_Local396_g3195 );
			float3 temp_output_261_0_g3195 = mul( unity_WorldToObject, float4( localfloat3switch396_g3195 , 0.0 ) ).xyz;
			float3 VAR_VERTEXPOSITION298_g3195 = ase_vertex3Pos;
			float3 temp_output_6_0_g3199 = ( temp_output_261_0_g3195 - VAR_VERTEXPOSITION298_g3195 );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 temp_output_4_0_g3199 = ( temp_output_6_0_g3199 + ( ase_vertexNormal * _OutlineThickness ) );
			float3 outlineVar = temp_output_4_0_g3199;
			v.vertex.xyz += outlineVar;
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float4 temp_output_12_0_g3199 = ( _OutlineTint * _OutlineTint.a );
			o.Emission = temp_output_12_0_g3199.rgb;
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry-10" "IgnoreProjector" = "True" "NatureRendererInstancing"="True" }
		LOD 200
		Cull [_CullMode]
		ZWrite [_ZWriteMode]
		ZTest [_ZTestMode]
		ColorMask [_ColorMask]
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma multi_compile_instancing
		#pragma instancing_options procedural:SetupNatureRenderer forwardadd
		#pragma multi_compile GPU_FRUSTUM_ON __
		#include "Nature Renderer.cginc"
		#pragma multi_compile_local _ NATURE_RENDERER
		#pragma multi_compile __ LOD_FADE_CROSSFADE
		#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
		#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
		#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
		#else//ASE Sampling Macros
		#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
		#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
		#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
		#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
		#endif//ASE Sampling Macros

		#pragma surface surf StandardCustomLighting keepalpha addshadow fullforwardshadows exclude_path:deferred dithercrossfade vertex:vertexDataFunc 
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
			float2 uv2_texcoord2;
			float4 screenPosition;
			float4 vertexColor : COLOR;
			float3 worldPos;
			float2 vertexToFrag30_g3196;
			float3 worldRefl;
			float3 viewDir;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform int _ZTestMode;
		uniform int _ColorMask;
		uniform int _CullMode;
		uniform int _ZWriteMode;
		uniform int _WindMode;
		uniform float _GlobalWindInfluenceOther;
		uniform float _WindStrength;
		uniform float _LocalWindStrength;
		uniform float _RandomWindOffset;
		uniform float _LocalRandomWindOffset;
		uniform float _WindPulse;
		uniform float _LocalWindPulse;
		uniform float _WindDirection;
		uniform float _LocalWindDirection;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		SamplerState sampler_MainTex;
		uniform int _Mian_UVSet;
		uniform int _TillingMode;
		uniform float _TilingX;
		uniform float _TilingY;
		uniform float _OffsetX;
		uniform float _OffsetY;
		SamplerState sampler_trilinear_repeat;
		uniform int _ToonMode;
		uniform int _EnableDetailMap;
		uniform float4 _Color;
		uniform half _Brightness;
		uniform half4 _ColorDetail;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_DetailAlbedoMap);
		uniform int _Detail_UVSet;
		uniform int _TillingModeDetail;
		uniform float _DetailTilingXDetail;
		uniform float _DetailTilingYDetail;
		uniform half _DetailOffsetXDetail;
		uniform half _DetailOffsetYDetail;
		uniform half _DetailBrightness;
		uniform half _DetailBlendInfluence;
		uniform half _DetailBlendHeight;
		uniform half _DetailBlendSmooth;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_ToonMap);
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		uniform half _NormalStrength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_DetailNormalMap);
		uniform half _DetailNormalMapScale;
		SamplerState sampler_ToonMap;
		uniform float _Saturation;
		uniform float _IndirectSmoothness;
		uniform float _IndirectOcclusion;
		uniform float _IndirectStrengthSpecular;
		uniform float _IndirectStrengthDiffuse;
		uniform float _ShadowOffset;
		uniform float _ShadowSharpness;
		uniform float _ShadowStrength;
		uniform int _EnableHighlight;
		uniform int _EmissionMode;
		uniform float4 _EmissionTint_01;
		uniform float _EmissionTintStrength_01;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissionMapMask);
		uniform int _Emission_UVSet;
		uniform int _EmissionMask_TillingMode;
		uniform float _EmissionMask_TilingX;
		uniform float _EmissionMask_TilingY;
		uniform float _EmissionMask_OffsetX;
		uniform float _EmissionMask_OffsetY;
		uniform float4 _EmissionTint_02;
		uniform float _EmissionTintStrength_02;
		uniform float4 _EmissionTintGlow;
		uniform float _EmissionTintGlowStrength;
		uniform float _Speed;
		uniform float _SpeedMinLevel;
		uniform float _SpeedMaxLevel;
		uniform float4 _HighlightTint;
		uniform float _HighlightStrength;
		uniform half _Shininess;
		uniform half4 _SpecularColor;
		uniform float _SmoothnessStrength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SmoothnessMap);
		UNITY_DECLARE_TEX2D_NOSAMPLER(_OcclusionMap);
		uniform int _OcclusionSourceMode;
		uniform float _OcclusionStrengthAO;


		float floatswitch( int m_switch, float m_Off, float m_Global, float m_Local )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Global;
			if(m_switch == 2)
				return m_Local;
			return m_Off;
		}


		float2 DirectionalEquation( float _WindDirection )
		{
			float d = _WindDirection * 0.0174532924;
			float xL = cos(d) + 1 / 2;
			float zL = sin(d) + 1 / 2;
			return float2(zL,xL);
		}


		float3 float3switch396_g3195( int m_switch, float3 m_Off, float3 m_Global, float3 m_Local )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Global;
			if(m_switch == 2)
				return m_Local;
			return m_Off;
		}


		float2 float2switch214_g3104( int m_switch, float2 m_Standard, float2 m_Scale )
		{
			if(m_switch == 0)
				return m_Standard;
			if(m_switch == 1)
				return m_Scale;
			return m_Standard;
		}


		float2 float2UVswitch379_g3104( int m_switch, float2 m_UV0, float2 m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		inline float Dither8x8Bayer( int x, int y )
		{
			const float dither[ 64 ] = {
				 1, 49, 13, 61,  4, 52, 16, 64,
				33, 17, 45, 29, 36, 20, 48, 32,
				 9, 57,  5, 53, 12, 60,  8, 56,
				41, 25, 37, 21, 44, 28, 40, 24,
				 3, 51, 15, 63,  2, 50, 14, 62,
				35, 19, 47, 31, 34, 18, 46, 30,
				11, 59,  7, 55, 10, 58,  6, 54,
				43, 27, 39, 23, 42, 26, 38, 22};
			int r = y * 8 + x;
			return dither[r] / 64; // same # of instructions as pre-dividing due to compiler magic
		}


		float2 float2switch393_g3104( int m_switch, float2 m_Standard, float2 m_Scale )
		{
			if(m_switch == 0)
				return m_Standard;
			if(m_switch == 1)
				return m_Scale;
			return m_Standard;
		}


		float2 float2UVswitch395_g3104( int m_switch, float2 m_UV0, float2 m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		float4 float4switch506_g3104( int m_switch, float4 m_Off, float4 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float3 float3switch502_g3104( int m_switch, float3 m_Off, float3 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float2 float2switch( int m_switch, float2 m_Off, float2 m_Ramp, float2 m_MatCap )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Ramp;
			if(m_switch == 2)
				return m_MatCap;
			return m_Off;
		}


		float4 float4switch49_g3196( int m_switch, float4 m_Off, float4 m_Ramp, float4 m_MatCap )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Ramp;
			if(m_switch == 2)
				return m_MatCap;
			return m_Off;
		}


		float2 float2switch58_g3193( int m_switch, float2 m_Standard, float2 m_Scale )
		{
			if(m_switch == 0)
				return m_Standard;
			if(m_switch == 1)
				return m_Scale;
			return m_Standard;
		}


		float2 float2UVswitch138_g3193( int m_switch, float2 m_UV0, float2 m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		float4 float4switch131_g3193( int m_switch, float4 m_Off, float4 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float4 float4switch( int m_switch, float4 m_Off, float4 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 localOutlineOutput10_g3199 = ( 0 );
			int WindController383_g3195 = _WindMode;
			int m_switch396_g3195 = WindController383_g3195;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VAR_VERTEXPOSITION_MATRIX299_g3195 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 m_Off396_g3195 = VAR_VERTEXPOSITION_MATRIX299_g3195;
			float3 break156_g3195 = VAR_VERTEXPOSITION_MATRIX299_g3195;
			int m_switch390_g3195 = _WindMode;
			float m_Off390_g3195 = 1.0;
			float GLOBAL_WINDINFLUENCE340_g3195 = _WindStrength;
			float m_Global390_g3195 = ( _GlobalWindInfluenceOther * GLOBAL_WINDINFLUENCE340_g3195 );
			float m_Local390_g3195 = _LocalWindStrength;
			float localfloatswitch390_g3195 = floatswitch( m_switch390_g3195 , m_Off390_g3195 , m_Global390_g3195 , m_Local390_g3195 );
			float VAR_WindStrength129_g3195 = localfloatswitch390_g3195;
			int m_switch117_g3195 = _WindMode;
			float m_Off117_g3195 = 1.0;
			float GLOBAL_RANDOMWINDOFFSET339_g3195 = _RandomWindOffset;
			float m_Global117_g3195 = GLOBAL_RANDOMWINDOFFSET339_g3195;
			float m_Local117_g3195 = _LocalRandomWindOffset;
			float localfloatswitch117_g3195 = floatswitch( m_switch117_g3195 , m_Off117_g3195 , m_Global117_g3195 , m_Local117_g3195 );
			float VAR_WindOffset76_g3195 = localfloatswitch117_g3195;
			float4 transform288_g3195 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult210_g3195 = (float2(transform288_g3195.x , transform288_g3195.z));
			float dotResult271_g3195 = dot( appendResult210_g3195 , float2( 12.9898,78.233 ) );
			float lerpResult44_g3195 = lerp( 0.8 , ( ( VAR_WindOffset76_g3195 / 2.0 ) + 0.9 ) , frac( ( sin( dotResult271_g3195 ) * 43758.55 ) ));
			float VAR_RandomTime191_g3195 = ( _Time.x * lerpResult44_g3195 );
			float FUNC_Turbulence296_g3195 = ( sin( ( ( VAR_RandomTime191_g3195 * 40.0 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3195.z / 15.0 ) ) ) * 0.5 );
			int m_switch387_g3195 = _WindMode;
			float m_Off387_g3195 = 1.0;
			float GLOBAL_WINDPULSE342_g3195 = _WindPulse;
			float m_Global387_g3195 = GLOBAL_WINDPULSE342_g3195;
			float m_Local387_g3195 = _LocalWindPulse;
			float localfloatswitch387_g3195 = floatswitch( m_switch387_g3195 , m_Off387_g3195 , m_Global387_g3195 , m_Local387_g3195 );
			float VAR_WindPulse264_g3195 = localfloatswitch387_g3195;
			float FUNC_Angle148_g3195 = ( VAR_WindStrength129_g3195 * ( 1.0 + sin( ( ( ( ( VAR_RandomTime191_g3195 * 2.0 ) + FUNC_Turbulence296_g3195 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3195.z / 50.0 ) ) - ( v.color.r / 20.0 ) ) ) ) * sqrt( v.color.r ) * VAR_WindPulse264_g3195 );
			float VAR_SinA111_g3195 = sin( FUNC_Angle148_g3195 );
			float VAR_CosA243_g3195 = cos( FUNC_Angle148_g3195 );
			int m_switch389_g3195 = _WindMode;
			float m_Off389_g3195 = 1.0;
			float GLOBAL_WINDDIRECTION341_g3195 = _WindDirection;
			float m_Global389_g3195 = GLOBAL_WINDDIRECTION341_g3195;
			float m_Local389_g3195 = _LocalWindDirection;
			float localfloatswitch389_g3195 = floatswitch( m_switch389_g3195 , m_Off389_g3195 , m_Global389_g3195 , m_Local389_g3195 );
			float _WindDirection178_g3195 = localfloatswitch389_g3195;
			float2 localDirectionalEquation178_g3195 = DirectionalEquation( _WindDirection178_g3195 );
			float2 break74_g3195 = localDirectionalEquation178_g3195;
			float VAR_xLerp173_g3195 = break74_g3195.x;
			float lerpResult232_g3195 = lerp( break156_g3195.x , ( ( break156_g3195.y * VAR_SinA111_g3195 ) + ( break156_g3195.x * VAR_CosA243_g3195 ) ) , VAR_xLerp173_g3195);
			float3 break99_g3195 = VAR_VERTEXPOSITION_MATRIX299_g3195;
			float3 break201_g3195 = VAR_VERTEXPOSITION_MATRIX299_g3195;
			float VAR_zLerp206_g3195 = break74_g3195.y;
			float lerpResult104_g3195 = lerp( break201_g3195.z , ( ( break201_g3195.y * VAR_SinA111_g3195 ) + ( break201_g3195.z * VAR_CosA243_g3195 ) ) , VAR_zLerp206_g3195);
			float3 appendResult197_g3195 = (float3(lerpResult232_g3195 , ( ( break99_g3195.y * VAR_CosA243_g3195 ) - ( break99_g3195.z * VAR_SinA111_g3195 ) ) , lerpResult104_g3195));
			float3 FUNC_vertexPos132_g3195 = appendResult197_g3195;
			float3 m_Global396_g3195 = FUNC_vertexPos132_g3195;
			float3 m_Local396_g3195 = FUNC_vertexPos132_g3195;
			float3 localfloat3switch396_g3195 = float3switch396_g3195( m_switch396_g3195 , m_Off396_g3195 , m_Global396_g3195 , m_Local396_g3195 );
			float3 temp_output_261_0_g3195 = mul( unity_WorldToObject, float4( localfloat3switch396_g3195 , 0.0 ) ).xyz;
			float3 VAR_VERTEXPOSITION298_g3195 = ase_vertex3Pos;
			float3 temp_output_6_0_g3199 = ( temp_output_261_0_g3195 - VAR_VERTEXPOSITION298_g3195 );
			float3 vertexoffset10_g3199 = temp_output_6_0_g3199;
			v.vertex.xyz += vertexoffset10_g3199;
			v.vertex.xyz += localOutlineOutput10_g3199;
			v.vertex.w = 1;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
			int SURFACE_MAP_MODE456_g3104 = _EnableDetailMap;
			int m_switch502_g3104 = SURFACE_MAP_MODE456_g3104;
			int UV_SET_MAIN381_g3104 = _Mian_UVSet;
			int m_switch379_g3104 = UV_SET_MAIN381_g3104;
			int TILLING_MODE190_g3104 = _TillingMode;
			int m_switch214_g3104 = TILLING_MODE190_g3104;
			float2 appendResult192_g3104 = (float2(_TilingX , _TilingY));
			float2 TEXTURE_TILLING200_g3104 = appendResult192_g3104;
			float2 m_Standard214_g3104 = TEXTURE_TILLING200_g3104;
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 break206_g3104 = ase_parentObjectScale;
			float2 appendResult205_g3104 = (float2(break206_g3104.z , break206_g3104.y));
			float3 ase_vertexNormal = v.normal.xyz;
			float3 normalizeResult194_g3104 = normalize( ase_vertexNormal );
			float3 break201_g3104 = normalizeResult194_g3104;
			float2 appendResult204_g3104 = (float2(break206_g3104.x , break206_g3104.z));
			float2 appendResult193_g3104 = (float2(break206_g3104.x , break206_g3104.y));
			float2 TEXTURE_TILLING_SCALE210_g3104 = ( ( ( appendResult205_g3104 * break201_g3104.x ) + ( break201_g3104.y * appendResult204_g3104 ) + ( break201_g3104.z * appendResult193_g3104 ) ) * TEXTURE_TILLING200_g3104 );
			float2 m_Scale214_g3104 = TEXTURE_TILLING_SCALE210_g3104;
			float2 localfloat2switch214_g3104 = float2switch214_g3104( m_switch214_g3104 , m_Standard214_g3104 , m_Scale214_g3104 );
			float2 appendResult166_g3104 = (float2(_OffsetX , _OffsetY));
			float2 uv_TexCoord165_g3104 = v.texcoord.xy * localfloat2switch214_g3104 + appendResult166_g3104;
			float2 m_UV0379_g3104 = uv_TexCoord165_g3104;
			float2 uv2_TexCoord383_g3104 = v.texcoord1.xy * localfloat2switch214_g3104 + appendResult166_g3104;
			float2 m_UV1379_g3104 = uv2_TexCoord383_g3104;
			float2 localfloat2UVswitch379_g3104 = float2UVswitch379_g3104( m_switch379_g3104 , m_UV0379_g3104 , m_UV1379_g3104 );
			float3 NORMAL_OUT23_g3104 = UnpackScaleNormal( SAMPLE_TEXTURE2D_LOD( _BumpMap, sampler_trilinear_repeat, localfloat2UVswitch379_g3104, 0.0 ), _NormalStrength );
			float3 m_Off502_g3104 = NORMAL_OUT23_g3104;
			int UV_SET_DETAL397_g3104 = _Detail_UVSet;
			int m_switch395_g3104 = UV_SET_DETAL397_g3104;
			int TILLING_MODE_DETAIL435_g3104 = _TillingModeDetail;
			int m_switch393_g3104 = TILLING_MODE_DETAIL435_g3104;
			float2 appendResult432_g3104 = (float2(_DetailTilingXDetail , _DetailTilingYDetail));
			float2 TEXTURE_TILLING_DETAIL425_g3104 = appendResult432_g3104;
			float2 m_Standard393_g3104 = TEXTURE_TILLING_DETAIL425_g3104;
			float3 break420_g3104 = ase_parentObjectScale;
			float2 appendResult448_g3104 = (float2(break420_g3104.z , break420_g3104.y));
			float3 normalizeResult480_g3104 = normalize( ase_vertexNormal );
			float3 break431_g3104 = normalizeResult480_g3104;
			float2 appendResult426_g3104 = (float2(break420_g3104.x , break420_g3104.z));
			float2 appendResult433_g3104 = (float2(break420_g3104.x , break420_g3104.y));
			float2 TEXTURE_TILLING_SCALE_DETAIL427_g3104 = ( ( ( appendResult448_g3104 * break431_g3104.x ) + ( break431_g3104.y * appendResult426_g3104 ) + ( break431_g3104.z * appendResult433_g3104 ) ) * TEXTURE_TILLING_DETAIL425_g3104 );
			float2 m_Scale393_g3104 = TEXTURE_TILLING_SCALE_DETAIL427_g3104;
			float2 localfloat2switch393_g3104 = float2switch393_g3104( m_switch393_g3104 , m_Standard393_g3104 , m_Scale393_g3104 );
			float2 appendResult394_g3104 = (float2(_DetailOffsetXDetail , _DetailOffsetYDetail));
			float2 uv_TexCoord414_g3104 = v.texcoord.xy * localfloat2switch393_g3104 + appendResult394_g3104;
			float2 m_UV0395_g3104 = uv_TexCoord414_g3104;
			float2 uv2_TexCoord409_g3104 = v.texcoord1.xy * localfloat2switch393_g3104 + appendResult394_g3104;
			float2 m_UV1395_g3104 = uv2_TexCoord409_g3104;
			float2 localfloat2UVswitch395_g3104 = float2UVswitch395_g3104( m_switch395_g3104 , m_UV0395_g3104 , m_UV1395_g3104 );
			float3 NORMAL_OUT_DETAIL491_g3104 = UnpackScaleNormal( SAMPLE_TEXTURE2D_LOD( _DetailNormalMap, sampler_trilinear_repeat, localfloat2UVswitch395_g3104, 0.0 ), _DetailNormalMapScale );
			float4 tex2DNode35_g3104 = SAMPLE_TEXTURE2D_LOD( _MainTex, sampler_trilinear_repeat, localfloat2UVswitch379_g3104, 0.0 );
			float4 temp_output_159_0_g3104 = ( float4( (_Color).rgb , 0.0 ) * tex2DNode35_g3104 * _Brightness );
			float4 ALBEDO_OUT91_g3104 = temp_output_159_0_g3104;
			float4 break462_g3104 = ALBEDO_OUT91_g3104;
			float ALBEDO_IN_XYZ464_g3104 = ( break462_g3104.r + break462_g3104.g + break462_g3104.b );
			float clampResult486_g3104 = clamp( ( ( ( ( ALBEDO_IN_XYZ464_g3104 - 0.5 ) * ( _DetailBlendInfluence - 0.9 ) ) + ( v.color.r - ( _DetailBlendHeight - 0.4 ) ) ) / _DetailBlendSmooth ) , 0.0 , 1.0 );
			float DETAIL_BLEND396_g3104 = clampResult486_g3104;
			float3 lerpResult498_g3104 = lerp( NORMAL_OUT_DETAIL491_g3104 , NORMAL_OUT23_g3104 , DETAIL_BLEND396_g3104);
			float3 m_Active502_g3104 = saturate( lerpResult498_g3104 );
			float3 localfloat3switch502_g3104 = float3switch502_g3104( m_switch502_g3104 , m_Off502_g3104 , m_Active502_g3104 );
			float3 temp_output_372_88 = localfloat3switch502_g3104;
			float3 temp_output_56_0_g3196 = temp_output_372_88;
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float3 ase_worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
			float3x3 tangentToWorld = CreateTangentToWorldPerVertex( ase_worldNormal, ase_worldTangent, v.tangent.w );
			float3 tangentNormal19_g3196 = temp_output_56_0_g3196;
			float3 modWorldNormal19_g3196 = (tangentToWorld[0] * tangentNormal19_g3196.x + tangentToWorld[1] * tangentNormal19_g3196.y + tangentToWorld[2] * tangentNormal19_g3196.z);
			float3 break12_g3196 = modWorldNormal19_g3196;
			float3 normalizeResult11_g3196 = normalize( ( ( (unity_WorldToObject[0]).xyz * break12_g3196.x ) + ( (unity_WorldToObject[1]).xyz * break12_g3196.y ) + ( (unity_WorldToObject[2]).xyz * break12_g3196.z ) ) );
			o.vertexToFrag30_g3196 = ((mul( UNITY_MATRIX_V, float4( normalizeResult11_g3196 , 0.0 ) ).xyz).xy*0.5 + 0.5);
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			int UV_SET_MAIN381_g3104 = _Mian_UVSet;
			int m_switch379_g3104 = UV_SET_MAIN381_g3104;
			int TILLING_MODE190_g3104 = _TillingMode;
			int m_switch214_g3104 = TILLING_MODE190_g3104;
			float2 appendResult192_g3104 = (float2(_TilingX , _TilingY));
			float2 TEXTURE_TILLING200_g3104 = appendResult192_g3104;
			float2 m_Standard214_g3104 = TEXTURE_TILLING200_g3104;
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 break206_g3104 = ase_parentObjectScale;
			float2 appendResult205_g3104 = (float2(break206_g3104.z , break206_g3104.y));
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float3 normalizeResult194_g3104 = normalize( ase_vertexNormal );
			float3 break201_g3104 = normalizeResult194_g3104;
			float2 appendResult204_g3104 = (float2(break206_g3104.x , break206_g3104.z));
			float2 appendResult193_g3104 = (float2(break206_g3104.x , break206_g3104.y));
			float2 TEXTURE_TILLING_SCALE210_g3104 = ( ( ( appendResult205_g3104 * break201_g3104.x ) + ( break201_g3104.y * appendResult204_g3104 ) + ( break201_g3104.z * appendResult193_g3104 ) ) * TEXTURE_TILLING200_g3104 );
			float2 m_Scale214_g3104 = TEXTURE_TILLING_SCALE210_g3104;
			float2 localfloat2switch214_g3104 = float2switch214_g3104( m_switch214_g3104 , m_Standard214_g3104 , m_Scale214_g3104 );
			float2 appendResult166_g3104 = (float2(_OffsetX , _OffsetY));
			float2 uv_TexCoord165_g3104 = i.uv_texcoord * localfloat2switch214_g3104 + appendResult166_g3104;
			float2 m_UV0379_g3104 = uv_TexCoord165_g3104;
			float2 uv2_TexCoord383_g3104 = i.uv2_texcoord2 * localfloat2switch214_g3104 + appendResult166_g3104;
			float2 m_UV1379_g3104 = uv2_TexCoord383_g3104;
			float2 localfloat2UVswitch379_g3104 = float2UVswitch379_g3104( m_switch379_g3104 , m_UV0379_g3104 , m_UV1379_g3104 );
			float4 tex2DNode35_g3104 = SAMPLE_TEXTURE2D( _MainTex, sampler_trilinear_repeat, localfloat2UVswitch379_g3104 );
			float temp_output_7_0_g3105 = tex2DNode35_g3104.a;
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen3_g3105 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither3_g3105 = Dither8x8Bayer( fmod(clipScreen3_g3105.x, 8), fmod(clipScreen3_g3105.y, 8) );
			dither3_g3105 = step( dither3_g3105, unity_LODFade.x );
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch5_g3105 = ( temp_output_7_0_g3105 * dither3_g3105 );
			#else
				float staticSwitch5_g3105 = temp_output_7_0_g3105;
			#endif
			float4 temp_cast_0 = (staticSwitch5_g3105).xxxx;
			float4 temp_output_147_0_g3200 = temp_cast_0;
			float4 OPACITY_IN148_g3200 = temp_output_147_0_g3200;
			SurfaceOutputStandardSpecular s54_g3200 = (SurfaceOutputStandardSpecular ) 0;
			int TOON_MODE50_g3196 = _ToonMode;
			int m_switch49_g3196 = TOON_MODE50_g3196;
			int SURFACE_MAP_MODE456_g3104 = _EnableDetailMap;
			int m_switch506_g3104 = SURFACE_MAP_MODE456_g3104;
			float4 temp_output_159_0_g3104 = ( float4( (_Color).rgb , 0.0 ) * tex2DNode35_g3104 * _Brightness );
			float4 ALBEDO_OUT91_g3104 = temp_output_159_0_g3104;
			float4 m_Off506_g3104 = ALBEDO_OUT91_g3104;
			int UV_SET_DETAL397_g3104 = _Detail_UVSet;
			int m_switch395_g3104 = UV_SET_DETAL397_g3104;
			int TILLING_MODE_DETAIL435_g3104 = _TillingModeDetail;
			int m_switch393_g3104 = TILLING_MODE_DETAIL435_g3104;
			float2 appendResult432_g3104 = (float2(_DetailTilingXDetail , _DetailTilingYDetail));
			float2 TEXTURE_TILLING_DETAIL425_g3104 = appendResult432_g3104;
			float2 m_Standard393_g3104 = TEXTURE_TILLING_DETAIL425_g3104;
			float3 break420_g3104 = ase_parentObjectScale;
			float2 appendResult448_g3104 = (float2(break420_g3104.z , break420_g3104.y));
			float3 normalizeResult480_g3104 = normalize( ase_vertexNormal );
			float3 break431_g3104 = normalizeResult480_g3104;
			float2 appendResult426_g3104 = (float2(break420_g3104.x , break420_g3104.z));
			float2 appendResult433_g3104 = (float2(break420_g3104.x , break420_g3104.y));
			float2 TEXTURE_TILLING_SCALE_DETAIL427_g3104 = ( ( ( appendResult448_g3104 * break431_g3104.x ) + ( break431_g3104.y * appendResult426_g3104 ) + ( break431_g3104.z * appendResult433_g3104 ) ) * TEXTURE_TILLING_DETAIL425_g3104 );
			float2 m_Scale393_g3104 = TEXTURE_TILLING_SCALE_DETAIL427_g3104;
			float2 localfloat2switch393_g3104 = float2switch393_g3104( m_switch393_g3104 , m_Standard393_g3104 , m_Scale393_g3104 );
			float2 appendResult394_g3104 = (float2(_DetailOffsetXDetail , _DetailOffsetYDetail));
			float2 uv_TexCoord414_g3104 = i.uv_texcoord * localfloat2switch393_g3104 + appendResult394_g3104;
			float2 m_UV0395_g3104 = uv_TexCoord414_g3104;
			float2 uv2_TexCoord409_g3104 = i.uv2_texcoord2 * localfloat2switch393_g3104 + appendResult394_g3104;
			float2 m_UV1395_g3104 = uv2_TexCoord409_g3104;
			float2 localfloat2UVswitch395_g3104 = float2UVswitch395_g3104( m_switch395_g3104 , m_UV0395_g3104 , m_UV1395_g3104 );
			float4 tex2DNode449_g3104 = SAMPLE_TEXTURE2D( _DetailAlbedoMap, sampler_trilinear_repeat, localfloat2UVswitch395_g3104 );
			float4 ALBEDO_OUT_DETAIL493_g3104 = ( _ColorDetail * tex2DNode449_g3104 * _DetailBrightness );
			float4 break462_g3104 = ALBEDO_OUT91_g3104;
			float ALBEDO_IN_XYZ464_g3104 = ( break462_g3104.r + break462_g3104.g + break462_g3104.b );
			float clampResult486_g3104 = clamp( ( ( ( ( ALBEDO_IN_XYZ464_g3104 - 0.5 ) * ( _DetailBlendInfluence - 0.9 ) ) + ( i.vertexColor.r - ( _DetailBlendHeight - 0.4 ) ) ) / _DetailBlendSmooth ) , 0.0 , 1.0 );
			float DETAIL_BLEND396_g3104 = clampResult486_g3104;
			float4 lerpResult503_g3104 = lerp( ALBEDO_OUT_DETAIL493_g3104 , ALBEDO_OUT91_g3104 , DETAIL_BLEND396_g3104);
			float4 m_Active506_g3104 = lerpResult503_g3104;
			float4 localfloat4switch506_g3104 = float4switch506_g3104( m_switch506_g3104 , m_Off506_g3104 , m_Active506_g3104 );
			float4 temp_output_372_106 = localfloat4switch506_g3104;
			float4 temp_output_14_0_g3196 = temp_output_372_106;
			float4 m_Off49_g3196 = temp_output_14_0_g3196;
			int m_switch5_g3196 = _ToonMode;
			float2 m_Off5_g3196 = float2( 1,1 );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			int m_switch502_g3104 = SURFACE_MAP_MODE456_g3104;
			float3 NORMAL_OUT23_g3104 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, localfloat2UVswitch379_g3104 ), _NormalStrength );
			float3 m_Off502_g3104 = NORMAL_OUT23_g3104;
			float3 NORMAL_OUT_DETAIL491_g3104 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_trilinear_repeat, localfloat2UVswitch395_g3104 ), _DetailNormalMapScale );
			float3 lerpResult498_g3104 = lerp( NORMAL_OUT_DETAIL491_g3104 , NORMAL_OUT23_g3104 , DETAIL_BLEND396_g3104);
			float3 m_Active502_g3104 = saturate( lerpResult498_g3104 );
			float3 localfloat3switch502_g3104 = float3switch502_g3104( m_switch502_g3104 , m_Off502_g3104 , m_Active502_g3104 );
			float3 temp_output_372_88 = localfloat3switch502_g3104;
			float3 temp_output_56_0_g3196 = temp_output_372_88;
			float3 NORMAL_IN78_g3196 = temp_output_56_0_g3196;
			float dotResult16_g3196 = dot( ase_worldlightDir , (WorldNormalVector( i , NORMAL_IN78_g3196 )) );
			float UV_RAMP42_g3196 = saturate( (dotResult16_g3196*0.5 + 0.5) );
			float2 temp_cast_7 = (( UV_RAMP42_g3196 * ase_lightAtten )).xx;
			float2 m_Ramp5_g3196 = temp_cast_7;
			float2 UV_MATCAP43_g3196 = i.vertexToFrag30_g3196;
			float2 m_MatCap5_g3196 = ( UV_MATCAP43_g3196 * ase_lightAtten );
			float2 localfloat2switch5_g3196 = float2switch( m_switch5_g3196 , m_Off5_g3196 , m_Ramp5_g3196 , m_MatCap5_g3196 );
			float4 tex2DNode37_g3196 = SAMPLE_TEXTURE2D( _ToonMap, sampler_trilinear_repeat, localfloat2switch5_g3196 );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 ase_worldReflection = WorldReflectionVector( i, float3( 0, 0, 1 ) );
			float dotResult132_g3196 = dot( ase_worldReflection , ase_worldlightDir );
			float4 temp_output_84_0_g3196 = saturate( ( temp_output_14_0_g3196 + ( ( tex2DNode37_g3196 * tex2DNode37_g3196.a * _Saturation ) * float4( ( ( ase_lightColor.rgb * ase_lightColor.a ) * dotResult132_g3196 ) , 0.0 ) ) ) );
			float4 m_Ramp49_g3196 = temp_output_84_0_g3196;
			float4 m_MatCap49_g3196 = temp_output_84_0_g3196;
			float4 localfloat4switch49_g3196 = float4switch49_g3196( m_switch49_g3196 , m_Off49_g3196 , m_Ramp49_g3196 , m_MatCap49_g3196 );
			float4 ALBEDO_IN45_g3200 = localfloat4switch49_g3196;
			float3 temp_cast_10 = (1.0).xxx;
			float3 NORMAL_IN44_g3200 = temp_output_372_88;
			float3 indirectNormal50_g3200 = WorldNormalVector( i , NORMAL_IN44_g3200 );
			Unity_GlossyEnvironmentData g50_g3200 = UnityGlossyEnvironmentSetup( _IndirectSmoothness, data.worldViewDir, indirectNormal50_g3200, float3(0,0,0));
			float3 indirectSpecular50_g3200 = UnityGI_IndirectSpecular( data, _IndirectOcclusion, indirectNormal50_g3200, g50_g3200 );
			float3 lerpResult27_g3200 = lerp( temp_cast_10 , indirectSpecular50_g3200 , ( 1.0 - _IndirectStrengthSpecular ));
			float3 temp_cast_11 = (1.0).xxx;
			UnityGI gi52_g3200 = gi;
			float3 diffNorm52_g3200 = WorldNormalVector( i , NORMAL_IN44_g3200 );
			gi52_g3200 = UnityGI_Base( data, 1, diffNorm52_g3200 );
			float3 indirectDiffuse52_g3200 = gi52_g3200.indirect.diffuse + diffNorm52_g3200 * 0.0001;
			float3 lerpResult6_g3200 = lerp( temp_cast_11 , indirectDiffuse52_g3200 , ( 1.0 - _IndirectStrengthDiffuse ));
			float temp_output_16_0_g3200 = ( 1.0 - ( ( 1.0 - ase_lightAtten ) * _WorldSpaceLightPos0.w ) );
			float dotResult17_g3200 = dot( ase_worldlightDir , (WorldNormalVector( i , NORMAL_IN44_g3200 )) );
			float clampResult70_g3200 = clamp( ( dotResult17_g3200 * dotResult17_g3200 * dotResult17_g3200 ) , 0.0 , 1.0 );
			float lerpResult5_g3200 = lerp( temp_output_16_0_g3200 , ( saturate( ( ( clampResult70_g3200 + _ShadowOffset ) / _ShadowSharpness ) ) * ase_lightAtten ) , _ShadowStrength);
			float3 LIGHTING32_g3200 = ( lerpResult27_g3200 * saturate( ( ( lerpResult6_g3200 * ase_lightColor.a * temp_output_16_0_g3200 ) + ( ase_lightColor.rgb * lerpResult5_g3200 ) ) ) );
			float4 temp_output_35_0_g3200 = ( ALBEDO_IN45_g3200 * float4( LIGHTING32_g3200 , 0.0 ) );
			s54_g3200.Albedo = temp_output_35_0_g3200.xyz;
			s54_g3200.Normal = WorldNormalVector( i , NORMAL_IN44_g3200 );
			int m_switch72_g3198 = _EnableHighlight;
			float4 color79_g3198 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float4 m_Off72_g3198 = color79_g3198;
			int m_switch131_g3193 = _EmissionMode;
			float4 color46_g3193 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float4 COLOR_000079_g3193 = color46_g3193;
			float4 m_Off131_g3193 = COLOR_000079_g3193;
			float4 EMISSION_TINT_01_RGBA75_g3193 = _EmissionTint_01;
			float EMISSION_TINT_01_A62_g3193 = _EmissionTint_01.a;
			float EMISSION_TINT_01_STRENGHT73_g3193 = _EmissionTintStrength_01;
			int UV_SET_EMISSION136_g3193 = _Emission_UVSet;
			int m_switch138_g3193 = UV_SET_EMISSION136_g3193;
			int m_switch58_g3193 = _EmissionMask_TillingMode;
			float2 appendResult57_g3193 = (float2(_EmissionMask_TilingX , _EmissionMask_TilingY));
			float2 m_Standard58_g3193 = appendResult57_g3193;
			float3 break35_g3193 = ase_parentObjectScale;
			float2 appendResult13_g3193 = (float2(break35_g3193.z , break35_g3193.y));
			float3 normalizeResult60_g3193 = normalize( ase_vertexNormal );
			float3 break44_g3193 = normalizeResult60_g3193;
			float2 appendResult28_g3193 = (float2(break35_g3193.x , break35_g3193.z));
			float2 appendResult9_g3193 = (float2(break35_g3193.x , break35_g3193.y));
			float2 m_Scale58_g3193 = ( ( ( appendResult13_g3193 * break44_g3193.x ) + ( break44_g3193.y * appendResult28_g3193 ) + ( break44_g3193.z * appendResult9_g3193 ) ) * appendResult57_g3193 );
			float2 localfloat2switch58_g3193 = float2switch58_g3193( m_switch58_g3193 , m_Standard58_g3193 , m_Scale58_g3193 );
			float2 appendResult27_g3193 = (float2(_EmissionMask_OffsetX , _EmissionMask_OffsetY));
			float2 uv_TexCoord74_g3193 = i.uv_texcoord * localfloat2switch58_g3193 + appendResult27_g3193;
			float2 m_UV0138_g3193 = uv_TexCoord74_g3193;
			float2 uv2_TexCoord139_g3193 = i.uv2_texcoord2 * localfloat2switch58_g3193 + appendResult27_g3193;
			float2 m_UV1138_g3193 = uv2_TexCoord139_g3193;
			float2 localfloat2UVswitch138_g3193 = float2UVswitch138_g3193( m_switch138_g3193 , m_UV0138_g3193 , m_UV1138_g3193 );
			float4 tex2DNode82_g3193 = SAMPLE_TEXTURE2D( _EmissionMapMask, sampler_trilinear_repeat, localfloat2UVswitch138_g3193 );
			float4 EMISSION_MAP_MASK_RGBA91_g3193 = tex2DNode82_g3193;
			float4 lerpResult117_g3193 = lerp( COLOR_000079_g3193 , ( EMISSION_TINT_01_RGBA75_g3193 * EMISSION_TINT_01_A62_g3193 * EMISSION_TINT_01_STRENGHT73_g3193 ) , EMISSION_MAP_MASK_RGBA91_g3193);
			float4 EMISSION_TINT_02_RGBA69_g3193 = _EmissionTint_02;
			float EMISSION_TINT_02_A92_g3193 = _EmissionTint_02.a;
			float EMISSION_TINT_02_STRENGHT70_g3193 = _EmissionTintStrength_02;
			float4 lerpResult124_g3193 = lerp( lerpResult117_g3193 , ( EMISSION_TINT_02_RGBA69_g3193 * EMISSION_TINT_02_A92_g3193 * EMISSION_TINT_02_STRENGHT70_g3193 ) , EMISSION_MAP_MASK_RGBA91_g3193);
			float4 EMISSION_TINTGLOW_RGBA90_g3193 = _EmissionTintGlow;
			float EMISSION_TINTGLOW_A78_g3193 = _EmissionTintGlow.a;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float4 NORMAL_IN77_g3193 = temp_output_372_106;
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_tangentToWorldFast = float3x3(ase_worldTangent.x,ase_worldBitangent.x,ase_worldNormal.x,ase_worldTangent.y,ase_worldBitangent.y,ase_worldNormal.y,ase_worldTangent.z,ase_worldBitangent.z,ase_worldNormal.z);
			float fresnelNdotV123_g3193 = dot( mul(ase_tangentToWorldFast,NORMAL_IN77_g3193.xyz), ase_worldViewDir );
			float fresnelNode123_g3193 = ( 0.0 + 1.0 * pow( max( 1.0 - fresnelNdotV123_g3193 , 0.0001 ), 10.0 ) );
			float4 lerpResult121_g3193 = lerp( COLOR_000079_g3193 , ( EMISSION_TINTGLOW_RGBA90_g3193 * EMISSION_TINTGLOW_A78_g3193 ) , fresnelNode123_g3193);
			float EMISSION_TINTGLOW_STRENGHT93_g3193 = _EmissionTintGlowStrength;
			float4 EMISSION_TYPE_HIGHLIGHT109_g3193 = saturate( ( lerpResult124_g3193 + ( lerpResult121_g3193 * EMISSION_TINTGLOW_STRENGHT93_g3193 ) ) );
			float4 m_Active131_g3193 = EMISSION_TYPE_HIGHLIGHT109_g3193;
			float4 localfloat4switch131_g3193 = float4switch131_g3193( m_switch131_g3193 , m_Off131_g3193 , m_Active131_g3193 );
			float3 temp_output_104_0_g3198 = temp_output_372_88;
			float3 normalizeResult113_g3198 = normalize( temp_output_104_0_g3198 );
			float3 normalizeResult110_g3198 = normalize( i.viewDir );
			float dotResult107_g3198 = dot( normalizeResult113_g3198 , normalizeResult110_g3198 );
			float mulTime97_g3198 = _Time.y * 0.05;
			float4 temp_output_74_0_g3198 = ( ( pow( ( 1.0 - saturate( dotResult107_g3198 ) ) , (10.0 + ((_SpeedMinLevel + (sin( ( mulTime97_g3198 * _Speed ) ) - -1.0) * (_SpeedMaxLevel - _SpeedMinLevel) / (1.0 - -1.0)) - 0.0) * (0.0 - 10.0) / (1.0 - 0.0)) ) * _HighlightTint * _HighlightTint.a ) * _HighlightStrength );
			float4 m_Active72_g3198 = ( localfloat4switch131_g3193 + temp_output_74_0_g3198 );
			float4 localfloat4switch72_g3198 = float4switch( m_switch72_g3198 , m_Off72_g3198 , m_Active72_g3198 );
			float4 EMISSION_IN46_g3200 = localfloat4switch72_g3198;
			s54_g3200.Emission = EMISSION_IN46_g3200.xyz;
			float3 normalizeResult189_g3200 = normalize( (WorldNormalVector( i , NORMAL_IN44_g3200 )) );
			float3 normalizeResult184_g3200 = normalize( ( ase_worldViewDir + ase_worldlightDir ) );
			float dotResult195_g3200 = dot( normalizeResult189_g3200 , normalizeResult184_g3200 );
			float clampResult226_g3200 = clamp( ( dotResult195_g3200 * dotResult195_g3200 * dotResult195_g3200 ) , 0.0 , 1.0 );
			float4 SPECULAR207_g3200 = saturate( ( pow( clampResult226_g3200 , max( _Shininess , 110.0 ) ) * _SpecularColor * _SpecularColor.a ) );
			s54_g3200.Specular = SPECULAR207_g3200.rgb;
			float2 CUSTOM_UV1179_g3104 = localfloat2UVswitch379_g3104;
			float4 SMOOTHNESS_IN48_g3200 = ( _SmoothnessStrength * SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_trilinear_repeat, CUSTOM_UV1179_g3104 ) );
			s54_g3200.Smoothness = SMOOTHNESS_IN48_g3200.x;
			float4 temp_cast_23 = (1.0).xxxx;
			float4 temp_cast_24 = (i.vertexColor.a).xxxx;
			float4 lerpResult134_g3104 = lerp( SAMPLE_TEXTURE2D( _OcclusionMap, sampler_trilinear_repeat, CUSTOM_UV1179_g3104 ) , temp_cast_24 , (float)_OcclusionSourceMode);
			float4 lerpResult135_g3104 = lerp( temp_cast_23 , lerpResult134_g3104 , _OcclusionStrengthAO);
			float4 OCCLUSION_IN49_g3200 = lerpResult135_g3104;
			s54_g3200.Occlusion = OCCLUSION_IN49_g3200.x;

			data.light = gi.light;

			UnityGI gi54_g3200 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g54_g3200 = UnityGlossyEnvironmentSetup( s54_g3200.Smoothness, data.worldViewDir, s54_g3200.Normal, float3(0,0,0));
			gi54_g3200 = UnityGlobalIllumination( data, s54_g3200.Occlusion, s54_g3200.Normal, g54_g3200 );
			#endif

			float3 surfResult54_g3200 = LightingStandardSpecular ( s54_g3200, viewDir, gi54_g3200 ).rgb;
			surfResult54_g3200 += s54_g3200.Emission;

			#ifdef UNITY_PASS_FORWARDADD//54_g3200
			surfResult54_g3200 -= s54_g3200.Emission;
			#endif//54_g3200
			c.rgb = surfResult54_g3200;
			c.a = OPACITY_IN148_g3200.x;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18502
1966;54;1076;952;441.3193;851.8693;1;True;False
Node;AmplifyShaderEditor.FunctionNode;372;-454.4262,-608.283;Inherit;False;DECSF Master Map Surface;4;;3104;6c26b12be02413b47bab527585da6bf6;4,185,0,508,0,520,0,366,0;0;9;FLOAT4;106;FLOAT3;88;COLOR;115;COLOR;129;COLOR;116;FLOAT;181;FLOAT;144;FLOAT;318;FLOAT;365
Node;AmplifyShaderEditor.FunctionNode;460;-87.16808,-753.5672;Inherit;False;DECSF Module Emission;75;;3193;58d2647a47347ee4891854495f246dd8;0;1;72;FLOAT4;0,0,1,0;False;1;FLOAT4;2
Node;AmplifyShaderEditor.CommentaryNode;290;1099.66,-874.6608;Inherit;False;346.5028;193.4201;;4;291;293;292;353;DEBUG SETTINGS ;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;295;1105.083,-1033.865;Inherit;False;370;124;;1;294;GLOBAL SETTINGS ;0.09433961,0.09433961,0.09433961,1;0;0
Node;AmplifyShaderEditor.FunctionNode;370;338.6641,-393.5479;Inherit;False;DECSF Module Wind;91;;3195;0c33ef2b38b405041aea041abb730ab8;10,230,0,242,0,164,0,202,0,196,0,220,0,310,0,308,0,289,0,309,0;0;1;FLOAT3;305
Node;AmplifyShaderEditor.FunctionNode;434;250.9791,-627.833;Inherit;False;DECSF Module Toon Texture;59;;3196;0404cf29c555e01489ddf22920662251;0;2;14;FLOAT4;0,0,0,0;False;56;FLOAT3;1,1,1;False;1;FLOAT4;38
Node;AmplifyShaderEditor.FunctionNode;462;248.979,-751.4331;Inherit;False;DECSF Module Highlight;66;;3198;0d70e226ee2a0634ba3a01f211d91aae;1,73,1;2;77;FLOAT4;0,0,0,0;False;104;FLOAT3;1,1,1;False;1;FLOAT4;80
Node;AmplifyShaderEditor.IntNode;292;1287.867,-766.0188;Inherit;False;Property;_ZTestMode;ZTest Mode;1;1;[Enum];Create;False;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;4;4;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;291;1108.889,-832.9455;Inherit;False;Property;_ColorMask;Color Mask Mode;2;1;[Enum];Create;False;0;1;None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15;True;0;False;15;15;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;294;1122.896,-996.053;Inherit;False;Property;_CullMode;Cull Mode;3;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;1;Header(GLOBAL SETTINGS);False;0;2;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;353;1113.131,-761.5532;Inherit;False;Constant;_MaskClipValue;Mask Clip Value;14;0;Create;True;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;293;1287.395,-837.1179;Inherit;False;Property;_ZWriteMode;ZWrite Mode;0;1;[Enum];Create;False;0;1;Off,0,On,1;True;2;Header(SHADER VERSION 1.0 STANDARD);Header(DEBUG SETTINGS);False;1;1;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;446;602.3895,-396.9119;Inherit;False;DECSF Module Outline;63;;3199;4da0d39180180e64ba9dd3482728a57e;1,15,0;2;14;FLOAT4;0,0,0,0;False;6;FLOAT3;0,0,0;False;1;FLOAT3;13
Node;AmplifyShaderEditor.FunctionNode;450;621.6586,-622.1521;Inherit;False;DECSF Module Custom Lighting;49;;3200;43bd29f4785fded42a0cee7fb1455076;8,180,0,177,0,178,0,176,0,179,0,175,0,61,1,174,0;10;40;FLOAT4;0,0,0,0;False;37;FLOAT4;0,0,0,0;False;38;FLOAT3;1,1,1;False;41;FLOAT4;0,0,0,0;False;42;FLOAT4;0,0,0,0;False;43;FLOAT4;0,0,0,0;False;147;FLOAT4;0,0,0,0;False;151;FLOAT4;0,0,0,0;False;161;FLOAT3;0,0,0;False;160;FLOAT3;0,0,0;False;3;FLOAT4;149;FLOAT4;154;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;194;1099.596,-656.6111;Float;False;True;-1;3;;200;0;CustomLighting;DEC/Custom Lighting/Custom Lighting Surface Detail;False;False;False;False;False;False;False;False;False;False;False;False;True;False;True;False;False;False;True;True;True;Back;0;True;293;0;True;292;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;-10;True;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;True;291;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;200;;-1;-1;-1;-1;1;NatureRendererInstancing=True;False;0;0;True;294;-1;0;True;353;5;Pragma;multi_compile_instancing;False;;Custom;Pragma;instancing_options procedural:SetupNatureRenderer forwardadd;False;;Custom;Pragma;multi_compile GPU_FRUSTUM_ON __;False;;Custom;Include;Nature Renderer.cginc;False;5d792e02fd6741e4cb63087f97979470;Custom;Pragma;multi_compile_local _ NATURE_RENDERER;False;;Custom;0;0;False;0.1;False;-1;0;False;-1;True;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;460;72;372;106
WireConnection;434;14;372;106
WireConnection;434;56;372;88
WireConnection;462;77;460;2
WireConnection;462;104;372;88
WireConnection;446;6;370;305
WireConnection;450;40;462;80
WireConnection;450;37;434;38
WireConnection;450;38;372;88
WireConnection;450;42;372;129
WireConnection;450;43;372;116
WireConnection;450;147;372;144
WireConnection;194;9;450;149
WireConnection;194;13;450;0
WireConnection;194;11;446;13
ASEEND*/
//CHKSM=C934D6B6ABDF4168118FB9E8E8A0A155717F8323