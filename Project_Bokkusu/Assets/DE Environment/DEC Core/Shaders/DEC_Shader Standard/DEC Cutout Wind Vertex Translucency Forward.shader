// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DEC/Cutout Wind/Cutout Wind Vertex Translucency Forward"
{
	Properties
	{
		[Enum(Off,0,On,1)][Header(SHADER VERSION 1.0 STANDARD)][Header(DEBUG SETTINGS)]_ZWriteMode("ZWrite Mode", Int) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTest Mode", Int) = 4
		[Enum(None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15)]_ColorMask("Color Mask Mode", Int) = 15
		[Enum(Off,0,On,1)]_AlphatoCoverage("Alpha to Coverage", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)][Header(GLOBAL SETTINGS)]_CullMode("Cull Mode", Int) = 0
		[Enum(Default,0,Flip,1,Mirror,2)]_NormalMode("Normal Mode", Int) = 0
		[Enum(Off,0,Active,1)]_GlancingClipMode("Clip Glancing Angle Mode", Int) = 0
		[Header(MAP MAIN TEXTURE)]_Color("Albedo Tint", Color) = (1,1,1,1)
		[SingleLineTexture]_MainTex("Albedo Map", 2D) = "white" {}
		[Enum(UV0,0,UV1,1)]_Mian_UVSet("UV Set", Int) = 0
		_Brightness("Brightness", Range( 0 , 2)) = 1
		_AlphaCutoffBias("Alpha Cutoff Bias", Range( 0 , 1)) = 0.5
		_TilingX("Tiling X", Float) = 1
		_TilingY("Tiling Y", Float) = 1
		_OffsetX("Offset X", Float) = 0
		_OffsetY("Offset Y", Float) = 0
		[NoScaleOffset][Normal][SingleLineTexture]_BumpMap("Normal Map", 2D) = "bump" {}
		_NormalStrength("Normal Strength", Float) = 1
		[SingleLineTexture]_MetallicGlossMap("Metallic Map", 2D) = "white" {}
		_MetallicStrength("Metallic Strength", Range( 0 , 1)) = 0
		[SingleLineTexture]_SmoothnessMap("Smoothness Map", 2D) = "white" {}
		_SmoothnessStrength("Smoothness Strength", Range( 0 , 1)) = 0
		[Enum(Texture,0,Baked UV4,1)]_OcclusionSourceMode("Occlusion Source Mode", Int) = 1
		[SingleLineTexture]_OcclusionMap("Occlusion Map", 2D) = "white" {}
		_OcclusionStrengthAO("Occlusion Strength", Range( 0 , 1)) = 0.95
		[Enum(Off,0,Color Shift,1)][Header(COLOR SHIFT MODE)]_ColorMode("Color Mode", Int) = 0
		_ShiftVariation("Shift Variation", Range( 0 , 0.3)) = 0.2
		_RGBColorBrightness("RGB Color Brightness ", Range( 0.25 , 3)) = 1
		_RGBColorHue("RGB Color Hue", Range( -0.5 , 0.5)) = 0
		_RGBColorSaturation("RGB Color Saturation", Range( 0 , 0.95)) = 0.95
		[Enum(Off,0,Active,1)][Header(TRANSLUCENCY)]_EnableTranslucency("Enable Translucency", Int) = 0
		[Enum(Double Sided,0,Cull Front Face,1,Cull Back Face,2)]_TranslucencyCullForward("Translucency Cull", Int) = 0
		[Enum(Texture,0,Baked UV4,1)]_TranslucencySource("Translucency Source", Int) = 0
		[HDR]_TranslucencyTint("Translucency Tint", Color) = (0.575,0.75,0,1)
		[HDR]_TransmissionTint("Transmission Tint", Color) = (0.3833333,0.5,0,1)
		[NoScaleOffset][SingleLineTexture]_TranslucencyMap("Translucency Map", 2D) = "white" {}
		[Enum(Default,0,Inverted,1)]_MapInverted("Map Inverted", Int) = 0
		_TranslucencyThickness("Translucency Thickness", Range( 0 , 1.5)) = 1.5
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scaterring Falloff", Range( 1 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
		[HideInInspector]_MaskClipValue("Mask Clip Value", Float) = 0.5
		[Enum(Off,0,Global,1,Local,2)][Header(WIND)]_WindMode("Wind Mode", Int) = 0
		[Enum(Leaf,0,Palm,1,Grass,2,Simple,3)]_WindModeCutoutShader("Wind Type", Int) = 1
		[Header(WIND MODE GLOBAL)]_GlobalWindInfluenceOther("Wind Strength", Float) = 0.3
		_GlobalTurbulenceInfluence("Wind Turbulence", Float) = 0.2
		[Header(WIND MODE LOCAL)]_LocalWindStrength("Wind Strength", Float) = 0.3
		_LocalWindPulse("Wind Pulse", Float) = 0.1
		_LocalWindTurbulence("Wind Turbulence", Float) = 0.2
		_LocalWindDirection("Wind Direction", Float) = 1
		_LocalRandomWindOffset("Wind Random Offset", Float) = 0.2
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord4( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry-10" "NatureRendererInstancing"="True" }
		LOD 200
		Cull [_CullMode]
		ZWrite [_ZWriteMode]
		ZTest [_ZTestMode]
		AlphaToMask [_AlphatoCoverage]
		ColorMask [_ColorMask]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
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

		#pragma surface surf StandardCustom keepalpha addshadow fullforwardshadows exclude_path:deferred dithercrossfade vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv2_texcoord2;
			half ASEVFace : VFACE;
			float4 vertexColor : COLOR;
			float2 uv4_texcoord4;
			float4 screenPosition;
			float3 worldPos;
		};

		struct SurfaceOutputStandardCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Transmission;
			half3 Translucency;
		};

		uniform int _ColorMask;
		uniform int _CullMode;
		uniform int _ZTestMode;
		uniform float _AlphatoCoverage;
		uniform int _ZWriteMode;
		uniform int _WindMode;
		uniform int _WindModeCutoutShader;
		uniform float _GlobalWindInfluenceOther;
		uniform float _WindStrength;
		uniform float _LocalWindStrength;
		uniform float _RandomWindOffset;
		uniform float _LocalRandomWindOffset;
		uniform float _WindPulse;
		uniform float _LocalWindPulse;
		uniform float _WindDirection;
		uniform float _LocalWindDirection;
		uniform float _GlobalTurbulenceInfluence;
		uniform float _WindTurbulence;
		uniform float _LocalWindTurbulence;
		uniform int _NormalMode;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		uniform int _Mian_UVSet;
		uniform float _TilingX;
		uniform float _TilingY;
		uniform float _OffsetX;
		uniform float _OffsetY;
		SamplerState sampler_trilinear_repeat;
		uniform half _NormalStrength;
		uniform int _ColorMode;
		uniform float4 _Color;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		uniform half _Brightness;
		uniform float _ShiftVariation;
		uniform float _RGBColorHue;
		uniform float _RGBColorSaturation;
		uniform float _RGBColorBrightness;
		uniform float _MetallicStrength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicGlossMap);
		uniform float _SmoothnessStrength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_SmoothnessMap);
		UNITY_DECLARE_TEX2D_NOSAMPLER(_OcclusionMap);
		uniform int _OcclusionSourceMode;
		uniform float _OcclusionStrengthAO;
		uniform int _TranslucencyCullForward;
		uniform int _EnableTranslucency;
		uniform half4 _TransmissionTint;
		uniform int _MapInverted;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_TranslucencyMap);
		uniform float _TranslucencyThickness;
		SamplerState sampler_TranslucencyMap;
		uniform int _TranslucencySource;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;
		uniform float4 _TranslucencyTint;
		SamplerState sampler_MainTex;
		uniform half _AlphaCutoffBias;
		uniform int _GlancingClipMode;
		uniform float _MaskClipValue;


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


		float3 float3switch135_g3149( int m_switch, float3 m_Leaf, float3 m_Palm, float3 m_Grass, float3 m_Simple )
		{
			if(m_switch == 0)
				return m_Leaf;
			if(m_switch == 1)
				return m_Palm;
			if(m_switch == 2)
				return m_Grass;
			if(m_switch == 3)
				return m_Simple;
			return m_Leaf;
		}


		float3 float3switch( int m_switch, float3 m_Off, float3 m_Global, float3 m_Local )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Global;
			if(m_switch == 2)
				return m_Local;
			return m_Off;
		}


		float floatUVswitch730_g3218( int m_switch, float m_UV0, float m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		float floatUVswitch735_g3218( int m_switch, float m_UV0, float m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		float3 float3switch9_g3219( int m_switch, float3 m_Default, float3 m_Flip, float3 m_Mirror )
		{
			if(m_switch == 0)
				return m_Default;
			if(m_switch == 1)
				return m_Flip;
			if(m_switch == 2)
				return m_Mirror;
			return m_Default;
		}


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		float3 float3switch420_g3218( int m_switch, float3 m_Off, float3 m_ColorShift )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_ColorShift;
			return m_Off;
		}


		float4 float4switch( int m_switch, float4 m_Default, float4 m_Inverted )
		{
			if(m_switch == 0)
				return m_Default;
			if(m_switch == 1)
				return m_Inverted;
			return m_Default;
		}


		float4 float4switch332_g3218( int m_switch, float4 m_Off, float4 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float4 float4switch537_g3218( int m_switch, float4 m_Default, float4 m_CullFrontFace, float4 m_CullBackFace )
		{
			if(m_switch == 0)
				return m_Default;
			if(m_switch == 1)
				return m_CullFrontFace;
			if(m_switch == 2)
				return m_CullBackFace;
			return m_Default;
		}


		float4 float4switch324_g3218( int m_switch, float4 m_Off, float4 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float4 float4switch539_g3218( int m_switch, float4 m_Default, float4 m_CullFrontFace, float4 m_CullBackFace )
		{
			if(m_switch == 0)
				return m_Default;
			if(m_switch == 1)
				return m_CullFrontFace;
			if(m_switch == 2)
				return m_CullBackFace;
			return m_Default;
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


		float floatswitch599_g3218( int m_switch, float m_Off, float m_Active )
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
			int WindController383_g3149 = _WindMode;
			int m_switch395_g3149 = WindController383_g3149;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VAR_VERTEXPOSITION_MATRIX299_g3149 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 m_Off395_g3149 = VAR_VERTEXPOSITION_MATRIX299_g3149;
			int m_switch135_g3149 = _WindModeCutoutShader;
			float3 break156_g3149 = VAR_VERTEXPOSITION_MATRIX299_g3149;
			int m_switch390_g3149 = _WindMode;
			float m_Off390_g3149 = 1.0;
			float GLOBAL_WINDINFLUENCE340_g3149 = _WindStrength;
			float m_Global390_g3149 = ( _GlobalWindInfluenceOther * GLOBAL_WINDINFLUENCE340_g3149 );
			float m_Local390_g3149 = _LocalWindStrength;
			float localfloatswitch390_g3149 = floatswitch( m_switch390_g3149 , m_Off390_g3149 , m_Global390_g3149 , m_Local390_g3149 );
			float VAR_WindStrength129_g3149 = localfloatswitch390_g3149;
			int m_switch117_g3149 = _WindMode;
			float m_Off117_g3149 = 1.0;
			float GLOBAL_RANDOMWINDOFFSET339_g3149 = _RandomWindOffset;
			float m_Global117_g3149 = GLOBAL_RANDOMWINDOFFSET339_g3149;
			float m_Local117_g3149 = _LocalRandomWindOffset;
			float localfloatswitch117_g3149 = floatswitch( m_switch117_g3149 , m_Off117_g3149 , m_Global117_g3149 , m_Local117_g3149 );
			float VAR_WindOffset76_g3149 = localfloatswitch117_g3149;
			float4 transform288_g3149 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult210_g3149 = (float2(transform288_g3149.x , transform288_g3149.z));
			float dotResult271_g3149 = dot( appendResult210_g3149 , float2( 12.9898,78.233 ) );
			float lerpResult44_g3149 = lerp( 0.8 , ( ( VAR_WindOffset76_g3149 / 2.0 ) + 0.9 ) , frac( ( sin( dotResult271_g3149 ) * 43758.55 ) ));
			float VAR_RandomTime191_g3149 = ( _Time.x * lerpResult44_g3149 );
			float FUNC_Turbulence296_g3149 = ( sin( ( ( VAR_RandomTime191_g3149 * 40.0 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3149.z / 15.0 ) ) ) * 0.5 );
			int m_switch387_g3149 = _WindMode;
			float m_Off387_g3149 = 1.0;
			float GLOBAL_WINDPULSE342_g3149 = _WindPulse;
			float m_Global387_g3149 = GLOBAL_WINDPULSE342_g3149;
			float m_Local387_g3149 = _LocalWindPulse;
			float localfloatswitch387_g3149 = floatswitch( m_switch387_g3149 , m_Off387_g3149 , m_Global387_g3149 , m_Local387_g3149 );
			float VAR_WindPulse264_g3149 = localfloatswitch387_g3149;
			float FUNC_Angle148_g3149 = ( VAR_WindStrength129_g3149 * ( 1.0 + sin( ( ( ( ( VAR_RandomTime191_g3149 * 2.0 ) + FUNC_Turbulence296_g3149 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3149.z / 50.0 ) ) - ( v.color.r / 20.0 ) ) ) ) * sqrt( v.color.r ) * VAR_WindPulse264_g3149 );
			float VAR_SinA111_g3149 = sin( FUNC_Angle148_g3149 );
			float VAR_CosA243_g3149 = cos( FUNC_Angle148_g3149 );
			int m_switch389_g3149 = _WindMode;
			float m_Off389_g3149 = 1.0;
			float GLOBAL_WINDDIRECTION341_g3149 = _WindDirection;
			float m_Global389_g3149 = GLOBAL_WINDDIRECTION341_g3149;
			float m_Local389_g3149 = _LocalWindDirection;
			float localfloatswitch389_g3149 = floatswitch( m_switch389_g3149 , m_Off389_g3149 , m_Global389_g3149 , m_Local389_g3149 );
			float _WindDirection178_g3149 = localfloatswitch389_g3149;
			float2 localDirectionalEquation178_g3149 = DirectionalEquation( _WindDirection178_g3149 );
			float2 break74_g3149 = localDirectionalEquation178_g3149;
			float VAR_xLerp173_g3149 = break74_g3149.x;
			float lerpResult232_g3149 = lerp( break156_g3149.x , ( ( break156_g3149.y * VAR_SinA111_g3149 ) + ( break156_g3149.x * VAR_CosA243_g3149 ) ) , VAR_xLerp173_g3149);
			float3 break99_g3149 = VAR_VERTEXPOSITION_MATRIX299_g3149;
			float3 break201_g3149 = VAR_VERTEXPOSITION_MATRIX299_g3149;
			float VAR_zLerp206_g3149 = break74_g3149.y;
			float lerpResult104_g3149 = lerp( break201_g3149.z , ( ( break201_g3149.y * VAR_SinA111_g3149 ) + ( break201_g3149.z * VAR_CosA243_g3149 ) ) , VAR_zLerp206_g3149);
			float3 appendResult197_g3149 = (float3(lerpResult232_g3149 , ( ( break99_g3149.y * VAR_CosA243_g3149 ) - ( break99_g3149.z * VAR_SinA111_g3149 ) ) , lerpResult104_g3149));
			float3 FUNC_vertexPos132_g3149 = appendResult197_g3149;
			float3 break303_g3149 = FUNC_vertexPos132_g3149;
			half FUNC_SinFunction295_g3149 = sin( ( ( VAR_RandomTime191_g3149 * 200.0 * ( 0.2 + v.color.g ) ) + ( v.color.g * 10.0 ) + FUNC_Turbulence296_g3149 + ( VAR_VERTEXPOSITION_MATRIX299_g3149.z / 2.0 ) ) );
			int m_switch388_g3149 = _WindMode;
			float m_Off388_g3149 = 1.0;
			float GLOBAL_WINDTURBULENCE350_g3149 = _WindTurbulence;
			float m_Global388_g3149 = ( _GlobalTurbulenceInfluence * GLOBAL_WINDTURBULENCE350_g3149 );
			float m_Local388_g3149 = _LocalWindTurbulence;
			float localfloatswitch388_g3149 = floatswitch( m_switch388_g3149 , m_Off388_g3149 , m_Global388_g3149 , m_Local388_g3149 );
			float VAR_GlobalWindTurbulence263_g3149 = localfloatswitch388_g3149;
			float3 appendResult158_g3149 = (float3(break303_g3149.x , ( break303_g3149.y + ( FUNC_SinFunction295_g3149 * v.color.b * ( FUNC_Angle148_g3149 + ( VAR_WindStrength129_g3149 / 200.0 ) ) * VAR_GlobalWindTurbulence263_g3149 ) ) , break303_g3149.z));
			float3 OUT_Leafs_Standalone221_g3149 = appendResult158_g3149;
			float3 m_Leaf135_g3149 = OUT_Leafs_Standalone221_g3149;
			float3 OUT_Palm_Standalone252_g3149 = ( ( FUNC_SinFunction295_g3149 * v.color.b * ( FUNC_Angle148_g3149 + ( VAR_WindStrength129_g3149 / 200.0 ) ) * VAR_GlobalWindTurbulence263_g3149 ) + FUNC_vertexPos132_g3149 );
			float3 m_Palm135_g3149 = OUT_Palm_Standalone252_g3149;
			float3 break270_g3149 = FUNC_vertexPos132_g3149;
			float temp_output_219_0_g3149 = ( FUNC_SinFunction295_g3149 * v.color.b * ( FUNC_Angle148_g3149 + ( VAR_WindStrength129_g3149 / 200.0 ) ) );
			float lerpResult57_g3149 = lerp( 0.0 , temp_output_219_0_g3149 , VAR_xLerp173_g3149);
			float lerpResult152_g3149 = lerp( 0.0 , temp_output_219_0_g3149 , VAR_zLerp206_g3149);
			float3 appendResult51_g3149 = (float3(( break270_g3149.x + lerpResult57_g3149 ) , break270_g3149.y , ( break270_g3149.z + lerpResult152_g3149 )));
			float3 OUT_Grass_Standalone179_g3149 = appendResult51_g3149;
			float3 m_Grass135_g3149 = OUT_Grass_Standalone179_g3149;
			float3 m_Simple135_g3149 = FUNC_vertexPos132_g3149;
			float3 localfloat3switch135_g3149 = float3switch135_g3149( m_switch135_g3149 , m_Leaf135_g3149 , m_Palm135_g3149 , m_Grass135_g3149 , m_Simple135_g3149 );
			float3 m_Global395_g3149 = localfloat3switch135_g3149;
			float3 m_Local395_g3149 = localfloat3switch135_g3149;
			float3 localfloat3switch395_g3149 = float3switch( m_switch395_g3149 , m_Off395_g3149 , m_Global395_g3149 , m_Local395_g3149 );
			float3 temp_output_261_0_g3149 = mul( unity_WorldToObject, float4( localfloat3switch395_g3149 , 0.0 ) ).xyz;
			float3 VAR_VERTEXPOSITION298_g3149 = ase_vertex3Pos;
			v.vertex.xyz += ( temp_output_261_0_g3149 - VAR_VERTEXPOSITION298_g3149 );
			v.vertex.w = 1;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		inline half4 LightingStandardCustom(SurfaceOutputStandardCustom s, half3 viewDir, UnityGI gi )
		{
			#if !DIRECTIONAL
			float3 lightAtten = gi.light.color;
			#else
			float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, _TransShadow );
			#endif
			half3 lightDir = gi.light.dir + s.Normal * _TransNormalDistortion;
			half transVdotL = pow( saturate( dot( viewDir, -lightDir ) ), _TransScattering );
			half3 translucency = lightAtten * (transVdotL * _TransDirect + gi.indirect.diffuse * _TransAmbient) * s.Translucency;
			half4 c = half4( s.Albedo * translucency * _Translucency, 0 );

			half3 transmission = max(0 , -dot(s.Normal, gi.light.dir)) * gi.light.color * s.Transmission;
			half4 d = half4(s.Albedo * transmission , 0);

			SurfaceOutputStandard r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Metallic = s.Metallic;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandard (r, viewDir, gi) + c + d;
		}

		inline void LightingStandardCustom_GI(SurfaceOutputStandardCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardCustom o )
		{
			int m_switch9_g3219 = _NormalMode;
			int UV_SET_MAIN732_g3218 = _Mian_UVSet;
			int m_switch730_g3218 = UV_SET_MAIN732_g3218;
			float2 appendResult77_g3218 = (float2(_TilingX , _TilingY));
			float2 appendResult82_g3218 = (float2(_OffsetX , _OffsetY));
			float2 uv_TexCoord73_g3218 = i.uv_texcoord * appendResult77_g3218 + appendResult82_g3218;
			float m_UV0730_g3218 = uv_TexCoord73_g3218.x;
			float2 uv2_TexCoord729_g3218 = i.uv2_texcoord2 * appendResult77_g3218 + appendResult82_g3218;
			float m_UV1730_g3218 = uv2_TexCoord729_g3218.x;
			float localfloatUVswitch730_g3218 = floatUVswitch730_g3218( m_switch730_g3218 , m_UV0730_g3218 , m_UV1730_g3218 );
			int m_switch735_g3218 = UV_SET_MAIN732_g3218;
			float m_UV0735_g3218 = uv_TexCoord73_g3218.y;
			float m_UV1735_g3218 = uv2_TexCoord729_g3218.y;
			float localfloatUVswitch735_g3218 = floatUVswitch735_g3218( m_switch735_g3218 , m_UV0735_g3218 , m_UV1735_g3218 );
			float2 appendResult559_g3218 = (float2(localfloatUVswitch730_g3218 , localfloatUVswitch735_g3218));
			float3 NORMAL_IN17_g3219 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, appendResult559_g3218 ), _NormalStrength );
			float3 m_Default9_g3219 = NORMAL_IN17_g3219;
			float3 m_Flip9_g3219 = ( NORMAL_IN17_g3219 * i.ASEVFace );
			float3 break2_g3219 = NORMAL_IN17_g3219;
			float3 appendResult3_g3219 = (float3(break2_g3219.x , break2_g3219.y , ( break2_g3219.z * i.ASEVFace )));
			float3 m_Mirror9_g3219 = appendResult3_g3219;
			float3 localfloat3switch9_g3219 = float3switch9_g3219( m_switch9_g3219 , m_Default9_g3219 , m_Flip9_g3219 , m_Mirror9_g3219 );
			float3 temp_output_530_11_g3218 = localfloat3switch9_g3219;
			o.Normal = temp_output_530_11_g3218;
			int m_switch420_g3218 = _ColorMode;
			float3 temp_output_11_0_g3218 = (_Color).rgb;
			float4 tex2DNode57_g3218 = SAMPLE_TEXTURE2D( _MainTex, sampler_trilinear_repeat, appendResult559_g3218 );
			float3 temp_output_76_0_g3218 = ( temp_output_11_0_g3218 * (tex2DNode57_g3218).rgb * _Brightness );
			float3 ALBEDO_01424_g3218 = temp_output_76_0_g3218;
			float3 m_Off420_g3218 = ALBEDO_01424_g3218;
			float3 hsvTorgb408_g3218 = RGBToHSV( ALBEDO_01424_g3218 );
			float3 hsvTorgb406_g3218 = HSVToRGB( float3(( ( ( i.vertexColor.g - 0.5 ) * _ShiftVariation ) + _RGBColorHue + hsvTorgb408_g3218 ).x,( hsvTorgb408_g3218.y * _RGBColorSaturation ),( hsvTorgb408_g3218.z * _RGBColorBrightness )) );
			float3 m_ColorShift420_g3218 = hsvTorgb406_g3218;
			float3 localfloat3switch420_g3218 = float3switch420_g3218( m_switch420_g3218 , m_Off420_g3218 , m_ColorShift420_g3218 );
			float3 COLOR_SHIFTING426_g3218 = localfloat3switch420_g3218;
			o.Albedo = COLOR_SHIFTING426_g3218;
			float2 CUSTOM_UV1263_g3218 = appendResult559_g3218;
			o.Metallic = ( _MetallicStrength * SAMPLE_TEXTURE2D( _MetallicGlossMap, sampler_trilinear_repeat, CUSTOM_UV1263_g3218 ) ).r;
			o.Smoothness = ( _SmoothnessStrength * SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_trilinear_repeat, CUSTOM_UV1263_g3218 ) ).r;
			float4 temp_cast_4 = (1.0).xxxx;
			float4 temp_cast_5 = (i.vertexColor.a).xxxx;
			float4 lerpResult39_g3218 = lerp( SAMPLE_TEXTURE2D( _OcclusionMap, sampler_trilinear_repeat, CUSTOM_UV1263_g3218 ) , temp_cast_5 , (float)_OcclusionSourceMode);
			float4 lerpResult29_g3218 = lerp( temp_cast_4 , lerpResult39_g3218 , _OcclusionStrengthAO);
			o.Occlusion = lerpResult29_g3218.r;
			int m_switch537_g3218 = _TranslucencyCullForward;
			int TRANSLUCENCY_MODE523_g3218 = _EnableTranslucency;
			int m_switch332_g3218 = TRANSLUCENCY_MODE523_g3218;
			float4 m_Off332_g3218 = float4( 0,0,0,0 );
			int m_switch639_g3218 = _MapInverted;
			float4 color726_g3218 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float4 COLOR_0000727_g3218 = color726_g3218;
			float4 tex2DNode322_g3218 = SAMPLE_TEXTURE2D( _TranslucencyMap, sampler_trilinear_repeat, CUSTOM_UV1263_g3218 );
			float4 lerpResult326_g3218 = lerp( COLOR_0000727_g3218 , tex2DNode322_g3218 , _TranslucencyThickness);
			float4 m_Default639_g3218 = lerpResult326_g3218;
			float temp_output_620_0_g3218 = ( 0.0 - 1.0 );
			float temp_output_623_0_g3218 = ( tex2DNode322_g3218.r - 1.0 );
			float lerpResult631_g3218 = lerp( ( temp_output_620_0_g3218 / temp_output_623_0_g3218 ) , ( temp_output_623_0_g3218 / temp_output_620_0_g3218 ) , ( 0.7 + _TranslucencyThickness ));
			float4 temp_cast_9 = (saturate( lerpResult631_g3218 )).xxxx;
			float4 m_Inverted639_g3218 = temp_cast_9;
			float4 localfloat4switch639_g3218 = float4switch( m_switch639_g3218 , m_Default639_g3218 , m_Inverted639_g3218 );
			float lerpResult334_g3218 = lerp( 0.0 , ( 5.0 - i.uv4_texcoord4.x ) , _TranslucencyThickness);
			float4 temp_cast_10 = (lerpResult334_g3218).xxxx;
			float4 lerpResult369_g3218 = lerp( localfloat4switch639_g3218 , temp_cast_10 , (float)_TranslucencySource);
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 temp_output_371_0_g3218 = ( ase_lightColor.rgb * ase_lightColor.a );
			float3 GLOBAL_LIGHT_COLOR373_g3218 = temp_output_371_0_g3218;
			float4 m_Active332_g3218 = ( ( _TransmissionTint * _TransmissionTint.a * lerpResult369_g3218 ) * float4( GLOBAL_LIGHT_COLOR373_g3218 , 0.0 ) * i.vertexColor.g );
			float4 localfloat4switch332_g3218 = float4switch332_g3218( m_switch332_g3218 , m_Off332_g3218 , m_Active332_g3218 );
			float4 m_Default537_g3218 = localfloat4switch332_g3218;
			float4 _Vector3 = float4(0,0,0,0);
			float4 switchResult535_g3218 = (((i.ASEVFace>0)?(_Vector3):(localfloat4switch332_g3218)));
			float4 m_CullFrontFace537_g3218 = switchResult535_g3218;
			float4 switchResult541_g3218 = (((i.ASEVFace>0)?(localfloat4switch332_g3218):(_Vector3)));
			float4 m_CullBackFace537_g3218 = switchResult541_g3218;
			float4 localfloat4switch537_g3218 = float4switch537_g3218( m_switch537_g3218 , m_Default537_g3218 , m_CullFrontFace537_g3218 , m_CullBackFace537_g3218 );
			o.Transmission = localfloat4switch537_g3218.xyz;
			int m_switch539_g3218 = _TranslucencyCullForward;
			int m_switch324_g3218 = TRANSLUCENCY_MODE523_g3218;
			float4 m_Off324_g3218 = float4( 0,0,0,0 );
			float4 m_Active324_g3218 = ( ( _TranslucencyTint * _TranslucencyTint.a * lerpResult369_g3218 ) * float4( GLOBAL_LIGHT_COLOR373_g3218 , 0.0 ) * i.vertexColor.g );
			float4 localfloat4switch324_g3218 = float4switch324_g3218( m_switch324_g3218 , m_Off324_g3218 , m_Active324_g3218 );
			float4 m_Default539_g3218 = localfloat4switch324_g3218;
			float4 switchResult531_g3218 = (((i.ASEVFace>0)?(_Vector3):(localfloat4switch324_g3218)));
			float4 m_CullFrontFace539_g3218 = switchResult531_g3218;
			float4 switchResult540_g3218 = (((i.ASEVFace>0)?(localfloat4switch324_g3218):(_Vector3)));
			float4 m_CullBackFace539_g3218 = switchResult540_g3218;
			float4 localfloat4switch539_g3218 = float4switch539_g3218( m_switch539_g3218 , m_Default539_g3218 , m_CullFrontFace539_g3218 , m_CullBackFace539_g3218 );
			o.Translucency = localfloat4switch539_g3218.xyz;
			float ALBEDO_A716_g3218 = tex2DNode57_g3218.a;
			clip( ALBEDO_A716_g3218 - ( 1.0 - _AlphaCutoffBias ));
			float temp_output_7_0_g3220 = saturate( ( ( ALBEDO_A716_g3218 / max( fwidth( ALBEDO_A716_g3218 ) , 0.0001 ) ) + 0.5 ) );
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen3_g3220 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither3_g3220 = Dither8x8Bayer( fmod(clipScreen3_g3220.x, 8), fmod(clipScreen3_g3220.y, 8) );
			dither3_g3220 = step( dither3_g3220, unity_LODFade.x );
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch5_g3220 = ( temp_output_7_0_g3220 * dither3_g3220 );
			#else
				float staticSwitch5_g3220 = temp_output_7_0_g3220;
			#endif
			o.Alpha = staticSwitch5_g3220;
			int m_switch599_g3218 = _GlancingClipMode;
			float m_Off599_g3218 = 1.0;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult583_g3218 = normalize( cross( ddx( ase_worldPos ) , ddy( ase_worldPos ) ) );
			float dotResult587_g3218 = dot( ase_worldViewDir , normalizeResult583_g3218 );
			float temp_output_585_0_g3218 = ( 1.0 - abs( dotResult587_g3218 ) );
			float temp_output_590_0_g3218 = ( 1.0 - ( temp_output_585_0_g3218 * temp_output_585_0_g3218 ) );
			float m_Active599_g3218 = temp_output_590_0_g3218;
			float localfloatswitch599_g3218 = floatswitch599_g3218( m_switch599_g3218 , m_Off599_g3218 , m_Active599_g3218 );
			clip( localfloatswitch599_g3218 - _MaskClipValue );
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18502
1982;67;1076;952;4603.872;3836.229;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;2820;-3940.45,-3907.181;Inherit;False;341.5028;250.4201;;5;202;2757;2786;2758;2760;DEBUG SETTINGS ;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2819;-3943.628,-4055.585;Inherit;False;352;119;;1;203;GLOBAL SETTINGS ;0.09433961,0.09433961,0.09433961,1;0;0
Node;AmplifyShaderEditor.IntNode;2758;-3934.076,-3805.627;Inherit;False;Property;_ColorMask;Color Mask Mode;2;1;[Enum];Create;False;0;1;None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15;True;0;False;15;15;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;202;-3933.771,-3873.078;Inherit;False;Constant;_MaskClipValue;Mask Clip Value;64;1;[HideInInspector];Create;True;0;0;True;0;False;0.5;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;203;-3930.373,-4021.418;Inherit;False;Property;_CullMode;Cull Mode;4;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;1;Header(GLOBAL SETTINGS);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;2757;-3751.249,-3804.592;Inherit;False;Property;_ZTestMode;ZTest Mode;1;1;[Enum];Create;False;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;4;4;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;2786;-3933.689,-3735;Inherit;False;Property;_AlphatoCoverage;Alpha to Coverage;3;1;[Enum];Create;True;1;Option1;0;1;Off,0,On,1;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;2760;-3751.31,-3874.784;Inherit;False;Property;_ZWriteMode;ZWrite Mode;0;1;[Enum];Create;False;0;1;Off,0,On,1;True;2;Header(SHADER VERSION 1.0 STANDARD);Header(DEBUG SETTINGS);False;1;1;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;3010;-4318.856,-3285.999;Inherit;False;DECSF Module Wind;63;;3149;0c33ef2b38b405041aea041abb730ab8;10,230,1,242,1,164,1,202,1,196,1,220,1,310,0,308,0,289,0,309,0;0;1;FLOAT3;305
Node;AmplifyShaderEditor.FunctionNode;3026;-4391.615,-3637.311;Inherit;False;DECSF Master Map Cutout;5;;3218;000f89ea707009441837de6c4e59b637;21,489,0,446,0,433,0,553,0,688,0,684,0,512,0,666,0,470,0,323,1,364,1,398,1,499,1,595,1,190,1,356,1,500,1,399,1,390,1,461,0,467,0;0;12;FLOAT3;189;FLOAT3;95;COLOR;100;COLOR;97;COLOR;99;FLOAT;403;FLOAT;96;FLOAT;600;FLOAT;480;FLOAT4;258;FLOAT4;259;FLOAT3;401
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;1319;-3941.374,-3630.745;Float;False;True;-1;3;;200;0;Standard;DEC/Cutout Wind/Cutout Wind Vertex Translucency Forward;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;True;True;True;Back;0;True;2760;0;True;2757;False;0;False;-1;0;False;-1;False;3;Custom;0;True;True;-10;True;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;True;2758;False;0;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;200;;-1;56;-1;-1;1;NatureRendererInstancing=True;False;0;0;True;203;-1;0;True;202;5;Pragma;multi_compile_instancing;False;;Custom;Pragma;instancing_options procedural:SetupNatureRenderer forwardadd;False;;Custom;Pragma;multi_compile GPU_FRUSTUM_ON __;False;8ccd508f733f5f0418220eaf14ecdf81;Custom;Include;Nature Renderer.cginc;False;5d792e02fd6741e4cb63087f97979470;Custom;Pragma;multi_compile_local _ NATURE_RENDERER;False;;Custom;0;0;False;0.1;False;-1;0;True;2786;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1319;0;3026;189
WireConnection;1319;1;3026;95
WireConnection;1319;3;3026;100
WireConnection;1319;4;3026;97
WireConnection;1319;5;3026;99
WireConnection;1319;6;3026;258
WireConnection;1319;7;3026;259
WireConnection;1319;9;3026;96
WireConnection;1319;10;3026;600
WireConnection;1319;11;3010;305
ASEEND*/
//CHKSM=36511FD43309EF88F69A695BB308EB68CF85EAE5