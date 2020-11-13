// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DEC/Billboard Wind/Billboard Wind Vertex Simple"
{
	Properties
	{
		[Enum(Off,0,On,1)][Header(SHADER VERSION 1.0 STANDARD)][Header(DEBUG SETTINGS)]_ZWriteMode("ZWrite Mode", Int) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTest Mode", Int) = 4
		[Enum(None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15)]_ColorMask("Color Mask Mode", Int) = 15
		[Enum(Off,0,On,1)]_AlphatoCoverage("Alpha to Coverage", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)][Header(GLOBAL SETTINGS)]_CullMode("Cull Mode", Int) = 0
		[Enum(Off,0,Active,1)]_GlancingClipMode("Clip Glancing Angle Mode", Int) = 0
		[Header(MAP MAIN TEXTURE)]_Color("Albedo Tint", Color) = (1,1,1,1)
		[SingleLineTexture]_MainTex("Albedo Map", 2D) = "white" {}
		[Enum(UV0,0,UV1,1)]_BB_UVSet("UV Set", Int) = 0
		_Brightness("Brightness", Range( 0 , 2)) = 1.5
		_AlphaCutoffBias("Alpha Cutoff Bias", Range( 0 , 1)) = 0.5
		_TilingX("Tiling X", Float) = 1
		_TilingY("Tiling Y", Float) = 1
		_OffsetX("Offset X", Float) = 0
		_OffsetY("Offset Y", Float) = 0
		[NoScaleOffset][Normal][SingleLineTexture]_BumpMap("Normal Map", 2D) = "bump" {}
		_NormalStrength("Normal Strength", Float) = 1
		_MetallicStrength("Metallic Strength", Range( 0 , 1)) = 0
		[HideInInspector]_MaskClipValue("Mask Clip Value", Float) = 0.5
		_OcclusionStrengthAO("Occlusion Strength", Range( 0 , 1)) = 0.95
		_SmoothnessStrength("Smoothness Strength", Range( 0 , 1)) = 0
		[Enum(Off,0,Global,1,Local,2)][Header(WIND)]_WindMode("Wind Mode", Int) = 0
		[Header(WIND MODE GLOBAL)]_GlobalWindInfluenceBillboard("Wind Strength", Float) = 0.3
		[Header(WIND MODE LOCAL)]_LocalWindStrength("Wind Strength", Float) = 0.3
		_LocalWindPulse("Wind Pulse", Float) = 0.1
		_LocalWindDirection("Wind Direction", Float) = 1
		_LocalRandomWindOffset("Wind Random Offset", Float) = 0.2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
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
		#include "UnityCG.cginc"
		#pragma target 3.0
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
			float2 uv_texcoord;
			float2 uv2_texcoord2;
			float3 worldPos;
			float4 screenPosition;
		};

		uniform int _CullMode;
		uniform int _ColorMask;
		uniform float _AlphatoCoverage;
		uniform int _ZTestMode;
		uniform int _ZWriteMode;
		uniform int _WindMode;
		uniform int BillboardWindEnabled;
		uniform float _GlobalWindInfluenceBillboard;
		uniform float Billboard_WindStrength;
		uniform float _WindStrength;
		uniform float _LocalWindStrength;
		uniform float _RandomWindOffset;
		uniform float _LocalRandomWindOffset;
		uniform float _WindPulse;
		uniform float _LocalWindPulse;
		uniform float _WindDirection;
		uniform float _LocalWindDirection;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
		uniform int _BB_UVSet;
		uniform float _TilingX;
		uniform float _TilingY;
		uniform float _OffsetX;
		uniform float _OffsetY;
		SamplerState sampler_trilinear_repeat;
		uniform half _NormalStrength;
		uniform float4 _Color;
		UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
		uniform half _Brightness;
		uniform float _MetallicStrength;
		uniform float _SmoothnessStrength;
		uniform half _OcclusionStrengthAO;
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


		float3 float3switch234_g3021( int m_switch, float3 m_Off, float3 m_On )
		{
			if(m_switch == 0)
				return m_Off;
			if(m_switch == 1)
				return m_On;
			return m_Off;
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


		float2 float2UVswitch369_g3028( int m_switch, float2 m_UV0, float2 m_UV1 )
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


		float floatswitch263_g3028( int m_switch, float m_Off, float m_Active )
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
			int WindController383_g3021 = _WindMode;
			int m_switch394_g3021 = WindController383_g3021;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VAR_VERTEXPOSITION_MATRIX299_g3021 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 m_Off394_g3021 = VAR_VERTEXPOSITION_MATRIX299_g3021;
			int m_switch234_g3021 = BillboardWindEnabled;
			float3 m_Off234_g3021 = VAR_VERTEXPOSITION_MATRIX299_g3021;
			float3 break156_g3021 = VAR_VERTEXPOSITION_MATRIX299_g3021;
			int m_switch391_g3021 = _WindMode;
			float m_Off391_g3021 = 1.0;
			float GLOBAL_WINDINFLUENCEBILLBOARD344_g3021 = Billboard_WindStrength;
			float GLOBAL_WINDINFLUENCE340_g3021 = _WindStrength;
			float m_Global391_g3021 = ( ( _GlobalWindInfluenceBillboard * GLOBAL_WINDINFLUENCEBILLBOARD344_g3021 ) * GLOBAL_WINDINFLUENCE340_g3021 );
			float m_Local391_g3021 = _LocalWindStrength;
			float localfloatswitch391_g3021 = floatswitch( m_switch391_g3021 , m_Off391_g3021 , m_Global391_g3021 , m_Local391_g3021 );
			float VAR_WindStrength129_g3021 = localfloatswitch391_g3021;
			int m_switch117_g3021 = _WindMode;
			float m_Off117_g3021 = 1.0;
			float GLOBAL_RANDOMWINDOFFSET339_g3021 = _RandomWindOffset;
			float m_Global117_g3021 = GLOBAL_RANDOMWINDOFFSET339_g3021;
			float m_Local117_g3021 = _LocalRandomWindOffset;
			float localfloatswitch117_g3021 = floatswitch( m_switch117_g3021 , m_Off117_g3021 , m_Global117_g3021 , m_Local117_g3021 );
			float VAR_WindOffset76_g3021 = localfloatswitch117_g3021;
			float4 transform288_g3021 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult210_g3021 = (float2(transform288_g3021.x , transform288_g3021.z));
			float dotResult271_g3021 = dot( appendResult210_g3021 , float2( 12.9898,78.233 ) );
			float lerpResult44_g3021 = lerp( 0.8 , ( ( VAR_WindOffset76_g3021 / 2.0 ) + 0.9 ) , frac( ( sin( dotResult271_g3021 ) * 43758.55 ) ));
			float VAR_RandomTime191_g3021 = ( _Time.x * lerpResult44_g3021 );
			float FUNC_Turbulence296_g3021 = ( sin( ( ( VAR_RandomTime191_g3021 * 40.0 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3021.z / 15.0 ) ) ) * 0.5 );
			int m_switch387_g3021 = _WindMode;
			float m_Off387_g3021 = 1.0;
			float GLOBAL_WINDPULSE342_g3021 = _WindPulse;
			float m_Global387_g3021 = GLOBAL_WINDPULSE342_g3021;
			float m_Local387_g3021 = _LocalWindPulse;
			float localfloatswitch387_g3021 = floatswitch( m_switch387_g3021 , m_Off387_g3021 , m_Global387_g3021 , m_Local387_g3021 );
			float VAR_WindPulse264_g3021 = localfloatswitch387_g3021;
			float FUNC_Angle148_g3021 = ( VAR_WindStrength129_g3021 * ( 1.0 + sin( ( ( ( ( VAR_RandomTime191_g3021 * 2.0 ) + FUNC_Turbulence296_g3021 ) - ( VAR_VERTEXPOSITION_MATRIX299_g3021.z / 50.0 ) ) - ( v.color.r / 20.0 ) ) ) ) * sqrt( v.color.r ) * VAR_WindPulse264_g3021 );
			float VAR_SinA111_g3021 = sin( FUNC_Angle148_g3021 );
			float VAR_CosA243_g3021 = cos( FUNC_Angle148_g3021 );
			int m_switch389_g3021 = _WindMode;
			float m_Off389_g3021 = 1.0;
			float GLOBAL_WINDDIRECTION341_g3021 = _WindDirection;
			float m_Global389_g3021 = GLOBAL_WINDDIRECTION341_g3021;
			float m_Local389_g3021 = _LocalWindDirection;
			float localfloatswitch389_g3021 = floatswitch( m_switch389_g3021 , m_Off389_g3021 , m_Global389_g3021 , m_Local389_g3021 );
			float _WindDirection178_g3021 = localfloatswitch389_g3021;
			float2 localDirectionalEquation178_g3021 = DirectionalEquation( _WindDirection178_g3021 );
			float2 break74_g3021 = localDirectionalEquation178_g3021;
			float VAR_xLerp173_g3021 = break74_g3021.x;
			float lerpResult232_g3021 = lerp( break156_g3021.x , ( ( break156_g3021.y * VAR_SinA111_g3021 ) + ( break156_g3021.x * VAR_CosA243_g3021 ) ) , VAR_xLerp173_g3021);
			float3 break99_g3021 = VAR_VERTEXPOSITION_MATRIX299_g3021;
			float3 break201_g3021 = VAR_VERTEXPOSITION_MATRIX299_g3021;
			float VAR_zLerp206_g3021 = break74_g3021.y;
			float lerpResult104_g3021 = lerp( break201_g3021.z , ( ( break201_g3021.y * VAR_SinA111_g3021 ) + ( break201_g3021.z * VAR_CosA243_g3021 ) ) , VAR_zLerp206_g3021);
			float3 appendResult197_g3021 = (float3(lerpResult232_g3021 , ( ( break99_g3021.y * VAR_CosA243_g3021 ) - ( break99_g3021.z * VAR_SinA111_g3021 ) ) , lerpResult104_g3021));
			float3 FUNC_vertexPos132_g3021 = appendResult197_g3021;
			float3 m_On234_g3021 = FUNC_vertexPos132_g3021;
			float3 localfloat3switch234_g3021 = float3switch234_g3021( m_switch234_g3021 , m_Off234_g3021 , m_On234_g3021 );
			float3 m_Global394_g3021 = localfloat3switch234_g3021;
			float3 m_Local394_g3021 = FUNC_vertexPos132_g3021;
			float3 localfloat3switch394_g3021 = float3switch( m_switch394_g3021 , m_Off394_g3021 , m_Global394_g3021 , m_Local394_g3021 );
			float3 temp_output_261_0_g3021 = mul( unity_WorldToObject, float4( localfloat3switch394_g3021 , 0.0 ) ).xyz;
			float3 VAR_VERTEXPOSITION298_g3021 = ase_vertex3Pos;
			v.vertex.xyz += ( temp_output_261_0_g3021 - VAR_VERTEXPOSITION298_g3021 );
			v.vertex.w = 1;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			int UV_SET_BILLBOARD370_g3028 = _BB_UVSet;
			int m_switch369_g3028 = UV_SET_BILLBOARD370_g3028;
			float2 appendResult83_g3028 = (float2(_TilingX , _TilingY));
			float2 appendResult71_g3028 = (float2(_OffsetX , _OffsetY));
			float2 uv_TexCoord13_g3028 = i.uv_texcoord * appendResult83_g3028 + appendResult71_g3028;
			float2 m_UV0369_g3028 = uv_TexCoord13_g3028;
			float2 uv2_TexCoord367_g3028 = i.uv2_texcoord2 * appendResult83_g3028 + appendResult71_g3028;
			float2 m_UV1369_g3028 = uv2_TexCoord367_g3028;
			float2 localfloat2UVswitch369_g3028 = float2UVswitch369_g3028( m_switch369_g3028 , m_UV0369_g3028 , m_UV1369_g3028 );
			float3 NORMAL_OUT_01292_g3028 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, localfloat2UVswitch369_g3028 ), _NormalStrength );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 worldToViewDir283_g3028 = normalize( mul( UNITY_MATRIX_V, float4( ase_worldlightDir, 0 ) ).xyz );
			float dotResult280_g3028 = dot( NORMAL_OUT_01292_g3028 , worldToViewDir283_g3028 );
			float3 appendResult279_g3028 = (float3(dotResult280_g3028 , dotResult280_g3028 , dotResult280_g3028));
			o.Normal = ( UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, localfloat2UVswitch369_g3028 ), _NormalStrength ) + saturate( appendResult279_g3028 ) );
			float4 tex2DNode150_g3028 = SAMPLE_TEXTURE2D( _MainTex, sampler_trilinear_repeat, localfloat2UVswitch369_g3028 );
			float3 temp_output_55_0_g3028 = ( (_Color).rgb * (tex2DNode150_g3028).rgb * _Brightness );
			o.Albedo = temp_output_55_0_g3028;
			o.Metallic = _MetallicStrength;
			o.Smoothness = _SmoothnessStrength;
			o.Occlusion = _OcclusionStrengthAO;
			float ALBEDO_A366_g3028 = tex2DNode150_g3028.a;
			clip( ALBEDO_A366_g3028 - ( 1.0 - _AlphaCutoffBias ));
			float temp_output_7_0_g3030 = saturate( ( ( ALBEDO_A366_g3028 / max( fwidth( ALBEDO_A366_g3028 ) , 0.0001 ) ) + 0.5 ) );
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen3_g3030 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither3_g3030 = Dither8x8Bayer( fmod(clipScreen3_g3030.x, 8), fmod(clipScreen3_g3030.y, 8) );
			dither3_g3030 = step( dither3_g3030, unity_LODFade.x );
			#ifdef LOD_FADE_CROSSFADE
				float staticSwitch5_g3030 = ( temp_output_7_0_g3030 * dither3_g3030 );
			#else
				float staticSwitch5_g3030 = temp_output_7_0_g3030;
			#endif
			o.Alpha = staticSwitch5_g3030;
			int m_switch263_g3028 = _GlancingClipMode;
			float m_Off263_g3028 = 1.0;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult332_g3028 = normalize( cross( ddx( ase_worldPos ) , ddy( ase_worldPos ) ) );
			float dotResult317_g3028 = dot( ase_worldViewDir , normalizeResult332_g3028 );
			float temp_output_319_0_g3028 = ( 1.0 - abs( dotResult317_g3028 ) );
			float temp_output_321_0_g3028 = ( 1.0 - ( temp_output_319_0_g3028 * temp_output_319_0_g3028 ) );
			float m_Active263_g3028 = temp_output_321_0_g3028;
			float localfloatswitch263_g3028 = floatswitch263_g3028( m_switch263_g3028 , m_Off263_g3028 , m_Active263_g3028 );
			clip( localfloatswitch263_g3028 - _MaskClipValue );
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18502
1982;67;1076;952;638.1359;-191.7621;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;411;61.82877,80.87488;Inherit;False;341.5028;250.4201;;5;187;283;388;188;51;DEBUG SETTINGS ;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;410;58.65128,-67.52942;Inherit;False;352;119;;1;52;GLOBAL SETTINGS ;0.09433961,0.09433961,0.09433961,1;0;0
Node;AmplifyShaderEditor.IntNode;52;70.11699,-33.1921;Inherit;False;Property;_CullMode;Cull Mode;4;1;[Enum];Create;False;0;1;UnityEngine.Rendering.CullMode;True;1;Header(GLOBAL SETTINGS);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;188;68.08816,117.2121;Inherit;False;Property;_ColorMask;Color Mask Mode;2;1;[Enum];Create;False;0;1;None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15;True;0;False;15;15;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;70.57893,185.4035;Inherit;False;Constant;_MaskClipValue;Mask Clip Value;19;1;[HideInInspector];Create;True;0;0;True;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;388;70.96429,256.2158;Inherit;False;Property;_AlphatoCoverage;Alpha to Coverage;3;1;[Enum];Create;True;1;Option1;0;1;Off,0,On,1;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;283;249.4697,188.5197;Inherit;False;Property;_ZTestMode;ZTest Mode;1;1;[Enum];Create;False;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;4;4;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;187;247.0663,117.283;Inherit;False;Property;_ZWriteMode;ZWrite Mode;0;1;[Enum];Create;False;0;1;Off,0,On,1;True;2;Header(SHADER VERSION 1.0 STANDARD);Header(DEBUG SETTINGS);False;1;1;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;496;-260.1587,622.5822;Inherit;False;DECSF Module Wind;22;;3021;0c33ef2b38b405041aea041abb730ab8;10,230,2,242,2,164,2,202,2,196,2,220,2,310,0,308,0,289,0,309,0;0;1;FLOAT3;305
Node;AmplifyShaderEditor.FunctionNode;499;-284.9685,337.1978;Inherit;False;DECSF Master Map Billboard;5;;3028;bd32d91e2d401734bbb5bafd06e38be2;2,218,0,275,1;0;8;FLOAT3;192;FLOAT3;194;FLOAT;207;FLOAT;205;FLOAT;213;FLOAT;193;FLOAT;277;FLOAT;223
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;39;63.95,341.8214;Float;False;True;-1;2;;200;0;Standard;DEC/Billboard Wind/Billboard Wind Vertex Simple;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;True;True;True;Back;0;True;187;0;True;283;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;-10;True;Opaque;;Geometry;All;14;all;True;True;True;True;0;True;188;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;True;Relative;200;;-1;-1;-1;-1;1;NatureRendererInstancing=True;False;0;0;True;52;-1;0;True;51;5;Pragma;multi_compile_instancing;False;;Custom;Pragma;instancing_options procedural:SetupNatureRenderer forwardadd;False;;Custom;Pragma;multi_compile GPU_FRUSTUM_ON __;False;8ccd508f733f5f0418220eaf14ecdf81;Custom;Include;Nature Renderer.cginc;False;5d792e02fd6741e4cb63087f97979470;Custom;Pragma;multi_compile_local _ NATURE_RENDERER;False;;Custom;0;0;False;0.1;False;-1;0;True;388;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;39;0;499;192
WireConnection;39;1;499;194
WireConnection;39;3;499;207
WireConnection;39;4;499;205
WireConnection;39;5;499;213
WireConnection;39;9;499;193
WireConnection;39;10;499;277
WireConnection;39;11;496;305
ASEEND*/
//CHKSM=46DC93E825C3F47E593B01B6F666740603D217CD