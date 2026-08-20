Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239C2C5DF81
	for <op-tee@archiver.kernel.org>; Thu, 20 Aug 2026 07:53:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 444DA452F9
	for <op-tee@archiver.kernel.org>; Thu, 20 Aug 2026 07:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787212419;
	bh=VizCQBMinCKZIQeApvAF6NKWz5JoYNftX3ZAIOL7fhM=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=W9Ms9/LOkTFf/Nb6xSX+s7vXpl+G0xx3OPrGTgzlauf8b7Y1m2btpiUxn3YS9ntuK
	 Y9qKmy4LYYmbzLPRvcLpT4SBr/FsHoo+NUzlzV/LvSA0BMTaWcbtE5sfrGmnhyW235
	 I2NSg0rhWZRtsBtsI+fexKTzt1HL1LjkFWlcv29zd6zEZR9hFPD7TqricOoQ+PjH2E
	 BEcL3AXqRbe6TcZYyerLX3oDAkuD5zepdFKR2lE+gaNpm6MLEoJsC/rg9mp05syj9r
	 wKZC/uSSQMO5zv57klI0GgxQ9EsfXNoXo64Tlbs04jqM7nY31JBylzU4k4OIQPWoAK
	 jh5kvW1WRO1yw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4C08E44423
	for <op-tee@lists.trustedfirmware.org>; Thu, 20 Aug 2026 07:53:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZZOokSdG;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DkFi0Ag2;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6N2Wi1027511
	for <op-tee@lists.trustedfirmware.org>; Thu, 20 Aug 2026 07:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cFbnnm4raDpYfoL8OuEtYJHYVYy0rI+rPAw5Nwnr2Z4=; b=ZZOokSdGz9PXRdKd
	DzK0rlxpdP7idjxiUtsLZtjzuKZ2kILyIjaLuZX8I0iRtL+EiKlRUJQX+/4er8Ez
	V52yzVYo3BimJ9BIpdl+J1VnJqczrDR18n0StWuaeGsyjCQT3NIaQItz5/gHyIP/
	T6aN80BZzup5BDqDRF+QolqZAiwwtglXjzGggUxen0r/MSPAx38gHSjBCRsdLzkA
	4FBxjHMUerzn+mG4SdDjfaY7A4iNTt0Gaez0m0uuL9SynDWbuHrCUgl1KhWZMxPr
	iSN0SFW8UHaAW6njiIxrSHIOv1sxQsnhZJKEI1taW1vz+4xx6etM/aqlXjgr/rBZ
	CYGPSQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es4ksr8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 20 Aug 2026 07:53:31 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8461ade272bso25181987b3.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 20 Aug 2026 00:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787212411; cv=none;
        d=google.com; s=arc-20260327;
        b=CXqmW7LMlrzSRp5p49E4xGL5XYI9df7HuBt+v1jMVRsupQYcQVePmK/kYdGw4uYI95
         aSlVXKPpzNTVQpvHpDPeV9jX024Z9sWegYFgiAyqMv3ouif68paNEXF/puwyMitcmFsg
         Zyv+NRVPAjE/nPYJrxwG3EhBLexnX9g7v45EkIGSYHhLIfFPKZrDGIp5FLH1R4EuxbU9
         Gdvu+I78/7sOXS/fRVX2tNotQKsOa4YTzY4JgE6Y+FBJdVa/VtJxgcfGj8LhrDFVnBc4
         QfCksmEXs/w7uuBJd1UYTqxp7wvrz21cyAFwzNgdSybt56pBTXpbCk+B3JY8T96/ETi/
         4sxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cFbnnm4raDpYfoL8OuEtYJHYVYy0rI+rPAw5Nwnr2Z4=;
        fh=0usXMoUPkxe6ssGfccaZ+tDjvUIQWVhpwUD0LsyxdVE=;
        b=lJtgeWN2xiIw0llsjfGfz4ADw7yn0KNCJQ7ANAc5Ih2QdezokiYh6Ik3OrUGPnUy3a
         SRx0OHcOdTvKcCjtrTP8CPjcHKwXReMGYHBmrcvxCThqaCwh1Z37LH+Jh1ABZJkrSv6x
         dKgLeZv7qjCKkbHN+rIMfceTPQR2D4ctM76jx0zAedzP/y9E9VFQfp16WTOS8PqgJWyU
         uSH4vO5elVPRbOXAhtuJ2kGRESnGcGIu56bOk/QTb1WjtTQV/exQAbvtyiHMSWxpELVo
         bB9JAoClmDJtGIORa+ep8xj1H3N1IYKp/+HGBmudqZiw73WXSHkO3JigkKKMFYF8Pxz2
         Tk9Q==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787212411; x=1787817211; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cFbnnm4raDpYfoL8OuEtYJHYVYy0rI+rPAw5Nwnr2Z4=;
        b=DkFi0Ag2mcuodbpEgtfCmRTHeXUj12Zj7Nt6OmqGreqUVk9Nz+wQ7U4ZEEqoqHesht
         nZDNiwzazH+h+gyV6QQxCdXIEHwb2EqI1ALPXLGXkudvivyXRoCrbc0pEateVOV2+DQi
         v1BZ/aq/SMQVjzGGze+7ReNepWjZnwZT9EAO6MttIVu1KjXkKb8eogYEIBWOL8aAEYBg
         h32NAYk/+Jyb1T1uzlQhybnbYJloqmCijytiAi/OHtCz0v4E89MYqkkra2Y845MNnP+y
         rAdQvtq4FeJmlm0f2Z1DbX/QKQzlx0C1OpLTy7lnFGkX0IEZ2lfIliDr+mJCcekCX8NO
         hHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787212411; x=1787817211;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFbnnm4raDpYfoL8OuEtYJHYVYy0rI+rPAw5Nwnr2Z4=;
        b=iJ43uibQiJRLvT4DmLuPM1+M7hfQ54ZXMqShXfRgGHTrt7qPf5hm5fCNB3aR+JpHSt
         ohoXBdBbflPUXx2QVw+pYqQaktkOqkubRvh0sqB8M27mbtsdBZy0X1fjxA/XSV0hfeSQ
         qYq5qD2yCNsxyyfiiFiMEKtaf7n9x/FXvruBiziBo53b7//s9caTJ0bELWUOOehzEksE
         4CLmJzhXnfugHRBaHRttpqiFwBDP71R8axI1DDLjiF8ahaiJxU1LX11hSnUlv4H7uNqR
         tC2BaxWN4OB4OpSUAmWcEizDdnET7SmUcBVKvfZqu6nsjiHfmgUx7MR1wcQvKspPNvn+
         w0bw==
X-Forwarded-Encrypted: i=1; AHgh+RrsBZ/8VXRXgt2i8xc1OhsE3TbuvPC5WeI6gQyW2vyJT2ERKrDFSa1nrOBpEugA8eG4ABtDh1A=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++ke6JjOZjNSrLobocY6Cz6M7gQLtdSWAoF5Ea4Krp3KX/OM5Iuh
	NTxXk341MPYyPVnvktfVbmt52x3KY2XJwJnHHms4q1bwxBH0fZx/pwDu6NZnSrFWR2cuuSuID3S
	Ev/qzGqCimmT8uCeXDe/G9M+TEb9Uy/f9cClrbfx3PrHucOUvqivR3zKnzqlTPcdLicpHTCRAj9
	OMBfY+jxJCUA0487pSkzKD6O+t6YmE+NpjJRzyNzK6ACTynos=
X-Gm-Gg: AR+sD11MLvHaoYFWp7gYx5+KBBMI2IWP/JB24S0FKM1p/kNLk+JYnDShuBSc+tPlaWP
	j/RWvdGFP/suLSX6nLUxG81nCNhwU6Ltah2vAICjswjEA5wsatx5T89YzW8xBZs1WNKmtGxoRb5
	Fz5TbuYvp6RjnPqah+evK6y6vA9E/gP1Uyhl0cw9e4D1VuTgq0fTfoAKY=
X-Received: by 2002:a05:690c:e3eb:b0:7ef:9fd9:db07 with SMTP id 00721157ae682-84709aa04a4mr17040647b3.12.1787212411214;
        Thu, 20 Aug 2026 00:53:31 -0700 (PDT)
X-Received: by 2002:a05:690c:e3eb:b0:7ef:9fd9:db07 with SMTP id
 00721157ae682-84709aa04a4mr17040497b3.12.1787212410850; Thu, 20 Aug 2026
 00:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <9f11db59-5245-4bd5-afbb-485500d37675@oss.qualcomm.com> <CAO8wpHw-J_A8bDL1MPnhXtVKSR1O4HCXbox1-eq2of5GU2wYKg@mail.gmail.com>
In-Reply-To: <CAO8wpHw-J_A8bDL1MPnhXtVKSR1O4HCXbox1-eq2of5GU2wYKg@mail.gmail.com>
Date: Thu, 20 Aug 2026 09:53:19 +0200
X-Gm-Features: AcwNN1WsQ0YZ2JNZ1554gZN_8x9NVrq_O0lG8VkVS503IOlCZjsrxm2QL5Gk708
Message-ID: <CAGgiveXZWSHDsKj1s3dHAhsBAOHgn_Pm_YrwM=u6SwwYUQGTPA@mail.gmail.com>
Subject: Re: Re: [PATCH] tee: qcomtee: fix kernel-doc warnings
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 2nTZ4BwDQPCtKo5Kk4LmJQ1GhsQZqdW4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1NiBTYWx0ZWRfX2o5BX1jd0KzG
 S2NbyH/s0cPbSePFpSsIrusYkPQzSCLAgmP93qZax5SxsxETTlQ1T+M/EnAvPUFOVSxFTLwrj8u
 D2URxzULAmvf8npi8+RgV0GCdx4USHeWhscPetyyHh0HmpJgT8F9512o9/W3Yf8NL0pRmfj9Maz
 QGpumagd29StLh/KljDV4sX50T36np+Qp9aC7SmIHSap+zhn8fBt5FUm7SqUm3NG3qThZZZg0UD
 FvKRLjlas9ms0CFQMe2qxicPkzVh6Hnc9YFjZwbZNQ6T+Tvdi7zWjiWaxZd6ZtLStt9rCHDdYNJ
 wdtFDcGpiywzJAHYMiGur9qSmSHfE5wtkKUxnaAJriIy1w2IIV/aweWSa6cd3+mUSQ+N8mR1mAk
 e6OSI+nTUp6aaN5+BavGXO3N3l4nqhDqcqjk1fH45q5V1HMINwdG4Lz2BAISIY8ZdqkdLU9RwyQ
 zbGJoHrurEacZ1zgL/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1NiBTYWx0ZWRfX+mt39yI6Z5R5
 KtYCB9utcEOUNXLdaRLck6rq2/2Zlp2fz/YIK0pkwsyH8eE7MYuAnC1muDJRLXwtR+87W1b0n7M
 BO9g81L02QQ4p/e1zwBqFeFmwWt5BMU=
X-Authority-Analysis: v=2.4 cv=CN8amxrD c=1 sm=1 tr=0 ts=6a86b27b cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=tO4S_OtGMeP9oHhStmEA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: 2nTZ4BwDQPCtKo5Kk4LmJQ1GhsQZqdW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.198:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4C08E44423
X-Spamd-Bar: -------
Message-ID-Hash: ECCPV2E3OLT7IAHFBGE2CQPO4NKUMIV5
X-Message-ID-Hash: ECCPV2E3OLT7IAHFBGE2CQPO4NKUMIV5
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, sumit.garg@kernel.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ECCPV2E3OLT7IAHFBGE2CQPO4NKUMIV5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi Babanpreet,

Thanks for the ping.

On Tue, Aug 18, 2026 at 5:38=E2=80=AFAM Babanpreet Singh
<bbnpreetsingh@gmail.com> wrote:
>
> Hi Jens,
>
> Gentle ping. Amirreza reviewed this a couple of weeks back =E2=80=94 is t=
here
> anything you need from me before it can be picked up?
>
> Thanks,
> Babanpreet
>
> On Mon, Aug 03, 2026 08:49 PM, Amirreza Zarrabi <amirreza.zarrabi@oss.qua=
lcomm.com> wrote:
>>
>> Hi Babanpreet,
>>
>> Thanks.
>>
>> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>
>> Amir
>>
>> On 8/2/2026 10:39 AM, Babanpreet Singh wrote:
>> > Fix kernel-doc issues present since the driver was added in commit
>> > d6e290837e50 ("tee: add Qualcomm TEE driver"):
>> >
>> > - async_release() documents its second parameter as @msg, but the
>> >   parameter is named async_msg (msg is a local variable);
>> > - struct qcomtee_msg_object_invoke documents member @ctx, but the
>> >   member is named cxt;
>> > - enum qcomtee_arg_type leaves QCOMTEE_ARG_TYPE_NR undescribed.
>> >
>> > The cxt spelling is part of the QTEE message format and is used
>> > throughout the driver; struct qcomtee_msg_callback in the same header
>> > already documents it as @cxt, so the comment is corrected rather than
>> > the member.
>> >
>> > No functional changes.
>> >
>> > Assisted-by: Claude:claude-opus-5 [kernel-doc]
>> > Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>

Since this is a fix, please add a proper fixes tag.

Thanks,
Jens

>> > ---
>> >  drivers/tee/qcomtee/async.c          | 4 ++--
>> >  drivers/tee/qcomtee/qcomtee_msg.h    | 2 +-
>> >  drivers/tee/qcomtee/qcomtee_object.h | 1 +
>> >  3 files changed, 4 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/tee/qcomtee/async.c b/drivers/tee/qcomtee/async.c
>> > index 31bff4309e672..5849e51612033 100644
>> > --- a/drivers/tee/qcomtee/async.c
>> > +++ b/drivers/tee/qcomtee/async.c
>> > @@ -97,10 +97,10 @@ static void qcomtee_get_async_buffer(struct qcomte=
e_object_invoke_ctx *oic,
>> >  /**
>> >   * async_release() - Process QTEE async release requests.
>> >   * @oic: context used for the current invocation.
>> > - * @msg: async message for object release.
>> > + * @async_msg: async message for object release.
>> >   * @size: size of the async buffer available.
>> >   *
>> > - * Return: Size of the outbound buffer used when processing @msg.
>> > + * Return: Size of the outbound buffer used when processing @async_ms=
g.
>> >   */
>> >  static size_t async_release(struct qcomtee_object_invoke_ctx *oic,
>> >                           struct qcomtee_async_msg_hdr *async_msg,
>> > diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/q=
comtee_msg.h
>> > index 878f70178a5b6..5d7b21fdd3688 100644
>> > --- a/drivers/tee/qcomtee/qcomtee_msg.h
>> > +++ b/drivers/tee/qcomtee/qcomtee_msg.h
>> > @@ -112,7 +112,7 @@ union qcomtee_msg_arg {
>> >
>> >  /**
>> >   * struct qcomtee_msg_object_invoke - Direct object invocation messag=
e.
>> > - * @ctx: object ID hosted in QTEE.
>> > + * @cxt: object ID hosted in QTEE.
>> >   * @op: operation for the object.
>> >   * @counts: number of different types of arguments in @args.
>> >   * @args: array of arguments.
>> > diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomte=
e/qcomtee_object.h
>> > index 8b4401ecad48c..d5de02dcef3b9 100644
>> > --- a/drivers/tee/qcomtee/qcomtee_object.h
>> > +++ b/drivers/tee/qcomtee/qcomtee_object.h
>> > @@ -74,6 +74,7 @@ enum qcomtee_object_type {
>> >   * @QCOMTEE_ARG_TYPE_OO: output object (OO).
>> >   * @QCOMTEE_ARG_TYPE_IB: input buffer (IB).
>> >   * @QCOMTEE_ARG_TYPE_IO: input object (IO).
>> > + * @QCOMTEE_ARG_TYPE_NR: number of argument types.
>> >   *
>> >   * Use the invalid type to specify the end of the argument array.
>> >   */
>>
