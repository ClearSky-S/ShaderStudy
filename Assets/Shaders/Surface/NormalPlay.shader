Shader "Custom/NormalPlay"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _myX ("Nx", Range(-10, 10)) = 1
        _myY ("Ny", Range(-10, 10)) = 1
        _myZ ("Nz", Range(-10, 10)) = 1
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

        struct Input
        {
            float2 uv_MainTex;
            INTERNAL_DATA
            float3 worldNormal; // Normal 값을 추가로 가져옵니다.
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        half _myX;
        half _myY;
        half _myZ;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            // o.Alpha = c.a;
            o.Albedo = normalize(IN.worldNormal);
            // o.Normal = float3(0,0,1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
