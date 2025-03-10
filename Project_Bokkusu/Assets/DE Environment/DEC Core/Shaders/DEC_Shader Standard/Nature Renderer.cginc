// Copyright 2020 Visual Design Cafe. All rights reserved.
// Package: Nature Shaders
// Website: https://www.visualdesigncafe.com/nature-shaders
// Documentation: https://support.visualdesigncafe.com/hc/categories/900000043503

#ifndef NODE_INSTANCED_INCLUDED
#define NODE_INSTANCED_INCLUDED

#define Use_Macro_UNITY_MATRIX_M_instead_of_unity_ObjectToWorld unity_ObjectToWorld
#define Use_Macro_UNITY_MATRIX_I_M_instead_of_unity_WorldToObject unity_WorldToObject

#ifdef NATURE_RENDERER

    #ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED


    struct CompressedFloat4x4
    {
        uint positionXY;
        uint positionZ_scale;
        uint rotationXY;
        uint rotationZW;
    };

    uniform float3 _CompressionRange;
    uniform float3 _CompressionBase;


    uint CompressToUshort( float value, float precision )
    {
        return (uint)(value / precision * 65535.0);
    }

    uint CompressToByte( float value, float precision )
    {
        return (uint)(value / precision * 255.0);
    }

    float DecompressFromByte( uint value, float precision )
    {
        return value / 255.0 * precision;
    }

    float DecompressFromUshort( uint value, float precision )
    {
        return value / 65535.0 * precision;
    }

    void _UnpackInt( uint packedInt, out uint a, out uint b )
    {
        a = ( (uint) (packedInt >> 16) );
        b = ( (uint) ((packedInt << 16) >> 16) );
    }

    void _UnpackShort( uint packedShort, out uint a, out uint b )
    {
        a = ( (uint) (packedShort >> 8) );
        b = ( (uint) ((packedShort << 24) >> 24) );
    }

    uint _PackInt( uint ushortA, uint ushortB )
    {
        return ushortA << 16 | ushortB;
    }

    uint _PackShort( uint byteA, uint byteB )
    {
        return (byteA << 8) | byteB;
    }

    float4x4 QuaternionToMatrix(float4 quaternion)
    {
        float4x4 result = (float4x4)0;
        float x = quaternion.x;
        float y = quaternion.y;
        float z = quaternion.z;
        float w = quaternion.w;

        float x2 = x + x;
        float y2 = y + y;
        float z2 = z + z;
        float xx = x * x2;
        float xy = x * y2;
        float xz = x * z2;
        float yy = y * y2;
        float yz = y * z2;
        float zz = z * z2;
        float wx = w * x2;
        float wy = w * y2;
        float wz = w * z2;

        result[0][0] = 1.0 - (yy + zz);
        result[0][1] = xy - wz;
        result[0][2] = xz + wy;

        result[1][0] = xy + wz;
        result[1][1] = 1.0 - (xx + zz);
        result[1][2] = yz - wx;

        result[2][0] = xz - wy;
        result[2][1] = yz + wx;
        result[2][2] = 1.0 - (xx + yy);

        result[3][3] = 1.0;

        return result;
    }

    void DecompressInstanceMatrix( inout float4x4 instance, CompressedFloat4x4 compressedMatrix )
    {
        uint positionX, positionY, positionZ;
        uint scaleXYZ;
        uint rotationX, rotationY, rotationZ, rotationW;

        _UnpackInt( compressedMatrix.positionXY, positionX, positionY );
        _UnpackInt( compressedMatrix.positionZ_scale, positionZ, scaleXYZ );
        _UnpackInt( compressedMatrix.rotationXY, rotationX, rotationY );
        _UnpackInt( compressedMatrix.rotationZW, rotationZ, rotationW );

        uint scaleX, scaleY;
        _UnpackShort( scaleXYZ, scaleX, scaleY );

        float3 position = 
            float3(
                DecompressFromUshort(positionX, _CompressionRange.x) + _CompressionBase.x,
                DecompressFromUshort(positionY, _CompressionRange.y) + _CompressionBase.y,
                DecompressFromUshort(positionZ, _CompressionRange.z) + _CompressionBase.z );

        float3 scale =
            float3(
                DecompressFromByte(scaleX, 16.0),
                DecompressFromByte(scaleY, 16.0),
                DecompressFromByte(scaleX, 16.0) );

        float4 rotation =
            float4(
                DecompressFromUshort(rotationX, 2.0) - 1.0,
                DecompressFromUshort(rotationY, 2.0) - 1.0,
                DecompressFromUshort(rotationZ, 2.0) - 1.0,
                DecompressFromUshort(rotationW, 2.0) - 1.0 );

        instance = QuaternionToMatrix( rotation );
        
        instance[0][0] *= scale.x; instance[1][0] *= scale.y; instance[2][0] *= scale.z;
        instance[0][1] *= scale.x; instance[1][1] *= scale.y; instance[2][1] *= scale.z;
        instance[0][2] *= scale.x; instance[1][2] *= scale.y; instance[2][2] *= scale.z;
        instance[0][3] *= scale.x; instance[1][3] *= scale.y; instance[2][3] *= scale.z;

        instance[0][3] = position.x;
        instance[1][3] = position.y;
        instance[2][3] = position.z;
    }

    #if defined(SHADER_API_GLCORE) \
        || defined(SHADER_API_D3D11) \
        || defined(SHADER_API_GLES3) \
        || defined(SHADER_API_METAL) \
        || defined(SHADER_API_VULKAN) \
        || defined(SHADER_API_PSSL) \
        || defined(SHADER_API_XBOXONE)
    uniform StructuredBuffer<CompressedFloat4x4> _NatureRendererBuffer;
    #endif

    float4x4 inverse(float4x4 input)
    {
        #define minor(a,b,c) determinant(float3x3(input.a, input.b, input.c))
        
        float4x4 cofactors = float4x4(
            minor(_22_23_24, _32_33_34, _42_43_44), 
            -minor(_21_23_24, _31_33_34, _41_43_44),
            minor(_21_22_24, _31_32_34, _41_42_44),
            -minor(_21_22_23, _31_32_33, _41_42_43),
            
            -minor(_12_13_14, _32_33_34, _42_43_44),
            minor(_11_13_14, _31_33_34, _41_43_44),
            -minor(_11_12_14, _31_32_34, _41_42_44),
            minor(_11_12_13, _31_32_33, _41_42_43),
            
            minor(_12_13_14, _22_23_24, _42_43_44),
            -minor(_11_13_14, _21_23_24, _41_43_44),
            minor(_11_12_14, _21_22_24, _41_42_44),
            -minor(_11_12_13, _21_22_23, _41_42_43),
            
            -minor(_12_13_14, _22_23_24, _32_33_34),
            minor(_11_13_14, _21_23_24, _31_33_34),
            -minor(_11_12_14, _21_22_24, _31_32_34),
            minor(_11_12_13, _21_22_23, _31_32_33)
        );
        #undef minor
        return transpose(cofactors) / determinant(input);
    }
    #endif

    // Pre-calculate and cache data for Nature Shaders that relies on
    // per-object data instead of per-vertex or per-pixel.
    #if defined(UNITY_PROCEDURAL_INSTANCING_ENABLED) && defined(NATURE_SHADERS)
        
        #define PER_OBJECT_VALUES_CALCULATED
        
        float g_WindFade;
        float g_ScaleFade;
        float g_WorldNoise;
        float3 g_ObjectPivot;
        float3 g_ConstantWindOffset;
        float g_PivotOffset;
        float3 g_WorldNormal;

        #include "../Input/Fade.cginc"
        #include "../Procedural/Perlin Noise.cginc"
        #include "../Input/Wind Direction.cginc"

        void PreCalculateNatureShadersData()
        {
            g_ObjectPivot = GetAbsolutePositionWS( TransformObjectToWorld( float3(0,0,0) ) );
            g_ConstantWindOffset = cross( GetWindDirection().xyz, float3(0,1,0) );
            g_PivotOffset = length( float3(g_ObjectPivot.x, 0, g_ObjectPivot.z) );
            g_WorldNormal = TransformObjectToWorldDir( float3(0, 0, 1) );

            GetFade( g_ObjectPivot, g_WindFade, g_ScaleFade );
            PerlinNoise( g_ObjectPivot.xz, _ColorVariationSpread, g_WorldNoise);
        }
    #endif
#else
    struct IndirectShaderData
	{
		float4x4 PositionMatrix;
		float4x4 InversePositionMatrix;
		float4 ControlData;
	};

	#if defined(SHADER_API_GLCORE) \
        || defined(SHADER_API_D3D11) \
        || defined(SHADER_API_GLES3) \
        || defined(SHADER_API_METAL) \
        || defined(SHADER_API_VULKAN) \
        || defined(SHADER_API_PSSL) \
        || defined(SHADER_API_XBOXONE)
    StructuredBuffer<IndirectShaderData> IndirectShaderDataBuffer;
    StructuredBuffer<IndirectShaderData> VisibleShaderDataBuffer;
	#endif	
#endif

void SetupNatureRenderer()
{
    #ifdef NATURE_RENDERER
        #ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
            DecompressInstanceMatrix(unity_ObjectToWorld, _NatureRendererBuffer[unity_InstanceID]);
            unity_WorldToObject = inverse(unity_ObjectToWorld);
        #endif

        #if defined(UNITY_PROCEDURAL_INSTANCING_ENABLED) && defined(NATURE_SHADERS)
            PreCalculateNatureShadersData();
        #endif
    #else
        #ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
			#ifdef GPU_FRUSTUM_ON
				unity_ObjectToWorld = VisibleShaderDataBuffer[unity_InstanceID].PositionMatrix;
				unity_WorldToObject = VisibleShaderDataBuffer[unity_InstanceID].InversePositionMatrix;
			#else
				unity_ObjectToWorld = IndirectShaderDataBuffer[unity_InstanceID].PositionMatrix;
				unity_WorldToObject = IndirectShaderDataBuffer[unity_InstanceID].InversePositionMatrix;
			#endif
		#endif
    #endif
}

void Instanced_float( float3 vertex, out float3 vertexOut )
{
    vertexOut = vertex;
}
#endif