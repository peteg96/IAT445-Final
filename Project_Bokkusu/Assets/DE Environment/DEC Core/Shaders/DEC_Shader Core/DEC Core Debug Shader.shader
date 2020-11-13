// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/DEC Core Debug Shader"
{
	Properties
	{
		[Enum(VertexColor,0,VertexTangent,1,VertexNormal,2,BakedAO,3,BakedTranslucency,4)][Header(SHADER VERSION 1.0 STANDARD)][Header(DEBUG SETTINGS)]_MCoreDebugMode("Debug Mode", Int) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("Cull Mode", Int) = 0
		[Enum(Default,0,Flip,1,Mirror,2)]_NormalMode("Normal Mode", Int) = 0
		[Enum(Off,0,On,1)]_ZWriteMode("ZWrite Mode", Int) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTestMode("ZTest Mode", Int) = 4
		[Enum(None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15)]_ColorMask("Color Mask Mode", Int) = 15
		[Enum(Off,0,On,1)]_AlphatoCoverage("Alpha to Coverage", Float) = 0
		[Enum(Off,0,Global,1,Local,2)][Header(WIND)]_WindMode("Wind Mode", Int) = 0
		[Enum(Leaf,0,Palm,1,Grass,2,Simple,3)]_WindModeCutoutShader("Wind Type", Int) = 1
		[Header(WIND MODE GLOBAL)]_GlobalWindInfluenceOther("Wind Strength", Float) = 0.3
		_GlobalTurbulenceInfluence("Wind Turbulence", Float) = 0.2
		[Header(WIND MODE LOCAL)]_LocalWindStrength("Wind Strength", Float) = 0.3
		_LocalWindPulse("Wind Pulse", Float) = 0.1
		_LocalWindTurbulence("Wind Turbulence", Float) = 0.2
		_LocalWindDirection("Wind Direction", Float) = 1
		_LocalRandomWindOffset("Wind Random Offset", Float) = 0.2
		[HideInInspector] _texcoord4( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
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

		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float4 vertexColor : COLOR;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv4_texcoord4;
			half ASEVFace : VFACE;
		};

		uniform float _AlphatoCoverage;
		uniform int _CullMode;
		uniform int _ColorMask;
		uniform int _ZTestMode;
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
		uniform int _MCoreDebugMode;


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


		float3 float3switch731( int m_switch, float3 m_Leaf, float3 m_Palm, float3 m_Grass, float3 m_Simple )
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


		float4 float4switch603( int m_switch, float4 m_VertexColor, float4 m_VertexTangent, float4 m_VertexNormal, float4 m_BakedAO, float4 m_BakedTranslucency )
		{
			if(m_switch == 0)
			    return m_VertexColor;
			if(m_switch == 1)
			    return m_VertexTangent;
			if(m_switch == 2)
			    return m_VertexNormal;
			if(m_switch ==3)
			    return m_BakedAO;
			if(m_switch ==4)
			    return m_BakedTranslucency;
			return m_VertexColor;
		}


		float3 float3switch605( int m_switch, float3 m_VertexColor, float3 m_VertexTangent, float3 m_VertexNormal, float3 m_BakedAO, float3 m_BakedTranslucency )
		{
			if(m_switch == 0)
			    return m_VertexColor;
			if(m_switch == 1)
			    return m_VertexTangent;
			if(m_switch == 2)
			    return m_VertexNormal;
			if(m_switch ==3)
			    return m_BakedAO;
			if(m_switch ==4)
			    return m_BakedTranslucency;
			return m_VertexColor;
		}


		float2 float2switch606( int m_switch, float2 m_VertexColor, float2 m_VertexTangent, float2 m_VertexNormal, float2 m_BakedAO, float2 m_BakedTranslucency )
		{
			if(m_switch == 0)
			    return m_VertexColor;
			if(m_switch == 1)
			    return m_VertexTangent;
			if(m_switch == 2)
			    return m_VertexNormal;
			if(m_switch ==3)
			    return m_BakedAO;
			if(m_switch ==4)
			    return m_BakedTranslucency;
			return m_VertexColor;
		}


		float3 float3switch316( int m_switch, float3 m_Default, float3 m_Flip, float3 m_Mirror )
		{
			if(m_switch == 0)
				return m_Default;
			if(m_switch == 1)
				return m_Flip;
			if(m_switch == 2)
				return m_Mirror;
			return m_Default;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			int WindController756 = _WindMode;
			int m_switch868 = WindController756;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 VAR_VERTEXPOSITION_MATRIX739 = mul( unity_ObjectToWorld, float4( ase_vertex3Pos , 0.0 ) ).xyz;
			float3 m_Off868 = VAR_VERTEXPOSITION_MATRIX739;
			int m_switch731 = _WindModeCutoutShader;
			float3 break817 = VAR_VERTEXPOSITION_MATRIX739;
			int m_switch875 = _WindMode;
			float m_Off875 = 1.0;
			float m_Global875 = ( _GlobalWindInfluenceOther * _WindStrength );
			float m_Local875 = _LocalWindStrength;
			float localfloatswitch875 = floatswitch( m_switch875 , m_Off875 , m_Global875 , m_Local875 );
			float VAR_WindStrength688 = localfloatswitch875;
			int m_switch873 = _WindMode;
			float m_Off873 = 1.0;
			float m_Global873 = _RandomWindOffset;
			float m_Local873 = _LocalRandomWindOffset;
			float localfloatswitch873 = floatswitch( m_switch873 , m_Off873 , m_Global873 , m_Local873 );
			float VAR_WindOffset708 = localfloatswitch873;
			float4 transform715 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult814 = (float2(transform715.x , transform715.z));
			float dotResult804 = dot( appendResult814 , float2( 12.9898,78.233 ) );
			float lerpResult805 = lerp( 0.8 , ( ( VAR_WindOffset708 / 2.0 ) + 0.0 ) , frac( ( sin( dotResult804 ) * 43758.55 ) ));
			float VAR_RandomTime813 = ( _Time.x * lerpResult805 );
			float FUNC_Turbulence823 = ( sin( ( ( VAR_RandomTime813 * 40.0 ) - ( VAR_VERTEXPOSITION_MATRIX739.z / 15.0 ) ) ) * 0.5 );
			int m_switch837 = _WindMode;
			float m_Off837 = 1.0;
			float m_Global837 = _WindPulse;
			float m_Local837 = _LocalWindPulse;
			float localfloatswitch837 = floatswitch( m_switch837 , m_Off837 , m_Global837 , m_Local837 );
			float VAR_WindPulse713 = localfloatswitch837;
			float FUNC_Angle812 = ( VAR_WindStrength688 * ( 1.0 + sin( ( ( ( ( VAR_RandomTime813 * 2.0 ) + FUNC_Turbulence823 ) - ( VAR_VERTEXPOSITION_MATRIX739.z / 50.0 ) ) - ( v.color.r / 20.0 ) ) ) ) * sqrt( v.color.r ) * VAR_WindPulse713 );
			float VAR_SinA779 = sin( FUNC_Angle812 );
			float VAR_CosA733 = cos( FUNC_Angle812 );
			int m_switch876 = _WindMode;
			float m_Off876 = 1.0;
			float m_Global876 = _WindDirection;
			float m_Local876 = _LocalWindDirection;
			float localfloatswitch876 = floatswitch( m_switch876 , m_Off876 , m_Global876 , m_Local876 );
			float _WindDirection816 = localfloatswitch876;
			float2 localDirectionalEquation816 = DirectionalEquation( _WindDirection816 );
			float2 break724 = localDirectionalEquation816;
			float VAR_xLerp711 = break724.x;
			float lerpResult842 = lerp( break817.x , ( ( break817.y * VAR_SinA779 ) + ( break817.x * VAR_CosA733 ) ) , VAR_xLerp711);
			float3 break761 = VAR_VERTEXPOSITION_MATRIX739;
			float3 break794 = VAR_VERTEXPOSITION_MATRIX739;
			float VAR_zLerp736 = break724.y;
			float lerpResult822 = lerp( break794.z , ( ( break794.y * VAR_SinA779 ) + ( break794.z * VAR_CosA733 ) ) , VAR_zLerp736);
			float3 appendResult737 = (float3(lerpResult842 , ( ( break761.y * VAR_CosA733 ) - ( break761.z * VAR_SinA779 ) ) , lerpResult822));
			float3 FUNC_vertexPos803 = appendResult737;
			float3 break955 = FUNC_vertexPos803;
			half FUNC_SinFunction831 = sin( ( ( VAR_RandomTime813 * 200.0 * ( 0.2 + v.color.g ) ) + ( v.color.g * 10.0 ) + FUNC_Turbulence823 + ( VAR_VERTEXPOSITION_MATRIX739.z / 2.0 ) ) );
			int m_switch749 = _WindMode;
			float m_Off749 = 1.0;
			float m_Global749 = ( _GlobalTurbulenceInfluence * _WindTurbulence );
			float m_Local749 = _LocalWindTurbulence;
			float localfloatswitch749 = floatswitch( m_switch749 , m_Off749 , m_Global749 , m_Local749 );
			float VAR_GlobalWindTurbulence726 = localfloatswitch749;
			float3 appendResult917 = (float3(break955.x , ( break955.y + ( FUNC_SinFunction831 * v.color.b * ( FUNC_Angle812 + ( VAR_WindStrength688 / 200.0 ) ) * VAR_GlobalWindTurbulence726 ) ) , break955.z));
			float3 OUT_Leafs_Standalone647 = appendResult917;
			float3 m_Leaf731 = OUT_Leafs_Standalone647;
			float3 OUT_Palm_Standalone864 = ( ( FUNC_SinFunction831 * v.color.b * ( FUNC_Angle812 + ( VAR_WindStrength688 / 200.0 ) ) * VAR_GlobalWindTurbulence726 ) + FUNC_vertexPos803 );
			float3 m_Palm731 = OUT_Palm_Standalone864;
			float3 break923 = FUNC_vertexPos803;
			float temp_output_951_0 = ( FUNC_SinFunction831 * v.color.b * ( FUNC_Angle812 + ( VAR_WindStrength688 / 200.0 ) ) );
			float lerpResult919 = lerp( 0.0 , temp_output_951_0 , VAR_xLerp711);
			float lerpResult921 = lerp( 0.0 , temp_output_951_0 , VAR_zLerp736);
			float3 appendResult926 = (float3(( break923.x + lerpResult919 ) , break923.y , ( break923.z + lerpResult921 )));
			float3 OUT_Grass_Standalone808 = appendResult926;
			float3 m_Grass731 = OUT_Grass_Standalone808;
			float3 m_Simple731 = FUNC_vertexPos803;
			float3 localfloat3switch731 = float3switch731( m_switch731 , m_Leaf731 , m_Palm731 , m_Grass731 , m_Simple731 );
			float3 m_Global868 = localfloat3switch731;
			float3 m_Local868 = localfloat3switch731;
			float3 localfloat3switch868 = float3switch( m_switch868 , m_Off868 , m_Global868 , m_Local868 );
			float3 VAR_VERTEXPOSITION734 = ase_vertex3Pos;
			v.vertex.xyz += ( mul( unity_WorldToObject, float4( localfloat3switch868 , 0.0 ) ).xyz - VAR_VERTEXPOSITION734 );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = float3(0,0,1);
			int m_switch316 = _NormalMode;
			int m_switch603 = _MCoreDebugMode;
			float4 m_VertexColor603 = i.vertexColor;
			float4 m_VertexTangent603 = float4( 0,0,0,0 );
			float4 m_VertexNormal603 = float4( 0,0,0,0 );
			float4 temp_cast_1 = (i.vertexColor.a).xxxx;
			float4 m_BakedAO603 = temp_cast_1;
			float4 m_BakedTranslucency603 = float4( 0,0,0,0 );
			float4 localfloat4switch603 = float4switch603( m_switch603 , m_VertexColor603 , m_VertexTangent603 , m_VertexNormal603 , m_BakedAO603 , m_BakedTranslucency603 );
			int m_switch605 = _MCoreDebugMode;
			float3 m_VertexColor605 = float3( 0,0,0 );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float4 ase_vertexTangent = mul( unity_WorldToObject, float4( ase_worldTangent, 0 ) );
			float3 m_VertexTangent605 = (ase_vertexTangent).xyz;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float3 m_VertexNormal605 = ase_vertexNormal;
			float3 m_BakedAO605 = float3( 0,0,0 );
			float3 m_BakedTranslucency605 = float3( 0,0,0 );
			float3 localfloat3switch605 = float3switch605( m_switch605 , m_VertexColor605 , m_VertexTangent605 , m_VertexNormal605 , m_BakedAO605 , m_BakedTranslucency605 );
			int m_switch606 = _MCoreDebugMode;
			float2 m_VertexColor606 = float2( 0,0 );
			float2 m_VertexTangent606 = float2( 0,0 );
			float2 m_VertexNormal606 = float2( 0,0 );
			float2 m_BakedAO606 = float2( 0,0 );
			float2 temp_cast_3 = (i.uv4_texcoord4.x).xx;
			float2 m_BakedTranslucency606 = temp_cast_3;
			float2 localfloat2switch606 = float2switch606( m_switch606 , m_VertexColor606 , m_VertexTangent606 , m_VertexNormal606 , m_BakedAO606 , m_BakedTranslucency606 );
			float4 temp_output_604_0 = ( localfloat4switch603 + float4( localfloat3switch605 , 0.0 ) + float4( localfloat2switch606, 0.0 , 0.0 ) );
			float3 m_Default316 = temp_output_604_0.xyz;
			float3 m_Flip316 = ( temp_output_604_0 * i.ASEVFace ).xyz;
			float3 appendResult314 = (float3(temp_output_604_0.x , 0.0 , ( 0.0 * i.ASEVFace )));
			float3 m_Mirror316 = appendResult314;
			float3 localfloat3switch316 = float3switch316( m_switch316 , m_Default316 , m_Flip316 , m_Mirror316 );
			o.Emission = localfloat3switch316;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				half4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv4_texcoord4;
				o.customPack1.xy = v.texcoord3;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv4_texcoord4 = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.vertexColor = IN.color;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18502
1968;15;1522;946;2522.564;1225.673;2.220708;True;False
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;715;-2437.737,2292.054;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;719;-4114.307,1428.789;Inherit;False;Property;_LocalRandomWindOffset;Wind Random Offset;15;0;Create;False;0;0;False;0;False;0.2;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;675;-4120.342,1334.168;Inherit;False;Global;_RandomWindOffset;_RandomWindOffset;0;0;Create;True;0;0;False;0;False;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;843;-4025.985,1225.688;Inherit;False;Property;_WindMode;Wind Mode;7;1;[Enum];Create;True;3;Off;0;Global;1;Local;2;0;False;1;Header(WIND);False;0;1;False;0;1;INT;0
Node;AmplifyShaderEditor.Vector2Node;661;-2296.821,2464.088;Inherit;False;Constant;_Vector0;Vector 0;0;0;Create;True;0;0;False;0;False;12.9898,78.233;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;814;-2237.307,2366.391;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CustomExpressionNode;873;-3845.184,1315.449;Inherit;False;if(m_switch == 0)$	return m_Off@$if(m_switch == 1)$	return m_Global@$if(m_switch == 2)$	return m_Local@$$return m_Off@;1;False;4;True;m_switch;INT;0;In;;Inherit;False;True;m_Off;FLOAT;1;In;;Inherit;False;True;m_Global;FLOAT;0;In;;Inherit;False;True;m_Local;FLOAT;0;In;;Inherit;False;float switch ;False;False;0;4;0;INT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;708;-3628.747,1311.187;Inherit;False;VAR_WindOffset;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;804;-2100.657,2407.266;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;680;-2179.107,2283.962;Inherit;False;708;VAR_WindOffset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;677;-1983.39,2406.05;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;799;-1824.119,2477.574;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;43758.55;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;693;-1954.07,2290.835;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;793;-2474.597,1369.203;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ObjectToWorldMatrixNode;701;-2475.11,1244.595;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.RangedFloatNode;846;-1770.165,2307.232;Inherit;False;Constant;_Min;Min;3;0;Create;True;0;0;False;0;False;0.8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;759;-1691.593,2475.587;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;760;-1751.736,2383.344;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;844;-1561.525,2286.636;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;705;-2278.719,1243.311;Inherit;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;805;-1557.877,2431.131;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;739;-2145.8,1235.466;Inherit;False;VAR_VERTEXPOSITION_MATRIX;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;664;-1358.294,2406.39;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;813;-1228.654,2408.827;Inherit;False;VAR_RandomTime;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;660;-389.0738,2479.74;Inherit;False;739;VAR_VERTEXPOSITION_MATRIX;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;670;-61.31294,2435.785;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;800;-275.9719,2284.488;Inherit;False;813;VAR_RandomTime;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;699;18.48705,2556.185;Inherit;False;Constant;_150;15.0;0;0;Create;True;0;0;False;0;False;15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;704;-204.879,2355;Inherit;False;Constant;_40;40;0;0;Create;True;0;0;False;0;False;40;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;789;163.8869,2480.285;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;878;-49.13794,2289.773;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;40;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;678;283.7881,2289.685;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;758;315.073,2389.131;Inherit;False;Constant;_05;0.5;0;0;Create;True;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;757;423.407,2290.892;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;764;547.8729,2291.932;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;823;690.2171,2287.025;Inherit;False;FUNC_Turbulence;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;694;-2236.528,2706.965;Inherit;False;813;VAR_RandomTime;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;722;-2164.228,2784.716;Inherit;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;668;-2351.758,2932.004;Inherit;False;739;VAR_VERTEXPOSITION_MATRIX;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;791;-2021.852,2907.688;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;762;-2018.442,2741.315;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;777;-2017.848,2833.879;Inherit;False;823;FUNC_Turbulence;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;690;-1941.044,3029.899;Inherit;False;Constant;_50;50;0;0;Create;True;0;0;False;0;False;50;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;839;-1579.723,3015.063;Inherit;False;Constant;_20;20;0;0;Create;True;0;0;False;0;False;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;811;-1792.376,2742.165;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;826;-1600.279,2846.145;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;858;-4426.055,1562.821;Inherit;False;Global;_WindStrength;_WindStrength;15;0;Create;True;0;0;False;0;False;0.01;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;695;-1736.434,2846.284;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;802;-4407.37,1482.218;Inherit;False;Property;_GlobalWindInfluenceOther;Wind Strength;9;0;Create;False;0;0;False;1;Header(WIND MODE GLOBAL);False;0.3;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;829;-4214.465,1509.024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;825;-1391.272,2811.926;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;851;-1601.537,2742.718;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;707;-4049.894,2050.539;Inherit;False;Property;_LocalWindPulse;Wind Pulse;12;0;Create;False;0;0;False;0;False;0.1;-0.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;746;-4067.995,1579.127;Inherit;False;Property;_LocalWindStrength;Wind Strength;11;0;Create;False;0;0;False;1;Header(WIND MODE LOCAL);False;0.3;2.88;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;663;-4089.338,1965.386;Inherit;False;Global;_WindPulse;_WindPulse;15;0;Create;True;0;0;False;0;False;0;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;685;-1257.434,2741.111;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;837;-3842.981,1916.108;Inherit;False;if(m_switch == 0)$	return m_Off@$if(m_switch == 1)$	return m_Global@$if(m_switch == 2)$	return m_Local@$$return m_Off@;1;False;4;True;m_switch;INT;0;In;;Inherit;False;True;m_Off;FLOAT;1;In;;Inherit;False;True;m_Global;FLOAT;0;In;;Inherit;False;True;m_Local;FLOAT;0;In;;Inherit;False;float switch ;False;False;0;4;0;INT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;875;-3848.49,1463.89;Inherit;False;if(m_switch == 0)$	return m_Off@$if(m_switch == 1)$	return m_Global@$if(m_switch == 2)$	return m_Local@$$return m_Off@;1;False;4;True;m_switch;INT;0;In;;Inherit;False;True;m_Off;FLOAT;1;In;;Inherit;False;True;m_Global;FLOAT;0;In;;Inherit;False;True;m_Local;FLOAT;0;In;;Inherit;False;float switch ;False;False;0;4;0;INT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;765;-1089.317,2713.453;Inherit;False;Constant;_1;1;0;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;750;-1140.713,2879.208;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;688;-3632.66,1458.485;Inherit;False;VAR_WindStrength;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;703;-1085.162,2790.99;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;713;-3636.005,1911.93;Inherit;False;VAR_WindPulse;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;807;-937.4949,2789.285;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;781;-964.1879,3082.281;Inherit;False;713;VAR_WindPulse;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;691;-939.9809,2710.645;Inherit;False;688;VAR_WindStrength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SqrtOpNode;827;-936.692,2894.91;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;836;-711.7062,2763.988;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;812;-551.2042,2757.977;Inherit;False;FUNC_Angle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;818;-2470.49,1656.68;Inherit;False;812;FUNC_Angle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;665;-4257.334,1663.712;Inherit;False;Global;_WindDirection;_WindDirection;15;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;819;-4080.576,1736.76;Inherit;False;Property;_LocalWindDirection;Wind Direction;14;0;Create;False;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;772;-2281.386,1711.847;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;776;-2279.191,1644.557;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;876;-3839.791,1621.89;Inherit;False;if(m_switch == 0)$	return m_Off@$if(m_switch == 1)$	return m_Global@$if(m_switch == 2)$	return m_Local@$$return m_Off@;1;False;4;True;m_switch;INT;0;In;;Inherit;False;True;m_Off;FLOAT;1;In;;Inherit;False;True;m_Global;FLOAT;0;In;;Inherit;False;True;m_Local;FLOAT;0;In;;Inherit;False;float switch ;False;False;0;4;0;INT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;754;-223.132,3313.746;Inherit;False;739;VAR_VERTEXPOSITION_MATRIX;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;806;-1729.14,1473.129;Inherit;False;739;VAR_VERTEXPOSITION_MATRIX;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;779;-2149.75,1717.254;Inherit;False;VAR_SinA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;672;-1730.58,1840.91;Inherit;False;739;VAR_VERTEXPOSITION_MATRIX;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;816;-3631.644,1623.431;Inherit;False;float d = _WindDirection * 0.0174532924@$float xL = cos(d) + 1 / 2@$float zL = sin(d) + 1 / 2@$$return float2(zL,xL)@;2;False;1;True;_WindDirection;FLOAT;0;In;;Float;False;Directional Equation;False;False;0;1;0;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;786;-70.91394,2928.844;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;733;-2151.77,1643.139;Inherit;False;VAR_CosA;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;666;-94.96898,3005.861;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;782;-15.78794,2777.839;Inherit;False;813;VAR_RandomTime;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;845;-1365.738,2058.481;Inherit;False;733;VAR_CosA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;696;-1728.273,1203.463;Inherit;False;739;VAR_VERTEXPOSITION_MATRIX;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;724;-3384.843,1622.157;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;682;81.49605,2934.538;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;841;53.99007,2857.336;Inherit;False;Constant;_200;200;0;0;Create;True;0;0;False;0;False;200;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;710;-1388.059,1657.365;Inherit;False;779;VAR_SinA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;709;82.43795,3107.069;Inherit;False;Constant;_Float4;Float 4;0;0;Create;True;0;0;False;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;794;-1430.437,1461.897;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;855;104.3751,3254.071;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;681;196.6922,3369.667;Inherit;False;Constant;_Float5;Float 5;0;0;Create;True;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;817;-1419.507,1829.539;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;797;-1379.607,1739.981;Inherit;False;733;VAR_CosA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;792;-1373.206,1974.41;Inherit;False;779;VAR_SinA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;852;-111.6211,3178.435;Inherit;False;823;FUNC_Turbulence;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;770;-1158.046,1894.637;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;798;-1166.984,1663.808;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;773;367.9552,3249.482;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;684;-1166.716,1566.062;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;711;-3152.788,1600.008;Inherit;False;VAR_xLerp;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;744;-1379.517,1384.004;Inherit;False;779;VAR_SinA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;741;-1163.689,2004.852;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;766;250.751,3054.09;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;736;-3152.959,1688.729;Inherit;False;VAR_zLerp;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;815;-1388.001,1306.366;Inherit;False;733;VAR_CosA;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;761;-1424.305,1194.314;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;686;229.3301,2841.944;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;774;-1169.136,1236.097;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;698;-1024.809,1600.208;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;771;502.606,3135.482;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;674;-1023.548,1947.754;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;911;-3434.264,512.6442;Inherit;False;1640.679;540.3227;Grass;18;952;951;950;949;948;946;945;930;926;925;924;923;922;921;920;919;918;808;GRASS;0.09433961,0.09433961,0.09433961,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;679;-4420.917,1886.068;Inherit;False;Global;_WindTurbulence;_WindTurbulence;0;0;Create;True;0;0;False;0;False;0.01;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;676;-4411.439,1796.545;Inherit;False;Property;_GlobalTurbulenceInfluence;Wind Turbulence;10;0;Create;False;0;0;False;0;False;0.2;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;790;-1039.984,2081.015;Inherit;False;711;VAR_xLerp;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;667;-1168.182,1345.935;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;735;-1029.641,1710.923;Inherit;False;736;VAR_zLerp;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;945;-3415.674,812.3568;Inherit;False;688;VAR_WindStrength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;689;-4091.484,1883.506;Inherit;False;Property;_LocalWindTurbulence;Wind Turbulence;13;0;Create;False;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;842;-813.1871,1836.569;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;930;-3347.741,896.1581;Inherit;False;Constant;_ws202;ws 200;0;0;Create;True;0;0;False;0;False;200;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;822;-831.9471,1514.2;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;712;623.1712,3135.097;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;768;-1026.661,1282.033;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;910;-3441.437,-679.3148;Inherit;False;1617.434;583.9324;Leaf;14;647;917;954;947;955;953;914;913;912;960;959;915;916;956;LEAF;0,0,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;833;-4208.231,1812.299;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;956;-3415.748,-260.5734;Inherit;False;688;VAR_WindStrength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;916;-3356.633,-188.0406;Inherit;False;Constant;_Float7;Float 1;0;0;Create;True;0;0;False;0;False;200;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;909;-3443.255,-33.042;Inherit;False;1632.228;476.4736;Palm;12;864;958;943;934;935;936;941;933;937;938;940;939;PALM;0.08490568,0.08490568,0.08490568,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;831;751.4425,3128.997;Half;False;FUNC_SinFunction;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;737;-619.0793,1462.726;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;749;-3839.507,1770.419;Inherit;False;if(m_switch == 0)$	return m_Off@$if(m_switch == 1)$	return m_Global@$if(m_switch == 2)$	return m_Local@$$return m_Off@;1;False;4;True;m_switch;INT;0;In;;Inherit;False;True;m_Off;FLOAT;1;In;;Inherit;False;True;m_Global;FLOAT;0;In;;Inherit;False;True;m_Local;FLOAT;0;In;;Inherit;False;float switch ;False;False;0;4;0;INT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;948;-3186.006,819.0276;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;946;-3391.406,724.1816;Inherit;False;812;FUNC_Angle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;950;-3194.578,579.6584;Inherit;False;831;FUNC_SinFunction;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;949;-3369.919,553.6102;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;803;-481.5905,1461.655;Inherit;False;FUNC_vertexPos;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;959;-3189.45,-256.2336;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;915;-3380.939,-341.4728;Inherit;False;812;FUNC_Angle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;940;-3330.029,308.4496;Inherit;False;Constant;_Float9;Float 2;0;0;Create;True;0;0;False;0;False;200;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;726;-3630.194,1768.969;Inherit;False;VAR_GlobalWindTurbulence;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;952;-3063.619,733.8946;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;939;-3395.054,227.3246;Inherit;False;688;VAR_WindStrength;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;912;-3024.098,-481.4466;Inherit;False;831;FUNC_SinFunction;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;918;-2766.509,662.2609;Inherit;False;711;VAR_xLerp;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;913;-3055.959,-333.9838;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;914;-3061.019,-231.6885;Inherit;False;726;VAR_GlobalWindTurbulence;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;938;-3140.029,232.4496;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;953;-3010.979,-604.3168;Inherit;False;803;FUNC_vertexPos;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;937;-3196.054,154.3237;Inherit;False;812;FUNC_Angle;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;920;-3110.052,922.267;Inherit;False;736;VAR_zLerp;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;960;-3362.238,-501.3866;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;951;-2941.684,604.3948;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;922;-2764.139,742.5139;Inherit;False;803;FUNC_vertexPos;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;936;-2989.342,151.4516;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;933;-3063.339,61.29568;Inherit;False;831;FUNC_SinFunction;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;941;-3151.212,328.8636;Inherit;False;726;VAR_GlobalWindTurbulence;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;935;-3395.704,22.76559;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;921;-2781.482,885.7191;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;919;-2576.482,582.7178;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;955;-2779.345,-598.6608;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;923;-2555.472,745.4359;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;947;-2781.747,-453.5836;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;943;-2849.239,262.0255;Inherit;False;803;FUNC_vertexPos;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;954;-2537.986,-478.0778;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;925;-2323.073,561.5182;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;934;-2840.444,71.26061;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;924;-2323.463,857.35;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;917;-2389.292,-598.0305;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;958;-2629.481,69.87103;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TangentVertexDataNode;284;-1381.899,18.27633;Inherit;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;926;-2169.244,746.7488;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.VertexColorNode;1;-1120.64,-402.0387;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;299;-1140.774,301.1688;Inherit;False;3;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;241;-1155.156,102.7722;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;864;-2484.648,69.73496;Inherit;False;OUT_Palm_Standalone;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IntNode;598;-1145.708,-532.1046;Inherit;False;Property;_MCoreDebugMode;Debug Mode;0;1;[Enum];Create;False;5;VertexColor;0;VertexTangent;1;VertexNormal;2;BakedAO;3;BakedTranslucency;4;0;False;2;Header(SHADER VERSION 1.0 STANDARD);Header(DEBUG SETTINGS);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.ComponentMaskNode;320;-1171.662,15.85321;Inherit;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;647;-2263.839,-601.6077;Inherit;False;OUT_Leafs_Standalone;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;808;-2032.558,742.9384;Inherit;False;OUT_Grass_Standalone;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;603;-905.6884,-428.0641;Inherit;False;if(m_switch == 0)$    return m_VertexColor@$if(m_switch == 1)$    return m_VertexTangent@$if(m_switch == 2)$    return m_VertexNormal@$if(m_switch ==3)$    return m_BakedAO@$if(m_switch ==4)$    return m_BakedTranslucency@$$return m_VertexColor@;4;False;6;True;m_switch;INT;0;In;;Inherit;False;True;m_VertexColor;FLOAT4;0,0,0,0;In;;Inherit;False;True;m_VertexTangent;FLOAT4;0,0,0,0;In;;Inherit;False;True;m_VertexNormal;FLOAT4;0,0,0,0;In;;Inherit;False;True;m_BakedAO;FLOAT4;0,0,0,0;In;;Inherit;False;True;m_BakedTranslucency;FLOAT4;0,0,0,0;In;;Inherit;False;float4 switch ;True;False;0;6;0;INT;0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;747;-812.1552,680.0342;Inherit;False;808;OUT_Grass_Standalone;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;751;-809.1542,609.0342;Inherit;False;864;OUT_Palm_Standalone;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;606;-912.5641,206.4674;Inherit;False;if(m_switch == 0)$    return m_VertexColor@$if(m_switch == 1)$    return m_VertexTangent@$if(m_switch == 2)$    return m_VertexNormal@$if(m_switch ==3)$    return m_BakedAO@$if(m_switch ==4)$    return m_BakedTranslucency@$$return m_VertexColor@;2;False;6;True;m_switch;INT;0;In;;Inherit;False;True;m_VertexColor;FLOAT2;0,0;In;;Inherit;False;True;m_VertexTangent;FLOAT2;0,0;In;;Inherit;False;True;m_VertexNormal;FLOAT2;0,0;In;;Inherit;False;True;m_BakedAO;FLOAT2;0,0;In;;Inherit;False;True;m_BakedTranslucency;FLOAT2;0,0;In;;Inherit;False;float2 switch ;True;False;0;6;0;INT;0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.IntNode;775;-730.0703,464.2603;Inherit;False;Property;_WindModeCutoutShader;Wind Type;8;1;[Enum];Create;False;4;Leaf;0;Palm;1;Grass;2;Simple;3;0;False;0;False;1;0;False;0;1;INT;0
Node;AmplifyShaderEditor.CustomExpressionNode;605;-913.5681,-37.67021;Inherit;False;if(m_switch == 0)$    return m_VertexColor@$if(m_switch == 1)$    return m_VertexTangent@$if(m_switch == 2)$    return m_VertexNormal@$if(m_switch ==3)$    return m_BakedAO@$if(m_switch ==4)$    return m_BakedTranslucency@$$return m_VertexColor@;3;False;6;True;m_switch;INT;0;In;;Inherit;False;True;m_VertexColor;FLOAT3;0,0,0;In;;Inherit;False;True;m_VertexTangent;FLOAT3;0,0,0;In;;Inherit;False;True;m_VertexNormal;FLOAT3;0,0,0;In;;Inherit;False;True;m_BakedAO;FLOAT3;0,0,0;In;;Inherit;False;True;m_BakedTranslucency;FLOAT3;0,0,0;In;;Inherit;False;float3 switch ;True;False;0;6;0;INT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;742;-779.3781,752.4562;Inherit;False;803;FUNC_vertexPos;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;669;-813.254,539.8141;Inherit;False;647;OUT_Leafs_Standalone;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;756;-3627.766,1231.049;Inherit;False;WindController;-1;True;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.CustomExpressionNode;731;-512.654,662.6442;Inherit;False;if(m_switch == 0)$	return m_Leaf@$if(m_switch == 1)$	return m_Palm@$if(m_switch == 2)$	return m_Grass@$if(m_switch == 3)$	return m_Simple@$$return m_Leaf@;3;False;5;True;m_switch;INT;0;In;;Inherit;False;True;m_Leaf;FLOAT3;0,0,0;In;;Inherit;False;True;m_Palm;FLOAT3;0,0,0;In;;Inherit;False;True;m_Grass;FLOAT3;0,0,0;In;;Inherit;False;True;m_Simple;FLOAT3;0,0,0;In;;Inherit;False;float3 switch ;True;False;0;5;0;INT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;604;-349.8396,-188.2737;Inherit;False;3;3;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;702;-509.7392,560.9762;Inherit;False;756;WindController;1;0;OBJECT;;False;1;INT;0
Node;AmplifyShaderEditor.FaceVariableNode;306;-13.45025,191.7912;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;673;-569.029,460.1413;Inherit;False;739;VAR_VERTEXPOSITION_MATRIX;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;310;-185.8552,29.50809;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CustomExpressionNode;868;-247.5182,642.6442;Inherit;False;if(m_switch == 0)$	return m_Off@$if(m_switch == 1)$	return m_Global@$if(m_switch == 2)$	return m_Local@$$return m_Off@;3;False;4;True;m_switch;INT;0;In;;Inherit;False;True;m_Off;FLOAT3;1,0,0;In;;Inherit;False;True;m_Global;FLOAT3;0,0,0;In;;Inherit;False;True;m_Local;FLOAT3;0,0,0;In;;Inherit;False;float3 switch ;False;False;0;4;0;INT;0;False;1;FLOAT3;1,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FaceVariableNode;317;-27.65678,-55.38347;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;734;-2160.875,1365.233;Inherit;False;VAR_VERTEXPOSITION;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;309;127.7797,117.1237;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldToObjectMatrix;729;11.03717,555.9612;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;313;100.0521,-123.0085;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;718;214.9472,614.6243;Inherit;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;314;257.0068,28.09687;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;687;19.61823,458.9862;Inherit;False;734;VAR_VERTEXPOSITION;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IntNode;312;93.9198,-342.8326;Inherit;False;Property;_NormalMode;Normal Mode;2;1;[Enum];Create;False;3;Default;0;Flip;1;Mirror;2;0;False;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.CommentaryNode;288;745.0168,-521.9947;Inherit;False;341.5028;250.4201;;5;295;294;293;292;291;DEBUG SETTINGS ;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;289;741.6398,-691.8987;Inherit;False;352;119;;1;290;GLOBAL SETTINGS ;0.09433961,0.09433961,0.09433961,1;0;0
Node;AmplifyShaderEditor.IntNode;295;934.9128,-489.1707;Inherit;False;Property;_ZWriteMode;ZWrite Mode;3;1;[Enum];Create;False;0;1;Off,0,On,1;True;0;False;1;1;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;293;753.0078,-349.4255;Inherit;False;Property;_AlphatoCoverage;Alpha to Coverage;6;1;[Enum];Create;False;1;Option1;0;1;Off,0,On,1;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;963;-1030.105,-847.7789;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;964;-905.6461,-930.812;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;961;-1272.671,-845.0014;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;962;-1187.335,-928.7938;Inherit;False;Constant;_Float2;Float 0;0;0;Create;True;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;290;749.0109,-661.9329;Inherit;False;Property;_CullMode;Cull Mode;1;1;[Enum];Create;False;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;292;752.3808,-417.7917;Inherit;False;Property;_ColorMask;Color Mask Mode;5;1;[Enum];Create;False;0;1;None,0,Alpha,1,Red,8,Green,4,Blue,2,RGB,14,RGBA,15;True;0;False;15;15;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;291;751.8298,-486.9645;Inherit;False;Constant;_MaskClipValue;Mask Clip Value;64;1;[HideInInspector];Create;True;0;0;True;0;False;0.5;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;294;933.9787,-417.5295;Inherit;False;Property;_ZTestMode;ZTest Mode;4;1;[Enum];Create;False;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;4;4;False;0;1;INT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;692;378.938,549.2742;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CustomExpressionNode;316;369.2846,-212.0443;Inherit;False;if(m_switch == 0)$	return m_Default@$if(m_switch == 1)$	return m_Flip@$if(m_switch == 2)$	return m_Mirror@$$return m_Default@;3;False;4;True;m_switch;INT;0;In;;Inherit;False;True;m_Default;FLOAT3;0,0,0;In;;Inherit;False;True;m_Flip;FLOAT3;0,0,0;In;;Inherit;False;True;m_Mirror;FLOAT3;0,0,0;In;;Inherit;False;float3 switch ;True;False;0;4;0;INT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;908;646.0904,-259.3134;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Hidden/DEC Core Debug Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;814;0;715;1
WireConnection;814;1;715;3
WireConnection;873;0;843;0
WireConnection;873;2;675;0
WireConnection;873;3;719;0
WireConnection;708;0;873;0
WireConnection;804;0;814;0
WireConnection;804;1;661;0
WireConnection;677;0;804;0
WireConnection;799;0;677;0
WireConnection;693;0;680;0
WireConnection;759;0;799;0
WireConnection;760;0;693;0
WireConnection;705;0;701;0
WireConnection;705;1;793;0
WireConnection;805;0;846;0
WireConnection;805;1;760;0
WireConnection;805;2;759;0
WireConnection;739;0;705;0
WireConnection;664;0;844;1
WireConnection;664;1;805;0
WireConnection;813;0;664;0
WireConnection;670;0;660;0
WireConnection;789;0;670;2
WireConnection;789;1;699;0
WireConnection;878;0;800;0
WireConnection;878;1;704;0
WireConnection;678;0;878;0
WireConnection;678;1;789;0
WireConnection;757;0;678;0
WireConnection;764;0;757;0
WireConnection;764;1;758;0
WireConnection;823;0;764;0
WireConnection;791;0;668;0
WireConnection;762;0;694;0
WireConnection;762;1;722;0
WireConnection;811;0;762;0
WireConnection;811;1;777;0
WireConnection;695;0;791;2
WireConnection;695;1;690;0
WireConnection;829;0;802;0
WireConnection;829;1;858;0
WireConnection;825;0;826;1
WireConnection;825;1;839;0
WireConnection;851;0;811;0
WireConnection;851;1;695;0
WireConnection;685;0;851;0
WireConnection;685;1;825;0
WireConnection;837;0;843;0
WireConnection;837;2;663;0
WireConnection;837;3;707;0
WireConnection;875;0;843;0
WireConnection;875;2;829;0
WireConnection;875;3;746;0
WireConnection;688;0;875;0
WireConnection;703;0;685;0
WireConnection;713;0;837;0
WireConnection;807;0;765;0
WireConnection;807;1;703;0
WireConnection;827;0;750;1
WireConnection;836;0;691;0
WireConnection;836;1;807;0
WireConnection;836;2;827;0
WireConnection;836;3;781;0
WireConnection;812;0;836;0
WireConnection;772;0;818;0
WireConnection;776;0;818;0
WireConnection;876;0;843;0
WireConnection;876;2;665;0
WireConnection;876;3;819;0
WireConnection;779;0;772;0
WireConnection;816;0;876;0
WireConnection;733;0;776;0
WireConnection;724;0;816;0
WireConnection;682;0;786;0
WireConnection;682;1;666;2
WireConnection;794;0;806;0
WireConnection;855;0;754;0
WireConnection;817;0;672;0
WireConnection;770;0;817;1
WireConnection;770;1;792;0
WireConnection;798;0;794;2
WireConnection;798;1;797;0
WireConnection;773;0;855;2
WireConnection;773;1;681;0
WireConnection;684;0;794;1
WireConnection;684;1;710;0
WireConnection;711;0;724;0
WireConnection;741;0;817;0
WireConnection;741;1;845;0
WireConnection;766;0;666;2
WireConnection;766;1;709;0
WireConnection;736;0;724;1
WireConnection;761;0;696;0
WireConnection;686;0;782;0
WireConnection;686;1;841;0
WireConnection;686;2;682;0
WireConnection;774;0;761;1
WireConnection;774;1;815;0
WireConnection;698;0;684;0
WireConnection;698;1;798;0
WireConnection;771;0;686;0
WireConnection;771;1;766;0
WireConnection;771;2;852;0
WireConnection;771;3;773;0
WireConnection;674;0;770;0
WireConnection;674;1;741;0
WireConnection;667;0;761;2
WireConnection;667;1;744;0
WireConnection;842;0;817;0
WireConnection;842;1;674;0
WireConnection;842;2;790;0
WireConnection;822;0;794;2
WireConnection;822;1;698;0
WireConnection;822;2;735;0
WireConnection;712;0;771;0
WireConnection;768;0;774;0
WireConnection;768;1;667;0
WireConnection;833;0;676;0
WireConnection;833;1;679;0
WireConnection;831;0;712;0
WireConnection;737;0;842;0
WireConnection;737;1;768;0
WireConnection;737;2;822;0
WireConnection;749;0;843;0
WireConnection;749;2;833;0
WireConnection;749;3;689;0
WireConnection;948;0;945;0
WireConnection;948;1;930;0
WireConnection;803;0;737;0
WireConnection;959;0;956;0
WireConnection;959;1;916;0
WireConnection;726;0;749;0
WireConnection;952;0;946;0
WireConnection;952;1;948;0
WireConnection;913;0;915;0
WireConnection;913;1;959;0
WireConnection;938;0;939;0
WireConnection;938;1;940;0
WireConnection;951;0;950;0
WireConnection;951;1;949;3
WireConnection;951;2;952;0
WireConnection;936;0;937;0
WireConnection;936;1;938;0
WireConnection;921;1;951;0
WireConnection;921;2;920;0
WireConnection;919;1;951;0
WireConnection;919;2;918;0
WireConnection;955;0;953;0
WireConnection;923;0;922;0
WireConnection;947;0;912;0
WireConnection;947;1;960;3
WireConnection;947;2;913;0
WireConnection;947;3;914;0
WireConnection;954;0;955;1
WireConnection;954;1;947;0
WireConnection;925;0;923;0
WireConnection;925;1;919;0
WireConnection;934;0;933;0
WireConnection;934;1;935;3
WireConnection;934;2;936;0
WireConnection;934;3;941;0
WireConnection;924;0;923;2
WireConnection;924;1;921;0
WireConnection;917;0;955;0
WireConnection;917;1;954;0
WireConnection;917;2;955;2
WireConnection;958;0;934;0
WireConnection;958;1;943;0
WireConnection;926;0;925;0
WireConnection;926;1;923;1
WireConnection;926;2;924;0
WireConnection;864;0;958;0
WireConnection;320;0;284;0
WireConnection;647;0;917;0
WireConnection;808;0;926;0
WireConnection;603;0;598;0
WireConnection;603;1;1;0
WireConnection;603;4;1;4
WireConnection;606;0;598;0
WireConnection;606;5;299;1
WireConnection;605;0;598;0
WireConnection;605;2;320;0
WireConnection;605;3;241;0
WireConnection;756;0;843;0
WireConnection;731;0;775;0
WireConnection;731;1;669;0
WireConnection;731;2;751;0
WireConnection;731;3;747;0
WireConnection;731;4;742;0
WireConnection;604;0;603;0
WireConnection;604;1;605;0
WireConnection;604;2;606;0
WireConnection;310;0;604;0
WireConnection;868;0;702;0
WireConnection;868;1;673;0
WireConnection;868;2;731;0
WireConnection;868;3;731;0
WireConnection;734;0;793;0
WireConnection;309;1;306;0
WireConnection;313;0;604;0
WireConnection;313;1;317;0
WireConnection;718;0;729;0
WireConnection;718;1;868;0
WireConnection;314;0;310;0
WireConnection;314;2;309;0
WireConnection;963;0;961;0
WireConnection;963;1;962;0
WireConnection;964;0;963;0
WireConnection;964;1;962;0
WireConnection;692;0;718;0
WireConnection;692;1;687;0
WireConnection;316;0;312;0
WireConnection;316;1;604;0
WireConnection;316;2;313;0
WireConnection;316;3;314;0
WireConnection;908;2;316;0
WireConnection;908;11;692;0
ASEEND*/
//CHKSM=31DD0B2FA4D877A3A79A0E57BCA7A2C25B135C8D