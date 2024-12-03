From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 09/10] arm64: dts: qcom: sm8650: add support for QTEE
Date: Mon, 02 Dec 2024 20:19:25 -0800
Message-ID: <20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-9-f502ef01e016@quicinc.com>
In-Reply-To: <=?utf-8?q?=3C20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-?=
 =?utf-8?q?0-f502ef01e016=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7906227075818644191=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7906227075818644191==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add qcom_tee node.

Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/=
sm8650.dtsi
index 25e47505adcb..41505b032e3a 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -372,6 +372,10 @@ scm: scm {
 			interconnects =3D <&aggre2_noc MASTER_CRYPTO QCOM_ICC_TAG_ALWAYS
 					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
+
+		qcom_tee {
+			compatible =3D "qcom,tee";
+		};
 	};
=20
 	clk_virt: interconnect-0 {

--=20
2.34.1


--===============7906227075818644191==--

