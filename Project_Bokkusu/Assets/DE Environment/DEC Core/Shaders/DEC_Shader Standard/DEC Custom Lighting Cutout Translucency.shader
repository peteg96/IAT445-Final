// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DEC/Custom Lighting/Custom Lighting Cutout Translucency"
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
		[Header (LIGHTING)]_IndirectStrengthDiffuse("Indirect Strength Diffuse", Range( 0 , 1)) = 0.5
		_IndirectStrengthSpecular("Indirect Strength Specular", Range( 0 , 1)) = 0.5
		_IndirectOcclusion("Indirect Occlusion", Range( 0 , 1)) = 0
		_IndirectSmoothness("Indirect Smoothness", Range( 0 , 1)) = 0
		[HDR]_SpecularColor("Specular Tint", Color) = (1,1,1,0.2117647)
		_Shininess("Specular Glossiness", Range( 0 , 1)) = 0
		_ShadowStrength("Shadow Strength", Range( 0 , 1)) = 0.42
		_ShadowSharpness("Shadow Sharpness", Range( 0.01 , 1)) = 1
		[HideInInspector]_MaskClipValue("Mask Clip Value", Float) = 0.5
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
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord4( "", 2D ) = "white" {}
		[Enum(Leaf,0,Palm,1,Grass,2,Simple,3)]_WindModeCutoutShader("Wind Type", Int) = 1
		[Header(WIND MODE GLOBAL)]_GlobalWindInfluenceOther("Wind Strength", Float) = 0.3
		_GlobalTurbulenceInfluence("Wind Turbulence", Float) = 0.2
		[Header(WIND MODE LOCAL)]_LocalWindStrength("Wind Strength", Float) = 0.3
		_LocalWindPulse("Wind Pulse", Float) = 0.1
		_LocalWindTurbulence("Wind Turbulence", Float) = 0.2
		_LocalWindDirection("Wind Direction", Float) = 1
		_LocalRandomWindOffset("Wind Random Offset", Float) = 0.2
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0"}
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline alpha:fade  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		#include "UnityShaderVariables.cginc"
		
		
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
		
		#pragma multi_compile_instancing
		#pragma instancing_options procedural:SetupNatureRenderer forwardadd
		#pragma multi_compile GPU_FRUSTUM_ON __
		#include "Nature Renderer.cginc"
		#pragma multi_compile_local _ NATURE_RENDERER
		#pragma multi_compile __ LOD_FADE_CROSSFADE
		
		struct Input
		{
			float2 uv_texcoord;
			float2 uv2_texcoord2;
			float4 screenPos;
		};
		uniform float4 _OutlineTint;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		SamplerState sampler_MainTex;
		uniform int _Mian_UVSet;
		uniform float _TilingX;
		uniform float _TilingY;
		uniform float _OffsetX;
		uniform float _OffsetY;
		SamplerState sampler_trilinear_repeat;
		uniform half _AlphaCutoffBias;
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
		uniform float _OutlineThickness;
		
		float floatUVswitch730_g1( int m_switch, float m_UV0, float m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		float floatUVswitch735_g1( int m_switch, float m_UV0, float m_UV1 )
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


		float3 float3switch135_g3186( int m_switch, float3 m_Leaf, float3 m_Palm, float3 m_Grass, float3 m_Simple )
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


		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			int WindController383_g3186 = _WindMode;
			int m_switch395_g3186 = WindController383_g3186;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VAR_VERTEXPOSITION_MATRIX299_g3186 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 m_Off395_g3186 = VAR_VERTEXPOSITION_MATRIX299_g3186;
			int m_switch135_g3186 = _WindModeCutoutShader;
			float3 break156_g3186 = VAR_VERTEXPOSITION_MATRIX299_g3186;
			int m_switch390_g3186 = _WindMode;
			float m_Off390_g3186 = 1.0;
			float GLOBAL_WINDINFLUENCE340_g3186 = _WindStrength;
			float m_Global390_g3186 = ( _GlobalWindInfluenceOther * GLOBAL_WINDINFLUENCE340_g3186 );
			float m_Local390_g3186 = _LocalWindStrength;
			float localfloatswitch390_g3186 = floatswitch( m_switch390_g3186 , m_Off390_g3186 , m_Global390_g3186 , m_Local390_g3186 );
			float VAR_WindStrength129_g3186 = localfloatswitch390_g3186;
			int m_switch117_g3186 = _WindMode;
			float m_Off117_g3186 = 1.0;
			float GLOBAL_RANDOMWINDOFFSET339_g3186 = _RandomWindOffset;
			float m_Global117_g3186 = GLOBAL_RANDOMWINDOFFSET339_g3186;
			float m_Local117_g3186 = _LocalRandomWindOffset;
			float localfloatswitch117_g3186 = floatswitch( m_switch117_g3186 , m_Off117_g3186 , m_Global117_g3186 , m_Local117_g3186 );
			float VAR_WindOffset76_g3186 = localfloatswitch117_g3186;
			float4 transform288_g3186 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult210_g3186 = (float2(transform288_g3186.x , transform288_g3186.z));
			float dotResult271_g3186 = dot( appendResult210_g3186 , float2( 12.9898,78.233 ) );
			float lerpResult44_g3186 = lerp( 0.8 , ( ( VAR_WindOffset76_g3186 / 2.0 ) + 0.9 ) , frac( ( sin( dotResult271_g3186 ) * 43758.55 ) ));
			float VAR_RandomTime191_g3186 = ( _Time.x * lerpResult44_g3186 );
			float FUNC_Turbulence296_g3186 = ( sin( ( ( VAR_RandomTime191_g3186 * 40.0 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3186.z / 15.0 ) ) ) * 0.5 );
			int m_switch387_g3186 = _WindMode;
			float m_Off387_g3186 = 1.0;
			float GLOBAL_WINDPULSE342_g3186 = _WindPulse;
			float m_Global387_g3186 = GLOBAL_WINDPULSE342_g3186;
			float m_Local387_g3186 = _LocalWindPulse;
			float localfloatswitch387_g3186 = floatswitch( m_switch387_g3186 , m_Off387_g3186 , m_Global387_g3186 , m_Local387_g3186 );
			float VAR_WindPulse264_g3186 = localfloatswitch387_g3186;
			float FUNC_Angle148_g3186 = ( VAR_WindStrength129_g3186 * ( 1.0 + sin( ( ( ( ( VAR_RandomTime191_g3186 * 2.0 ) + FUNC_Turbulence296_g3186 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3186.z / 50.0 ) ) - ( v.color.r / 20.0 ) ) ) ) * sqrt( v.color.r ) * VAR_WindPulse264_g3186 );
			float VAR_SinA111_g3186 = sin( FUNC_Angle148_g3186 );
			float VAR_CosA243_g3186 = cos( FUNC_Angle148_g3186 );
			int m_switch389_g3186 = _WindMode;
			float m_Off389_g3186 = 1.0;
			float GLOBAL_WINDDIRECTION341_g3186 = _WindDirection;
			float m_Global389_g3186 = GLOBAL_WINDDIRECTION341_g3186;
			float m_Local389_g3186 = _LocalWindDirection;
			float localfloatswitch389_g3186 = floatswitch( m_switch389_g3186 , m_Off389_g3186 , m_Global389_g3186 , m_Local389_g3186 );
			float _WindDirection178_g3186 = localfloatswitch389_g3186;
			float2 localDirectionalEquation178_g3186 = DirectionalEquation( _WindDirection178_g3186 );
			float2 break74_g3186 = localDirectionalEquation178_g3186;
			float VAR_xLerp173_g3186 = break74_g3186.x;
			float lerpResult232_g3186 = lerp( break156_g3186.x , ( ( break156_g3186.y * VAR_SinA111_g3186 ) + ( break156_g3186.x * VAR_CosA243_g3186 ) ) , VAR_xLerp173_g3186);
			float3 break99_g3186 = VAR_VERTEXPOSITION_MATRIX299_g3186;
			float3 break201_g3186 = VAR_VERTEXPOSITION_MATRIX299_g3186;
			float VAR_zLerp206_g3186 = break74_g3186.y;
			float lerpResult104_g3186 = lerp( break201_g3186.z , ( ( break201_g3186.y * VAR_SinA111_g3186 ) + ( break201_g3186.z * VAR_CosA243_g3186 ) ) , VAR_zLerp206_g3186);
			float3 appendResult197_g3186 = (float3(lerpResult232_g3186 , ( ( break99_g3186.y * VAR_CosA243_g3186 ) - ( break99_g3186.z * VAR_SinA111_g3186 ) ) , lerpResult104_g3186));
			float3 FUNC_vertexPos132_g3186 = appendResult197_g3186;
			float3 break303_g3186 = FUNC_vertexPos132_g3186;
			half FUNC_SinFunction295_g3186 = sin( ( ( VAR_RandomTime191_g3186 * 200.0 * ( 0.2 + v.color.g ) ) + ( v.color.g * 10.0 ) + FUNC_Turbulence296_g3186 + ( VAR_VERTEXPOSITION_MATRIX299_g3186.z / 2.0 ) ) );
			int m_switch388_g3186 = _WindMode;
			float m_Off388_g3186 = 1.0;
			float GLOBAL_WINDTURBULENCE350_g3186 = _WindTurbulence;
			float m_Global388_g3186 = ( _GlobalTurbulenceInfluence * GLOBAL_WINDTURBULENCE350_g3186 );
			float m_Local388_g3186 = _LocalWindTurbulence;
			float localfloatswitch388_g3186 = floatswitch( m_switch388_g3186 , m_Off388_g3186 , m_Global388_g3186 , m_Local388_g3186 );
			float VAR_GlobalWindTurbulence263_g3186 = localfloatswitch388_g3186;
			float3 appendResult158_g3186 = (float3(break303_g3186.x , ( break303_g3186.y + ( FUNC_SinFunction295_g3186 * v.color.b * ( FUNC_Angle148_g3186 + ( VAR_WindStrength129_g3186 / 200.0 ) ) * VAR_GlobalWindTurbulence263_g3186 ) ) , break303_g3186.z));
			float3 OUT_Leafs_Standalone221_g3186 = appendResult158_g3186;
			float3 m_Leaf135_g3186 = OUT_Leafs_Standalone221_g3186;
			float3 OUT_Palm_Standalone252_g3186 = ( ( FUNC_SinFunction295_g3186 * v.color.b * ( FUNC_Angle148_g3186 + ( VAR_WindStrength129_g3186 / 200.0 ) ) * VAR_GlobalWindTurbulence263_g3186 ) + FUNC_vertexPos132_g3186 );
			float3 m_Palm135_g3186 = OUT_Palm_Standalone252_g3186;
			float3 break270_g3186 = FUNC_vertexPos132_g3186;
			float temp_output_219_0_g3186 = ( FUNC_SinFunction295_g3186 * v.color.b * ( FUNC_Angle148_g3186 + ( VAR_WindStrength129_g3186 / 200.0 ) ) );
			float lerpResult57_g3186 = lerp( 0.0 , temp_output_219_0_g3186 , VAR_xLerp173_g3186);
			float lerpResult152_g3186 = lerp( 0.0 , temp_output_219_0_g3186 , VAR_zLerp206_g3186);
			float3 appendResult51_g3186 = (float3(( break270_g3186.x + lerpResult57_g3186 ) , break270_g3186.y , ( break270_g3186.z + lerpResult152_g3186 )));
			float3 OUT_Grass_Standalone179_g3186 = appendResult51_g3186;
			float3 m_Grass135_g3186 = OUT_Grass_Standalone179_g3186;
			float3 m_Simple135_g3186 = FUNC_vertexPos132_g3186;
			float3 localfloat3switch135_g3186 = float3switch135_g3186( m_switch135_g3186 , m_Leaf135_g3186 , m_Palm135_g3186 , m_Grass135_g3186 , m_Simple135_g3186 );
			float3 m_Global395_g3186 = localfloat3switch135_g3186;
			float3 m_Local395_g3186 = localfloat3switch135_g3186;
			float3 localfloat3switch395_g3186 = float3switch( m_switch395_g3186 , m_Off395_g3186 , m_Global395_g3186 , m_Local395_g3186 );
			float3 temp_output_261_0_g3186 = mul( unity_WorldToObject, float4( localfloat3switch395_g3186 , 0.0 ) ).xyz;
			float3 VAR_VERTEXPOSITION298_g3186 = ase_vertex3Pos;
			float3 temp_output_6_0_g3191 = ( temp_output_261_0_g3186 - VAR_VERTEXPOSITION298_g3186 );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 temp_output_4_0_g3191 = ( temp_output_6_0_g3191 + ( ase_vertexNormal * _OutlineThickness ) );
			float3 outlineVar = temp_output_4_0_g3191;
			v.vertex.xyz += outlineVar;
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float4 temp_output_12_0_g3191 = ( _OutlineTint * _OutlineTint.a );
			int UV_SET_MAIN732_g1 = _Mian_UVSet;
			int m_switch730_g1 = UV_SET_MAIN732_g1;
			float2 appendResult77_g1 = (float2(_TilingX , _TilingY));
			float2 appendResult82_g1 = (float2(_OffsetX , _OffsetY));
			float2 uv_TexCoord73_g1 = i.uv_texcoord * appendResult77_g1 + appendResult82_g1;
			float m_UV0730_g1 = uv_TexCoord73_g1.x;
			float2 uv2_TexCoord729_g1 = i.uv2_texcoord2 * appendResult77_g1 + appendResult82_g1;
			float m_UV1730_g1 = uv2_TexCoord729_g1.x;
			float localfloatUVswitch730_g1 = floatUVswitch730_g1( m_switch730_g1 , m_UV0730_g1 , m_UV1730_g1 );
			int m_switch735_g1 = UV_SET_MAIN732_g1;
			float m_UV0735_g1 = uv_TexCoord73_g1.y;
			float m_UV1735_g1 = uv2_TexCoord729_g1.y;
			float localfloatUVswitch735_g1 = floatUVswitch735_g1( m_switch735_g1 , m_UV0735_g1 , m_UV1735_g1 );
			float2 appendResult559_g1 = (float2(localfloatUVswitch730_g1 , localfloatUVswitch735_g1));
			float4 tex2DNode57_g1 = SAMPLE_TEXTURE2D( _MainTex, sampler_trilinear_repeat, appendResult559_g1 );
			float ALBEDO_A716_g1 = tex2DNode57_g1.a;
			clip( ALBEDO_A716_g1 - ( 1.0 - _AlphaCutoffBias ));
			float temp_output_7_0_g2975 = saturate( ( ( ALBEDO_A716_g1 / max( fwidth( ALBEDO_A716_g1 ) , 0.0001 ) ) + 0.5 ) );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen3_g2975 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither3_g2975 = Dither8x8Bayer( fmod(clipScreen3_g2975.x, 8), fmod(clipScreen3_g2975.y, 8) );
			dither3_g2975 = step( dither3_g2975, unity_LODFade.x );
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch5_g2975 = ( temp_output_7_0_g2975 * dither3_g2975 );
			#else
				float staticSwitch5_g2975 = temp_output_7_0_g2975;
			#endif
			float temp_output_3038_96 = staticSwitch5_g2975;
			float4 temp_cast_1 = (temp_output_3038_96).xxxx;
			o.Emission = temp_output_12_0_g3191.rgb;
			o.Alpha = temp_cast_1.x;
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent-10" "NatureRendererInstancing"="True" }
		LOD 200
		Cull [_CullMode]
		ZWrite [_ZWriteMode]
		ZTest [_ZTestMode]
		Stencil
		{
			Ref 0
			Comp Always
			Pass Keep
			Fail Keep
			ZFail Keep
		}
		AlphaToMask [_AlphatoCoverage]
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
			float2 uv_texcoord;
			float2 uv2_texcoord2;
			float4 screenPosition;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float4 vertexColor : COLOR;
			half ASEVFace : VFACE;
			float2 vertexToFrag30_g3184;
			float3 worldRefl;
			float2 uv4_texcoord4;
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
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		SamplerState sampler_MainTex;
		uniform int _Mian_UVSet;
		uniform float _TilingX;
		uniform float _TilingY;
		uniform float _OffsetX;
		uniform float _OffsetY;
		SamplerState sampler_trilinear_repeat;
		uniform half _AlphaCutoffBias;
		uniform int _GlancingClipMode;
		uniform int _ToonMode;
		uniform int _ColorMode;
		uniform float4 _Color;
		uniform half _Brightness;
		uniform float _ShiftVariation;
		uniform float _RGBColorHue;
		uniform float _RGBColorSaturation;
		uniform float _RGBColorBrightness;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_ToonMap);
		uniform int _NormalMode;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		uniform half _NormalStrength;
		SamplerState sampler_ToonMap;
		uniform float _Saturation;
		uniform float _IndirectSmoothness;
		uniform float _IndirectOcclusion;
		uniform float _IndirectStrengthSpecular;
		uniform float _IndirectStrengthDiffuse;
		uniform float _ShadowOffset;
		uniform float _ShadowSharpness;
		uniform float _ShadowStrength;
		uniform int _TranslucencyCullForward;
		uniform int _EnableTranslucency;
		uniform half4 _TransmissionTint;
		uniform int _MapInverted;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_TranslucencyMap);
		uniform float _TranslucencyThickness;
		SamplerState sampler_TranslucencyMap;
		uniform int _TranslucencySource;
		uniform float4 _TranslucencyTint;
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


		float3 float3switch135_g3186( int m_switch, float3 m_Leaf, float3 m_Palm, float3 m_Grass, float3 m_Simple )
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


		float floatUVswitch730_g1( int m_switch, float m_UV0, float m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		float floatUVswitch735_g1( int m_switch, float m_UV0, float m_UV1 )
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


		float floatswitch599_g1( int m_switch, float m_Off, float m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
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

		float3 float3switch420_g1( int m_switch, float3 m_Off, float3 m_ColorShift )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_ColorShift;
			return m_Off;
		}


		float3 float3switch9_g2974( int m_switch, float3 m_Default, float3 m_Flip, float3 m_Mirror )
		{
			if(m_switch == 0)
				return m_Default;
			if(m_switch == 1)
				return m_Flip;
			if(m_switch == 2)
				return m_Mirror;
			return m_Default;
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


		float4 float4switch49_g3184( int m_switch, float4 m_Off, float4 m_Ramp, float4 m_MatCap )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Ramp;
			if(m_switch == 2)
				return m_MatCap;
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


		float4 float4switch332_g1( int m_switch, float4 m_Off, float4 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float4 float4switch537_g1( int m_switch, float4 m_Default, float4 m_CullFrontFace, float4 m_CullBackFace )
		{
			if(m_switch == 0)
				return m_Default;
			if(m_switch == 1)
				return m_CullFrontFace;
			if(m_switch == 2)
				return m_CullBackFace;
			return m_Default;
		}


		float4 float4switch324_g1( int m_switch, float4 m_Off, float4 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float4 float4switch539_g1( int m_switch, float4 m_Default, float4 m_CullFrontFace, float4 m_CullBackFace )
		{
			if(m_switch == 0)
				return m_Default;
			if(m_switch == 1)
				return m_CullFrontFace;
			if(m_switch == 2)
				return m_CullBackFace;
			return m_Default;
		}


		float2 float2switch58_g3182( int m_switch, float2 m_Standard, float2 m_Scale )
		{
			if(m_switch == 0)
				return m_Standard;
			if(m_switch == 1)
				return m_Scale;
			return m_Standard;
		}


		float2 float2UVswitch138_g3182( int m_switch, float2 m_UV0, float2 m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		float4 float4switch131_g3182( int m_switch, float4 m_Off, float4 m_Active )
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
			float3 localOutlineOutput10_g3191 = ( 0 );
			int WindController383_g3186 = _WindMode;
			int m_switch395_g3186 = WindController383_g3186;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VAR_VERTEXPOSITION_MATRIX299_g3186 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 m_Off395_g3186 = VAR_VERTEXPOSITION_MATRIX299_g3186;
			int m_switch135_g3186 = _WindModeCutoutShader;
			float3 break156_g3186 = VAR_VERTEXPOSITION_MATRIX299_g3186;
			int m_switch390_g3186 = _WindMode;
			float m_Off390_g3186 = 1.0;
			float GLOBAL_WINDINFLUENCE340_g3186 = _WindStrength;
			float m_Global390_g3186 = ( _GlobalWindInfluenceOther * GLOBAL_WINDINFLUENCE340_g3186 );
			float m_Local390_g3186 = _LocalWindStrength;
			float localfloatswitch390_g3186 = floatswitch( m_switch390_g3186 , m_Off390_g3186 , m_Global390_g3186 , m_Local390_g3186 );
			float VAR_WindStrength129_g3186 = localfloatswitch390_g3186;
			int m_switch117_g3186 = _WindMode;
			float m_Off117_g3186 = 1.0;
			float GLOBAL_RANDOMWINDOFFSET339_g3186 = _RandomWindOffset;
			float m_Global117_g3186 = GLOBAL_RANDOMWINDOFFSET339_g3186;
			float m_Local117_g3186 = _LocalRandomWindOffset;
			float localfloatswitch117_g3186 = floatswitch( m_switch117_g3186 , m_Off117_g3186 , m_Global117_g3186 , m_Local117_g3186 );
			float VAR_WindOffset76_g3186 = localfloatswitch117_g3186;
			float4 transform288_g3186 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult210_g3186 = (float2(transform288_g3186.x , transform288_g3186.z));
			float dotResult271_g3186 = dot( appendResult210_g3186 , float2( 12.9898,78.233 ) );
			float lerpResult44_g3186 = lerp( 0.8 , ( ( VAR_WindOffset76_g3186 / 2.0 ) + 0.9 ) , frac( ( sin( dotResult271_g3186 ) * 43758.55 ) ));
			float VAR_RandomTime191_g3186 = ( _Time.x * lerpResult44_g3186 );
			float FUNC_Turbulence296_g3186 = ( sin( ( ( VAR_RandomTime191_g3186 * 40.0 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3186.z / 15.0 ) ) ) * 0.5 );
			int m_switch387_g3186 = _WindMode;
			float m_Off387_g3186 = 1.0;
			float GLOBAL_WINDPULSE342_g3186 = _WindPulse;
			float m_Global387_g3186 = GLOBAL_WINDPULSE342_g3186;
			float m_Local387_g3186 = _LocalWindPulse;
			float localfloatswitch387_g3186 = floatswitch( m_switch387_g3186 , m_Off387_g3186 , m_Global387_g3186 , m_Local387_g3186 );
			float VAR_WindPulse264_g3186 = localfloatswitch387_g3186;
			float FUNC_Angle148_g3186 = ( VAR_WindStrength129_g3186 * ( 1.0 + sin( ( ( ( ( VAR_RandomTime191_g3186 * 2.0 ) + FUNC_Turbulence296_g3186 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3186.z / 50.0 ) ) - ( v.color.r / 20.0 ) ) ) ) * sqrt( v.color.r ) * VAR_WindPulse264_g3186 );
			float VAR_SinA111_g3186 = sin( FUNC_Angle148_g3186 );
			float VAR_CosA243_g3186 = cos( FUNC_Angle148_g3186 );
			int m_switch389_g3186 = _WindMode;
			float m_Off389_g3186 = 1.0;
			float GLOBAL_WINDDIRECTION341_g3186 = _WindDirection;
			float m_Global389_g3186 = GLOBAL_WINDDIRECTION341_g3186;
			float m_Local389_g3186 = _LocalWindDirection;
			float localfloatswitch389_g3186 = floatswitch( m_switch389_g3186 , m_Off389_g3186 , m_Global389_g3186 , m_Local389_g3186 );
			float _WindDirection178_g3186 = localfloatswitch389_g3186;
			float2 localDirectionalEquation178_g3186 = DirectionalEquation( _WindDirection178_g3186 );
			float2 break74_g3186 = localDirectionalEquation178_g3186;
			float VAR_xLerp173_g3186 = break74_g3186.x;
			float lerpResult232_g3186 = lerp( break156_g3186.x , ( ( break156_g3186.y * VAR_SinA111_g3186 ) + ( break156_g3186.x * VAR_CosA243_g3186 ) ) , VAR_xLerp173_g3186);
			float3 break99_g3186 = VAR_VERTEXPOSITION_MATRIX299_g3186;
			float3 break201_g3186 = VAR_VERTEXPOSITION_MATRIX299_g3186;
			float VAR_zLerp206_g3186 = break74_g3186.y;
			float lerpResult104_g3186 = lerp( break201_g3186.z , ( ( break201_g3186.y * VAR_SinA111_g3186 ) + ( break201_g3186.z * VAR_CosA243_g3186 ) ) , VAR_zLerp206_g3186);
			float3 appendResult197_g3186 = (float3(lerpResult232_g3186 , ( ( break99_g3186.y * VAR_CosA243_g3186 ) - ( break99_g3186.z * VAR_SinA111_g3186 ) ) , lerpResult104_g3186));
			float3 FUNC_vertexPos132_g3186 = appendResult197_g3186;
			float3 break303_g3186 = FUNC_vertexPos132_g3186;
			half FUNC_SinFunction295_g3186 = sin( ( ( VAR_RandomTime191_g3186 * 200.0 * ( 0.2 + v.color.g ) ) + ( v.color.g * 10.0 ) + FUNC_Turbulence296_g3186 + ( VAR_VERTEXPOSITION_MATRIX299_g3186.z / 2.0 ) ) );
			int m_switch388_g3186 = _WindMode;
			float m_Off388_g3186 = 1.0;
			float GLOBAL_WINDTURBULENCE350_g3186 = _WindTurbulence;
			float m_Global388_g3186 = ( _GlobalTurbulenceInfluence * GLOBAL_WINDTURBULENCE350_g3186 );
			float m_Local388_g3186 = _LocalWindTurbulence;
			float localfloatswitch388_g3186 = floatswitch( m_switch388_g3186 , m_Off388_g3186 , m_Global388_g3186 , m_Local388_g3186 );
			float VAR_GlobalWindTurbulence263_g3186 = localfloatswitch388_g3186;
			float3 appendResult158_g3186 = (float3(break303_g3186.x , ( break303_g3186.y + ( FUNC_SinFunction295_g3186 * v.color.b * ( FUNC_Angle148_g3186 + ( VAR_WindStrength129_g3186 / 200.0 ) ) * VAR_GlobalWindTurbulence263_g3186 ) ) , break303_g3186.z));
			float3 OUT_Leafs_Standalone221_g3186 = appendResult158_g3186;
			float3 m_Leaf135_g3186 = OUT_Leafs_Standalone221_g3186;
			float3 OUT_Palm_Standalone252_g3186 = ( ( FUNC_SinFunction295_g3186 * v.color.b * ( FUNC_Angle148_g3186 + ( VAR_WindStrength129_g3186 / 200.0 ) ) * VAR_GlobalWindTurbulence263_g3186 ) + FUNC_vertexPos132_g3186 );
			float3 m_Palm135_g3186 = OUT_Palm_Standalone252_g3186;
			float3 break270_g3186 = FUNC_vertexPos132_g3186;
			float temp_output_219_0_g3186 = ( FUNC_SinFunction295_g3186 * v.color.b * ( FUNC_Angle148_g3186 + ( VAR_WindStrength129_g3186 / 200.0 ) ) );
			float lerpResult57_g3186 = lerp( 0.0 , temp_output_219_0_g3186 , VAR_xLerp173_g3186);
			float lerpResult152_g3186 = lerp( 0.0 , temp_output_219_0_g3186 , VAR_zLerp206_g3186);
			float3 appendResult51_g3186 = (float3(( break270_g3186.x + lerpResult57_g3186 ) , break270_g3186.y , ( break270_g3186.z + lerpResult152_g3186 )));
			float3 OUT_Grass_Standalone179_g3186 = appendResult51_g3186;
			float3 m_Grass135_g3186 = OUT_Grass_Standalone179_g3186;
			float3 m_Simple135_g3186 = FUNC_vertexPos132_g3186;
			float3 localfloat3switch135_g3186 = float3switch135_g3186( m_switch135_g3186 , m_Leaf135_g3186 , m_Palm135_g3186 , m_Grass135_g3186 , m_Simple135_g3186 );
			float3 m_Global395_g3186 = localfloat3switch135_g3186;
			float3 m_Local395_g3186 = localfloat3switch135_g3186;
			float3 localfloat3switch395_g3186 = float3switch( m_switch395_g3186 , m_Off395_g3186 , m_Global395_g3186 , m_Local395_g3186 );
			float3 temp_output_261_0_g3186 = mul( unity_WorldToObject, float4( localfloat3switch395_g3186 , 0.0 ) ).xyz;
			float3 VAR_VERTEXPOSITION298_g3186 = ase_vertex3Pos;
			float3 temp_output_6_0_g3191 = ( temp_output_261_0_g3186 - VAR_VERTEXPOSITION298_g3186 );
			float3 vertexoffset10_g3191 = temp_output_6_0_g3191;
			v.vertex.xyz += vertexoffset10_g3191;
			v.vertex.xyz += localOutlineOutput10_g3191;
			v.vertex.w = 1;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
			int m_switch9_g2974 = _NormalMode;
			int UV_SET_MAIN732_g1 = _Mian_UVSet;
			int m_switch730_g1 = UV_SET_MAIN732_g1;
			float2 appendResult77_g1 = (float2(_TilingX , _TilingY));
			float2 appendResult82_g1 = (float2(_OffsetX , _OffsetY));
			float2 uv_TexCoord73_g1 = v.texcoord.xy * appendResult77_g1 + appendResult82_g1;
			float m_UV0730_g1 = uv_TexCoord73_g1.x;
			float2 uv2_TexCoord729_g1 = v.texcoord1.xy * appendResult77_g1 + appendResult82_g1;
			float m_UV1730_g1 = uv2_TexCoord729_g1.x;
			float localfloatUVswitch730_g1 = floatUVswitch730_g1( m_switch730_g1 , m_UV0730_g1 , m_UV1730_g1 );
			int m_switch735_g1 = UV_SET_MAIN732_g1;
			float m_UV0735_g1 = uv_TexCoord73_g1.y;
			float m_UV1735_g1 = uv2_TexCoord729_g1.y;
			float localfloatUVswitch735_g1 = floatUVswitch735_g1( m_switch735_g1 , m_UV0735_g1 , m_UV1735_g1 );
			float2 appendResult559_g1 = (float2(localfloatUVswitch730_g1 , localfloatUVswitch735_g1));
			float3 NORMAL_IN17_g2974 = UnpackScaleNormal( SAMPLE_TEXTURE2D_LOD( _BumpMap, sampler_trilinear_repeat, appendResult559_g1, 0.0 ), _NormalStrength );
			float3 m_Default9_g2974 = NORMAL_IN17_g2974;
			float3 m_Flip9_g2974 = ( NORMAL_IN17_g2974 * (0) );
			float3 break2_g2974 = NORMAL_IN17_g2974;
			float3 appendResult3_g2974 = (float3(break2_g2974.x , break2_g2974.y , ( break2_g2974.z * (0) )));
			float3 m_Mirror9_g2974 = appendResult3_g2974;
			float3 localfloat3switch9_g2974 = float3switch9_g2974( m_switch9_g2974 , m_Default9_g2974 , m_Flip9_g2974 , m_Mirror9_g2974 );
			float3 temp_output_530_11_g1 = localfloat3switch9_g2974;
			float3 temp_output_3038_95 = temp_output_530_11_g1;
			float3 temp_output_56_0_g3184 = temp_output_3038_95;
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float3 ase_worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
			float3x3 tangentToWorld = CreateTangentToWorldPerVertex( ase_worldNormal, ase_worldTangent, v.tangent.w );
			float3 tangentNormal19_g3184 = temp_output_56_0_g3184;
			float3 modWorldNormal19_g3184 = (tangentToWorld[0] * tangentNormal19_g3184.x + tangentToWorld[1] * tangentNormal19_g3184.y + tangentToWorld[2] * tangentNormal19_g3184.z);
			float3 break12_g3184 = modWorldNormal19_g3184;
			float3 normalizeResult11_g3184 = normalize( ( ( (unity_WorldToObject[0]).xyz * break12_g3184.x ) + ( (unity_WorldToObject[1]).xyz * break12_g3184.y ) + ( (unity_WorldToObject[2]).xyz * break12_g3184.z ) ) );
			o.vertexToFrag30_g3184 = ((mul( UNITY_MATRIX_V, float4( normalizeResult11_g3184 , 0.0 ) ).xyz).xy*0.5 + 0.5);
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
			int UV_SET_MAIN732_g1 = _Mian_UVSet;
			int m_switch730_g1 = UV_SET_MAIN732_g1;
			float2 appendResult77_g1 = (float2(_TilingX , _TilingY));
			float2 appendResult82_g1 = (float2(_OffsetX , _OffsetY));
			float2 uv_TexCoord73_g1 = i.uv_texcoord * appendResult77_g1 + appendResult82_g1;
			float m_UV0730_g1 = uv_TexCoord73_g1.x;
			float2 uv2_TexCoord729_g1 = i.uv2_texcoord2 * appendResult77_g1 + appendResult82_g1;
			float m_UV1730_g1 = uv2_TexCoord729_g1.x;
			float localfloatUVswitch730_g1 = floatUVswitch730_g1( m_switch730_g1 , m_UV0730_g1 , m_UV1730_g1 );
			int m_switch735_g1 = UV_SET_MAIN732_g1;
			float m_UV0735_g1 = uv_TexCoord73_g1.y;
			float m_UV1735_g1 = uv2_TexCoord729_g1.y;
			float localfloatUVswitch735_g1 = floatUVswitch735_g1( m_switch735_g1 , m_UV0735_g1 , m_UV1735_g1 );
			float2 appendResult559_g1 = (float2(localfloatUVswitch730_g1 , localfloatUVswitch735_g1));
			float4 tex2DNode57_g1 = SAMPLE_TEXTURE2D( _MainTex, sampler_trilinear_repeat, appendResult559_g1 );
			float ALBEDO_A716_g1 = tex2DNode57_g1.a;
			clip( ALBEDO_A716_g1 - ( 1.0 - _AlphaCutoffBias ));
			float temp_output_7_0_g2975 = saturate( ( ( ALBEDO_A716_g1 / max( fwidth( ALBEDO_A716_g1 ) , 0.0001 ) ) + 0.5 ) );
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen3_g2975 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither3_g2975 = Dither8x8Bayer( fmod(clipScreen3_g2975.x, 8), fmod(clipScreen3_g2975.y, 8) );
			dither3_g2975 = step( dither3_g2975, unity_LODFade.x );
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch5_g2975 = ( temp_output_7_0_g2975 * dither3_g2975 );
			#else
				float staticSwitch5_g2975 = temp_output_7_0_g2975;
			#endif
			float temp_output_3038_96 = staticSwitch5_g2975;
			float4 temp_cast_0 = (temp_output_3038_96).xxxx;
			float4 temp_output_147_0_g3192 = temp_cast_0;
			float4 OPACITY_IN148_g3192 = temp_output_147_0_g3192;
			int m_switch599_g1 = _GlancingClipMode;
			float m_Off599_g1 = 1.0;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult583_g1 = normalize( cross( ddx( ase_worldPos ) , ddy( ase_worldPos ) ) );
			float dotResult587_g1 = dot( ase_worldViewDir , normalizeResult583_g1 );
			float temp_output_585_0_g1 = ( 1.0 - abs( dotResult587_g1 ) );
			float temp_output_590_0_g1 = ( 1.0 - ( temp_output_585_0_g1 * temp_output_585_0_g1 ) );
			float m_Active599_g1 = temp_output_590_0_g1;
			float localfloatswitch599_g1 = floatswitch599_g1( m_switch599_g1 , m_Off599_g1 , m_Active599_g1 );
			float4 temp_cast_2 = (localfloatswitch599_g1).xxxx;
			float4 temp_output_151_0_g3192 = temp_cast_2;
			float4 OPACITY_MASK_IN152_g3192 = temp_output_151_0_g3192;
			SurfaceOutputStandardSpecular s54_g3192 = (SurfaceOutputStandardSpecular ) 0;
			int TOON_MODE50_g3184 = _ToonMode;
			int m_switch49_g3184 = TOON_MODE50_g3184;
			int m_switch420_g1 = _ColorMode;
			float3 temp_output_11_0_g1 = (_Color).rgb;
			float3 temp_output_76_0_g1 = ( temp_output_11_0_g1 * (tex2DNode57_g1).rgb * _Brightness );
			float3 ALBEDO_01424_g1 = temp_output_76_0_g1;
			float3 m_Off420_g1 = ALBEDO_01424_g1;
			float3 hsvTorgb408_g1 = RGBToHSV( ALBEDO_01424_g1 );
			float3 hsvTorgb406_g1 = HSVToRGB( float3(( ( ( i.vertexColor.g - 0.5 ) * _ShiftVariation ) + _RGBColorHue + hsvTorgb408_g1 ).x,( hsvTorgb408_g1.y * _RGBColorSaturation ),( hsvTorgb408_g1.z * _RGBColorBrightness )) );
			float3 m_ColorShift420_g1 = hsvTorgb406_g1;
			float3 localfloat3switch420_g1 = float3switch420_g1( m_switch420_g1 , m_Off420_g1 , m_ColorShift420_g1 );
			float3 COLOR_SHIFTING426_g1 = localfloat3switch420_g1;
			float4 temp_output_14_0_g3184 = float4( COLOR_SHIFTING426_g1 , 0.0 );
			float4 m_Off49_g3184 = temp_output_14_0_g3184;
			int m_switch5_g3184 = _ToonMode;
			float2 m_Off5_g3184 = float2( 1,1 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			int m_switch9_g2974 = _NormalMode;
			float3 NORMAL_IN17_g2974 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, appendResult559_g1 ), _NormalStrength );
			float3 m_Default9_g2974 = NORMAL_IN17_g2974;
			float3 m_Flip9_g2974 = ( NORMAL_IN17_g2974 * i.ASEVFace );
			float3 break2_g2974 = NORMAL_IN17_g2974;
			float3 appendResult3_g2974 = (float3(break2_g2974.x , break2_g2974.y , ( break2_g2974.z * i.ASEVFace )));
			float3 m_Mirror9_g2974 = appendResult3_g2974;
			float3 localfloat3switch9_g2974 = float3switch9_g2974( m_switch9_g2974 , m_Default9_g2974 , m_Flip9_g2974 , m_Mirror9_g2974 );
			float3 temp_output_530_11_g1 = localfloat3switch9_g2974;
			float3 temp_output_3038_95 = temp_output_530_11_g1;
			float3 temp_output_56_0_g3184 = temp_output_3038_95;
			float3 NORMAL_IN78_g3184 = temp_output_56_0_g3184;
			float dotResult16_g3184 = dot( ase_worldlightDir , (WorldNormalVector( i , NORMAL_IN78_g3184 )) );
			float UV_RAMP42_g3184 = saturate( (dotResult16_g3184*0.5 + 0.5) );
			float2 temp_cast_7 = (( UV_RAMP42_g3184 * ase_lightAtten )).xx;
			float2 m_Ramp5_g3184 = temp_cast_7;
			float2 UV_MATCAP43_g3184 = i.vertexToFrag30_g3184;
			float2 m_MatCap5_g3184 = ( UV_MATCAP43_g3184 * ase_lightAtten );
			float2 localfloat2switch5_g3184 = float2switch( m_switch5_g3184 , m_Off5_g3184 , m_Ramp5_g3184 , m_MatCap5_g3184 );
			float4 tex2DNode37_g3184 = SAMPLE_TEXTURE2D( _ToonMap, sampler_trilinear_repeat, localfloat2switch5_g3184 );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 ase_worldReflection = WorldReflectionVector( i, float3( 0, 0, 1 ) );
			float dotResult132_g3184 = dot( ase_worldReflection , ase_worldlightDir );
			float4 temp_output_84_0_g3184 = saturate( ( temp_output_14_0_g3184 + ( ( tex2DNode37_g3184 * tex2DNode37_g3184.a * _Saturation ) * float4( ( ( ase_lightColor.rgb * ase_lightColor.a ) * dotResult132_g3184 ) , 0.0 ) ) ) );
			float4 m_Ramp49_g3184 = temp_output_84_0_g3184;
			float4 m_MatCap49_g3184 = temp_output_84_0_g3184;
			float4 localfloat4switch49_g3184 = float4switch49_g3184( m_switch49_g3184 , m_Off49_g3184 , m_Ramp49_g3184 , m_MatCap49_g3184 );
			float4 ALBEDO_IN45_g3192 = localfloat4switch49_g3184;
			float3 temp_cast_10 = (1.0).xxx;
			float3 NORMAL_IN44_g3192 = temp_output_3038_95;
			float3 indirectNormal50_g3192 = WorldNormalVector( i , NORMAL_IN44_g3192 );
			Unity_GlossyEnvironmentData g50_g3192 = UnityGlossyEnvironmentSetup( _IndirectSmoothness, data.worldViewDir, indirectNormal50_g3192, float3(0,0,0));
			float3 indirectSpecular50_g3192 = UnityGI_IndirectSpecular( data, _IndirectOcclusion, indirectNormal50_g3192, g50_g3192 );
			float3 lerpResult27_g3192 = lerp( temp_cast_10 , indirectSpecular50_g3192 , ( 1.0 - _IndirectStrengthSpecular ));
			float3 temp_cast_11 = (1.0).xxx;
			UnityGI gi52_g3192 = gi;
			float3 diffNorm52_g3192 = WorldNormalVector( i , NORMAL_IN44_g3192 );
			gi52_g3192 = UnityGI_Base( data, 1, diffNorm52_g3192 );
			float3 indirectDiffuse52_g3192 = gi52_g3192.indirect.diffuse + diffNorm52_g3192 * 0.0001;
			float3 lerpResult6_g3192 = lerp( temp_cast_11 , indirectDiffuse52_g3192 , ( 1.0 - _IndirectStrengthDiffuse ));
			float temp_output_16_0_g3192 = ( 1.0 - ( ( 1.0 - ase_lightAtten ) * _WorldSpaceLightPos0.w ) );
			float dotResult17_g3192 = dot( ase_worldlightDir , (WorldNormalVector( i , NORMAL_IN44_g3192 )) );
			float clampResult70_g3192 = clamp( ( dotResult17_g3192 * dotResult17_g3192 * dotResult17_g3192 ) , 0.0 , 1.0 );
			float lerpResult5_g3192 = lerp( temp_output_16_0_g3192 , ( saturate( ( ( clampResult70_g3192 + _ShadowOffset ) / _ShadowSharpness ) ) * ase_lightAtten ) , _ShadowStrength);
			float3 LIGHTING32_g3192 = ( lerpResult27_g3192 * saturate( ( ( lerpResult6_g3192 * ase_lightColor.a * temp_output_16_0_g3192 ) + ( ase_lightColor.rgb * lerpResult5_g3192 ) ) ) );
			float4 temp_output_35_0_g3192 = ( ALBEDO_IN45_g3192 * float4( LIGHTING32_g3192 , 0.0 ) );
			int m_switch537_g1 = _TranslucencyCullForward;
			int TRANSLUCENCY_MODE523_g1 = _EnableTranslucency;
			int m_switch332_g1 = TRANSLUCENCY_MODE523_g1;
			float4 m_Off332_g1 = float4( 0,0,0,0 );
			int m_switch639_g1 = _MapInverted;
			float4 color726_g1 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float4 COLOR_0000727_g1 = color726_g1;
			float2 CUSTOM_UV1263_g1 = appendResult559_g1;
			float4 tex2DNode322_g1 = SAMPLE_TEXTURE2D( _TranslucencyMap, sampler_trilinear_repeat, CUSTOM_UV1263_g1 );
			float4 lerpResult326_g1 = lerp( COLOR_0000727_g1 , tex2DNode322_g1 , _TranslucencyThickness);
			float4 m_Default639_g1 = lerpResult326_g1;
			float temp_output_620_0_g1 = ( 0.0 - 1.0 );
			float temp_output_623_0_g1 = ( tex2DNode322_g1.r - 1.0 );
			float lerpResult631_g1 = lerp( ( temp_output_620_0_g1 / temp_output_623_0_g1 ) , ( temp_output_623_0_g1 / temp_output_620_0_g1 ) , ( 0.7 + _TranslucencyThickness ));
			float4 temp_cast_14 = (saturate( lerpResult631_g1 )).xxxx;
			float4 m_Inverted639_g1 = temp_cast_14;
			float4 localfloat4switch639_g1 = float4switch( m_switch639_g1 , m_Default639_g1 , m_Inverted639_g1 );
			float lerpResult334_g1 = lerp( 0.0 , ( 5.0 - i.uv4_texcoord4.x ) , _TranslucencyThickness);
			float4 temp_cast_15 = (lerpResult334_g1).xxxx;
			float4 lerpResult369_g1 = lerp( localfloat4switch639_g1 , temp_cast_15 , (float)_TranslucencySource);
			float3 temp_output_371_0_g1 = ( ase_lightColor.rgb * ase_lightColor.a );
			float3 GLOBAL_LIGHT_COLOR373_g1 = temp_output_371_0_g1;
			float4 m_Active332_g1 = ( ( _TransmissionTint * _TransmissionTint.a * lerpResult369_g1 ) * float4( GLOBAL_LIGHT_COLOR373_g1 , 0.0 ) * i.vertexColor.g );
			float4 localfloat4switch332_g1 = float4switch332_g1( m_switch332_g1 , m_Off332_g1 , m_Active332_g1 );
			float4 m_Default537_g1 = localfloat4switch332_g1;
			float4 _Vector3 = float4(0,0,0,0);
			float4 switchResult535_g1 = (((i.ASEVFace>0)?(_Vector3):(localfloat4switch332_g1)));
			float4 m_CullFrontFace537_g1 = switchResult535_g1;
			float4 switchResult541_g1 = (((i.ASEVFace>0)?(localfloat4switch332_g1):(_Vector3)));
			float4 m_CullBackFace537_g1 = switchResult541_g1;
			float4 localfloat4switch537_g1 = float4switch537_g1( m_switch537_g1 , m_Default537_g1 , m_CullFrontFace537_g1 , m_CullBackFace537_g1 );
			float3 TRANSLUCENCY_IN166_g3192 = localfloat4switch537_g1.xyz;
			int m_switch539_g1 = _TranslucencyCullForward;
			int m_switch324_g1 = TRANSLUCENCY_MODE523_g1;
			float4 m_Off324_g1 = float4( 0,0,0,0 );
			float4 m_Active324_g1 = ( ( _TranslucencyTint * _TranslucencyTint.a * lerpResult369_g1 ) * float4( GLOBAL_LIGHT_COLOR373_g1 , 0.0 ) * i.vertexColor.g );
			float4 localfloat4switch324_g1 = float4switch324_g1( m_switch324_g1 , m_Off324_g1 , m_Active324_g1 );
			float4 m_Default539_g1 = localfloat4switch324_g1;
			float4 switchResult531_g1 = (((i.ASEVFace>0)?(_Vector3):(localfloat4switch324_g1)));
			float4 m_CullFrontFace539_g1 = switchResult531_g1;
			float4 switchResult540_g1 = (((i.ASEVFace>0)?(localfloat4switch324_g1):(_Vector3)));
			float4 m_CullBackFace539_g1 = switchResult540_g1;
			float4 localfloat4switch539_g1 = float4switch539_g1( m_switch539_g1 , m_Default539_g1 , m_CullFrontFace539_g1 , m_CullBackFace539_g1 );
			float3 TRANSMISSION_IN167_g3192 = localfloat4switch539_g1.xyz;
			s54_g3192.Albedo = ( ( temp_output_35_0_g3192 + float4( TRANSLUCENCY_IN166_g3192 , 0.0 ) ) + float4( TRANSMISSION_IN167_g3192 , 0.0 ) ).xyz;
			s54_g3192.Normal = WorldNormalVector( i , NORMAL_IN44_g3192 );
			int m_switch72_g3190 = _EnableHighlight;
			float4 color79_g3190 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float4 m_Off72_g3190 = color79_g3190;
			int m_switch131_g3182 = _EmissionMode;
			float4 color46_g3182 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float4 COLOR_000079_g3182 = color46_g3182;
			float4 m_Off131_g3182 = COLOR_000079_g3182;
			float4 EMISSION_TINT_01_RGBA75_g3182 = _EmissionTint_01;
			float EMISSION_TINT_01_A62_g3182 = _EmissionTint_01.a;
			float EMISSION_TINT_01_STRENGHT73_g3182 = _EmissionTintStrength_01;
			int UV_SET_EMISSION136_g3182 = _Emission_UVSet;
			int m_switch138_g3182 = UV_SET_EMISSION136_g3182;
			int m_switch58_g3182 = _EmissionMask_TillingMode;
			float2 appendResult57_g3182 = (float2(_EmissionMask_TilingX , _EmissionMask_TilingY));
			float2 m_Standard58_g3182 = appendResult57_g3182;
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 break35_g3182 = ase_parentObjectScale;
			float2 appendResult13_g3182 = (float2(break35_g3182.z , break35_g3182.y));
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float3 normalizeResult60_g3182 = normalize( ase_vertexNormal );
			float3 break44_g3182 = normalizeResult60_g3182;
			float2 appendResult28_g3182 = (float2(break35_g3182.x , break35_g3182.z));
			float2 appendResult9_g3182 = (float2(break35_g3182.x , break35_g3182.y));
			float2 m_Scale58_g3182 = ( ( ( appendResult13_g3182 * break44_g3182.x ) + ( break44_g3182.y * appendResult28_g3182 ) + ( break44_g3182.z * appendResult9_g3182 ) ) * appendResult57_g3182 );
			float2 localfloat2switch58_g3182 = float2switch58_g3182( m_switch58_g3182 , m_Standard58_g3182 , m_Scale58_g3182 );
			float2 appendResult27_g3182 = (float2(_EmissionMask_OffsetX , _EmissionMask_OffsetY));
			float2 uv_TexCoord74_g3182 = i.uv_texcoord * localfloat2switch58_g3182 + appendResult27_g3182;
			float2 m_UV0138_g3182 = uv_TexCoord74_g3182;
			float2 uv2_TexCoord139_g3182 = i.uv2_texcoord2 * localfloat2switch58_g3182 + appendResult27_g3182;
			float2 m_UV1138_g3182 = uv2_TexCoord139_g3182;
			float2 localfloat2UVswitch138_g3182 = float2UVswitch138_g3182( m_switch138_g3182 , m_UV0138_g3182 , m_UV1138_g3182 );
			float4 tex2DNode82_g3182 = SAMPLE_TEXTURE2D( _EmissionMapMask, sampler_trilinear_repeat, localfloat2UVswitch138_g3182 );
			float4 EMISSION_MAP_MASK_RGBA91_g3182 = tex2DNode82_g3182;
			float4 lerpResult117_g3182 = lerp( COLOR_000079_g3182 , ( EMISSION_TINT_01_RGBA75_g3182 * EMISSION_TINT_01_A62_g3182 * EMISSION_TINT_01_STRENGHT73_g3182 ) , EMISSION_MAP_MASK_RGBA91_g3182);
			float4 EMISSION_TINT_02_RGBA69_g3182 = _EmissionTint_02;
			float EMISSION_TINT_02_A92_g3182 = _EmissionTint_02.a;
			float EMISSION_TINT_02_STRENGHT70_g3182 = _EmissionTintStrength_02;
			float4 lerpResult124_g3182 = lerp( lerpResult117_g3182 , ( EMISSION_TINT_02_RGBA69_g3182 * EMISSION_TINT_02_A92_g3182 * EMISSION_TINT_02_STRENGHT70_g3182 ) , EMISSION_MAP_MASK_RGBA91_g3182);
			float4 EMISSION_TINTGLOW_RGBA90_g3182 = _EmissionTintGlow;
			float EMISSION_TINTGLOW_A78_g3182 = _EmissionTintGlow.a;
			float3 NORMAL_IN77_g3182 = temp_output_3038_95;
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_tangentToWorldFast = float3x3(ase_worldTangent.x,ase_worldBitangent.x,ase_worldNormal.x,ase_worldTangent.y,ase_worldBitangent.y,ase_worldNormal.y,ase_worldTangent.z,ase_worldBitangent.z,ase_worldNormal.z);
			float fresnelNdotV123_g3182 = dot( mul(ase_tangentToWorldFast,NORMAL_IN77_g3182), ase_worldViewDir );
			float fresnelNode123_g3182 = ( 0.0 + 1.0 * pow( max( 1.0 - fresnelNdotV123_g3182 , 0.0001 ), 10.0 ) );
			float4 lerpResult121_g3182 = lerp( COLOR_000079_g3182 , ( EMISSION_TINTGLOW_RGBA90_g3182 * EMISSION_TINTGLOW_A78_g3182 ) , fresnelNode123_g3182);
			float EMISSION_TINTGLOW_STRENGHT93_g3182 = _EmissionTintGlowStrength;
			float4 EMISSION_TYPE_HIGHLIGHT109_g3182 = saturate( ( lerpResult124_g3182 + ( lerpResult121_g3182 * EMISSION_TINTGLOW_STRENGHT93_g3182 ) ) );
			float4 m_Active131_g3182 = EMISSION_TYPE_HIGHLIGHT109_g3182;
			float4 localfloat4switch131_g3182 = float4switch131_g3182( m_switch131_g3182 , m_Off131_g3182 , m_Active131_g3182 );
			float3 temp_output_104_0_g3190 = temp_output_3038_95;
			float3 normalizeResult113_g3190 = normalize( temp_output_104_0_g3190 );
			float3 normalizeResult110_g3190 = normalize( i.viewDir );
			float dotResult107_g3190 = dot( normalizeResult113_g3190 , normalizeResult110_g3190 );
			float mulTime97_g3190 = _Time.y * 0.05;
			float4 temp_output_74_0_g3190 = ( ( pow( ( 1.0 - saturate( dotResult107_g3190 ) ) , (10.0 + ((_SpeedMinLevel + (sin( ( mulTime97_g3190 * _Speed ) ) - -1.0) * (_SpeedMaxLevel - _SpeedMinLevel) / (1.0 - -1.0)) - 0.0) * (0.0 - 10.0) / (1.0 - 0.0)) ) * _HighlightTint * _HighlightTint.a ) * _HighlightStrength );
			float4 m_Active72_g3190 = ( localfloat4switch131_g3182 + temp_output_74_0_g3190 );
			float4 localfloat4switch72_g3190 = float4switch( m_switch72_g3190 , m_Off72_g3190 , m_Active72_g3190 );
			float4 EMISSION_IN46_g3192 = localfloat4switch72_g3190;
			s54_g3192.Emission = EMISSION_IN46_g3192.xyz;
			float3 normalizeResult189_g3192 = normalize( (WorldNormalVector( i , NORMAL_IN44_g3192 )) );
			float3 normalizeResult184_g3192 = normalize( ( ase_worldViewDir + ase_worldlightDir ) );
			float dotResult195_g3192 = dot( normalizeResult189_g3192 , normalizeResult184_g3192 );
			float clampResult226_g3192 = clamp( ( dotResult195_g3192 * dotResult195_g3192 * dotResult195_g3192 ) , 0.0 , 1.0 );
			float4 SPECULAR207_g3192 = saturate( ( pow( clampResult226_g3192 , max( _Shininess , 110.0 ) ) * _SpecularColor * _SpecularColor.a ) );
			s54_g3192.Specular = SPECULAR207_g3192.rgb;
			float4 SMOOTHNESS_IN48_g3192 = ( _SmoothnessStrength * SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_trilinear_repeat, CUSTOM_UV1263_g1 ) );
			s54_g3192.Smoothness = SMOOTHNESS_IN48_g3192.x;
			float4 temp_cast_36 = (1.0).xxxx;
			float4 temp_cast_37 = (i.vertexColor.a).xxxx;
			float4 lerpResult39_g1 = lerp( SAMPLE_TEXTURE2D( _OcclusionMap, sampler_trilinear_repeat, CUSTOM_UV1263_g1 ) , temp_cast_37 , (float)_OcclusionSourceMode);
			float4 lerpResult29_g1 = lerp( temp_cast_36 , lerpResult39_g1 , _OcclusionStrengthAO);
			float4 OCCLUSION_IN49_g3192 = lerpResult29_g1;
			s54_g3192.Occlusion = OCCLUSION_IN49_g3192.x;

			data.light = gi.light;

			UnityGI gi54_g3192 = gi;
			#ifdef UNITY_PASS_FORWARDBASE
			Unity_GlossyEnvironmentData g54_g3192 = UnityGlossyEnvironmentSetup( s54_g3192.Smoothness, data.worldViewDir, s54_g3192.Normal, float3(0,0,0));
			gi54_g3192 = UnityGlobalIllumination( data, s54_g3192.Occlusion, s54_g3192.Normal, g54_g3192 );
			#endif

			float3 surfResult54_g3192 = LightingStandardSpecular ( s54_g3192, viewDir, gi54_g3192 ).rgb;
			surfResult54_g3192 += s54_g3192.Emission;

			#ifdef UNITY_PASS_FORWARDADD//54_g3192
			surfResult54_g3192 -= s54_g3192.Emission;
			#endif//54_g3192
			c.rgb = surfResult54_g3192;
			c.a = OPACITY_IN148_g3192.x;
			clip( OPACITY_MASK_IN152_g3192.x - _MaskClipValue );
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
1982;67;1076;952;5996.718;3900.418;1.3;True;False
Node;AmplifyShaderEditor.FunctionNode;3038;-5510.185,-3495.996;Inherit;False;DECSF Master Map Cutout;5;;1;000f89ea707009441837de6c4e59b637;21,489,0,446,0,433,0,553,0,688,0,684,0,512,0,666,0,470,0,323,1,364,1,398,1,499,1,595,1,190,1,356,1,500,1,399,1,390,1,461,0,467,0;0;12;FLOAT3;189;FLOAT3;95;COLOR;100;COLOR;97;COLOR;99;FLOAT;403;FLOAT;96;FLOAT;600;FLOAT;480;FLOAT4;258;FLOAT4;259;FLOAT3;401
Node;AmplifyShaderEditor.FunctionNode;3035;-5139.166,-3620.699;Inherit;False;DECSF Module Emission;82;;3182;58d2647a47347ee4891854495f246dd8;0;1;72;FLOAT3;0,0,1;False;1;FLOAT4;2
Node;AmplifyShaderEditor.CommentaryNode;2820;-3940.45,-3907.181;Inherit;False;341.5028;250.4201;;5;202;2757;2786;2758;2760;DEBUG SETTINGS ;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2819;-3943.628,-4055.585;Inherit;False;352;119;;1;203;GLOBAL SETTINGS ;0.09433961,0.09433961,0.09433961,1;0;0
Node;AmplifyShaderEditor.FunctionNode;3006;-4816.022,-3517.216;Inherit;False;DECSF Module Toon Texture;66;;3184;0404cf29c555e01489ddf22920662251;0;2;14;FLOAT4;0,0,0,0;False;56;FLOAT3;1,1,1;False;1;FLOAT4;38
Node;AmplifyShaderEditor.FunctionNode;2999;-4787.607,-3161.225;Inherit;False;DECSF Module Wind;98;;3186;0c33ef2b38b405041aea041abb730ab8;10,230,1,242,1,164,1,202,1,196,1,220,1,310,0,308,0,289,0,309,0;0;1;FLOAT3;305
Node;AmplifyShaderEditor.FunctionNode;3036;-4816.744,-3615.579;Inherit;False;DECSF Module Highlight;73;;3190;0d70e226ee2a0634ba3a01f211d91aae;1,73,1;2;77;FLOAT4;0,0,0,0;False;104;FLOAT3;1,1,1;False;1;FLOAT4;80
Node;AmplifyShaderEditor.IntNode;2758;-3934.076,-3805.627;Inherit;False;Property;_ColorMask;Color Mask Mode;2;1;[Enum];Create;False;0;1;None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15;True;0;False;15;15;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;202;-3933.771,-3873.078;Inherit;False;Constant;_MaskClipValue;Mask Clip Value;64;1;[HideInInspector];Create;True;0;0;True;0;False;0.5;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;203;-3930.373,-4021.418;Inherit;False;Property;_CullMode;Cull Mode;4;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;1;Header(GLOBAL SETTINGS);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;2757;-3751.249,-3804.592;Inherit;False;Property;_ZTestMode;ZTest Mode;1;1;[Enum];Create;False;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;4;4;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;2786;-3933.689,-3735;Inherit;False;Property;_AlphatoCoverage;Alpha to Coverage;3;1;[Enum];Create;True;1;Option1;0;1;Off,0,On,1;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;2760;-3751.31,-3874.784;Inherit;False;Property;_ZWriteMode;ZWrite Mode;0;1;[Enum];Create;False;0;1;Off,0,On,1;True;2;Header(SHADER VERSION 1.0 STANDARD);Header(DEBUG SETTINGS);False;1;1;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;3032;-4474.319,-3220.757;Inherit;False;DECSF Module Outline;70;;3191;4da0d39180180e64ba9dd3482728a57e;1,15,1;2;14;FLOAT4;0,0,0,0;False;6;FLOAT3;0,0,0;False;1;FLOAT3;13
Node;AmplifyShaderEditor.FunctionNode;3051;-4469.422,-3526.188;Inherit;False;DECSF Module Custom Lighting;56;;3192;43bd29f4785fded42a0cee7fb1455076;8,180,1,177,1,178,1,176,1,179,1,175,1,61,1,174,1;10;40;FLOAT4;0,0,0,0;False;37;FLOAT4;0,0,0,0;False;38;FLOAT3;1,1,1;False;41;FLOAT4;0,0,0,0;False;42;FLOAT4;0,0,0,0;False;43;FLOAT4;0,0,0,0;False;147;FLOAT4;0,0,0,0;False;151;FLOAT4;0,0,0,0;False;161;FLOAT3;0,0,0;False;160;FLOAT3;0,0,0;False;3;FLOAT4;149;FLOAT4;154;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;1319;-3941.374,-3630.745;Float;False;True;-1;3;;200;0;CustomLighting;DEC/Custom Lighting/Custom Lighting Cutout Translucency;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;True;True;True;Back;0;True;2760;0;True;2757;False;0;False;-1;0;False;-1;False;3;Custom;0;True;True;-10;True;Opaque;;Transparent;ForwardOnly;14;all;True;True;True;True;0;True;2758;True;0;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;200;;-1;-1;-1;-1;1;NatureRendererInstancing=True;False;0;0;True;203;-1;0;True;202;5;Pragma;multi_compile_instancing;False;;Custom;Pragma;instancing_options procedural:SetupNatureRenderer forwardadd;False;;Custom;Pragma;multi_compile GPU_FRUSTUM_ON __;False;8ccd508f733f5f0418220eaf14ecdf81;Custom;Include;Nature Renderer.cginc;False;5d792e02fd6741e4cb63087f97979470;Custom;Pragma;multi_compile_local _ NATURE_RENDERER;False;;Custom;0;0;False;0.1;False;-1;0;True;2786;True;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3035;72;3038;95
WireConnection;3006;14;3038;189
WireConnection;3006;56;3038;95
WireConnection;3036;77;3035;2
WireConnection;3036;104;3038;95
WireConnection;3032;14;3038;96
WireConnection;3032;6;2999;305
WireConnection;3051;40;3036;80
WireConnection;3051;37;3006;38
WireConnection;3051;38;3038;95
WireConnection;3051;42;3038;97
WireConnection;3051;43;3038;99
WireConnection;3051;147;3038;96
WireConnection;3051;151;3038;600
WireConnection;3051;161;3038;258
WireConnection;3051;160;3038;259
WireConnection;1319;9;3051;149
WireConnection;1319;10;3051;154
WireConnection;1319;13;3051;0
WireConnection;1319;11;3032;13
ASEEND*/
//CHKSM=85C6F8D5A7D164B8B8C3396F5028A69B316CF379