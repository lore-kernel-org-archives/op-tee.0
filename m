From: Krzysztof Kozlowski <krzk@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 09/10] arm64: dts: qcom: sm8650: add support for QTEE
Date: Tue, 03 Dec 2024 08:59:45 +0100
Message-ID: <11038b0c-e9f7-46ce-bd7f-2d763db230cb@kernel.org>
In-Reply-To: <=?utf-8?q?=3C20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-?=
 =?utf-8?q?9-f502ef01e016=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4104058316385321149=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4104058316385321149==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 03/12/2024 05:19, Amirreza Zarrabi wrote:
> Add qcom_tee node.

Why? "What" we see from the diff. Stop repeating subjects, but say
something useful. This applies to all your patches.

Anyway, your driver and binding say that this is just a fake node used
purely to instantiate the Linux driver. Drop the patch.


Best regards,
Krzysztof

--===============4104058316385321149==--

