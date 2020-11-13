// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DEC/Water/Water Lake"
{
	Properties
	{
		[Enum(Off,0,On,1)][Header(SHADER VERSION 1.0 STANDARD)][Header(DEBUG SETTINGS)]_ZWriteMode("ZWrite Mode", Int) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTest Mode", Int) = 4
		[Enum(None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15)]_ColorMask("Color Mask Mode", Int) = 15
		[Enum(Off,0,On,1)]_AlphatoCoverage("Alpha to Coverage", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)][Header(GLOBAL SETTINGS)]_CullMode("Cull Mode", Int) = 0
		[HDR][Header (COLOR TINT WATER LAYERS)]_ShorelineTint("Shoreline Tint", Color) = (0.2784314,0.4235294,0.4431373,1)
		_ShorelineDepth("Shoreline Depth", Range( 0 , 100)) = 40
		_ShorelineOffset("Shoreline Offset", Range( -1 , 1)) = 0.1
		[HDR]_MidwaterTint("Midwater Tint", Color) = (0.1490196,0.4235294,0.4705882,1)
		[HDR]_DepthTint("Depth Tint", Color) = (0.1960784,0.4313726,0.509804,1)
		_DepthOffset("Depth Offset", Range( 0 , 10)) = 2
		[Header (OPACITY)]_Opacity("Opacity", Range( 0.001 , 1)) = 0.05
		_OpacityShoreline("Opacity Shoreline", Range( 0 , 25)) = 2
		[Enum(Standard,0,Geometric,1)][Header (SMOOTHNESS)]_SmoothnessModeWater("Smoothness Mode", Int) = 0
		[Enum(Standard,0,Cull Front,1,Cull Back,2)]_SmoothnessCullModeWater("Smoothness Cull Mode", Int) = 2
		_SmoothnessStrength("Smoothness Strength", Range( 0 , 1)) = 0.1
		_SmoothnessThreshold("Smoothness Threshold", Range( 0 , 0.5)) = 0
		_SmoothnessVariance("Smoothness Variance", Range( 0 , 1)) = 0.2
		_SmoothnessFresnel("Smoothness Fresnel", Range( 0 , 1)) = 1
		_SmoothnessBias("Smoothness Bias", Range( 0 , 1)) = 0
		_SmoothnessScale("Smoothness Scale", Range( 0 , 1)) = 1
		_SmoothnessPower("Smoothness Power", Range( 0 , 10)) = 5
		[Header (REFRACTION)]_RefractionScale("Refraction Scale", Range( 0 , 1)) = 0.2
		[Enum(Off,0,Swirling,1)][Header (NORMAL MAP)]_FlowDirectionNormal("Flow Direction Mode", Int) = 1
		[NoScaleOffset][Normal][SingleLineTexture]_BumpMap("Normal Map", 2D) = "bump" {}
		[Enum(Standard,0,Scale Independent,1)]_NormalMapTillingMode("Normal Map Tilling Mode", Int) = 0
		_NormalMapTilingX("Normal Map Tiling X", Float) = 10
		_NormalMapTilingY("Normal Map Tiling Y", Float) = 10
		_NormalMapStrength("Normal Map Strength", Range( 0 , 1)) = 0.9
		_NormalMapSpeed("Normal Map Speed", Range( 0 , 250)) = 2
		_NormalMapTimescale("Normal Map Timescale", Range( 0 , 1)) = 0.6
		[Enum(Off,0,Swirling,1)][Header (FOAM SHORELINE)]_FlowDirectionShoreline("Flow Direction Mode", Int) = 1
		[HDR]_ShorelineFoamTint("Shoreline Foam Tint", Color) = (1,1,1,0)
		[SingleLineTexture]_ShorelineFoamMap("Shoreline Foam Map", 2D) = "white" {}
		[Enum(Standard,0,Scale Independent,1)]_ShorelineFoamTillingMode("Shoreline Foam Tilling Mode", Int) = 0
		_ShorelineFoamTilingX("Shoreline Foam Tiling X", Float) = 10
		_ShorelineFoamTilingY("Shoreline Foam Tiling Y", Float) = 10
		_ShorelineFoamStrength("Shoreline Foam Strength", Range( 0 , 1)) = 1
		_ShorelineFoamDistance("Shoreline Foam Distance", Range( 0.3 , 100)) = 92.07362
		_ShorelineFoamSpeed("Shoreline Foam Speed", Range( 0 , 250)) = 80
		_ShorelineFoamTimescale("Shoreline Foam Timescale", Range( 0 , 1)) = 0.6
		[Enum(Off,0,Swirling,1)][Header (FOAM OFFSHORE)]_FlowDirectionOffshore("Flow Direction Mode", Int) = 1
		[HDR]_OffshoreFoamTint("Offshore Foam Tint ", Color) = (1,1,1,0)
		[SingleLineTexture]_OffshoreFoamMap("Offshore Foam Map ", 2D) = "white" {}
		[Enum(Standard,0,Scale Independent,1)]_OffshoreFoamTillingMode("Offshore Foam Tilling Mode", Int) = 0
		_OffshoreFoamTilingX("Offshore Foam Tiling X", Float) = 10
		_OffshoreFoamTilingY("Offshore Foam Tiling Y", Float) = 10
		[Gamma]_OffshoreFoamStrength("Offshore Foam Strength", Range( 0 , 1)) = 1
		_OffshoreFoamDistance("Offshore Foam Distance", Range( 0.1 , 100)) = 60
		_OffshoreFoamSpeed("Offshore Foam Speed", Range( 0 , 250)) = 80
		_OffshoreFoamTimescale("Offshore Foam Timescale", Range( 0 , 1)) = 0.6
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord4( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent-20" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" }
		LOD 200
		Cull [_CullMode]
		ZWrite [_ZWriteMode]
		ZTest [_ZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		
		AlphaToMask [_AlphatoCoverage]
		ColorMask [_ColorMask]
		GrabPass{ }
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 4.6
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
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

		#pragma surface surf Standard keepalpha noshadow noinstancing  
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv4_texcoord4;
			float2 uv_texcoord;
			float4 screenPos;
			float3 worldPos;
			float4 vertexColor : COLOR;
			half ASEVFace : VFACE;
		};

		uniform int _ZTestMode;
		uniform int _CullMode;
		uniform int _ZWriteMode;
		uniform int _ColorMask;
		uniform float _AlphatoCoverage;
		uniform int _FlowDirectionNormal;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		uniform float _NormalMapTimescale;
		uniform float _NormalMapSpeed;
		uniform int _NormalMapTillingMode;
		uniform float _NormalMapTilingX;
		uniform float _NormalMapTilingY;
		SamplerState sampler_trilinear_repeat;
		uniform float _NormalMapStrength;
		uniform int _FlowDirectionOffshore;
		uniform float4 _OffshoreFoamTint;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_OffshoreFoamMap);
		uniform float _OffshoreFoamTimescale;
		uniform float _OffshoreFoamSpeed;
		uniform int _OffshoreFoamTillingMode;
		uniform float _OffshoreFoamTilingX;
		uniform float _OffshoreFoamTilingY;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _OffshoreFoamDistance;
		uniform float _OffshoreFoamStrength;
		uniform int _FlowDirectionShoreline;
		uniform float4 _ShorelineFoamTint;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_ShorelineFoamMap);
		uniform float _ShorelineFoamTimescale;
		uniform float _ShorelineFoamSpeed;
		uniform int _ShorelineFoamTillingMode;
		uniform float _ShorelineFoamTilingX;
		uniform float _ShorelineFoamTilingY;
		uniform float _ShorelineFoamDistance;
		uniform float _ShorelineFoamStrength;
		uniform float4 _DepthTint;
		uniform float4 _ShorelineTint;
		uniform float4 _MidwaterTint;
		uniform float _ShorelineDepth;
		uniform float _ShorelineOffset;
		uniform float _DepthOffset;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform float _RefractionScale;
		uniform float _OpacityShoreline;
		uniform float _Opacity;
		uniform int _SmoothnessCullModeWater;
		uniform int _SmoothnessModeWater;
		uniform float _SmoothnessStrength;
		uniform float _SmoothnessVariance;
		uniform float _SmoothnessThreshold;
		uniform float _SmoothnessBias;
		uniform float _SmoothnessScale;
		uniform float _SmoothnessPower;
		uniform float _SmoothnessFresnel;


		float2 AlignWithGrabTexel( float2 uv )
		{
			#if UNITY_UV_STARTS_AT_TOP
			if (_CameraDepthTexture_TexelSize.y < 0) {
				uv.y = 1 - uv.y;
			}
			#endif
			return (floor(uv * _CameraDepthTexture_TexelSize.zw) + 0.5) * abs(_CameraDepthTexture_TexelSize.xy);
		}


		void ResetAlpha( Input SurfaceIn, SurfaceOutputStandard SurfaceOut, inout fixed4 FinalColor )
		{
			FinalColor.a = 1;
		}


		float4 CalculateObliqueFrustumCorrection(  )
		{
			float x1 = -UNITY_MATRIX_P._31 / (UNITY_MATRIX_P._11 * UNITY_MATRIX_P._34);
			float x2 = -UNITY_MATRIX_P._32 / (UNITY_MATRIX_P._22 * UNITY_MATRIX_P._34);
			return float4(x1, x2, 0, UNITY_MATRIX_P._33 / UNITY_MATRIX_P._34 + x1 * UNITY_MATRIX_P._13 + x2 * UNITY_MATRIX_P._23);
		}


		float CorrectedLinearEyeDepth( float z, float correctionFactor )
		{
			return 1.f / (z / UNITY_MATRIX_P._34 + correctionFactor);
		}


		float2 float2switch963_g11( int m_switch, float2 m_Standard, float2 m_Scale )
		{
			if(m_switch == 0)
				return m_Standard;
			if(m_switch == 1)
				return m_Scale;
			return m_Standard;
		}


		float3 float3switch932_g11( int m_switch, float3 m_Off, float3 m_Swirling )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Swirling;
			return m_Swirling;
		}


		float2 float2switch1015_g11( int m_switch, float2 m_Standard, float2 m_Scale )
		{
			if(m_switch == 0)
				return m_Standard;
			if(m_switch == 1)
				return m_Scale;
			return m_Standard;
		}


		float4 float4switch936_g11( int m_switch, float4 m_Off, float4 m_Swirling )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Swirling;
			return m_Swirling;
		}


		float2 float2switch989_g11( int m_switch, float2 m_Standard, float2 m_Scale )
		{
			if(m_switch == 0)
				return m_Standard;
			if(m_switch == 1)
				return m_Scale;
			return m_Standard;
		}


		float4 float4switch934_g11( int m_switch, float4 m_Off, float4 m_Swirling )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_Swirling;
			return m_Swirling;
		}


		float GetRefractedDepth55_g13( float3 tangentSpaceNormal, float4 screenPos, inout float2 uv )
		{
			float2 uvOffset = tangentSpaceNormal.xy;
			uvOffset.y *= _CameraDepthTexture_TexelSize.z * abs(_CameraDepthTexture_TexelSize.y);
			uv = AlignWithGrabTexel((screenPos.xy + uvOffset) / screenPos.w);
			float backgroundDepth = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv));
			float surfaceDepth = UNITY_Z_0_FAR_FROM_CLIPSPACE(screenPos.z);
			float depthDifference = backgroundDepth - surfaceDepth;
			uvOffset *= saturate(depthDifference);
			uv = AlignWithGrabTexel((screenPos.xy + uvOffset) / screenPos.w);
			backgroundDepth = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, uv));
			return depthDifference = backgroundDepth - surfaceDepth;
		}


		float4 float4switch1051_g11( int m_switch, float4 m_Standard, float4 m_Geometric )
		{
			if(m_switch == 0)
				return m_Standard;
			if(m_switch == 1)
				return m_Geometric;
			return m_Standard;
		}


		float3 float3switch1041_g11( int m_switch, float3 m_Standard, float3 m_Cullfront, float3 m_Cullback )
		{
			if(m_switch == 0)
				return m_Standard;
			if(m_switch == 1)
				return m_Cullfront;
			if(m_switch == 2)
				return m_Cullback;
			return m_Cullback;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			int m_switch932_g11 = _FlowDirectionNormal;
			float3 m_Off932_g11 = float3( 0,0,0 );
			float mulTime863_g11 = _Time.y * _NormalMapTimescale;
			float temp_output_849_0_g11 = ( _NormalMapSpeed * 0.0006 );
			float2 temp_cast_0 = (temp_output_849_0_g11).xx;
			int m_switch963_g11 = _NormalMapTillingMode;
			float2 appendResult947_g11 = (float2(_NormalMapTilingX , _NormalMapTilingY));
			float2 TEXTURE_TILLING_Normal959_g11 = appendResult947_g11;
			float2 m_Standard963_g11 = TEXTURE_TILLING_Normal959_g11;
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float3 break939_g11 = ase_parentObjectScale;
			float2 appendResult941_g11 = (float2(break939_g11.z , break939_g11.y));
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float3 normalizeResult957_g11 = normalize( ase_vertexNormal );
			float3 break948_g11 = normalizeResult957_g11;
			float2 appendResult940_g11 = (float2(break939_g11.x , break939_g11.z));
			float2 appendResult953_g11 = (float2(break939_g11.x , break939_g11.y));
			float2 TEXTURE_TILLING_SCALE_Normal942_g11 = ( ( ( appendResult941_g11 * break948_g11.x ) + ( break948_g11.y * appendResult940_g11 ) + ( break948_g11.z * appendResult953_g11 ) ) * TEXTURE_TILLING_Normal959_g11 );
			float2 m_Scale963_g11 = TEXTURE_TILLING_SCALE_Normal942_g11;
			float2 localfloat2switch963_g11 = float2switch963_g11( m_switch963_g11 , m_Standard963_g11 , m_Scale963_g11 );
			float2 uv4_TexCoord844_g11 = i.uv4_texcoord4 * ( localfloat2switch963_g11 * float2( 2,2 ) );
			float2 _G_FlowSwirling2 = float2(2,4);
			float cos843_g11 = cos( _G_FlowSwirling2.x );
			float sin843_g11 = sin( _G_FlowSwirling2.x );
			float2 rotator843_g11 = mul( uv4_TexCoord844_g11 - float2( 0,0 ) , float2x2( cos843_g11 , -sin843_g11 , sin843_g11 , cos843_g11 )) + float2( 0,0 );
			float2 panner845_g11 = ( mulTime863_g11 * temp_cast_0 + rotator843_g11);
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float lerpResult1191_g11 = lerp( 0.0 , _NormalMapStrength , ase_normWorldNormal.y);
			float2 temp_cast_1 = (temp_output_849_0_g11).xx;
			float cos847_g11 = cos( _G_FlowSwirling2.y );
			float sin847_g11 = sin( _G_FlowSwirling2.y );
			float2 rotator847_g11 = mul( uv4_TexCoord844_g11 - float2( 0,0 ) , float2x2( cos847_g11 , -sin847_g11 , sin847_g11 , cos847_g11 )) + float2( 0,0 );
			float2 panner839_g11 = ( mulTime863_g11 * temp_cast_1 + rotator847_g11);
			float2 temp_cast_2 = (temp_output_849_0_g11).xx;
			float2 panner850_g11 = ( mulTime863_g11 * temp_cast_2 + uv4_TexCoord844_g11);
			float3 m_Swirling932_g11 = BlendNormals( UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, panner845_g11 ), lerpResult1191_g11 ) , ( UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, panner839_g11 ), lerpResult1191_g11 ) + UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, panner850_g11 ), lerpResult1191_g11 ) ) );
			float3 localfloat3switch932_g11 = float3switch932_g11( m_switch932_g11 , m_Off932_g11 , m_Swirling932_g11 );
			float4 appendResult486_g11 = (float4(1.0 , 0.0 , 1.0 , localfloat3switch932_g11.x));
			o.Normal = UnpackScaleNormal( appendResult486_g11, 0.15 );
			int m_switch936_g11 = _FlowDirectionOffshore;
			float4 m_Off936_g11 = float4( 0,0,0,0 );
			float mulTime920_g11 = _Time.y * _OffshoreFoamTimescale;
			float temp_output_908_0_g11 = ( _OffshoreFoamSpeed * 0.0006 );
			float2 temp_cast_4 = (temp_output_908_0_g11).xx;
			int m_switch1015_g11 = _OffshoreFoamTillingMode;
			float2 appendResult991_g11 = (float2(_OffshoreFoamTilingX , _OffshoreFoamTilingY));
			float2 TEXTURE_TILLING_Offshore996_g11 = appendResult991_g11;
			float2 m_Standard1015_g11 = TEXTURE_TILLING_Offshore996_g11;
			float3 break1001_g11 = ase_parentObjectScale;
			float2 appendResult1002_g11 = (float2(break1001_g11.z , break1001_g11.y));
			float3 normalizeResult1008_g11 = normalize( ase_vertexNormal );
			float3 break1007_g11 = normalizeResult1008_g11;
			float2 appendResult1000_g11 = (float2(break1001_g11.x , break1001_g11.z));
			float2 appendResult1005_g11 = (float2(break1001_g11.x , break1001_g11.y));
			float2 TEXTURE_TILLING_SCALE_Offshore1011_g11 = ( ( ( appendResult1002_g11 * break1007_g11.x ) + ( break1007_g11.y * appendResult1000_g11 ) + ( break1007_g11.z * appendResult1005_g11 ) ) * TEXTURE_TILLING_Offshore996_g11 );
			float2 m_Scale1015_g11 = TEXTURE_TILLING_SCALE_Offshore1011_g11;
			float2 localfloat2switch1015_g11 = float2switch1015_g11( m_switch1015_g11 , m_Standard1015_g11 , m_Scale1015_g11 );
			float2 uv_TexCoord912_g11 = i.uv_texcoord * ( localfloat2switch1015_g11 * float2( 2,2 ) );
			float2 _G_FlowSwirling4 = float2(2,4);
			float cos911_g11 = cos( _G_FlowSwirling4.x );
			float sin911_g11 = sin( _G_FlowSwirling4.x );
			float2 rotator911_g11 = mul( uv_TexCoord912_g11 - float2( 0,0 ) , float2x2( cos911_g11 , -sin911_g11 , sin911_g11 , cos911_g11 )) + float2( 0,0 );
			float2 panner914_g11 = ( mulTime920_g11 * temp_cast_4 + rotator911_g11);
			float2 temp_cast_5 = (temp_output_908_0_g11).xx;
			float cos913_g11 = cos( _G_FlowSwirling4.y );
			float sin913_g11 = sin( _G_FlowSwirling4.y );
			float2 rotator913_g11 = mul( uv_TexCoord912_g11 - float2( 0,0 ) , float2x2( cos913_g11 , -sin913_g11 , sin913_g11 , cos913_g11 )) + float2( 0,0 );
			float2 panner910_g11 = ( mulTime920_g11 * temp_cast_5 + rotator913_g11);
			float2 temp_cast_6 = (temp_output_908_0_g11).xx;
			float2 panner915_g11 = ( mulTime920_g11 * temp_cast_6 + uv_TexCoord912_g11);
			float4 m_Swirling936_g11 = ( float4( (_OffshoreFoamTint).rgb , 0.0 ) * ( SAMPLE_TEXTURE2D( _OffshoreFoamMap, sampler_trilinear_repeat, panner914_g11 ) + ( SAMPLE_TEXTURE2D( _OffshoreFoamMap, sampler_trilinear_repeat, panner910_g11 ) + SAMPLE_TEXTURE2D( _OffshoreFoamMap, sampler_trilinear_repeat, panner915_g11 ) ) ) );
			float4 localfloat4switch936_g11 = float4switch936_g11( m_switch936_g11 , m_Off936_g11 , m_Swirling936_g11 );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float clampDepth47_g11 = SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy );
			float z46_g11 = clampDepth47_g11;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 localCalculateObliqueFrustumCorrection63_g11 = CalculateObliqueFrustumCorrection();
			float dotResult59_g11 = dot( float4( ase_vertex3Pos , 0.0 ) , localCalculateObliqueFrustumCorrection63_g11 );
			float correctionFactor46_g11 = dotResult59_g11;
			float localCorrectedLinearEyeDepth46_g11 = CorrectedLinearEyeDepth( z46_g11 , correctionFactor46_g11 );
			float eyeDepth53_g11 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float temp_output_56_0_g11 = ( eyeDepth53_g11 - ase_screenPos.w );
			float temp_output_48_0_g11 = ( localCorrectedLinearEyeDepth46_g11 - abs( temp_output_56_0_g11 ) );
			float temp_output_49_0_g11 = saturate( temp_output_48_0_g11 );
			float GRAB_SCREEN_DEPTH_BEHIND80_g11 = temp_output_49_0_g11;
			float3 unityObjectToViewPos531_g11 = UnityObjectToViewPos( ase_vertex3Pos );
			float GRAB_SCREEN_DEPTH73_g11 = localCorrectedLinearEyeDepth46_g11;
			float temp_output_548_0_g11 = ( unityObjectToViewPos531_g11.z + GRAB_SCREEN_DEPTH73_g11 );
			float3 ase_worldPos = i.worldPos;
			float temp_output_55_0_g11 = saturate( ( 1.0 / distance( _WorldSpaceCameraPos , ase_worldPos ) ) );
			float GRAB_SCREEN_CLOSENESS83_g11 = temp_output_55_0_g11;
			float4 lerpResult537_g11 = lerp( float4( 0,0,0,0 ) , ( ( localfloat4switch936_g11 * GRAB_SCREEN_DEPTH_BEHIND80_g11 ) / 3.0 ) , saturate( ( ( ( temp_output_548_0_g11 - 0.001 ) * GRAB_SCREEN_CLOSENESS83_g11 ) / ( ( _OffshoreFoamDistance - 0.001 ) * GRAB_SCREEN_CLOSENESS83_g11 ) ) ));
			float4 lerpResult578_g11 = lerp( float4( 0,0,0,0 ) , lerpResult537_g11 , _OffshoreFoamStrength);
			float4 FOAM_OFFSHORE655_g11 = lerpResult578_g11;
			int m_switch934_g11 = _FlowDirectionShoreline;
			float4 m_Off934_g11 = float4( 0,0,0,0 );
			float mulTime877_g11 = _Time.y * _ShorelineFoamTimescale;
			float temp_output_888_0_g11 = ( _ShorelineFoamSpeed * 0.0006 );
			float2 temp_cast_10 = (temp_output_888_0_g11).xx;
			int m_switch989_g11 = _ShorelineFoamTillingMode;
			float2 appendResult981_g11 = (float2(_ShorelineFoamTilingX , _ShorelineFoamTilingY));
			float2 TEXTURE_TILLING_Shoreline982_g11 = appendResult981_g11;
			float2 m_Standard989_g11 = TEXTURE_TILLING_Shoreline982_g11;
			float3 break971_g11 = ase_parentObjectScale;
			float2 appendResult972_g11 = (float2(break971_g11.z , break971_g11.y));
			float3 normalizeResult978_g11 = normalize( ase_vertexNormal );
			float3 break977_g11 = normalizeResult978_g11;
			float2 appendResult970_g11 = (float2(break971_g11.x , break971_g11.z));
			float2 appendResult975_g11 = (float2(break971_g11.x , break971_g11.y));
			float2 TEXTURE_TILLING_SCALE_Shoreline980_g11 = ( ( ( appendResult972_g11 * break977_g11.x ) + ( break977_g11.y * appendResult970_g11 ) + ( break977_g11.z * appendResult975_g11 ) ) * TEXTURE_TILLING_Shoreline982_g11 );
			float2 m_Scale989_g11 = TEXTURE_TILLING_SCALE_Shoreline980_g11;
			float2 localfloat2switch989_g11 = float2switch989_g11( m_switch989_g11 , m_Standard989_g11 , m_Scale989_g11 );
			float2 uv_TexCoord893_g11 = i.uv_texcoord * ( localfloat2switch989_g11 * float2( 2,2 ) );
			float2 _G_FlowSwirling3 = float2(2,4);
			float cos892_g11 = cos( _G_FlowSwirling3.x );
			float sin892_g11 = sin( _G_FlowSwirling3.x );
			float2 rotator892_g11 = mul( uv_TexCoord893_g11 - float2( 0,0 ) , float2x2( cos892_g11 , -sin892_g11 , sin892_g11 , cos892_g11 )) + float2( 0,0 );
			float2 panner897_g11 = ( mulTime877_g11 * temp_cast_10 + rotator892_g11);
			float2 temp_cast_11 = (temp_output_888_0_g11).xx;
			float cos895_g11 = cos( _G_FlowSwirling3.y );
			float sin895_g11 = sin( _G_FlowSwirling3.y );
			float2 rotator895_g11 = mul( uv_TexCoord893_g11 - float2( 0,0 ) , float2x2( cos895_g11 , -sin895_g11 , sin895_g11 , cos895_g11 )) + float2( 0,0 );
			float2 panner891_g11 = ( mulTime877_g11 * temp_cast_11 + rotator895_g11);
			float2 temp_cast_12 = (temp_output_888_0_g11).xx;
			float2 panner898_g11 = ( mulTime877_g11 * temp_cast_12 + uv_TexCoord893_g11);
			float4 m_Swirling934_g11 = ( float4( (_ShorelineFoamTint).rgb , 0.0 ) * ( SAMPLE_TEXTURE2D( _ShorelineFoamMap, sampler_trilinear_repeat, panner897_g11 ) + ( SAMPLE_TEXTURE2D( _ShorelineFoamMap, sampler_trilinear_repeat, panner891_g11 ) + SAMPLE_TEXTURE2D( _ShorelineFoamMap, sampler_trilinear_repeat, panner898_g11 ) ) ) );
			float4 localfloat4switch934_g11 = float4switch934_g11( m_switch934_g11 , m_Off934_g11 , m_Swirling934_g11 );
			float3 unityObjectToViewPos561_g11 = UnityObjectToViewPos( ase_vertex3Pos );
			float temp_output_565_0_g11 = ( unityObjectToViewPos561_g11.z + GRAB_SCREEN_DEPTH73_g11 );
			float4 lerpResult511_g11 = lerp( ( localfloat4switch934_g11 * GRAB_SCREEN_DEPTH_BEHIND80_g11 ) , float4( 0,0,0,0 ) , saturate( ( ( ( temp_output_565_0_g11 - 0.2237944 ) * GRAB_SCREEN_CLOSENESS83_g11 ) / ( ( _ShorelineFoamDistance - 0.2237944 ) * GRAB_SCREEN_CLOSENESS83_g11 ) ) ));
			float4 lerpResult552_g11 = lerp( float4( 0,0,0,0 ) , lerpResult511_g11 , _ShorelineFoamStrength);
			float4 FOAM_SHORELINE654_g11 = lerpResult552_g11;
			float screenDepth1198_g11 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth1198_g11 = abs( ( screenDepth1198_g11 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _ShorelineDepth ) );
			float4 lerpResult25_g11 = lerp( _ShorelineTint , _MidwaterTint , saturate( (distanceDepth1198_g11*1.0 + _ShorelineOffset) ));
			float4 lerpResult27_g11 = lerp( _DepthTint , lerpResult25_g11 , saturate( (distanceDepth1198_g11*-1.0 + _DepthOffset) ));
			float4 COLOR_TINT161_g11 = lerpResult27_g11;
			float REFACTED_SCALE_FLOAT78_g13 = _RefractionScale;
			float3 NORMAL_OUT_Z505_g11 = localfloat3switch932_g11;
			float3 NORMAL_IN84_g13 = NORMAL_OUT_Z505_g11;
			float3 tangentSpaceNormal55_g13 = ( REFACTED_SCALE_FLOAT78_g13 * NORMAL_IN84_g13 );
			float4 screenPos55_g13 = ase_screenPos;
			float2 uv55_g13 = _CameraDepthTexture_TexelSize.xy;
			float localGetRefractedDepth55_g13 = GetRefractedDepth55_g13( tangentSpaceNormal55_g13 , screenPos55_g13 , uv55_g13 );
			float2 uv61_g13 = uv55_g13;
			float2 localAlignWithGrabTexel61_g13 = AlignWithGrabTexel( uv61_g13 );
			float4 screenColor53_g13 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,localAlignWithGrabTexel61_g13);
			float4 REFRACTED_DEPTH144_g11 = screenColor53_g13;
			float temp_output_20_0_g11 = ( i.vertexColor.a * ( 1.0 - _Opacity ) );
			#ifdef UNITY_PASS_FORWARDADD
				float staticSwitch37_g11 = 0.0;
			#else
				float staticSwitch37_g11 = ( 1.0 - ( ( 1.0 - saturate( ( _OpacityShoreline * (distanceDepth1198_g11*-5.0 + 1.0) ) ) ) * temp_output_20_0_g11 ) );
			#endif
			float DEPTH_TINT_ALPHA93_g11 = staticSwitch37_g11;
			float4 lerpResult105_g11 = lerp( COLOR_TINT161_g11 , REFRACTED_DEPTH144_g11 , DEPTH_TINT_ALPHA93_g11);
			o.Albedo = ( ( FOAM_OFFSHORE655_g11 + FOAM_SHORELINE654_g11 ) + lerpResult105_g11 ).xyz;
			int m_switch1041_g11 = _SmoothnessCullModeWater;
			int m_switch1051_g11 = _SmoothnessModeWater;
			float2 uv_BumpMap870_g11 = i.uv_texcoord;
			float3 NORMAL_WORLD_OUT506_g11 = normalize( (WorldNormalVector( i , UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, uv_BumpMap870_g11 ), lerpResult1191_g11 ) )) );
			float3 temp_output_1106_0_g11 = ddx( NORMAL_WORLD_OUT506_g11 );
			float dotResult1088_g11 = dot( temp_output_1106_0_g11 , temp_output_1106_0_g11 );
			float3 temp_output_1087_0_g11 = ddy( NORMAL_WORLD_OUT506_g11 );
			float dotResult1114_g11 = dot( temp_output_1087_0_g11 , temp_output_1087_0_g11 );
			float temp_output_1102_0_g11 = sqrt( saturate( ( ( _SmoothnessStrength * _SmoothnessStrength ) + min( ( ( _SmoothnessVariance * ( dotResult1088_g11 + dotResult1114_g11 ) ) * 2.0 ) , ( _SmoothnessThreshold * _SmoothnessThreshold ) ) ) ) );
			float3 NORMAL_OUT504_g11 = UnpackScaleNormal( appendResult486_g11, 0.15 );
			float4 m_Standard1051_g11 = float4( ( min( temp_output_1102_0_g11 , 0.5 ) * ( 1.0 - ( NORMAL_OUT504_g11 * float3( 0.79,0.79,0.79 ) ) ) ) , 0.0 );
			float4 m_Geometric1051_g11 = float4( ( temp_output_1102_0_g11 * ( 1.0 - NORMAL_OUT504_g11 ) ) , 0.0 );
			float4 localfloat4switch1051_g11 = float4switch1051_g11( m_switch1051_g11 , m_Standard1051_g11 , m_Geometric1051_g11 );
			float3 m_Standard1041_g11 = localfloat4switch1051_g11.xyz;
			float4 switchResult1059_g11 = (((i.ASEVFace>0)?(localfloat4switch1051_g11):(float4( 0,0,0,0 ))));
			float3 m_Cullfront1041_g11 = switchResult1059_g11.xyz;
			float4 switchResult1037_g11 = (((i.ASEVFace>0)?(float4( 1,0,0,0 )):(localfloat4switch1051_g11)));
			float3 m_Cullback1041_g11 = switchResult1037_g11.xyz;
			float3 localfloat3switch1041_g11 = float3switch1041_g11( m_switch1041_g11 , m_Standard1041_g11 , m_Cullfront1041_g11 , m_Cullback1041_g11 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float fresnelNdotV1036_g11 = dot( NORMAL_WORLD_OUT506_g11, ase_worldlightDir );
			float fresnelNode1036_g11 = ( _SmoothnessBias + _SmoothnessScale * pow( max( 1.0 - fresnelNdotV1036_g11 , 0.0001 ), _SmoothnessPower ) );
			float clampResult1060_g11 = clamp( fresnelNode1036_g11 , 0.0 , 1.0 );
			float3 lerpResult1043_g11 = lerp( localfloat3switch1041_g11 , float3( 0,0,0 ) , ( clampResult1060_g11 * ( 1.0 - _SmoothnessFresnel ) ));
			o.Smoothness = lerpResult1043_g11.x;
			o.Alpha = 1;
		}

		ENDCG
	}
}
/*ASEBEGIN
Version=18502
2149;77;1522;946;645.7454;3268.422;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;844;199.208,-3064.666;Inherit;False;347.5028;191.4201;;4;698;700;697;894;DEBUG SETTINGS ;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;843;196.0305,-3214.07;Inherit;False;352;119;;1;207;GLOBAL SETTINGS ;0.09433961,0.09433961,0.09433961,1;0;0
Node;AmplifyShaderEditor.IntNode;207;211.0131,-3177.746;Float;False;Property;_CullMode;Cull Mode;5;1;[Enum];Create;True;0;1;UnityEngine.Rendering.CullMode;True;1;Header(GLOBAL SETTINGS);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;700;386.1788,-3024.381;Inherit;False;Property;_ZWriteMode;ZWrite Mode;0;1;[Enum];Create;False;0;1;Off,0,On,1;True;2;Header(SHADER VERSION 1.0 STANDARD);Header(DEBUG SETTINGS);False;1;1;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;698;205.3818,-3024.394;Inherit;False;Property;_ColorMask;Color Mask Mode;3;1;[Enum];Create;False;0;1;None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15;True;0;False;15;15;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;697;400.4021,-2951.943;Inherit;False;Property;_ZTestMode;ZTest Mode;1;1;[Enum];Create;False;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;4;4;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;894;209.2546,-2952.422;Inherit;False;Property;_AlphatoCoverage;Alpha to Coverage;4;1;[Enum];Create;False;1;Option1;0;1;Off,0,On,1;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;893;-132.8823,-2870.492;Inherit;False;DECSF Master Map Water Standard;6;;11;e9180da13cd3dd44380a8c2f4a746da6;0;0;3;FLOAT4;0;FLOAT3;123;FLOAT3;122
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;198.1309,-2867.459;Float;False;True;-1;6;;200;0;Standard;DEC/Water/Water Lake;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;True;True;True;False;Back;0;True;700;0;True;697;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;-20;True;Opaque;;Transparent;All;14;all;True;True;True;True;0;True;698;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;18;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;200;;2;-1;-1;-1;0;True;0;0;True;207;-1;0;False;-1;0;1;;0;False;0.1;False;-1;0;True;894;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;0;0;893;0
WireConnection;0;1;893;123
WireConnection;0;4;893;122
ASEEND*/
//CHKSM=9678C2A33435059EE5E279821DB5ACDF02045A2A