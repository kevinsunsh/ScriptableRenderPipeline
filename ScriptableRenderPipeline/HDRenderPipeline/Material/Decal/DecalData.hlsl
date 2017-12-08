﻿//-------------------------------------------------------------------------------------
// Fill SurfaceData/Builtin data function
//-------------------------------------------------------------------------------------
#include "ShaderLibrary/Packing.hlsl"
#include "ShaderLibrary/SampleUVMapping.hlsl"

void GetSurfaceData(float2 texCoordDS, out DecalSurfaceData surfaceData)
{
	surfaceData.baseColor = float4(0,0,0,0);
	surfaceData.normalWS = float4(0,0,0,0);
	float totalBlend = _DecalBlend;
#if _COLORMAP
	surfaceData.baseColor = SAMPLE_TEXTURE2D(_BaseColorMap, sampler_BaseColorMap, texCoordDS.xy); 
	totalBlend *= surfaceData.baseColor.w;
	surfaceData.baseColor.w = totalBlend;
#endif
	UVMapping texCoord;
	ZERO_INITIALIZE(UVMapping, texCoord);
	texCoord.uv = texCoordDS.xy;
#if _NORMALMAP
	surfaceData.normalWS.xyz = mul((float3x3)_DecalToWorldR, SAMPLE_UVMAPPING_NORMALMAP(_NormalMap, sampler_NormalMap, texCoord, 1)) * 0.5f + 0.5f;
	surfaceData.normalWS.w = totalBlend;
#endif
}
