// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/DEC ASE Impostors Bake Shader"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.CullMode)][Header(SHADER VERSION 1.0 STANDARD)][Header(GLOBAL SETTINGS)]_CullMode("Cull Mode", Int) = 0
		[Enum(Default,0,Flip,1,Mirror,2)]_NormalMode("Normal Mode", Int) = 0
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

	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }
	LOD 100
		CGINCLUDE
		#pragma target 4.0
		ENDCG
		Cull [_CullMode]
		

		Pass
		{
			Name "Unlit"
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#pragma multi_compile_fwdbase
			#include "UnityStandardUtils.cginc"
			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_VERT_POSITION
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
			


			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_tangent : TANGENT;
				float3 ase_normal : NORMAL;
				float4 ase_color : COLOR;
			};

			struct v2f
			{
				UNITY_POSITION(pos);
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord4 : TEXCOORD4;
			};

			uniform int _CullMode;
			uniform float4 _Color;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainTex);
			uniform int _Mian_UVSet;
			uniform float _TilingX;
			uniform float _TilingY;
			uniform float _OffsetX;
			uniform float _OffsetY;
			SamplerState sampler_trilinear_repeat;
			uniform half _Brightness;
			uniform int _NormalMode;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_BumpMap);
			uniform half _NormalStrength;
			uniform float _MetallicStrength;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MetallicGlossMap);
			uniform float _SmoothnessStrength;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SmoothnessMap);
			UNITY_DECLARE_TEX2D_NOSAMPLER(_OcclusionMap);
			uniform int _OcclusionSourceMode;
			uniform float _OcclusionStrengthAO;
			SamplerState sampler_MainTex;
			uniform half _AlphaCutoffBias;
			float floatUVswitch730_g2954( int m_switch, float m_UV0, float m_UV1 )
			{
				if(m_switch == 0)
					return m_UV0;
				if(m_switch == 1)
					return m_UV1;
				return m_UV0;
			}
			
			float floatUVswitch735_g2954( int m_switch, float m_UV0, float m_UV1 )
			{
				if(m_switch == 0)
					return m_UV0;
				if(m_switch == 1)
					return m_UV1;
				return m_UV0;
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
			


			v2f vert(appdata v )
			{
				v2f o = (v2f)0;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 ase_worldTangent = UnityObjectToWorldDir(v.ase_tangent);
				o.ase_texcoord1.xyz = ase_worldTangent;
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord2.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord3.xyz = ase_worldBitangent;
				float3 objectToViewPos = UnityObjectToViewPos(v.vertex.xyz);
				float eyeDepth = -objectToViewPos.z;
				o.ase_texcoord1.w = eyeDepth;
				
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord4 = screenPos;
				
				o.ase_texcoord.xy = v.ase_texcoord.xy;
				o.ase_texcoord.zw = v.ase_texcoord1.xy;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;

				v.vertex.xyz +=  float3(0,0,0) ;
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}


			void frag(v2f i , half ase_vface : VFACE,
				out half4 outGBuffer0 : SV_Target0, 
				out half4 outGBuffer1 : SV_Target1, 
				out half4 outGBuffer2 : SV_Target2, 
				out half4 outGBuffer3 : SV_Target3,
				out half4 outGBuffer4 : SV_Target4,
				out half4 outGBuffer5 : SV_Target5,
				out half4 outGBuffer6 : SV_Target6,
				out half4 outGBuffer7 : SV_Target7,
				out float outDepth : SV_Depth
			) 
			{
				UNITY_SETUP_INSTANCE_ID( i );
				float3 temp_output_11_0_g2954 = (_Color).rgb;
				int UV_SET_MAIN732_g2954 = _Mian_UVSet;
				int m_switch730_g2954 = UV_SET_MAIN732_g2954;
				float2 appendResult77_g2954 = (float2(_TilingX , _TilingY));
				float2 appendResult82_g2954 = (float2(_OffsetX , _OffsetY));
				float2 texCoord73_g2954 = i.ase_texcoord.xy * appendResult77_g2954 + appendResult82_g2954;
				float m_UV0730_g2954 = texCoord73_g2954.x;
				float2 texCoord729_g2954 = i.ase_texcoord.zw * appendResult77_g2954 + appendResult82_g2954;
				float m_UV1730_g2954 = texCoord729_g2954.x;
				float localfloatUVswitch730_g2954 = floatUVswitch730_g2954( m_switch730_g2954 , m_UV0730_g2954 , m_UV1730_g2954 );
				int m_switch735_g2954 = UV_SET_MAIN732_g2954;
				float m_UV0735_g2954 = texCoord73_g2954.y;
				float m_UV1735_g2954 = texCoord729_g2954.y;
				float localfloatUVswitch735_g2954 = floatUVswitch735_g2954( m_switch735_g2954 , m_UV0735_g2954 , m_UV1735_g2954 );
				float2 appendResult559_g2954 = (float2(localfloatUVswitch730_g2954 , localfloatUVswitch735_g2954));
				float4 tex2DNode57_g2954 = SAMPLE_TEXTURE2D( _MainTex, sampler_trilinear_repeat, appendResult559_g2954 );
				float3 temp_output_76_0_g2954 = ( temp_output_11_0_g2954 * (tex2DNode57_g2954).rgb * _Brightness );
				float4 appendResult14_g2977 = (float4(float4( temp_output_76_0_g2954 , 0.0 ).xyz , 1.0));
				
				int m_switch9_g2974 = _NormalMode;
				float3 NORMAL_IN17_g2974 = UnpackScaleNormal( SAMPLE_TEXTURE2D( _BumpMap, sampler_trilinear_repeat, appendResult559_g2954 ), _NormalStrength );
				float3 m_Default9_g2974 = NORMAL_IN17_g2974;
				float3 m_Flip9_g2974 = ( NORMAL_IN17_g2974 * ase_vface );
				float3 break2_g2974 = NORMAL_IN17_g2974;
				float3 appendResult3_g2974 = (float3(break2_g2974.x , break2_g2974.y , ( break2_g2974.z * ase_vface )));
				float3 m_Mirror9_g2974 = appendResult3_g2974;
				float3 localfloat3switch9_g2974 = float3switch9_g2974( m_switch9_g2974 , m_Default9_g2974 , m_Flip9_g2974 , m_Mirror9_g2974 );
				float3 temp_output_530_11_g2954 = localfloat3switch9_g2974;
				float3 ase_worldTangent = i.ase_texcoord1.xyz;
				float3 ase_worldNormal = i.ase_texcoord2.xyz;
				float3 ase_worldBitangent = i.ase_texcoord3.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal4_g2977 = temp_output_530_11_g2954;
				float3 worldNormal4_g2977 = float3(dot(tanToWorld0,tanNormal4_g2977), dot(tanToWorld1,tanNormal4_g2977), dot(tanToWorld2,tanNormal4_g2977));
				float eyeDepth = i.ase_texcoord1.w;
				float temp_output_11_0_g2977 = ( -1.0 / UNITY_MATRIX_P[2].z );
				float temp_output_5_0_g2977 = ( ( eyeDepth + temp_output_11_0_g2977 ) / temp_output_11_0_g2977 );
				float4 appendResult18_g2977 = (float4((worldNormal4_g2977*0.5 + 0.5) , temp_output_5_0_g2977));
				
				float2 CUSTOM_UV1263_g2954 = appendResult559_g2954;
				
				float4 temp_cast_5 = (1.0).xxxx;
				float4 temp_cast_6 = (i.ase_color.a).xxxx;
				float4 lerpResult39_g2954 = lerp( SAMPLE_TEXTURE2D( _OcclusionMap, sampler_trilinear_repeat, CUSTOM_UV1263_g2954 ) , temp_cast_6 , (float)_OcclusionSourceMode);
				float4 lerpResult29_g2954 = lerp( temp_cast_5 , lerpResult39_g2954 , _OcclusionStrengthAO);
				
				float ALBEDO_A716_g2954 = tex2DNode57_g2954.a;
				clip( ALBEDO_A716_g2954 - ( 1.0 - _AlphaCutoffBias ));
				float temp_output_7_0_g2975 = saturate( ( ( ALBEDO_A716_g2954 / max( fwidth( ALBEDO_A716_g2954 ) , 0.0001 ) ) + 0.5 ) );
				float4 screenPos = i.ase_texcoord4;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 clipScreen3_g2975 = ase_screenPosNorm.xy * _ScreenParams.xy;
				float dither3_g2975 = Dither8x8Bayer( fmod(clipScreen3_g2975.x, 8), fmod(clipScreen3_g2975.y, 8) );
				dither3_g2975 = step( dither3_g2975, unity_LODFade.x );
				#ifdef LOD_FADE_CROSSFADE
				float staticSwitch5_g2975 = ( temp_output_7_0_g2975 * dither3_g2975 );
				#else
				float staticSwitch5_g2975 = temp_output_7_0_g2975;
				#endif
				

				outGBuffer0 = appendResult14_g2977;
				outGBuffer1 = appendResult18_g2977;
				outGBuffer2 = ( _MetallicStrength * SAMPLE_TEXTURE2D( _MetallicGlossMap, sampler_trilinear_repeat, CUSTOM_UV1263_g2954 ) );
				outGBuffer3 = ( _SmoothnessStrength * SAMPLE_TEXTURE2D( _SmoothnessMap, sampler_trilinear_repeat, CUSTOM_UV1263_g2954 ) );
				outGBuffer4 = lerpResult29_g2954;
				outGBuffer5 = 0;
				outGBuffer6 = 0;
				outGBuffer7 = 0;
				float alpha = staticSwitch5_g2975;
				clip( alpha );
				outDepth = i.pos.z;
			}
			ENDCG
		}
	}
	
	CustomEditor "ASEMaterialInspector"
	
}
/*ASEBEGIN
Version=18502
1982;67;1076;952;-1522.39;554.2727;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;215;2761.112,-532.1646;Inherit;False;370;124;;1;218;GLOBAL SETTINGS ;0.09433961,0.09433961,0.09433961,1;0;0
Node;AmplifyShaderEditor.FunctionNode;221;1931.164,-280.7958;Inherit;False;DECSF Master Map Cutout;1;;2954;000f89ea707009441837de6c4e59b637;21,489,0,446,0,433,0,553,0,688,0,684,0,512,0,666,0,470,0,323,1,364,1,398,1,499,1,595,0,190,0,356,0,500,0,399,0,390,0,461,0,467,0;0;12;FLOAT3;189;FLOAT3;95;COLOR;100;COLOR;97;COLOR;99;FLOAT;403;FLOAT;96;FLOAT;600;FLOAT;480;FLOAT4;258;FLOAT4;259;FLOAT3;401
Node;AmplifyShaderEditor.IntNode;218;2778.925,-494.3526;Inherit;False;Property;_CullMode;Cull Mode;0;1;[Enum];Create;False;0;1;UnityEngine.Rendering.CullMode;True;2;Header(SHADER VERSION 1.0 STANDARD);Header(GLOBAL SETTINGS);False;0;2;False;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;222;2343.843,-334.7993;Inherit;False;DECSF Module Impostors;-1;;2977;c564d5a6cd3366f40b5b50f48f502a01;1,8,0;2;6;FLOAT4;0,0,0,0;False;12;FLOAT3;0,0,0;False;3;FLOAT4;22;FLOAT4;23;FLOAT;21
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;220;2750,-275;Float;False;True;-1;2;ASEMaterialInspector;100;9;Hidden/DEC ASE Impostors Bake Shader;f53051a8190f7044fa936bd7fbe116c1;True;Unlit;0;0;Unlit;10;False;False;False;False;False;False;False;False;False;True;0;True;218;False;False;False;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;True;4;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;0;0;1;True;False;;True;0
WireConnection;222;6;221;189
WireConnection;222;12;221;95
WireConnection;220;0;222;22
WireConnection;220;1;222;23
WireConnection;220;2;221;100
WireConnection;220;3;221;97
WireConnection;220;4;221;99
WireConnection;220;8;221;96
ASEEND*/
//CHKSM=B34729C1CC41FABBBE4AAEEDF9059CCDB65E214F