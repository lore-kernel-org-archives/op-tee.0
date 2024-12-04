From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 09/10] arm64: dts: qcom: sm8650: add support for QTEE
Date: Wed, 04 Dec 2024 12:00:58 +1100
Message-ID: <e9c048b1-6027-46a5-afc3-d8a964a0fdce@quicinc.com>
In-Reply-To: <11038b0c-e9f7-46ce-bd7f-2d763db230cb@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2372175792634823096=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2372175792634823096==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit



On 12/3/2024 6:59 PM, Krzysztof Kozlowski wrote:
> On 03/12/2024 05:19, Amirreza Zarrabi wrote:
>> Add qcom_tee node.
> 
> Why? "What" we see from the diff. Stop repeating subjects, but say
> something useful. This applies to all your patches.
> 
> Anyway, your driver and binding say that this is just a fake node used
> purely to instantiate the Linux driver. Drop the patch.
> 

Hi Krzysztof,

Thank you so much for your comments. I totally understand.
I'll remove the fake node.

Best Regards,
Amir

> 
> Best regards,
> Krzysztof

--===============2372175792634823096==--

