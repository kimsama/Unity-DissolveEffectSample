// Unlit shader. Simplest possible textured shader.
// - no lighting
// - no lightmap support
// - no per-material color

Shader "Dissolve/Unlit" {
Properties {
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_DissolveTex ("Dissolve (R)", 2D) = "white" {}
	_Color ("Main Color", Color) = (1,1,1,1)
}

SubShader {
	Tags { "IgnoreProjector"="True" "RenderType"="TransparentCutout" }
	LOD 300
	
	Pass {  
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata_t {
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				float2 uv_dissolve : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				half2 texcoord : TEXCOORD0;
				half2 uv_dissolve : TEXCOORD0;
			};

			sampler2D _MainTex;
			sampler2D _DissolveTex;
			float4 _MainTex_ST;
			float4 _DissolveTex_ST;
			float4 _Color;
			
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.uv_dissolve = TRANSFORM_TEX(v.uv_dissolve, _DissolveTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.texcoord);
				fixed4 cold = tex2D(_DissolveTex, i.uv_dissolve);

                //.rgb = col * rgb * _Color.rbg;
				col = fixed4(col.r*_Color.r, col.g*_Color.g, col.b*_Color.b, col.a*_Color.a);
				col.a = _Color.a - cold.r;
				return col;
			}
		ENDCG
	}
}

}
