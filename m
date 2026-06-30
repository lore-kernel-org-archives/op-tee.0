Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49491C43458
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:36:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 92F0D44F9D
	for <op-tee@archiver.kernel.org>; Tue, 30 Jun 2026 12:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782823002;
	bh=xalr14ue42EEz8a0KF+uv2BCteqC/Z7u/YTLcm6EW80=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=YvIMFi4qtESwTpuBMKDzxmX6sMf1yQFt1jD0UyUfgnyo6l85agnH8/owvaIF2e3Ct
	 pqjk4YIwW89wZoV7+jGr62RxPdtaLXHpn4MPs42T1A4YAWqhY8d8RXr/VnavJeRy2Y
	 IFjeN4AzJOElQZFHCkRFoMF16lzlNi0N0UPl3Rne+/kksIl2FiZjouhLrvAnR6kJ4m
	 cy3Kr4efRkcwKSR01yj06RuVxdWroJ1zZoJvW2lt34845GPR4oZFRzTrn/p1DnorAx
	 8+Bmd3E8h2fH1XJvaaDLzegbj7DwRyYy6arAOKjfIgDdR3wHQfW9n9c30oGJXB+85x
	 ehH5lA9PhZsxA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 17EC544E69
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:36:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hMAv06XB;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NK9R4Ww9;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n9BA1605952
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hWECIwdx2FjYu4F2Dv37YsQcOFv1h/HrdIPZgZxYiUo=; b=hMAv06XB7kVL6dKY
	+mHGw3jLF/V8VbrZUImQfj2Obz1kqidz2H33ovgOc19u+mb+yDLaOpPN/kUCihqJ
	VxyDFRhHHF3LE+BMpwV25kokDuysV/+xRDcxCR/nksSgx/Y98VucDYD/N4RQvqAS
	RfzOiO2B+ckua6pWwG5ZmOxuB/BsGWc4mZ8/uTlRsGQW8OZvq0FVIp5Rwvm2/qnM
	rHSsXx4FPnD7merqI3IYjqYhb4n5YQSq2ebVHHhxuIgh4ogpK92nyJAxaWQOyjrY
	yPhPlQTtcEYNELxEP7xiMOsLVXEo0PekJnEHp1ItAwYxkBJailhxbT8YtECLlLUg
	7O5slQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f45k5tbxe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 12:36:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e57e56ce9so22542285a.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 30 Jun 2026 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782822995; x=1783427795; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hWECIwdx2FjYu4F2Dv37YsQcOFv1h/HrdIPZgZxYiUo=;
        b=NK9R4Ww9HrJbM1WuA9IkigNBDlM8y7RvdwxcwOjfVIFXXen3fUsPhbOf2EYrJ8aqJG
         7vKKX6b4oH2YMbcLaAe9F5YiwtJIMl7J5ykfGUSn6HfwC2CQYlcdz2VYQzrGz0JmhA5t
         XvtgFjiidRO9cxtlbsO8l5YLkv0CpwtNbRXZTC6+lbvIqT6pPGyjQx1VPn1fmwg9CUsc
         7QpTMq+V2quk2fXSBkzUWNvObkHq1WvibnpPEiIFYtOsRvbm1KfEKacKfLL7r0iUw5iA
         KrKDh9c+XT71OS4ngTaAE6fGfHWcAz1OY/8v3tm8JXSCRWfqzcQbLCYBSVYqL/t9+qs5
         mkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822995; x=1783427795;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hWECIwdx2FjYu4F2Dv37YsQcOFv1h/HrdIPZgZxYiUo=;
        b=sf670wlBYldx09ZHGiOUQECBuC7rIsvvKOYgN9CNEUlNzMMrWX0wHuQwsC3Ov3qpRe
         FlYrkQho3uazRyYUeciKszP3MOtmB+9x/vdHLfN/m3lMtcfVCxWHplwJ+ZQxLOPSR/Ut
         sWD2epW0Sxx4oMQEErnIYsODhj0abN6ag5NFfUJL2Lj5+ZWVZubXL+wIpa1f5+Q4N09P
         C5qqnnp/8KeaXNIVjJI5lQzER2CbBQmiv+tkXXmt8/9JNdZEStDn114po8EHF7JaRr7V
         LgNhzOFJ6LoYd4WhLJhLvQFeTxBXVhD32OLC9GV48Vb81orVMnmzgy0rcL2kgzaCZbh7
         6vdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+E93Bpwolcx2Y5ShRyv6ChTw6RcY33B89uKUgJllsVpGOHktUkVQpiAp4j4VEqjb2RE62csb8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxbrnTSwQNUhM8YwohRREaW0BquI2gjPYR2kNE52NqMQaY3CTBT
	TZDsrVyL9uRdLgaV3MlSiJtB/57Sy9Nl+SaC8ZlC9id0ZVqqHb2ln7WnhVGxh6n2GjJpOVr4oYR
	HNvcJlLkNdLq+C6ByFAEJdqo0ijgMdfBzomzuKfSpA7qyPy9NtQg+qZEUJRtyEwz63VTDb+QP
X-Gm-Gg: AfdE7cl8AJB1UYHaSzeNP9kQrvKeq9SDoaZ5PjEht5oDGu5pBkT7P0+Dj8wReORx7mm
	Ca0k5nuCMi1EUpRDSXvoP76ruk8WAKznXwnYaRVFgI5/JRcfBTxdDcXwPNCH8rO6+Za9KUq35Ie
	f64OKsVfAlpZcxWuapCXW5XF9rtULwmOAoVUTVSJZDBcAipYejeYdHhvojdKQy7gTFOSaxu9Aqw
	HDmLxJ8o1CbfpGfFMv0QU2up6RYY/fenMIXiI9RQ8S07mRxBQkhrc3AVtYZoupg2klyQSbvwwTW
	2vbG+5451FJIKUZAL5JC9LPE2+8n6bV7cJ5LNEwY+LQj6SCR/nMUysFViiFAo/2boY+JlK9Ktf6
	cptlk0uYltsk/oB2tlvGoCrQ1Xw079nilD1k=
X-Received: by 2002:a05:620a:2a13:b0:92b:14bc:7936 with SMTP id af79cd13be357-92e6247af35mr377075285a.1.1782822994724;
        Tue, 30 Jun 2026 05:36:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2a13:b0:92b:14bc:7936 with SMTP id af79cd13be357-92e6247af35mr377067885a.1.1782822994089;
        Tue, 30 Jun 2026 05:36:34 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f48b35sm115852066b.46.2026.06.30.05.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:36:33 -0700 (PDT)
Message-ID: <6ea161a2-d959-4028-8aec-175b73df18ea@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:36:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/14] remoteproc: qcom_wcnss: Switch to generic PAS TZ
 APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-7-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260626133440.692849-7-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=6a43b853 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=jx0KCs2Px1p7SxVd6dwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: CqGeTEe_RyoEtPHnwQtiEIQr8Up5fsf7
X-Proofpoint-ORIG-GUID: CqGeTEe_RyoEtPHnwQtiEIQr8Up5fsf7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXzRIbMU4UBarc
 1tltMTWj/aVYrNL65qVI22qikWYbiQ4TlNXegOvWRCfPEw/h1Hghj6MGAILxaZoGeKc+cngYtmh
 R3pXOe+UzVddbp634+AlHfbY5F4O1NwZLNIS0xuBGADHQ0TtIVFWLhn782cXa1OXRYbrd3Le4vP
 2Kk1ewq/IqIxlt7y/xhAV1JG138vujP8eJhNP/ojwfVFrUfWWWSAerKASYMsaRy/dNcYsn+Ry0C
 HVcU0e6bOTUHYEbjoa3iFCwpfCp1JXiksvz8MxdgIiCg1g4pt2KzY7CpO6x7IHIrGx4IpwrFMTh
 z8IwSAgP8sZ3xP+r0+M9Shtnf/GmaesltwBz9KDFpcqXzPVU+HCeVk4CpwHGE+FnUUpdRoNKIC+
 dG/HxMkvIlJXm113VWZ2qTRUOR2iVcSaiMaplLgTSKr8kAXOMLk7j6FCKvhN9AsQGamkDA+LL0T
 ps/uWZ4vc0vlcBvJdIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfX782nBiMgLXWx
 USEq6bJxZ7iL27s2HlcMJjKFM+90KwSMvNnbLyDSadBJtG3Aiw5eV1QEWnTkZ5L+sk+4dCPiqcW
 X4GPK1rsqkOxlnZhfNQ2ttmcGweDRQc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.47 / 15.00];
	BAYES_HAM(-2.97)[99.89%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[48];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DNSWL_BLOCKED(0.00)[178.235.128.140:received,205.220.180.131:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 17EC544E69
X-Spamd-Bar: ---
Message-ID-Hash: ZA2IGBPNLICMPPGCV3TOOOPX2APZIVU5
X-Message-ID-Hash: ZA2IGBPNLICMPPGCV3TOOOPX2APZIVU5
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.
 com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZA2IGBPNLICMPPGCV3TOOOPX2APZIVU5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_wcnss client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
