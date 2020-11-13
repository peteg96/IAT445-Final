// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DEC/Surface/Surface Detail Displacement Tessellation"
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
		[Enum(Off,0,Active,1)][Header(DISPLACEMENT)]_Displacement_Mode("Displacement Mode", Int) = 0
		[NoScaleOffset][SingleLineTexture]_ParallaxMap("Displacement Map", 2D) = "white" {}
		_DisplacementStrength("Displacement Strength", Range( 0 , 1)) = 0.00125
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
		[Enum(Off,0,Active,1)][Header(TESSELLATION )]_TessellationMode("Tessellation Mode", Int) = 0
		_TessellationStrength("Tessellation Strength", Range( 0.001 , 100)) = 6
		_TessellationDistanceMin("Tessellation Distance Min", Float) = 0
		_TessellationDistanceMax("Tessellation Distance Max ", Float) = 5
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
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
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

		#pragma surface surf Standard keepalpha addshadow fullforwardshadows dithercrossfade vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
			float2 uv2_texcoord2;
			float4 vertexColor : COLOR;
			float3 worldPos;
		};

		uniform int _CullMode;
		uniform int _ColorMask;
		uniform int _ZTestMode;
		uniform int _ZWriteMode;
		uniform int _Displacement_Mode;
		uniform half _DisplacementStrength;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_ParallaxMap);
		uniform int _Mian_UVSet;
		uniform int _TillingMode;
		uniform float _TilingX;
		uniform float _TilingY;
		uniform float _OffsetX;
		uniform float _OffsetY;
		SamplerState sampler_trilinear_repeat;
		uniform int _EnableDetailMap;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
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
		uniform int _TessellationMode;
		uniform half _TessellationDistanceMin;
		uniform half _TessellationDistanceMax;
		uniform half _TessellationStrength;


		float2 float2switch214_g3273( int m_switch, float2 m_Standard, float2 m_Scale )
		{
			if(m_switch == 0)
				return m_Standard;
			if(m_switch == 1)
				return m_Scale;
			return m_Standard;
		}


		float2 float2UVswitch379_g3273( int m_switch, float2 m_UV0, float2 m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		float4 float4switch361_g3273( int m_switch, float4 m_Off, float4 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float2 float2switch393_g3273( int m_switch, float2 m_Standard, float2 m_Scale )
		{
			if(m_switch == 0)
				return m_Standard;
			if(m_switch == 1)
				return m_Scale;
			return m_Standard;
		}


		float2 float2UVswitch395_g3273( int m_switch, float2 m_UV0, float2 m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		float2 float2UVswitch401_g3273( int m_switch, float2 m_UV0, float2 m_UV1 )
		{
			if(m_switch == 0)
				return m_UV0;
			if(m_switch == 1)
				return m_UV1;
			return m_UV0;
		}


		float3 float3switch467_g3273( int m_switch, float3 m_Off, float3 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float3 float3switch502_g3273( int m_switch, float3 m_Off, float3 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float4 float4switch476_g3273( int m_switch, float4 m_Off, float4 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float4 float4switch506_g3273( int m_switch, float4 m_Off, float4 m_Active )
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


		float4 float4switch457( int m_switch, float4 m_Off, float4 m_Active )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Active;
			return m_Off;
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			int m_switch457 = _TessellationMode;
			float4 temp_cast_4 = (0.001).xxxx;
			float4 m_Off457 = temp_cast_4;
			float4 m_Active457 = UnityDistanceBasedTess( v0.vertex, v1.vertex, v2.vertex, _TessellationDistanceMin,_TessellationDistanceMax,_TessellationStrength);
			float4 localfloat4switch457 = float4switch457( m_switch457 , m_Off457 , m_Active457 );
			return localfloat4switch457;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			int m_switch361_g3273 = _Displacement_Mode;
			float4 temp_cast_0 = (0.0).xxxx;
			float4 m_Off361_g3273 = temp_cast_0;
			int UV_SET_MAIN381_g3273 = _Mian_UVSet;
			int m_switch379_g3273 = UV_SET_MAIN381_g3273;
			int TILLING_MODE190_g3273 = _TillingMode;
			int m_switch214_g3273 = TILLING_MODE190_g3273;
			float2 appendResult192_g3273 = (float2(_TilingX , _TilingY));
			float2 TEXTURE_TILLING200_g3273 = appendResult192_g3273;
			float2 m_Standard214_g3273 = TEXTURE_TILLING200_g3273;
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 break206_g3273 = ase_parentObjectScale;
			float2 appendResult205_g3273 = (float2(break206_g3273.z , break206_g3273.y));
			float3 ase_vertexNormal = v.normal.xyz;
			float3 normalizeResult194_g3273 = normalize( ase_vertexNormal );
			float3 break201_g3273 = normalizeResult194_g3273;
			float2 appendResult204_g3273 = (float2(break206_g3273.x , break206_g3273.z));
			float2 appendResult193_g3273 = (float2(break206_g3273.x , break206_g3273.y));
			float2 TEXTURE_TILLING_SCALE210_g3273 = ( ( ( appendResult205_g3273 * break201_g3273.x ) + ( break201_g3273.y * appendResult204_g3273 ) + ( break201_g3273.z * appendResult193_g3273 ) ) * TEXTURE_TILLING200_g3273 );
			float2 m_Scale214_g3273 = TEXTURE_TILLING_SCALE210_g3273;
			float2 localfloat2switch214_g3273 = float2switch214_g3273( m_switch214_g3273 , m_Standard214_g3273 , m_Scale214_g3273 );
			float2 appendResult166_g3273 = (float2(_OffsetX , _OffsetY));
			float2 uv_TexCoord165_g3273 = v.texcoord.xy * localfloat2switch214_g3273 + appendResult166_g3273;
			float2 m_UV0379_g3273 = uv_TexCoord165_g3273;
			float2 uv2_TexCoord383_g3273 = v.texcoord1.xy * localfloat2switch214_g3273 + appendResult166_g3273;
			float2 m_UV1379_g3273 = uv2_TexCoord383_g3273;
			float2 localfloat2UVswitch379_g3273 = float2UVswitch379_g3273( m_switch379_g3273 , m_UV0379_g3273 , m_UV1379_g3273 );
			float2 CUSTOM_UV1179_g3273 = localfloat2UVswitch379_g3273;
			float4 m_Active361_g3273 = ( _DisplacementStrength * ( SAMPLE_TEXTURE2D_LOD( _ParallaxMap, sampler_trilinear_repeat, CUSTOM_UV1179_g3273, 1.0 ) * float4( ase_vertexNormal , 0.0 ) ) );
			float4 localfloat4switch361_g3273 = float4switch361_g3273( m_switch361_g3273 , m_Off361_g3273 , m_Active361_g3273 );
			v.vertex.xyz += localfloat4switch361_g3273.xyz;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			int SURFACE_MAP_MODE456_g3273 = _EnableDetailMap;
			int m_switch502_g3273 = SURFACE_MAP_MODE456_g3273;
			int UV_SET_MAIN381_g3273 = _Mian_UVSet;
			int m_switch379_g3273 = UV_SET_MAIN381_g3273;
			int TILLING_MODE190_g3273 = _TillingMode;
			int m_switch214_g3273 = TILLING_MODE190_g3273;
			float2 appendResult192_g3273 = (float2(_TilingX , _TilingY));
			float2 TEXTURE_TILLING200_g3273 = appendResult192_g3273;
			float2 m_Standard214_g3273 = TEXTURE_TILLING200_g3273;
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 break206_g3273 = ase_parentObjectScale;
			float2 appendResult205_g3273 = (float2(break206_g3273.z , break206_g3273.y));
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float3 normalizeResult194_g3273 = normalize( ase_vertexNormal );
			float3 break201_g3273 = normalizeResult194_g3273;
			float2 appendResult204_g3273 = (float2(break206_g3273.x , break206_g3273.z));
			float2 appendResult193_g3273 = (float2(break206_g3273.x , break206_g3273.y));
			float2 TEXTURE_TILLING_SCALE210_g3273 = ( ( ( appendResult205_g3273 * break201_g3273.x ) + ( break201_g3273.y * appendResult204_g3273 ) + ( break201_g3273.z * appendResult193_g3273 ) ) * TEXTURE_TILLING200_g3273 );
			float2 m_Scale214_g3273 = TEXTURE_TILLING_SCALE210_g3273;
			float2 localfloat2switch214_g3273 = float2switch214_g3273( m_switch214_g3273 , m_Standard214_g3273 , m_Scale214_g3273 );
			float2 appendResult166_g3273 = (float2(_OffsetX , _OffsetY));
			float2 uv_TexCoord165_g3273 = i.uv_texcoord * localfloat2switch214_g3273 + appendResult166_g3273;
			float2 m_UV0379_g3273 = uv_TexCoord165_g3273;
			float2 uv2_TexCoord383_g3273 = i.uv2_texcoord2 * localfloat2switch214_g3273 + appendResult166_g3273;
			float2 m_UV1379_g3273 = uv2_TexCoord383_g3273;
			float2 localfloat2UVswitch379_g3273 = float2UVswitch379_g3273( m_switch379_g3273 , m_UV0379_g3273 , m_UV1379_g3273 );
			float3 NORMAL_OUT23_g3273 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, localfloat2UVswitch379_g3273 ), _NormalStrength );
			float3 m_Off502_g3273 = NORMAL_OUT23_g3273;
			int EnableDetailMask428_g3273 = _EnableDetailMask;
			int m_switch467_g3273 = EnableDetailMask428_g3273;
			int UV_SET_DETAL397_g3273 = _Detail_UVSet;
			int m_switch395_g3273 = UV_SET_DETAL397_g3273;
			int TILLING_MODE_DETAIL435_g3273 = _TillingModeDetail;
			int m_switch393_g3273 = TILLING_MODE_DETAIL435_g3273;
			float2 appendResult432_g3273 = (float2(_DetailTilingXDetail , _DetailTilingYDetail));
			float2 TEXTURE_TILLING_DETAIL425_g3273 = appendResult432_g3273;
			float2 m_Standard393_g3273 = TEXTURE_TILLING_DETAIL425_g3273;
			float3 break420_g3273 = ase_parentObjectScale;
			float2 appendResult448_g3273 = (float2(break420_g3273.z , break420_g3273.y));
			float3 normalizeResult480_g3273 = normalize( ase_vertexNormal );
			float3 break431_g3273 = normalizeResult480_g3273;
			float2 appendResult426_g3273 = (float2(break420_g3273.x , break420_g3273.z));
			float2 appendResult433_g3273 = (float2(break420_g3273.x , break420_g3273.y));
			float2 TEXTURE_TILLING_SCALE_DETAIL427_g3273 = ( ( ( appendResult448_g3273 * break431_g3273.x ) + ( break431_g3273.y * appendResult426_g3273 ) + ( break431_g3273.z * appendResult433_g3273 ) ) * TEXTURE_TILLING_DETAIL425_g3273 );
			float2 m_Scale393_g3273 = TEXTURE_TILLING_SCALE_DETAIL427_g3273;
			float2 localfloat2switch393_g3273 = float2switch393_g3273( m_switch393_g3273 , m_Standard393_g3273 , m_Scale393_g3273 );
			float2 appendResult394_g3273 = (float2(_DetailOffsetXDetail , _DetailOffsetYDetail));
			float2 uv_TexCoord414_g3273 = i.uv_texcoord * localfloat2switch393_g3273 + appendResult394_g3273;
			float2 m_UV0395_g3273 = uv_TexCoord414_g3273;
			float2 uv2_TexCoord409_g3273 = i.uv2_texcoord2 * localfloat2switch393_g3273 + appendResult394_g3273;
			float2 m_UV1395_g3273 = uv2_TexCoord409_g3273;
			float2 localfloat2UVswitch395_g3273 = float2UVswitch395_g3273( m_switch395_g3273 , m_UV0395_g3273 , m_UV1395_g3273 );
			float3 NORMAL_OUT_DETAIL491_g3273 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _DetailNormalMap, sampler_trilinear_repeat, localfloat2UVswitch395_g3273 ), _DetailNormalMapScale );
			float3 m_Off467_g3273 = NORMAL_OUT_DETAIL491_g3273;
			int m_switch401_g3273 = UV_SET_DETAL397_g3273;
			float2 appendResult445_g3273 = (float2(_DetailTilingXDetailMask , _DetailTilingYDetailMask));
			float2 appendResult417_g3273 = (float2(_DetailOffsetXDetailMask , _DetailOffsetYDetailMask));
			float2 uv_TexCoord415_g3273 = i.uv_texcoord * appendResult445_g3273 + appendResult417_g3273;
			float2 m_UV0401_g3273 = uv_TexCoord415_g3273;
			float2 uv2_TexCoord447_g3273 = i.uv2_texcoord2 * appendResult445_g3273 + appendResult417_g3273;
			float2 m_UV1401_g3273 = uv2_TexCoord447_g3273;
			float2 localfloat2UVswitch401_g3273 = float2UVswitch401_g3273( m_switch401_g3273 , m_UV0401_g3273 , m_UV1401_g3273 );
			float4 tex2DNode418_g3273 = SAMPLE_TEXTURE2D( _DetailMaskMap, sampler_trilinear_repeat, localfloat2UVswitch401_g3273 );
			float3 lerpResult470_g3273 = lerp( NORMAL_OUT23_g3273 , NORMAL_OUT_DETAIL491_g3273 , tex2DNode418_g3273.r);
			float3 m_Active467_g3273 = saturate( lerpResult470_g3273 );
			float3 localfloat3switch467_g3273 = float3switch467_g3273( m_switch467_g3273 , m_Off467_g3273 , m_Active467_g3273 );
			float3 MASK_NORMAL_OUT469_g3273 = localfloat3switch467_g3273;
			float4 tex2DNode35_g3273 = SAMPLE_TEXTURE2D( _MainTex, sampler_trilinear_repeat, localfloat2UVswitch379_g3273 );
			float4 temp_output_159_0_g3273 = ( float4( (_Color).rgb , 0.0 ) * tex2DNode35_g3273 * _Brightness );
			float4 ALBEDO_OUT91_g3273 = temp_output_159_0_g3273;
			float4 break462_g3273 = ALBEDO_OUT91_g3273;
			float ALBEDO_IN_XYZ464_g3273 = ( break462_g3273.r + break462_g3273.g + break462_g3273.b );
			float clampResult486_g3273 = clamp( ( ( ( ( ALBEDO_IN_XYZ464_g3273 - 0.5 ) * ( _DetailBlendInfluence - 0.9 ) ) + ( i.vertexColor.r - ( _DetailBlendHeight - 0.4 ) ) ) / _DetailBlendSmooth ) , 0.0 , 1.0 );
			float DETAIL_BLEND396_g3273 = clampResult486_g3273;
			float3 lerpResult498_g3273 = lerp( MASK_NORMAL_OUT469_g3273 , NORMAL_OUT23_g3273 , DETAIL_BLEND396_g3273);
			float3 m_Active502_g3273 = saturate( lerpResult498_g3273 );
			float3 localfloat3switch502_g3273 = float3switch502_g3273( m_switch502_g3273 , m_Off502_g3273 , m_Active502_g3273 );
			o.Normal = localfloat3switch502_g3273;
			int m_switch506_g3273 = SURFACE_MAP_MODE456_g3273;
			float4 m_Off506_g3273 = ALBEDO_OUT91_g3273;
			int m_switch476_g3273 = EnableDetailMask428_g3273;
			float4 tex2DNode449_g3273 = SAMPLE_TEXTURE2D( _DetailAlbedoMap, sampler_trilinear_repeat, localfloat2UVswitch395_g3273 );
			float4 ALBEDO_OUT_DETAIL493_g3273 = ( _ColorDetail * tex2DNode449_g3273 * _DetailBrightness );
			float4 m_Off476_g3273 = ALBEDO_OUT_DETAIL493_g3273;
			float4 lerpResult477_g3273 = lerp( ALBEDO_OUT91_g3273 , ALBEDO_OUT_DETAIL493_g3273 , tex2DNode418_g3273.r);
			float4 m_Active476_g3273 = lerpResult477_g3273;
			float4 localfloat4switch476_g3273 = float4switch476_g3273( m_switch476_g3273 , m_Off476_g3273 , m_Active476_g3273 );
			float4 MASK_ALBEDO_OUT473_g3273 = localfloat4switch476_g3273;
			float4 lerpResult503_g3273 = lerp( MASK_ALBEDO_OUT473_g3273 , ALBEDO_OUT91_g3273 , DETAIL_BLEND396_g3273);
			float4 m_Active506_g3273 = lerpResult503_g3273;
			float4 localfloat4switch506_g3273 = float4switch506_g3273( m_switch506_g3273 , m_Off506_g3273 , m_Active506_g3273 );
			o.Albedo = localfloat4switch506_g3273.xyz;
			float2 CUSTOM_UV1179_g3273 = localfloat2UVswitch379_g3273;
			o.Metallic = ( _MetallicStrength * SAMPLE_TEXTURE2D( _Metal, sampler_trilinear_repeat, CUSTOM_UV1179_g3273 ) ).r;
			o.Smoothness = ( _SmoothnessStrength * SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_trilinear_repeat, CUSTOM_UV1179_g3273 ) ).r;
			float4 temp_cast_11 = (1.0).xxxx;
			float4 temp_cast_12 = (i.vertexColor.a).xxxx;
			float4 lerpResult134_g3273 = lerp( SAMPLE_TEXTURE2D( _OcclusionMap, sampler_trilinear_repeat, CUSTOM_UV1179_g3273 ) , temp_cast_12 , (float)_OcclusionSourceMode);
			float4 lerpResult135_g3273 = lerp( temp_cast_11 , lerpResult134_g3273 , _OcclusionStrengthAO);
			o.Occlusion = lerpResult135_g3273.r;
			float temp_output_7_0_g3274 = tex2DNode35_g3273.a;
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 ase_clipPos = ComputeScreenPos( UnityObjectToClipPos( ase_vertex4Pos ) );
			float2 clipScreen3_g3274 = ase_clipPos.xy * _ScreenParams.xy;
			float dither3_g3274 = Dither8x8Bayer( fmod(clipScreen3_g3274.x, 8), fmod(clipScreen3_g3274.y, 8) );
			dither3_g3274 = step( dither3_g3274, unity_LODFade.x );
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch5_g3274 = ( temp_output_7_0_g3274 * dither3_g3274 );
			#else
				float staticSwitch5_g3274 = temp_output_7_0_g3274;
			#endif
			o.Alpha = staticSwitch5_g3274;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18502
1966;54;1076;952;-285.7357;866.6401;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;451;323.4283,-417.0689;Inherit;False;958.192;281.1019;;7;453;452;454;456;458;457;455;Tessellation;0,0,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;453;352.7438,-219.9669;Half;False;Property;_TessellationDistanceMax;Tessellation Distance Max ;52;0;Create;False;0;0;False;0;False;5;2000;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;452;358.9274,-293.1461;Half;False;Property;_TessellationDistanceMin;Tessellation Distance Min;51;0;Create;False;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;454;338.4284,-368.361;Half;False;Property;_TessellationStrength;Tessellation Strength;50;0;Create;False;0;0;False;0;False;6;0.5;0.001;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;456;836.6835,-379.0689;Inherit;False;Property;_TessellationMode;Tessellation Mode;49;1;[Enum];Create;False;2;Off;0;Active;1;0;False;1;Header(TESSELLATION );False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.CommentaryNode;295;1376.783,-1041.665;Inherit;False;370;124;;1;294;GLOBAL SETTINGS ;0.09433961,0.09433961,0.09433961,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;458;886.1425,-254.0531;Inherit;False;Constant;_Float4;Float 4;53;1;[HideInInspector];Create;True;0;0;False;0;False;0.001;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;290;1386.96,-890.2607;Inherit;False;346.5028;193.4201;;4;291;293;292;353;DEBUG SETTINGS ;0,0,0,1;0;0
Node;AmplifyShaderEditor.DistanceBasedTessNode;455;627.3023,-318.868;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.IntNode;293;1574.695,-852.7178;Inherit;False;Property;_ZWriteMode;ZWrite Mode;0;1;[Enum];Create;False;0;1;Off,0,On,1;True;2;Header(SHADER VERSION 1.0 STANDARD);Header(DEBUG SETTINGS);False;1;1;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;294;1394.596,-1003.853;Inherit;False;Property;_CullMode;Cull Mode;3;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;1;Header(GLOBAL SETTINGS);False;0;2;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;353;1400.431,-777.1531;Inherit;False;Constant;_MaskClipValue1;Mask Clip Value;14;0;Create;True;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;291;1396.189,-848.5454;Inherit;False;Property;_ColorMask;Color Mask Mode;2;1;[Enum];Create;False;0;1;None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15;True;0;False;15;15;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;460;954.7002,-692.8051;Inherit;False;DECSF Master Map Surface;4;;3273;6c26b12be02413b47bab527585da6bf6;4,185,0,508,1,520,1,366,1;0;9;FLOAT4;106;FLOAT3;88;COLOR;115;COLOR;129;COLOR;116;FLOAT;181;FLOAT;144;FLOAT;318;FLOAT4;365
Node;AmplifyShaderEditor.CustomExpressionNode;457;1049.61,-367.965;Inherit;False;if(m_switch == 0)$	return m_Off@$if(m_switch == 1)$	return m_Active@$$return m_Off@;4;False;3;True;m_switch;INT;0;In;;Inherit;False;True;m_Off;FLOAT4;0,0,0,0;In;;Inherit;False;True;m_Active;FLOAT4;0,0,0,0;In;;Inherit;False;float4 switch ;True;False;0;3;0;INT;0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.IntNode;292;1575.167,-781.6187;Inherit;False;Property;_ZTestMode;ZTest Mode;1;1;[Enum];Create;False;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;4;4;False;0;1;INT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;194;1374.904,-680.6909;Float;False;True;-1;6;;200;0;Standard;DEC/Surface/Surface Detail Displacement Tessellation;False;False;False;False;False;False;False;False;False;False;False;False;True;False;True;False;False;False;True;True;True;Back;0;True;293;0;True;292;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;-10;True;Opaque;;Geometry;All;14;all;True;True;True;True;0;True;291;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;0;1;0;5;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;200;;-1;-1;-1;-1;1;NatureRendererInstancing=True;False;0;0;True;294;-1;0;True;353;5;Pragma;multi_compile_instancing;False;;Custom;Pragma;instancing_options procedural:SetupNatureRenderer forwardadd;False;;Custom;Pragma;multi_compile GPU_FRUSTUM_ON __;False;;Custom;Include;Nature Renderer.cginc;False;5d792e02fd6741e4cb63087f97979470;Custom;Pragma;multi_compile_local _ NATURE_RENDERER;False;;Custom;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;455;0;454;0
WireConnection;455;1;452;0
WireConnection;455;2;453;0
WireConnection;457;0;456;0
WireConnection;457;1;458;0
WireConnection;457;2;455;0
WireConnection;194;0;460;106
WireConnection;194;1;460;88
WireConnection;194;3;460;115
WireConnection;194;4;460;129
WireConnection;194;5;460;116
WireConnection;194;9;460;144
WireConnection;194;11;460;365
WireConnection;194;14;457;0
ASEEND*/
//CHKSM=21DEFA80CB49201986CBC8FDA869A956CFF169D2