Shader "Dissolve/Diffuse" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_DissolveTex ("Dissolve (R)", 2D) = "white" {}
}

SubShader {
	Tags {"IgnoreProjector"="True" "RenderType"="TransparentCutout"}
	LOD 300

CGPROGRAM
#pragma surface surf Lambert alphatest:Zero
sampler2D _MainTex;
sampler2D _DissolveTex;
float4 _Color;

struct Input {
	float2 uv_MainTex;
	float2 uv_DissolveTex;
};

void surf (Input IN, inout SurfaceOutput o) {
	half4 tex = tex2D(_MainTex, IN.uv_MainTex);
	half4 texd = tex2D(_DissolveTex, IN.uv_DissolveTex);
	o.Albedo = tex.rgb * _Color.rgb;
	o.Alpha = _Color.a - texd.r;
}
ENDCG
}

Fallback "Transparent/Cutout/VertexLit"
}