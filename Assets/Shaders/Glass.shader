Shader "Holistic/Glass"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_BumpMap ("Bump Map", 2D) = "bump" {}
		_ScaleUVX ("Scale X", Range(1,10)) = 1
		_ScaleUVY ("Scale Y", Range(1,10)) = 1
	}
	SubShader
	{
		Tags{ "Queue" = "Transparent"}
		GrabPass{}
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 uvgrab : TEXCOORD1;
				float4 vertex : SV_POSITION;
			};

			sampler2D _GrabTexture;
			float4 _GrabTexture_TexelSize;
			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _ScaleUVX;
			float _ScaleUVY;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);

				// vertex to NDC
				o.uvgrab = ComputeGrabScreenPos (o.vertex);
				// o.uvgrab = o.vertex/o.vertex.w*0.5+0.5;
				// o.uvgrab = float3(o.uvgrab.x, 1-o.uvgrab.y, o.vertex.z);

				
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv.x = sin(o.uv.x * _ScaleUVX);
				o.uv.y = sin(o.uv.y * _ScaleUVY);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2Dproj(_GrabTexture, i.uvgrab) * float4(2,1,1,1);
				return col;
			}
			ENDCG
		}
	}
}
