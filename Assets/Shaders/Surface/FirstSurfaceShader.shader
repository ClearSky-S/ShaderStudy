Shader "Custom/HelloShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _Emission ("Emission", Color) = (0,0,0,0)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Normal ("Normal", Vector) =  (0, 0, 1)
        _Environment ("Environment", CUBE) = "black" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        samplerCUBE _Environment;

        struct Input
        {
            float2 uv_MainTex;
            INTERNAL_DATA // WorldNormalVector, WorldReflectionVector 사용을 위한 필수 데이터
            float3 worldRefl;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        fixed4 _Emission;
        half3 _Normal;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
        // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = 1;
            // fixed4 tex = tex2D (_MainTex, IN.uv_MainTex);
            // fixed4 c = tex*_Color;
            // o.Albedo = c.rgb;
            // o.Alpha = c.a;
            // o.Emission = _Emission.rgb + texCUBE(_Environment, IN.worldRefl).rgb;
            o.Normal = float3(0, 0, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
