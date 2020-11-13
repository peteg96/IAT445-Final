// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DEC/Surface Wind/Surface Wind Vertex Detail"
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
		[SingleLineTexture]_Metal("Metallic Map", 2D) = "white" {}
		_MetallicStrength("Metallic Strength", Range( 0 , 1)) = 0
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
		[Enum(Off,0,Active,1)][Header(MAP DETAIL MASK)]_EnableDetailMask("Enable Detail Mask", Int) = 0
		[SingleLineTexture]_DetailMaskMap("Mask Map", 2D) = "white" {}
		_DetailTilingXDetailMask("Tiling X", Float) = 1
		_DetailTilingYDetailMask("Tiling Y", Float) = 1
		_DetailOffsetXDetailMask("Offset X", Float) = 0
		_DetailOffsetYDetailMask("Offset Y", Float) = 0
		[Enum(Off,0,Global,1,Local,2)][Header(WIND)]_WindMode("Wind Mode", Int) = 0
		[Header(WIND MODE GLOBAL)]_GlobalWindInfluenceOther("Wind Strength", Float) = 0.3
		[Header(WIND MODE LOCAL)]_LocalWindStrength("Wind Strength", Float) = 0.3
		_LocalWindPulse("Wind Pulse", Float) = 0.1
		_LocalWindDirection("Wind Direction", Float) = 1
		_LocalRandomWindOffset("Wind Random Offset", Float) = 0.2
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry-10" "IgnoreProjector" = "True" "NatureRendererInstancing"="True" }
		LOD 200
		Cull [_CullMode]
		ZWrite [_ZWriteMode]
		ZTest [_ZTestMode]
		ColorMask [_ColorMask]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
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

		#pragma surface surf Standard keepalpha addshadow fullforwardshadows dithercrossfade vertex:vertexDataFunc 
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
			float2 uv2_texcoord2;
			float4 vertexColor : COLOR;
			float4 screenPosition;
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
		uniform int _EnableDetailMap;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		uniform int _Mian_UVSet;
		uniform int _TillingMode;
		uniform float _TilingX;
		uniform float _TilingY;
		uniform float _OffsetX;
		uniform float _OffsetY;
		SamplerState sampler_trilinear_repeat;
		uniform half _NormalStrength;
		uniform int _EnableDetailMask;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_DetailNormalMap);
		uniform int _Detail_UVSet;
		uniform int _TillingModeDetail;
		uniform float _DetailTilingXDetail;
		uniform float _DetailTilingYDetail;
		uniform half _DetailOffsetXDetail;
		uniform half _DetailOffsetYDetail;
		uniform half _DetailNormalMapScale;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_DetailMaskMap);
		SamplerState sampler_DetailMaskMap;
		uniform float _DetailTilingXDetailMask;
		uniform float _DetailTilingYDetailMask;
		uniform half _DetailOffsetXDetailMask;
		uniform half _DetailOffsetYDetailMask;
		uniform float4 _Color;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		uniform half _Brightness;
		uniform half _DetailBlendInfluence;
		uniform half _DetailBlendHeight;
		uniform half _DetailBlendSmooth;
		uniform half4 _ColorDetail;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_DetailAlbedoMap);
		uniform half _DetailBrightness;
		uniform float _MetallicStrength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_Metal);
		uniform float _SmoothnessStrength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SmoothnessMap);
		UNITY_DECLARE_TEX2D_NOSAMPLER(_OcclusionMap);
		uniform int _OcclusionSourceMode;
		uniform float _OcclusionStrengthAO;
		SamplerState sampler_MainTex;


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


		float3 float3switch396_g3243( int m_switch, float3 m_Off, float3 m_Global, float3 m_Local )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Global;
			if(m_switch == 2)
				return m_Local;
			return m_Off;
		}


		float2 float2switch214_g3248( int m_switch, float2 m_Standard, float2 m_Scale )
		{
			if(m_switch == 0)
				return m_Standard;
			if(m_switch == 1)
				return m_Scale;
			return m_Standard;
		}


		float2 float2UVswitch379_g3248( int m_switch, float2 m_UV0, float2 m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		float2 float2switch393_g3248( int m_switch, float2 m_Standard, float2 m_Scale )
		{
			if(m_switch == 0)
				return m_Standard;
			if(m_switch == 1)
				return m_Scale;
			return m_Standard;
		}


		float2 float2UVswitch395_g3248( int m_switch, float2 m_UV0, float2 m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		float2 float2UVswitch401_g3248( int m_switch, float2 m_UV0, float2 m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		float3 float3switch467_g3248( int m_switch, float3 m_Off, float3 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float3 float3switch502_g3248( int m_switch, float3 m_Off, float3 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float4 float4switch476_g3248( int m_switch, float4 m_Off, float4 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float4 float4switch506_g3248( int m_switch, float4 m_Off, float4 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
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


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			int WindController383_g3243 = _WindMode;
			int m_switch396_g3243 = WindController383_g3243;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VAR_VERTEXPOSITION_MATRIX299_g3243 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 m_Off396_g3243 = VAR_VERTEXPOSITION_MATRIX299_g3243;
			float3 break156_g3243 = VAR_VERTEXPOSITION_MATRIX299_g3243;
			int m_switch390_g3243 = _WindMode;
			float m_Off390_g3243 = 1.0;
			float GLOBAL_WINDINFLUENCE340_g3243 = _WindStrength;
			float m_Global390_g3243 = ( _GlobalWindInfluenceOther * GLOBAL_WINDINFLUENCE340_g3243 );
			float m_Local390_g3243 = _LocalWindStrength;
			float localfloatswitch390_g3243 = floatswitch( m_switch390_g3243 , m_Off390_g3243 , m_Global390_g3243 , m_Local390_g3243 );
			float VAR_WindStrength129_g3243 = localfloatswitch390_g3243;
			int m_switch117_g3243 = _WindMode;
			float m_Off117_g3243 = 1.0;
			float GLOBAL_RANDOMWINDOFFSET339_g3243 = _RandomWindOffset;
			float m_Global117_g3243 = GLOBAL_RANDOMWINDOFFSET339_g3243;
			float m_Local117_g3243 = _LocalRandomWindOffset;
			float localfloatswitch117_g3243 = floatswitch( m_switch117_g3243 , m_Off117_g3243 , m_Global117_g3243 , m_Local117_g3243 );
			float VAR_WindOffset76_g3243 = localfloatswitch117_g3243;
			float4 transform288_g3243 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult210_g3243 = (float2(transform288_g3243.x , transform288_g3243.z));
			float dotResult271_g3243 = dot( appendResult210_g3243 , float2( 12.9898,78.233 ) );
			float lerpResult44_g3243 = lerp( 0.8 , ( ( VAR_WindOffset76_g3243 / 2.0 ) + 0.9 ) , frac( ( sin( dotResult271_g3243 ) * 43758.55 ) ));
			float VAR_RandomTime191_g3243 = ( _Time.x * lerpResult44_g3243 );
			float FUNC_Turbulence296_g3243 = ( sin( ( ( VAR_RandomTime191_g3243 * 40.0 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3243.z / 15.0 ) ) ) * 0.5 );
			int m_switch387_g3243 = _WindMode;
			float m_Off387_g3243 = 1.0;
			float GLOBAL_WINDPULSE342_g3243 = _WindPulse;
			float m_Global387_g3243 = GLOBAL_WINDPULSE342_g3243;
			float m_Local387_g3243 = _LocalWindPulse;
			float localfloatswitch387_g3243 = floatswitch( m_switch387_g3243 , m_Off387_g3243 , m_Global387_g3243 , m_Local387_g3243 );
			float VAR_WindPulse264_g3243 = localfloatswitch387_g3243;
			float FUNC_Angle148_g3243 = ( VAR_WindStrength129_g3243 * ( 1.0 + sin( ( ( ( ( VAR_RandomTime191_g3243 * 2.0 ) + FUNC_Turbulence296_g3243 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3243.z / 50.0 ) ) - ( v.color.r / 20.0 ) ) ) ) * sqrt( v.color.r ) * VAR_WindPulse264_g3243 );
			float VAR_SinA111_g3243 = sin( FUNC_Angle148_g3243 );
			float VAR_CosA243_g3243 = cos( FUNC_Angle148_g3243 );
			int m_switch389_g3243 = _WindMode;
			float m_Off389_g3243 = 1.0;
			float GLOBAL_WINDDIRECTION341_g3243 = _WindDirection;
			float m_Global389_g3243 = GLOBAL_WINDDIRECTION341_g3243;
			float m_Local389_g3243 = _LocalWindDirection;
			float localfloatswitch389_g3243 = floatswitch( m_switch389_g3243 , m_Off389_g3243 , m_Global389_g3243 , m_Local389_g3243 );
			float _WindDirection178_g3243 = localfloatswitch389_g3243;
			float2 localDirectionalEquation178_g3243 = DirectionalEquation( _WindDirection178_g3243 );
			float2 break74_g3243 = localDirectionalEquation178_g3243;
			float VAR_xLerp173_g3243 = break74_g3243.x;
			float lerpResult232_g3243 = lerp( break156_g3243.x , ( ( break156_g3243.y * VAR_SinA111_g3243 ) + ( break156_g3243.x * VAR_CosA243_g3243 ) ) , VAR_xLerp173_g3243);
			float3 break99_g3243 = VAR_VERTEXPOSITION_MATRIX299_g3243;
			float3 break201_g3243 = VAR_VERTEXPOSITION_MATRIX299_g3243;
			float VAR_zLerp206_g3243 = break74_g3243.y;
			float lerpResult104_g3243 = lerp( break201_g3243.z , ( ( break201_g3243.y * VAR_SinA111_g3243 ) + ( break201_g3243.z * VAR_CosA243_g3243 ) ) , VAR_zLerp206_g3243);
			float3 appendResult197_g3243 = (float3(lerpResult232_g3243 , ( ( break99_g3243.y * VAR_CosA243_g3243 ) - ( break99_g3243.z * VAR_SinA111_g3243 ) ) , lerpResult104_g3243));
			float3 FUNC_vertexPos132_g3243 = appendResult197_g3243;
			float3 m_Global396_g3243 = FUNC_vertexPos132_g3243;
			float3 m_Local396_g3243 = FUNC_vertexPos132_g3243;
			float3 localfloat3switch396_g3243 = float3switch396_g3243( m_switch396_g3243 , m_Off396_g3243 , m_Global396_g3243 , m_Local396_g3243 );
			float3 temp_output_261_0_g3243 = mul( unity_WorldToObject, float4( localfloat3switch396_g3243 , 0.0 ) ).xyz;
			float3 VAR_VERTEXPOSITION298_g3243 = ase_vertex3Pos;
			v.vertex.xyz += ( temp_output_261_0_g3243 - VAR_VERTEXPOSITION298_g3243 );
			v.vertex.w = 1;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			int SURFACE_MAP_MODE456_g3248 = _EnableDetailMap;
			int m_switch502_g3248 = SURFACE_MAP_MODE456_g3248;
			int UV_SET_MAIN381_g3248 = _Mian_UVSet;
			int m_switch379_g3248 = UV_SET_MAIN381_g3248;
			int TILLING_MODE190_g3248 = _TillingMode;
			int m_switch214_g3248 = TILLING_MODE190_g3248;
			float2 appendResult192_g3248 = (float2(_TilingX , _TilingY));
			float2 TEXTURE_TILLING200_g3248 = appendResult192_g3248;
			float2 m_Standard214_g3248 = TEXTURE_TILLING200_g3248;
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 break206_g3248 = ase_parentObjectScale;
			float2 appendResult205_g3248 = (float2(break206_g3248.z , break206_g3248.y));
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float3 normalizeResult194_g3248 = normalize( ase_vertexNormal );
			float3 break201_g3248 = normalizeResult194_g3248;
			float2 appendResult204_g3248 = (float2(break206_g3248.x , break206_g3248.z));
			float2 appendResult193_g3248 = (float2(break206_g3248.x , break206_g3248.y));
			float2 TEXTURE_TILLING_SCALE210_g3248 = ( ( ( appendResult205_g3248 * break201_g3248.x ) + ( break201_g3248.y * appendResult204_g3248 ) + ( break201_g3248.z * appendResult193_g3248 ) ) * TEXTURE_TILLING200_g3248 );
			float2 m_Scale214_g3248 = TEXTURE_TILLING_SCALE210_g3248;
			float2 localfloat2switch214_g3248 = float2switch214_g3248( m_switch214_g3248 , m_Standard214_g3248 , m_Scale214_g3248 );
			float2 appendResult166_g3248 = (float2(_OffsetX , _OffsetY));
			float2 uv_TexCoord165_g3248 = i.uv_texcoord * localfloat2switch214_g3248 + appendResult166_g3248;
			float2 m_UV0379_g3248 = uv_TexCoord165_g3248;
			float2 uv2_TexCoord383_g3248 = i.uv2_texcoord2 * localfloat2switch214_g3248 + appendResult166_g3248;
			float2 m_UV1379_g3248 = uv2_TexCoord383_g3248;
			float2 localfloat2UVswitch379_g3248 = float2UVswitch379_g3248( m_switch379_g3248 , m_UV0379_g3248 , m_UV1379_g3248 );
			float3 NORMAL_OUT23_g3248 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, localfloat2UVswitch379_g3248 ), _NormalStrength );
			float3 m_Off502_g3248 = NORMAL_OUT23_g3248;
			int EnableDetailMask428_g3248 = _EnableDetailMask;
			int m_switch467_g3248 = EnableDetailMask428_g3248;
			int UV_SET_DETAL397_g3248 = _Detail_UVSet;
			int m_switch395_g3248 = UV_SET_DETAL397_g3248;
			int TILLING_MODE_DETAIL435_g3248 = _TillingModeDetail;
			int m_switch393_g3248 = TILLING_MODE_DETAIL435_g3248;
			float2 appendResult432_g3248 = (float2(_DetailTilingXDetail , _DetailTilingYDetail));
			float2 TEXTURE_TILLING_DETAIL425_g3248 = appendResult432_g3248;
			float2 m_Standard393_g3248 = TEXTURE_TILLING_DETAIL425_g3248;
			float3 break420_g3248 = ase_parentObjectScale;
			float2 appendResult448_g3248 = (float2(break420_g3248.z , break420_g3248.y));
			float3 normalizeResult480_g3248 = normalize( ase_vertexNormal );
			float3 break431_g3248 = normalizeResult480_g3248;
			float2 appendResult426_g3248 = (float2(break420_g3248.x , break420_g3248.z));
			float2 appendResult433_g3248 = (float2(break420_g3248.x , break420_g3248.y));
			float2 TEXTURE_TILLING_SCALE_DETAIL427_g3248 = ( ( ( appendResult448_g3248 * break431_g3248.x ) + ( break431_g3248.y * appendResult426_g3248 ) + ( break431_g3248.z * appendResult433_g3248 ) ) * TEXTURE_TILLING_DETAIL425_g3248 );
			float2 m_Scale393_g3248 = TEXTURE_TILLING_SCALE_DETAIL427_g3248;
			float2 localfloat2switch393_g3248 = float2switch393_g3248( m_switch393_g3248 , m_Standard393_g3248 , m_Scale393_g3248 );
			float2 appendResult394_g3248 = (float2(_DetailOffsetXDetail , _DetailOffsetYDetail));
			float2 uv_TexCoord414_g3248 = i.uv_texcoord * localfloat2switch393_g3248 + appendResult394_g3248;
			float2 m_UV0395_g3248 = uv_TexCoord414_g3248;
			float2 uv2_TexCoord409_g3248 = i.uv2_texcoord2 * localfloat2switch393_g3248 + appendResult394_g3248;
			float2 m_UV1395_g3248 = uv2_TexCoord409_g3248;
			float2 localfloat2UVswitch395_g3248 = float2UVswitch395_g3248( m_switch395_g3248 , m_UV0395_g3248 , m_UV1395_g3248 );
			float3 NORMAL_OUT_DETAIL491_g3248 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_trilinear_repeat, localfloat2UVswitch395_g3248 ), _DetailNormalMapScale );
			float3 m_Off467_g3248 = NORMAL_OUT_DETAIL491_g3248;
			int m_switch401_g3248 = UV_SET_DETAL397_g3248;
			float2 appendResult445_g3248 = (float2(_DetailTilingXDetailMask , _DetailTilingYDetailMask));
			float2 appendResult417_g3248 = (float2(_DetailOffsetXDetailMask , _DetailOffsetYDetailMask));
			float2 uv_TexCoord415_g3248 = i.uv_texcoord * appendResult445_g3248 + appendResult417_g3248;
			float2 m_UV0401_g3248 = uv_TexCoord415_g3248;
			float2 uv2_TexCoord447_g3248 = i.uv2_texcoord2 * appendResult445_g3248 + appendResult417_g3248;
			float2 m_UV1401_g3248 = uv2_TexCoord447_g3248;
			float2 localfloat2UVswitch401_g3248 = float2UVswitch401_g3248( m_switch401_g3248 , m_UV0401_g3248 , m_UV1401_g3248 );
			float4 tex2DNode418_g3248 = SAMPLE_TEXTURE2D( _DetailMaskMap, sampler_trilinear_repeat, localfloat2UVswitch401_g3248 );
			float3 lerpResult470_g3248 = lerp( NORMAL_OUT23_g3248 , NORMAL_OUT_DETAIL491_g3248 , tex2DNode418_g3248.r);
			float3 m_Active467_g3248 = saturate( lerpResult470_g3248 );
			float3 localfloat3switch467_g3248 = float3switch467_g3248( m_switch467_g3248 , m_Off467_g3248 , m_Active467_g3248 );
			float3 MASK_NORMAL_OUT469_g3248 = localfloat3switch467_g3248;
			float4 tex2DNode35_g3248 = SAMPLE_TEXTURE2D( _MainTex, sampler_trilinear_repeat, localfloat2UVswitch379_g3248 );
			float4 temp_output_159_0_g3248 = ( float4( (_Color).rgb , 0.0 ) * tex2DNode35_g3248 * _Brightness );
			float4 ALBEDO_OUT91_g3248 = temp_output_159_0_g3248;
			float4 break462_g3248 = ALBEDO_OUT91_g3248;
			float ALBEDO_IN_XYZ464_g3248 = ( break462_g3248.r + break462_g3248.g + break462_g3248.b );
			float clampResult486_g3248 = clamp( ( ( ( ( ALBEDO_IN_XYZ464_g3248 - 0.5 ) * ( _DetailBlendInfluence - 0.9 ) ) + ( i.vertexColor.r - ( _DetailBlendHeight - 0.4 ) ) ) / _DetailBlendSmooth ) , 0.0 , 1.0 );
			float DETAIL_BLEND396_g3248 = clampResult486_g3248;
			float3 lerpResult498_g3248 = lerp( MASK_NORMAL_OUT469_g3248 , NORMAL_OUT23_g3248 , DETAIL_BLEND396_g3248);
			float3 m_Active502_g3248 = saturate( lerpResult498_g3248 );
			float3 localfloat3switch502_g3248 = float3switch502_g3248( m_switch502_g3248 , m_Off502_g3248 , m_Active502_g3248 );
			o.Normal = localfloat3switch502_g3248;
			int m_switch506_g3248 = SURFACE_MAP_MODE456_g3248;
			float4 m_Off506_g3248 = ALBEDO_OUT91_g3248;
			int m_switch476_g3248 = EnableDetailMask428_g3248;
			float4 tex2DNode449_g3248 = SAMPLE_TEXTURE2D( _DetailAlbedoMap, sampler_trilinear_repeat, localfloat2UVswitch395_g3248 );
			float4 ALBEDO_OUT_DETAIL493_g3248 = ( _ColorDetail * tex2DNode449_g3248 * _DetailBrightness );
			float4 m_Off476_g3248 = ALBEDO_OUT_DETAIL493_g3248;
			float4 lerpResult477_g3248 = lerp( ALBEDO_OUT91_g3248 , ALBEDO_OUT_DETAIL493_g3248 , tex2DNode418_g3248.r);
			float4 m_Active476_g3248 = lerpResult477_g3248;
			float4 localfloat4switch476_g3248 = float4switch476_g3248( m_switch476_g3248 , m_Off476_g3248 , m_Active476_g3248 );
			float4 MASK_ALBEDO_OUT473_g3248 = localfloat4switch476_g3248;
			float4 lerpResult503_g3248 = lerp( MASK_ALBEDO_OUT473_g3248 , ALBEDO_OUT91_g3248 , DETAIL_BLEND396_g3248);
			float4 m_Active506_g3248 = lerpResult503_g3248;
			float4 localfloat4switch506_g3248 = float4switch506_g3248( m_switch506_g3248 , m_Off506_g3248 , m_Active506_g3248 );
			o.Albedo = localfloat4switch506_g3248.xyz;
			float2 CUSTOM_UV1179_g3248 = localfloat2UVswitch379_g3248;
			o.Metallic = ( _MetallicStrength * SAMPLE_TEXTURE2D( _Metal, sampler_trilinear_repeat, CUSTOM_UV1179_g3248 ) ).r;
			o.Smoothness = ( _SmoothnessStrength * SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_trilinear_repeat, CUSTOM_UV1179_g3248 ) ).r;
			float4 temp_cast_11 = (1.0).xxxx;
			float4 temp_cast_12 = (i.vertexColor.a).xxxx;
			float4 lerpResult134_g3248 = lerp( SAMPLE_TEXTURE2D( _OcclusionMap, sampler_trilinear_repeat, CUSTOM_UV1179_g3248 ) , temp_cast_12 , (float)_OcclusionSourceMode);
			float4 lerpResult135_g3248 = lerp( temp_cast_11 , lerpResult134_g3248 , _OcclusionStrengthAO);
			o.Occlusion = lerpResult135_g3248.r;
			float temp_output_7_0_g3249 = tex2DNode35_g3248.a;
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen3_g3249 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither3_g3249 = Dither8x8Bayer( fmod(clipScreen3_g3249.x, 8), fmod(clipScreen3_g3249.y, 8) );
			dither3_g3249 = step( dither3_g3249, unity_LODFade.x );
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch5_g3249 = ( temp_output_7_0_g3249 * dither3_g3249 );
			#else
				float staticSwitch5_g3249 = temp_output_7_0_g3249;
			#endif
			o.Alpha = staticSwitch5_g3249;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18502
1966;54;1076;952;-938.8442;847.6598;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;290;1386.96,-890.2607;Inherit;False;346.5028;193.4201;;4;291;293;292;353;DEBUG SETTINGS ;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;295;1376.783,-1041.665;Inherit;False;370;124;;1;294;GLOBAL SETTINGS ;0.09433961,0.09433961,0.09433961,1;0;0
Node;AmplifyShaderEditor.IntNode;292;1575.167,-781.6187;Inherit;False;Property;_ZTestMode;ZTest Mode;1;1;[Enum];Create;False;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;4;4;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;291;1396.189,-848.5454;Inherit;False;Property;_ColorMask;Color Mask Mode;2;1;[Enum];Create;False;0;1;None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15;True;0;False;15;15;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;294;1394.596,-1003.853;Inherit;False;Property;_CullMode;Cull Mode;3;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;1;Header(GLOBAL SETTINGS);False;0;2;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;353;1400.431,-777.1531;Inherit;False;Constant;_MaskClipValue1;Mask Clip Value;14;0;Create;True;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;293;1574.695,-852.7178;Inherit;False;Property;_ZWriteMode;ZWrite Mode;0;1;[Enum];Create;False;0;1;Off,0,On,1;True;2;Header(SHADER VERSION 1.0 STANDARD);Header(DEBUG SETTINGS);False;1;1;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;375;1039.631,-392.3534;Inherit;False;DECSF Module Wind;49;;3243;0c33ef2b38b405041aea041abb730ab8;10,230,0,242,0,164,0,202,0,196,0,220,0,310,0,308,0,289,0,309,0;0;1;FLOAT3;305
Node;AmplifyShaderEditor.FunctionNode;468;953.7002,-683.8051;Inherit;False;DECSF Master Map Surface;4;;3248;6c26b12be02413b47bab527585da6bf6;4,185,0,508,1,520,1,366,0;0;9;FLOAT4;106;FLOAT3;88;COLOR;115;COLOR;129;COLOR;116;FLOAT;181;FLOAT;144;FLOAT;318;FLOAT;365
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;194;1374.904,-680.6909;Float;False;True;-1;3;;200;0;Standard;DEC/Surface Wind/Surface Wind Vertex Detail;False;False;False;False;False;False;False;False;False;False;False;False;True;False;True;False;False;False;True;True;True;Back;0;True;293;0;True;292;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;-10;True;Opaque;;Geometry;All;14;all;True;True;True;True;0;True;291;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;200;;-1;-1;-1;-1;1;NatureRendererInstancing=True;False;0;0;True;294;-1;0;True;353;5;Pragma;multi_compile_instancing;False;;Custom;Pragma;instancing_options procedural:SetupNatureRenderer forwardadd;False;;Custom;Pragma;multi_compile GPU_FRUSTUM_ON __;False;;Custom;Include;Nature Renderer.cginc;False;5d792e02fd6741e4cb63087f97979470;Custom;Pragma;multi_compile_local _ NATURE_RENDERER;False;;Custom;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;194;0;468;106
WireConnection;194;1;468;88
WireConnection;194;3;468;115
WireConnection;194;4;468;129
WireConnection;194;5;468;116
WireConnection;194;9;468;144
WireConnection;194;11;375;305
ASEEND*/
//CHKSM=A1D3DADA2C09A47C518D47C8F8E170C7B176B1A0