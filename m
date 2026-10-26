Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37B606A31A
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 04:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=X4UJTR6j;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ars7puuj;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bWiy56xL
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 02C40452BB
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 04:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792989883;
	bh=2PqucPpUQo26vnk7RHR0MWeFdpzREQJCqzMGixLUfVk=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=X4UJTR6jqT587k8o2dmrx3AhVrIJgo3Gg+Y5daRcvBuUr4d7+rnUzUBZQT47FEpVN
	 Ij0kTtdyV12tf4vQ4XttdZtSxRz6dn5WF0abqTrYcdpWLExMd/CNxCStnF8yxUBGF7
	 bbD//1k9/spAsffPe/Oyqce+HOaHHIXmJ8DK9USuhoU8/wLRpPwGLfEEDe8Mird//T
	 KPhdTeHrpyvDix9Cha+rNBHqKGnNAP17MIF1wGRgxglqjyLRyWNCAo8RP4wKdmx8Gf
	 RBG2OAl2DIL2dJ4tRfalr5NOQeViKZPoHnQxrWPyzLdceG+x0hcMGxE/SRT93SVXvO
	 uyVZBy9nqduQw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 83DFB44E63
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Oct 2026 04:44:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ars7puuj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bWiy56xL;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b6fm1907790
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Oct 2026 04:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lsnuduDgCCRH7FONLrbGaPIpcgTkDpDG7VkAeg7v8Jw=; b=ars7puuj2u7QwYPk
	fA0QCPZKFOo/pXxI3OyRUdoHd/Iic1LpcQDA+dwTdSsOS4O0W93FFmfEujxaw0Ap
	bzoloJD5b4gM0n3FBgtjk/ic+3S7V3DKOAFulryP1aG7sfKz4w0AnuL42nABjfnM
	+6xjlLRtynWlBZAkqkpk7rGRnPflMsjfzH8ydUVcOqURsOa9yesxNxeCckThvZT/
	hVQAnmNbwpw8i0dFBhwAMHKZ8DUL7ytUsrJruAy2dz9g/qiDzQrIqKgxW7WPamtt
	pexkYog2nlYwizP9lzRIdGh3lU3MosDGGuaRwebOP/DiaSFQmuA2f+SgJ0WMqa1W
	5HY3kg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0gmugq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Oct 2026 04:44:22 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso4773223eec.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 25 Oct 2026 21:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792989862; x=1793594662; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsnuduDgCCRH7FONLrbGaPIpcgTkDpDG7VkAeg7v8Jw=;
        b=bWiy56xLWnNFKjClGhoLgouLXQTnSgE63fmnmrZBo77I3aH1xUHzewRpX3EjbzQ2rq
         dQi/sUDKQqbbnokinyOVllyQNhhl+dx+RZL+bqP9SZKZFwf7v1Gmx4CfJz8JnuKZmL1d
         ePdlgK7tIoimUjTa01suRDtajmPajZyUGwmR760wcnH6AoNkB4nEqb5sruLl6VMybZZ6
         aBGJA4+oT0UPggwcBWO4y6PKXlIN2XhR5Vp4Kn4lPgShvK0UJVmbrpiQerNOQbu7/onu
         owM8ppzHyBsDOlsf6CMDmf0+xHiztHS9fsW2jTEobm9H1ASq1W/c+j3iUAeZL0GPQTkB
         WYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792989862; x=1793594662;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lsnuduDgCCRH7FONLrbGaPIpcgTkDpDG7VkAeg7v8Jw=;
        b=dF3dgjinJMXppNmXFdy8ektM69hhdi5mjZPuk5sYI0/IyGz88nvknjLl4QoEbAzFrp
         dzgPO1MrsTcQ7htkM6M4pJkYaKDB8Mg9tjJJ1Q2U1wyXMppXSI/wwYHIvvPhuAm/SHwu
         phLk/JGDLQxLvNxNivuYzwnCaOj9UlJEmw3GBEmMCxg2/ASgGsNFj92hIESSuK1xA6Wm
         uPp0JCmtjDWbe/+THv6Oe2rMVCmeGRdMoptZreM8IDmOFlUFE7cpGqmIiJ9njUVRqK+1
         vbHgr5NJDmdUwmTfSlxlb9lY6W/eLl29oHge5ivjlmaHrbP3HjQexgNYdY8ut2LXx0gc
         k8XA==
X-Forwarded-Encrypted: i=1; AKwUvBxFnMrQn98lPGxtqShsO4MBvaxXYqDIhiOiaRCcORXQFOV3rRrRRSkLUMmh3f8HUwazkswWAtg=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLE5+dJCzO8PD+LMGIdKEQWpXVM/I5EnTBz0oZW6NCnbpl/ItlK
	i3wvH3Hab3DKgcww+e8KCATmmB+wts7uHv2oI1/7BTJwvXqXWE6XbfSVXI86kFxlKOuJRnKk6MP
	kLp9nVWT0KC+NJGPwnevonQgCt9HCsnsKCtXLNw5pZtSO/oOAbR9o4RmaDiJPXf0IY89N82c=
X-Gm-Gg: AYBFou2ZgtZ5Xh6lX1Lh2MZxsXfazfLP7gIUayw7TxZ/Ut8lqY1QdKK0hMTfWMgy53F
	5ezOVRnVfhyDCNNy95hne2dcF2EYbOIyADx/utCJpQ7zGyt6OrzQw2+Ar/5p31BNZvqyPOHq/Z7
	z5HSoowsYsSFfpN/ShYVu3HbauuPhqjXs4qAH+EMF4QmeCNs72CBSCdZC5piDeuKcXzmPV3fzFo
	NofrK2GQuAGQGmJbBRqjJJU3wbBqln7eR8sqFHp1SHaL09iVciRvPOqN6S9IOpvyEjcHi0aNujN
	+a8s7CIj0l+baG/JCCAOa8y+PIsY7yrcyXhpmnBfySTALcHaOUEpuYf9bqA7HEDc7KnChLhN7P6
	wZv2gzWNN8UfjeHivKMMM33TRiV7XOpbx
X-Received: by 2002:a05:693c:2807:b0:369:eec1:1d7e with SMTP id 5a478bee46e88-369eec12196mr7507471eec.11.1792989861168;
        Sun, 25 Oct 2026 21:44:21 -0700 (PDT)
X-Received: by 2002:a05:693c:2807:b0:369:eec1:1d7e with SMTP id 5a478bee46e88-369eec12196mr7507422eec.11.1792989860139;
        Sun, 25 Oct 2026 21:44:20 -0700 (PDT)
Received: from [192.168.1.86] ([206.83.119.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a002a486csm6781858eec.22.2026.10.25.21.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 21:44:19 -0700 (PDT)
Message-ID: <4fed24d1-72a4-4314-a6e0-89ee7546240b@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 15:44:13 +1100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] firmware: qcom: Add support for TEE based EFI-var
 client driver
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-6-1460691b35d3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-6-1460691b35d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LzJN8sLfqGRVAN4WdM2pQlEITSvZ3dGB
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adedaa6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=pnHLkUe0LhHGSDu6DPowAg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=wEvnRhFnY__mLrJFcrEA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: LzJN8sLfqGRVAN4WdM2pQlEITSvZ3dGB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAxOCBTYWx0ZWRfX6lBQTzxlImtr
 MKSv2NAm/9nJvmMpgQQ5ocZAVCQHG1d7+Si0w1teGcp35/+y5EtB+6YZt6RJICmsgiqxq7aexJv
 aEsZKCPq9apkefjJ91//hw+Izhap+CJ+R34Yu9IEsdzJrdquc6bulaJ2OwvC/htNjOmhCPdHVKx
 yqaFE2tHVO/NNrtruW4lXZ+4MhKNCxv4pmNXufV/qIflIoeqsny0ombFnFMfV8oX2F+jd9dTTJr
 PH3SuZMAAM4KIoG4yzxjI8cjc5ttkjk5giA3F5Y4XmueHvh7/iqpldvSklG80AIkPYoUgwWL8aZ
 RjtQdYgOvs5aL9WkEE4F1RwOT2t/4woxr5NlmlUr6l2B2pZU+1dZ+2Dhq6cME3BnndrafNoYP+/
 oEu/6Xw6o6R1r5wrV8eZpa/jwdGzPX2NLGSNpEJJLGO6OvLEMPT//U0WwjKwxPdpjtBr3luf1vE
 NqhgliePv5LS8rnhIjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAxOCBTYWx0ZWRfXzhiGzhFgzaKR
 0RoTzuqUerpDYOVhqKc6llp4+/HCpbCkh0hmKK4b8c+fO17VkNlvmJWSXCdHonJuULp9cUu0H+t
 R3nzDs+Q/fwtORfIMttKnujK67maSaE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260018
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[206.83.119.25:received,205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 83DFB44E63
X-Spamd-Bar: ------
Message-ID-Hash: BTEP6EKXQXFZP2UWVRQBQGIRRULQX3Z2
X-Message-ID-Hash: BTEP6EKXQXFZP2UWVRQBQGIRRULQX3Z2
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BTEP6EKXQXFZP2UWVRQBQGIRRULQX3Z2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Harshal,

On 10/15/2026 10:39 PM, Harshal Dev wrote:
> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
> Replay Protected Memory Block (RPMB) located within either the UFS,
> eMMC or SPI-NOR storage. The RPMB key which is one-time programmed into
> the storage controller to allow authentication of the RPMB frames is
> generated by and only available to the Qualcomm Trusted Execution
> Environment (QTEE).
> 
> The legacy QSEECOM protocol used for communicating with the QTEE is
> deprecated and replaced with the use-case agnostic SMCInvoke protocol
> starting with the Qualcomm SM8x50 series. On platforms where the QSEECOM
> driver still probes, it does not support a listener interface with QTEE
> to enable writing of non-volatile EFI variables to the RPMB for UFS and
> eMMC storage.
> Therefore on such platforms, a TEE client driver which communicates with
> QTEE via the SMCInvoke protocol implemented by the QCOMTEE driver (and
> registered with the TEE subsystem) must be used to update such EFI
> variables.
> 
> Add support for a TEE based uefisecapp client driver which installs efivar
> operations after obtaining an object reference to the uefisecapp service.
> This enables the kernel/user-space to access or modify both volatile EFI
> variables stored by the Secure Application (in-memory) and non-volatile
> ones stored within RPMB.
> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
>  MAINTAINERS                                 |   6 +
>  drivers/firmware/qcom/Kconfig               |  31 ++
>  drivers/firmware/qcom/Makefile              |   1 +
>  drivers/firmware/qcom/qcom_tee_uefisecapp.c | 644 ++++++++++++++++++++++++++++
>  4 files changed, 682 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 30c1cdd0fb38..7ccedad8d388 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22981,6 +22981,12 @@ L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
>  F:	drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
>  
> +QUALCOMM TEE UEFISECAPP DRIVER
> +M:	Harshal Dev <harshal.dev@oss.qualcomm.com>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/firmware/qcom/qcom_tee_uefisecapp.c
> +
>  QUALCOMM PINCTRL DRIVERS
>  M:	Bartosz Golaszewski <brgl@kernel.org>
>  L:	linux-arm-msm@vger.kernel.org
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index 3ad22f8fc3e5..694d98fef4f4 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -79,4 +79,35 @@ config QCOM_QSEECOM_UEFISECAPP
>  	  Select Y here to provide access to EFI variables on the aforementioned
>  	  platforms.
>  
> +config QCOM_TEE_UEFISECAPP
> +	tristate "Qualcomm TEE UEFI Secure App client driver"
> +	depends on QCOMTEE
> +	depends on EFI
> +	help
> +	  The QSEECOM protocol used for communicating with the Qualcomm Trusted
> +	  Execution Environment (QTEE) is deprecated and replaced with the SMCInvoke
> +	  protocol starting with the Qualcomm SM8x50 series. On platforms where the
> +	  QSEECOM protocol still works (the QSEECOM driver probes) the driver does
> +	  not support a listener interface with QTEE to enable writing of
> +	  non-volatile EFI variables (via listener requests to Linux) in the Replay
> +	  Protected Memory Block (RPMB) located on UFS/eMMC storage.
> +	  Therefore on such platforms, the TEE based uefisecapp client driver
> +	  (which communicates with QTEE via the SMCInvoke protocol) must be used
> +	  to update such EFI variables through the RPMB service hosted in the QTEE
> +	  supplicant user-space daemon (github.com/qualcomm/minkipc) which forwards
> +	  RPMB packets to the RPMB device.
> +	  NOTE: Qualcomm Compute platforms with SPI-NOR storage are an exception to
> +	  this scenario. Since they do not have a firmware running on their SPI-NOR
> +	  storage controller which must be programmed with a RPMB key, QTEE has a
> +	  SPI-NOR driver which holds the key, and so the QSEECOM driver can be used
> +	  for updating EFI variables on these platforms because QTEE never makes a
> +	  listener request to Linux (QTEE doesn't need the Linux SPI-NOR driver).
> +
> +	  This module provides a TEE client driver for uefisecapp, installing efivar
> +	  operations to allow the kernel and user-space access to EFI variables.
> +
> +	  Select m here to provide access to EFI variables on the aforementioned
> +	  platforms if your Linux distribution has QTEE supplicant installed and
> +	  running.
> +
>  endmenu
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> index 88ce74d74c3e..237192b74de3 100644
> --- a/drivers/firmware/qcom/Makefile
> +++ b/drivers/firmware/qcom/Makefile
> @@ -9,5 +9,6 @@ CFLAGS_qcom_scm-smc.o := -I$(src)
>  obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
> +obj-$(CONFIG_QCOM_TEE_UEFISECAPP) += qcom_tee_uefisecapp.o
>  obj-$(CONFIG_QCOM_PAS)		+= qcom_pas.o
>  obj-$(CONFIG_QCOM_PAS_TEE)	+= qcom_pas_tee.o
> diff --git a/drivers/firmware/qcom/qcom_tee_uefisecapp.c b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
> new file mode 100644
> index 000000000000..bcd025f929fc
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_tee_uefisecapp.c
> @@ -0,0 +1,644 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/efi.h>
> +#include <linux/tee.h>
> +#include <linux/tee_drv.h>
> +#include <linux/ucs2_string.h>
> +
> +#define QCOMTEE_OP_CLIENT_ENV_OPEN 0
> +#define QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS 5
> +
> +/* Each service exposed by QTEE is identified by a 32-bit UID */
> +#define QCOMTEE_UEFI_SEC_UID                 413
> +
> +/* Operations supported by the UEFI Sec App service */
> +#define QCOMTEE_UEFI_SEC_OP_GET_VAR 0
> +#define QCOMTEE_UEFI_SEC_OP_SET_VAR 1
> +#define QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO 2
> +#define QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME 3
> +
> +#define QCOMTEE_GET_VAR_NPARAMS 5
> +#define QCOMTEE_SET_VAR_NPARAMS 4
> +#define QCOMTEE_QUERY_VAR_NPARAMS 2
> +#define QCOMTEE_GET_NEXT_VAR_NPARAMS 4
> +#define QCOMTEE_GET_UEFI_SVC_NPARAMS 2
> +#define QCOMTEE_GET_CLIENT_ENV_NPARAMS 2
> +
> +/* Error codes returned by the UEFI Sec App service */
> +#define QCOMTEE_UEFI_SEC_SUCCESS 0
> +#define QCOMTEE_UEFI_SEC_ERROR_INVALID_PARAMETER 10
> +#define QCOMTEE_UEFI_SEC_ERROR_UNSUPPORTED 11
> +#define QCOMTEE_UEFI_SEC_ERROR_WRITE_PROTECTED 12
> +#define QCOMTEE_UEFI_SEC_ERROR_SECURITY_VIOLATION 13
> +#define QCOMTEE_UEFI_SEC_ERROR_DEVICE_ERROR 14
> +#define QCOMTEE_UEFI_SEC_ERROR_OUT_OF_RESOURCES 15
> +#define QCOMTEE_UEFI_SEC_ERROR_VOLUME_CORRUPTED 16
> +#define QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT 17
> +#define QCOMTEE_UEFI_SEC_ERROR_NOT_FOUND 18
> +#define QCOMTEE_UEFI_SEC_ERROR_ALREADY_STARTED 19
> +
> +/* Operations for objects are 32-bit. QCOMTEE transport uses the upper 16 bits. */
> +#define QCOMTEE_MSG_OBJECT_OP_MASK GENMASK(15, 0)
> +#define QCOMTEE_MSG_OBJECT_OP_RELEASE (QCOMTEE_MSG_OBJECT_OP_MASK - 0)
> +
> +/**
> + * struct qcomtee_uefisec_app - An instance of UEFI Secure Application.
> + * @dev: TEE client device on the TEE bus which represents uefisecapp.
> + * @ctx: The context opened with the TEE subsystem by the uefisecapp client.
> + * @uefisec_svc_obj: A TEE object representing the uefisecapp service.
> + * @efivars: EFI variables registered with the EFI subsystem.
> + */
> +struct qcomtee_uefisec_app {
> +	struct device *dev;
> +	struct tee_context *ctx;
> +	struct tee_param_objref uefisec_svc_obj;
> +	struct efivars efivars;
> +};
> +
> +#define UEFISECAPP_UUID \
> +	UUID_INIT(0x01f95dcd, 0x2d7e, 0x58be, \
> +		  0xa1, 0x43, 0x81, 0x32, 0xa1, 0x72, 0xdb, 0x7d)
> +
> +/* Short-hands for these long attribute names */
> +#define UBUF_INPUT     TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT
> +#define UBUF_OUTPUT    TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT
> +#define OBJREF_INPUT   TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT
> +#define OBJREF_OUTPUT  TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT
> +
> +/* Init instance of 'struct tee_param_objref'. */
> +#define SET_TEE_PARAM_OBJREF(param, attri, obj_id, obj_flag) do { \
> +		(param).attr = (attri); \
> +		(param).u.objref.id = (obj_id); \
> +		(param).u.objref.flags = (obj_flag); \
> +	} while (0)
> +
> +/* Init instance of 'struct tee_param_ubuf'. */
> +#define SET_TEE_PARAM_UBUF(param, attri, ubuff) do { \
> +		(param).attr = (attri); \
> +		(param).u.ubuf = (ubuff);  \
> +	} while (0)
> +
> +#define TEE_PARAM_UBUF(x) ((struct tee_param_ubuf){ .addr = &(x), sizeof(x) })
> +
> +#define SET_INVOKE_ARG(arg, object_id, opp, nparam) do { \
> +		(arg).id = (object_id); \
> +		(arg).op = (opp); \
> +		(arg).num_params = (nparam); \
> +	} while (0)
> +
> +static inline efi_status_t uefisecapp_err_to_efi_status(u32 err)
> +{
> +	switch (err) {
> +	case QCOMTEE_UEFI_SEC_SUCCESS:
> +		return EFI_SUCCESS;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_INVALID_PARAMETER:
> +		return EFI_INVALID_PARAMETER;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_UNSUPPORTED:
> +		return EFI_UNSUPPORTED;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_WRITE_PROTECTED:
> +		return EFI_WRITE_PROTECTED;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_SECURITY_VIOLATION:
> +		return EFI_SECURITY_VIOLATION;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_DEVICE_ERROR:
> +		return EFI_DEVICE_ERROR;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_OUT_OF_RESOURCES:
> +		return EFI_OUT_OF_RESOURCES;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT:
> +		return EFI_BUFFER_TOO_SMALL;
> +
> +	case QCOMTEE_UEFI_SEC_ERROR_NOT_FOUND:
> +		return EFI_NOT_FOUND;
> +
> +	/* No matching on EFI_* list. */
> +	case QCOMTEE_UEFI_SEC_ERROR_ALREADY_STARTED: /* EFI_ALREADY_STARTED.  */
> +	case QCOMTEE_UEFI_SEC_ERROR_VOLUME_CORRUPTED: /* EFI_VOLUME_CORRUPTED. */
> +	default:
> +		return EFI_DEVICE_ERROR;
> +	}
> +}
> +
> +/*
> + * This singleton is implicitly protected against concurrent access via
> + * efivar_lock() implemented by the efivar framework.
> + */
> +static struct qcomtee_uefisec_app uefisec_app;
> +
> +static int qcuefi_get_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
> +			       struct tee_param_ubuf in_attributes,
> +			       struct tee_param_ubuf *data,
> +			       u32 *out_attributes, u32 *out_errno)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
> +	struct tee_param param[QCOMTEE_GET_VAR_NPARAMS];
> +
> +	struct {
> +		efi_guid_t guid;
> +		u32 in_data_size;
> +	} in_cong = { 0 };
> +
> +	struct {
> +		u32 out_data_size;
> +		u32 attributes;
> +		u32 errno;
> +	} out_cong = { 0 };
> +
> +	in_cong.guid = *guid;
> +	in_cong.in_data_size = data->size;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, obj_id,
> +		       QCOMTEE_UEFI_SEC_OP_GET_VAR,
> +		       QCOMTEE_GET_VAR_NPARAMS);
> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
> +	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
> +	SET_TEE_PARAM_UBUF(param[2], UBUF_INPUT, in_attributes);
> +	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
> +	SET_TEE_PARAM_UBUF(param[4], UBUF_OUTPUT, *data);
> +
> +	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_GET_VAR invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	data->size = out_cong.out_data_size;
> +	*out_attributes = out_cong.attributes;
> +	*out_errno = out_cong.errno;
> +
> +	return ret;
> +}
> +
> +static efi_status_t qcomtee_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid,
> +					      u32 *attr, unsigned long *data_size,
> +					      void *data)
> +{
> +	int ret;
> +	u32 in_attr, out_attributes, out_errno;
> +	struct tee_param_ubuf in_data, in_var, in_attributes;
> +
> +	if (!name || !guid)
> +		return EFI_INVALID_PARAMETER;
> +
> +	/*
> +	 * 'attr' can be NULL, however an input attribute is always expected
> +	 * by UefiSecApp TA
> +	 */

You are enforceing a poliy on the arguments of a cb which is called publicly, are you
sure all callers understand that this output value is optional? it is not specified
anywhere as far as I can see. This seesm to be a TA thing.

> +	in_attr = 0;
> +	if (attr)
> +		in_attr = *attr;
> +
> +	in_data = (struct tee_param_ubuf){ .addr = data, *data_size };
> +	in_var = (struct tee_param_ubuf){ .addr = name,
> +					  (ucs2_strlen(name) + 1) * sizeof(*name) };
> +	in_attributes = (struct tee_param_ubuf){ .addr = &in_attr, sizeof(u32) };
> +
> +	/* On SUCCESS, 'data' member of 'in_data' has already been updated. */
> +	ret = qcuefi_get_variable(in_var, guid, in_attributes, &in_data,
> +				  &out_attributes, &out_errno);
> +
> +	if (ret)
> +		return EFI_DEVICE_ERROR;
> +
> +	if (!out_errno || out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT) {
> +		/* If 'attr' is NULL 'out_attributes' is not updated. */
> +		if (attr)
> +			*attr = out_attributes;
> +
> +		*data_size = in_data.size;
> +	}
> +
> +	return uefisecapp_err_to_efi_status(out_errno);
> +}
> +
> +static int qcuefi_set_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
> +			       u32 attributes, struct tee_param_ubuf data,
> +			       u32 *out_errno)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
> +	struct tee_param param[QCOMTEE_SET_VAR_NPARAMS];
> +
> +	struct {
> +		efi_guid_t guid;
> +		u32 attributes;
> +		u32 in_data_size;
> +	} in_cong = { 0 };
> +
> +	in_cong.guid = *guid;
> +	in_cong.attributes = attributes;
> +	in_cong.in_data_size = data.size;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, obj_id,
> +		       QCOMTEE_UEFI_SEC_OP_SET_VAR,
> +		       QCOMTEE_SET_VAR_NPARAMS);
> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
> +	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
> +	SET_TEE_PARAM_UBUF(param[2], UBUF_INPUT, data);
> +	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, TEE_PARAM_UBUF(*out_errno));
> +
> +	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_SET_VAR invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static efi_status_t qcomtee_uefi_set_variable(efi_char16_t *name, efi_guid_t *guid,
> +					      u32 attr, unsigned long data_size,
> +					      void *data)
> +{
> +	int ret;
> +	u32 out_errno;
> +	struct tee_param_ubuf in_data, in_var;
> +
> +	if (!name || !guid)
> +		return EFI_INVALID_PARAMETER;
> +
> +	in_data = (struct tee_param_ubuf){ .addr = data, data_size };
> +	in_var = (struct tee_param_ubuf){ .addr = name,
> +					  (ucs2_strlen(name) + 1) * sizeof(*name) };
> +
> +	ret = qcuefi_set_variable(in_var, guid, attr, in_data, &out_errno);
> +	if (ret)
> +		return EFI_DEVICE_ERROR;
> +
> +	return uefisecapp_err_to_efi_status(out_errno);
> +}
> +
> +static int qcuefi_get_next_variable(struct tee_param_ubuf in_variable, efi_guid_t *guid,
> +				    struct tee_param_ubuf *out_variable,
> +				    efi_guid_t *out_vendor_guid, u32 *out_errno)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
> +	struct tee_param param[QCOMTEE_GET_NEXT_VAR_NPARAMS];
> +
> +	struct {
> +		efi_guid_t guid;
> +		u32 in_data_size;
> +	} in_cong = { 0 };
> +
> +	struct {
> +		efi_guid_t guid;
> +		u32 out_data_size;
> +		u32 errno;
> +	} out_cong = { 0 };
> +
> +	/* Pass size of available buffer */
> +	in_cong.in_data_size = out_variable->size;
> +	in_cong.guid = *guid;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, obj_id,
> +		       QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME,
> +		       QCOMTEE_GET_NEXT_VAR_NPARAMS);
> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(in_cong));
> +	SET_TEE_PARAM_UBUF(param[1], UBUF_INPUT, in_variable);
> +	SET_TEE_PARAM_UBUF(param[2], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
> +	SET_TEE_PARAM_UBUF(param[3], UBUF_OUTPUT, *out_variable);
> +
> +	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_GET_NEXT_VAR_NAME invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	/*
> +	 * UefiSecApp TA does not touch 'out_variable.size'. Update it here.
> +	 * On SUCCESS (!out_errno), 'out_data_size' is length of name in
> +	 * 'out_variable.addr'.
> +	 * On failure (out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT),
> +	 * 'out_data_size' is actual name length.
> +	 * Otherwise, it's undefined.
> +	 */
> +	out_variable->size = out_cong.out_data_size;
> +	*out_vendor_guid = out_cong.guid;
> +	*out_errno = out_cong.errno;
> +
> +	return ret;
> +}
> +
> +static efi_status_t qcomtee_uefi_get_next_variable(unsigned long *name_size,
> +						   efi_char16_t *name,
> +						   efi_guid_t *guid)
> +{
> +	int ret;
> +	u32 out_errno;
> +	efi_guid_t out_guid;
> +	struct tee_param_ubuf in_var, out_var;
> +
> +	if (!name_size || !name || !guid)
> +		return EFI_INVALID_PARAMETER;
> +
> +	if (*name_size == 0)
> +		return EFI_INVALID_PARAMETER;
> +
> +	/*
> +	 * For 'in_var', 'name_size' is not necessarily size of 'name';
> +	 * could be size of buffer where 'name' has been stored. TA expects a
> +	 * NULL-terminated string in 'name' and ignores the size.
> +	 * For 'out_var', 'name_size' is size of buffer pointed by 'name'.
> +	 */
> +	in_var = (struct tee_param_ubuf){ .addr = name, *name_size };
> +	out_var = (struct tee_param_ubuf){ .addr = name, *name_size };
> +
> +	ret = qcuefi_get_next_variable(in_var, guid, &out_var, &out_guid,
> +				       &out_errno);
> +	if (ret)
> +		return EFI_DEVICE_ERROR;
> +
> +	if (!out_errno)
> +		*guid = out_guid;
> +
> +	if (!out_errno || out_errno == QCOMTEE_UEFI_SEC_ERROR_SIZE_OUT)
> +		*name_size = out_var.size;
> +
> +	/* On SUCCESS, 'name' stores the next variable name. */
> +	return uefisecapp_err_to_efi_status(out_errno);
> +}
> +
> +static int qcuefi_query_variable_info(u32 attributes,
> +				      u64 *maximum_variable_storage_size,
> +				      u64 *remaining_variable_storage_size,
> +				      u64 *maximum_variable_size, u32 *out_errno)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	u64 obj_id = uefisec_app.uefisec_svc_obj.id;
> +	struct tee_param param[QCOMTEE_QUERY_VAR_NPARAMS];
> +
> +	struct {
> +		u64 max_var_storage_size;
> +		u64 remaining_var_storage_size;
> +		u64 maximum_var_size;
> +		u32 errno;
> +	} out_cong = { 0 };
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, obj_id,
> +		       QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO,
> +		       QCOMTEE_QUERY_VAR_NPARAMS);
> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(attributes));
> +	SET_TEE_PARAM_UBUF(param[1], UBUF_OUTPUT, TEE_PARAM_UBUF(out_cong));
> +
> +	ret = tee_client_object_invoke_func(uefisec_app.ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_UEFI_SEC_OP_QUERY_VAR_INFO invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	*out_errno = out_cong.errno;
> +	if (!*out_errno) {
> +		*maximum_variable_storage_size = out_cong.max_var_storage_size;
> +		*remaining_variable_storage_size = out_cong.remaining_var_storage_size;
> +		*maximum_variable_size = out_cong.maximum_var_size;
> +	}
> +
> +	return ret;
> +}
> +
> +static efi_status_t qcomtee_uefi_query_variable_info(u32 attr, u64 *storage_space,
> +						     u64 *remaining_space,
> +						     u64 *max_variable_size)
> +{
> +	int ret;
> +	u32 out_errno;
> +
> +	if (!storage_space || !remaining_space || !max_variable_size)
> +		return EFI_INVALID_PARAMETER;
> +
> +	ret = qcuefi_query_variable_info(attr,
> +					 storage_space,
> +					 remaining_space,
> +					 max_variable_size,
> +					 &out_errno);
> +
> +	if (ret)
> +		return EFI_DEVICE_ERROR;
> +
> +	return uefisecapp_err_to_efi_status(out_errno);
> +}
> +
> +/**
> + * qcomtee_release_object() - Release an object returned by QTEE.
> + *
> + * Each object returned by QTEE repesents a secure service exposed to the
> + * client. Whenever an secure service is opened, QTEE may allocate resources
> + * on the client's behalf. Therefore, once the client is done accessing the
> + * secure service, the object representing it should be explicitly released
> + * so that QTEE can release the associated resources as well.
> + *
> + * @ctx: TEE context.
> + * @object: The object to release.
> + */
> +static void qcomtee_release_object(struct tee_context *ctx,
> +				   struct tee_param_objref object)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	SET_INVOKE_ARG(inv_arg, object.id, QCOMTEE_MSG_OBJECT_OP_RELEASE, 0);
> +	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
> +}
> +
> +/**
> + * qcomtee_get_uefisec_svc_obj() - Get a UEFI Secure App service object to
> + * begin communication with the service.
> + * @ctx: TEE context.
> + * @client_env_obj: The client environment object returned earlier by QTEE.
> + * @uefisec_svc_obj: The UEFI Secure App service object.
> + *
> + * Returns 0 on success.
> + * Returns < 0 if client environment object invocation failed.
> + * Returns > 0 if client environment invocation was success but UEFI Secure App
> + * service object could not be returned for some other reason (represented by the
> + * returned value)
> + */
> +static int qcomtee_get_uefisec_svc_obj(struct tee_context *ctx,
> +				       struct tee_param_objref client_env_obj,
> +				       struct tee_param_objref *uefisec_svc_obj)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	u64 obj_id = client_env_obj.id;
> +	struct tee_param param[QCOMTEE_GET_UEFI_SVC_NPARAMS];
> +	u32 uefisec_uid = QCOMTEE_UEFI_SEC_UID;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, obj_id,
> +		       QCOMTEE_OP_CLIENT_ENV_OPEN,
> +		       QCOMTEE_GET_UEFI_SVC_NPARAMS);
> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(uefisec_uid));
> +	SET_TEE_PARAM_OBJREF(param[1], OBJREF_OUTPUT, 0, 0);
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_CLIENT_ENV_OPEN invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	*uefisec_svc_obj = param[1].u.objref;
> +	return ret;
> +}
> +
> +/**
> + * qcomtee_get_client_env_obj() - Get a client environment object to begin
> + * object exchange with QTEE.
> + * @ctx: TEE context.
> + * @client_env_obj: The client environment object returned by QTEE.
> + *
> + * Returns 0 on success.
> + * Returns < 0 if root object invocation failed.
> + * Returns > 0 if root object invocation was success but client environment
> + * object could not be returned for some other reason (represented by the
> + * returned value)
> + */
> +static int qcomtee_get_client_env_obj(struct tee_context *ctx,
> +				      struct tee_param_objref *client_env_obj)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	struct tee_param param[QCOMTEE_GET_CLIENT_ENV_NPARAMS];
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, TEE_OBJREF_NULL,
> +		       QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS,
> +		       QCOMTEE_GET_CLIENT_ENV_NPARAMS);
> +	SET_TEE_PARAM_OBJREF(param[0], OBJREF_INPUT, TEE_OBJREF_NULL, 0);
> +	SET_TEE_PARAM_OBJREF(param[1], OBJREF_OUTPUT, 0, 0);
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	*client_env_obj = param[1].u.objref;
> +	return ret;
> +}
> +
> +static const struct efivar_operations qcom_efivar_ops = {
> +	.get_variable = qcomtee_uefi_get_variable,
> +	.set_variable = qcomtee_uefi_set_variable,

Not sure how much it is relevant, but I was looking into the efi and in
efivar_set_variable_locked, saw this comment "If no _nonblocking variant exists,
the ordinary one is assumed to be non-blocking." which in not the case fo us.

Does it make sense to introduce something like
qcomtee_uefi_set_variable_nonblocking and return UNSUPPORTED!?

> +	.get_next_variable = qcomtee_uefi_get_next_variable,
> +	.query_variable_info = qcomtee_uefi_query_variable_info,
> +};
> +
> +static int qcomtee_ctx_match(struct tee_ioctl_version_data *ver,
> +			     const void *data)
> +{
> +	return (ver->impl_id == TEE_IMPL_ID_QTEE);
> +}
> +
> +static int qcomtee_uefisecapp_probe(struct tee_client_device *tee_dev)
> +{
> +	int ret, err;
> +	struct tee_param_objref client_env_obj;
> +	struct tee_param_objref uefisec_svc_obj;
> +
> +	uefisec_app.dev = &tee_dev->dev;
> +	/* Open context with QCOMTEE driver */
> +	uefisec_app.ctx = tee_client_open_context(NULL, qcomtee_ctx_match, NULL,
> +						  NULL);
> +	if (IS_ERR(uefisec_app.ctx))
> +		return -ENODEV;
> +
> +	ret = qcomtee_get_client_env_obj(uefisec_app.ctx, &client_env_obj);
> +	if (ret) {
> +		err = -EINVAL;
> +		goto err_get_client_env;
> +	}
> +
> +	ret = qcomtee_get_uefisec_svc_obj(uefisec_app.ctx, client_env_obj,
> +					  &uefisec_svc_obj);
> +	if (ret) {
> +		err = -EINVAL;
> +		goto err_get_uefisec_svc;
> +	}
> +	uefisec_app.uefisec_svc_obj = uefisec_svc_obj;
> +
> +	ret = efivars_register(&uefisec_app.efivars, &qcom_efivar_ops);
> +	if (ret) {
> +		err = ret;
> +		goto err_efi_vars_reg;
> +	}
> +
> +	/*
> +	 * We don't need to keep a reference to this object anymore, we only
> +	 * needed it to obtain the uefisec_svc object.
> +	 */
> +	qcomtee_release_object(uefisec_app.ctx, client_env_obj);
> +	return 0;
> +
> +err_efi_vars_reg:
> +	qcomtee_release_object(uefisec_app.ctx, uefisec_svc_obj);
> +err_get_uefisec_svc:
> +	qcomtee_release_object(uefisec_app.ctx, client_env_obj);
> +err_get_client_env:
> +	tee_client_close_context(uefisec_app.ctx);
> +
> +	return err;
> +}
> +
> +static void qcomtee_uefisecapp_remove(struct tee_client_device *tee_dev)
> +{
> +	efivars_unregister(&uefisec_app.efivars);

I still have concerns about the removal path. efivars_unregister() acquires the
semaphore interruptibly and can return -EINTR, for example when a signal arrives while
it waits for an active EFI operation. Its return value is ignored here, so removal can
release the service object and close the TEE context while the EFI provider remains registered.

Separately, efivar_lock() appears to have an existing bug: it checks __efivars->ops
without first checking whether __efivars is NULL. Successful unregister sets that pointer to NULL,
so subsequent access through an existing efivarfs can dereference NULL.
I Feel, that needs an EFI-core fix as well. what do you think?


- Amir


> +	qcomtee_release_object(uefisec_app.ctx, uefisec_app.uefisec_svc_obj);
> +	tee_client_close_context(uefisec_app.ctx);
> +}
> +
> +static const struct tee_client_device_id qcomtee_uefisecapp_id_table[] = {
> +	{UEFISECAPP_UUID},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(tee, qcomtee_uefisecapp_id_table);
> +
> +static struct tee_client_driver qcomtee_uefisecapp_driver = {
> +	.id_table	= qcomtee_uefisecapp_id_table,
> +	.probe		= qcomtee_uefisecapp_probe,
> +	.remove		= qcomtee_uefisecapp_remove,
> +	.driver		= {
> +		.name		= "qcom-tee-uefisecapp",
> +	},
> +};
> +
> +module_tee_client_driver(qcomtee_uefisecapp_driver);
> +
> +MODULE_AUTHOR("Qualcomm");
> +MODULE_DESCRIPTION("TEE client driver for Qualcomm TEE UEFI Secure App");
> +MODULE_LICENSE("GPL");
> 

