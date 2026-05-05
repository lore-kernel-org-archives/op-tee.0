Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3854CD343F
	for <op-tee@archiver.kernel.org>; Tue,  5 May 2026 14:50:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EF8D744459
	for <op-tee@archiver.kernel.org>; Tue,  5 May 2026 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777992615;
	bh=/ThHF8hJw+I5T6qQTw/Q1CJUS1knLMz9fJpBGnuPP7I=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=R6PbNt6xvwmT1Lpl44XuzeEIWCUdP8QdK7DMAKz0F+Lbs15WNpxWDMZWFtqxj8m5t
	 gHgqL1iNAKavi2BCs9EWsj5c5AFctwZIQOrfXzbTLjC6yw2AwzPq6s1SBBhUOcE1jf
	 dBD1aRyaHakMudVJia9w9GVc6y2osZ7jEzN9gVDoq+pvf3UigTPQkHyD1ieFqzqJMQ
	 F60flVedGyErmUxQjclJ78LuYm5dE5jN95yIVooT92FF03H0+LfMoWnxpg3X91XcbA
	 d+lwH5SVo9eehB/HosASGAth0PIZVlpNSCGuSh4IO5mTs6Gvo5oQA3gh8wP7ttDPnC
	 GZA/3uCe64Rcw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2EF8543035
	for <op-tee@lists.trustedfirmware.org>; Tue,  5 May 2026 14:50:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l/9FEifz;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qusf9n1Q;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645CE2KD2187468
	for <op-tee@lists.trustedfirmware.org>; Tue, 5 May 2026 14:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KBSnO8fLfv2V7HIGkj9CawV0Uw7GLfZNqY6E6hFC104=; b=l/9FEifzdbjK9Knf
	VYMr3kcwzNNLhbAzkKvw0GYs2OJ7sGEeOZWHWKf0cK+obbOnyvKMJDrIQJ8lgoHV
	XU/JcwvsxKjYVEKjIGZuOVpxLX4NZmGktmosZokNx+YJqslTQBCiGGl9BCYdMXNE
	crE7L0LpAeXm5vmofh7Uggtr3DCHMeTSJtLFDz6DF2o4nJfDx6jsKCqBo1yrq0Jy
	rqamtvs6nhXmQIdnBDGtNhhFEDzHZ0fsjdc6/iAFVW2wmae8RcSCd8kJi5+jxz5F
	c8fmALkBNzOLw+891xaprdQssFDUYsd3Hx7I5HqJ9STd75ldyI54mKNtTm1wzK9E
	wtw6lQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dygce0m05-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 05 May 2026 14:50:08 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1309f4ee96dso2949016c88.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 05 May 2026 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777992607; x=1778597407; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBSnO8fLfv2V7HIGkj9CawV0Uw7GLfZNqY6E6hFC104=;
        b=Qusf9n1QphTfNZB5x/c8cXw2XcgHgZupEL44ZK0VxEC24bWLTXRC1/NPrsAv+RPxrS
         +uDCiOwRuib80ePiQt4rL9clf2r5P0IkC/rZ5BkgRl5nu+WEECrYi4OD/60+QZfYqRlg
         4/HZmEMyHfikSfa2vo/kwlei6GYkKAXcL3NepRLE9iG+EWr2R51YnachEEwNHzqNmDs2
         s/Xj9UhSQj/vroul0sVXCRCVDklClqFm6CBEHgY+Mq6AnhJe+lT4/wFI2hWStjlTALt9
         JcMZU+ls+GadxjTARiWMmz9nejMstxoVsxPs9xAIZcumyIc9Qk31o0em5LqTU2IXS321
         p4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777992607; x=1778597407;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBSnO8fLfv2V7HIGkj9CawV0Uw7GLfZNqY6E6hFC104=;
        b=HC9ZZczQpkrk3+PLn1x9//5nFOSD3qGQfin9yh+sUut3Ku9CsW/goRQ6vvF7AZFF6d
         iu3yCmcV05s4QpVx+Zh9tIEBjNMC4zI8NbK6uemxxf0BXgv2yFrIk1JPNPionxYeC2Z9
         6dJ7dk16LeOpWeEPIf/ZrkO7enC1nBAQI9tiA7LyA80unaFKZCa7kaiRgmNKI8/u80fC
         zPxjN/BzYKfhCp/o6qBRZHracgRFyOtHOXUFjF6UIxYvgvhxu5ROwOk2GJ4QZQ0NZ3DU
         L0mAzhvkiGFXP/apz22oNKQRy2/Z6n/luf1745ULxE5H1je4SH8UHrosp3xuP51JsImz
         guUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tM1SRsnLrRDKXFBbIXuQ5WIobeMbHoKCBf1E6XaKIfw8pfUH7W+juQx73XuuVuKVmrzaByhs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw0bdUKVxc+6NOa+6N5X6a0MVhvuRwWf6UtfXynAXwuDp/q77II
	SW/jF4DuxkA/OPJjtUQJrzEajzKAW0yk6A4wvMcYzdKydHHybm2/ttCkjzjYJCInXEXB92x6x5D
	Un4uNl0iHs+4N++t4GpfSzhKzkPApcNBd3SBm2B3F0SHSN/MxpgaPjHqUT0H14IYYKMIHNXy+
X-Gm-Gg: AeBDiev7jW8zW3KI+bRIINORNoDV5EssxBBtzXQPIsYjRlOHdz2+FUq4zAYSCGB0Tcx
	Wp7GX0h9m9CpabOXhR9/PFuH1b7GM4GchIxoljfvaHfwcs8GRGb9MNFfEeP0DyxISIKR1pw+6Mx
	up9+E5MXIRepw+3fAufwkn6TgvWS7Cjb72aVlOtCpdd4ai00VfsA3SZSC23LJ9XmHdQQD8TNChV
	TMDmygpUMzfC4F4lYoNZTxJ45nCDyrl2qHvI8KSgrPvvYQI2Ag0FWrmDW3DWTHoqMOtS/fbmKK4
	GcqYaPQKwpcSC8OAxotzW4eVtictryk+Y9XM3UJtUjZTkXIj9ApOmTkVUC1pAl57JKb6jafX9IY
	/snG4dmBGyWjttjCe02Ii94mA+r/Lyb5V7Ny8pi7M1BXDaOkzRmN3WoAN982XKbz9tl7zAS3hh7
	Sau9lBwk4h5TDVErdE
X-Received: by 2002:a05:7022:6628:b0:122:33e:6d41 with SMTP id a92af1059eb24-12dfd84327fmr6504972c88.23.1777992607377;
        Tue, 05 May 2026 07:50:07 -0700 (PDT)
X-Received: by 2002:a05:7022:6628:b0:122:33e:6d41 with SMTP id a92af1059eb24-12dfd84327fmr6504928c88.23.1777992606769;
        Tue, 05 May 2026 07:50:06 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8279e57sm19149584c88.3.2026.05.05.07.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 07:50:05 -0700 (PDT)
Message-ID: <ae68bdb3-d683-4e7a-a27f-739214656ce2@oss.qualcomm.com>
Date: Tue, 5 May 2026 07:50:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/16] wifi: ath12k: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
        konradybcio@kernel.org,
        Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>
References: <20260504130603.1474043-1-sumit.garg@kernel.org>
 <20260504130603.1474043-15-sumit.garg@kernel.org>
 <3bfdc11c-115f-45ab-b0ab-75ad88dc6f31@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3bfdc11c-115f-45ab-b0ab-75ad88dc6f31@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0MSBTYWx0ZWRfX5f1x4kQKZocG
 3ADHj+tDyly8bu1Hn93WWNmSnyHLWxgBwIheWQrRV74b0IR5Aresgy/jTz0z7Tj985Nfm8bZFWU
 G7lgMzbBpvDTtJ36eVwDjUZ5e2TUhvrOaM1fNFArurlDHeo3BWC21Jvl3l0OkWrsZaIp/rc1zYl
 vXYpc7P3TF8yKJb8We3bDV+VrtifTq0ba+uHpToIbPzcp/ViJVet4elB+9hgIKGBZuAAHaMIDR7
 ckP4YlS83IoiP+MFDfoLzWGoIr2OvkbSCxnIWWY+FEM+D81TL0ODanlPHIl6broaPNsGp+uaNTX
 3y6qr7wBm4DKp+c+oEXP+n3ecHPEgjzTBfR3nDciSL8pBodkzVKtmYsxiLmyDm1TZgkjlMUPkfk
 +Esj5rhPTAywL7s3MllUGjf7BDx/k1OtvEqf+pLSNHaP0wUS0INB2+enO0D7ZNFc+hS6fL3wRUX
 37+c2OhtecisyG+3QuA==
X-Proofpoint-GUID: coA5P3ljLocbVkROhDODYcpXdBD1O69I
X-Proofpoint-ORIG-GUID: coA5P3ljLocbVkROhDODYcpXdBD1O69I
X-Authority-Analysis: v=2.4 cv=b6KCJNGx c=1 sm=1 tr=0 ts=69fa03a0 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VMT16xk1LGalzlQIQqAA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050141
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.22 / 15.00];
	BAYES_HAM(-2.92)[99.67%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_MED(-0.20)[199.106.103.254:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DNSWL_BLOCKED(0.00)[74.125.82.69:received];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_GT_50(0.00)[51];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2EF8543035
X-Spamd-Bar: -----
Message-ID-Hash: TRW2JYEGADTJK2NF63ZQYATPQCZPBLBV
X-Message-ID-Hash: TRW2JYEGADTJK2NF63ZQYATPQCZPBLBV
X-MailFrom: jeff.johnson@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm
 .com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TRW2JYEGADTJK2NF63ZQYATPQCZPBLBV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jeff Johnson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

On 5/5/2026 7:27 AM, Jeff Johnson wrote:
> On 5/4/2026 6:06 AM, Sumit Garg wrote:
>> @@ -485,9 +485,9 @@ static void ath12k_ahb_power_down(struct ath12k_base *ab, bool is_suspend)
>>  		pasid = (u32_encode_bits(ab_ahb->userpd_id, ATH12K_USERPD_ID_MASK)) |
>>  			 ATH12K_AHB_UPD_SWID;
>>  		/* Release the firmware */
>> -		ret = qcom_scm_pas_shutdown(pasid);
>> +		ret = qcom_pas_shutdown(pasid);
>>  		if (ret)
>> -			ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
>> +			ath12k_err(ab, "pas shutdown failed for userPD%d: %d\n",
>>  				   ab_ahb->userpd_id);
> 
> at some point the "ret" param was dropped, and this now generates build warnings
The 'ret' param was dropped by:
8fb66931fe31 ("wifi: ath12k: Enable IPQ5424 WiFi device support")

Not sure if that was on purpose or accidental. Sowmiya?

-       if (ret)
-               ath12k_err(ab, "scm pas shutdown failed for userPD%d: %d\n",
-                          ab_ahb->userpd_id, ret);
...
+               if (ret)
+                       ath12k_err(ab, "scm pas shutdown failed for userPD%d\n",
+                                  ab_ahb->userpd_id);




