//////////////////////////////////////////////////////////////////////////
// dissolveEmissive.shader
//
//  A shader for dissovle effect.
//
// (c) 2014 hwkim
//////////////////////////////////////////////////////////////////////////
Shader "Dissolve/Emissive" { 
 
Properties { 
    _Color ("Main Color", Color) = (1,1,1,1) 
    _EdgeColor ("Edge Color", Color) = (1,0,0)
    _EdgeWidth ("Edge Width", Range(0,1)) = 0.1
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
    float3 _EdgeColor;
    float _EdgeWidth; 
     
    struct Input { 
        float2 uv_MainTex; 
        float2 uv_DissolveTex;
    }; 
     
    void surf (Input IN, inout SurfaceOutput o) { 
        half4 tex = tex2D(_MainTex, IN.uv_MainTex); 
        half4 texd = tex2D(_DissolveTex, IN.uv_DissolveTex); 
        o.Emission = tex.rgb * _Color.rgb; 
        o.Gloss = tex.a; 
        o.Alpha = _Color.a - texd.r; 
        //if ((o.Alpha < 0)(o.Alpha > -_EdgeWidth)(_Color.a>0)) 
        //{ 
        //    o.Alpha = 1; 
        //    o.Emission = _EdgeColor;
        //} 
    }     
    ENDCG 
}
 
Fallback "Transparent/Cutout/Soft Edge Unlit" 
}