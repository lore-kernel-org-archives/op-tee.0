Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C25CA5FEC
	for <op-tee@archiver.kernel.org>; Sat,  3 Oct 2026 14:24:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 68287454A4
	for <op-tee@archiver.kernel.org>; Sat,  3 Oct 2026 14:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791037473;
	bh=Q8e70/5onMVOdbRZODPcLfVxhB90C2nmP0cyvm+D88s=;
	h=Date:To:Subject:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=Bm/dhkfB6XjCgPPyau8GH/Xd9kVpxRBPUZPHcKS2+VvQx/1vEt+wU9MrkAliWDeKr
	 V1iKm8QlFlyV3Zo2fPHmV++RVQ8hCvhegRW5Uo6qhFjv2z2UUP5OAT77u04mO9gg4S
	 dsJEsZkAPpXkPyH/2zREALHX2RnyGGhQz9RX7g8AKoRn6MvvmaOLxWx67oqO2OcRiy
	 zNaLRtlb/TZ9YU6nIIdwcZ289D6KYuJ8pmd0Ky6k0VlVIwb2GeWdX6LDK6wN1stRD9
	 ac44992W9obwYKAb8lG4S8jVjAu4BAQY/jLB2YsfbSGIg3MFyHmgJVyR+zrtQXgVsJ
	 40IIH9Paa3k3g==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6A08F445AC
	for <op-tee@lists.trustedfirmware.org>; Sat,  3 Oct 2026 14:24:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MzBWH51a;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S/2wX4fy;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693E69RV897634
	for <op-tee@lists.trustedfirmware.org>; Sat, 3 Oct 2026 14:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0zbsE0omg0TYg8XlU4yqOB
	v+Ij+j5rVhI0VbWrq7cDM=; b=MzBWH51aB1b4v71ZhF6iHdMvS8wyvf7D2bD2JJ
	p66iDUdHR1Sq4J6cu7JUvwDsDHThNIhkIauTvBW8ha0IxchX8Qgqj9ab93sZZmbp
	l8O2qaV87vD0UAmvMzH60AgM2z5x7LyLIIj+vrXZ1qRjHWkId62GfBAjid1c4XOZ
	nZ7vYEO1+VGG4pBDIcvUqyXv5IVcyqjl2v2oxIBqhcGhEaun4IQ7vuUU6XU/LrC5
	fnRzHgI3i+n89LNLZD6xvfMZmbJ2/5DyCv3BBSi8M68VFJBpemL9Ch6APsJi5iZL
	3C/z/J/YTrd8ghmMT3a2Vpvc4tO0Jnyoz3C6eEAOu5SGw99g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sq8s73y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sat, 03 Oct 2026 14:24:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93be1861d2dso75777385a.3
        for <op-tee@lists.trustedfirmware.org>; Sat, 03 Oct 2026 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791037465; x=1791642265; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0zbsE0omg0TYg8XlU4yqOBv+Ij+j5rVhI0VbWrq7cDM=;
        b=S/2wX4fyXxMHNHWHhIer9ckqatgbfFgXewXy7wVFu0VyMT47rhSLsD4VHCXQqyNGCL
         K3HfeiXq/Gdzohx6XebZMkB100oAGfbwxK9+Ueh6aof3guS9oWsQJqy7zyI8/OZilUq8
         uomAd0qLn5F1J+mgj+9hkWSUXKEPEQJ5Oel1/PB83SPw7W1P6tQvp655lcHpamVq2oGh
         TS8RYV1Q5p/l6Ga57K486mCbrGlMi4uRE5NAEeq+OuCh5GOR+VK9ohq/d3GhPbJCg00B
         Y5ZEgqj3IgFaCzSHOJYvmhX7+hoiPfwEyumStTjAGR4DWBTHY91gOt8BR1jytFOgzkLF
         H9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791037465; x=1791642265;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0zbsE0omg0TYg8XlU4yqOBv+Ij+j5rVhI0VbWrq7cDM=;
        b=lqyuXS+2rW+rUt7s/6QZMUD6KbIIcDT4Sw2sTUevrYT4n7SIx8mRxiaeXJBxahs7kh
         JkCqGSYs/6Mp/L8BIRUccxHLNLFvhhXduSgyzNj1i0Qg9AoBsrAOrWnue4vbzjcPi7Vs
         485Qch2eX87XpPg68MPqCJwR40Vu+1Y1R4yJ8iZS6nA06uzTPlxCsGAakXN5Snnn01lm
         9CuAPmGszFMdWhWgKsFz+rD/X1MMnP6iFRMrXJ5BX53Ckm86QcURnN5yq2K5C99X4LH8
         dus7Pa4EIs7keM9nRUqikN5r628pz3Kma5gG4LeHX297xB0HOgnxkeCnW1PUiX/F0nB5
         h1Lw==
X-Forwarded-Encrypted: i=1; AKwUvBw7Byd4TodaOHA8Jt3nGA02RB8ixfgjFBVLxuZatWT/n8HplojgmexFxKQsFBze3HJmGFTlZvc=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mh9FrQKZiAkLb1t/Xi5ZoiGzjzwZilJakfS9LF5LxOelUDgsn0
	xUndtCOd1lxXCFXMlf56czGXEiuK/HPAHKKxwgH4hfyM+Xg7+vJ8ImLsNgNg1TDw89b7ooE8yxS
	PuIsOJD9dDTR5UCzBievfTjS71ZbTevsTF8n/Ae5RezpijVUuA6bA+fAELoBMYGfhFLldW08O
X-Gm-Gg: AYBFou0eqJ69H8o/Jimf6sfXbpVa9pYAosogmHMJpgRgHqwUnIMM/v9wekQpIaCounP
	xxy2Und7aplqb/ENkxt6G4+hq2NAYAq4D8m+3oiEv8KTuM30K6rhoWjSVvtGH8C3g31cHylpjfI
	MuGCnLjdEGB03IfGporht7sPx4Jts9aSNhtc+7KKwdpJe+DZ2IwRINkLXeJBzfyAq/QxYaajwnr
	cG3wY+9fe7SkK7Hjiv/T4TIBFI/LSYgjYVF67jE0NnnJzRXqxATouskTgb6pVjbdJdj3ktbVW/v
	GTKhKHlctmqpeMm+yc0drPypSn/pWZ/2Y9TYpsCwY0gcopr7AGbd5zvliDeDNVEa1hLhu8E/xoq
	TifL6K9FmSX+vx7d73w88K8v86UbPDWVtp2GD1FDIrAu4sg==
X-Received: by 2002:a05:620a:2b47:b0:93c:c1e8:6504 with SMTP id af79cd13be357-93e50fe9f3amr495619785a.23.1791037465066;
        Sat, 03 Oct 2026 07:24:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2b47:b0:93c:c1e8:6504 with SMTP id af79cd13be357-93e50fe9f3amr495616185a.23.1791037464617;
        Sat, 03 Oct 2026 07:24:24 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e614cc508sm154549966b.38.2026.10.03.07.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 07:24:23 -0700 (PDT)
Date: Sat, 3 Oct 2026 16:24:21 +0200
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE QTEE update for v7.4
Message-ID: <20261003142421.GA928135@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: xQi7TFAiCEFkUaZyI2VBoJNMWpZ_DIcQ
X-Proofpoint-ORIG-GUID: xQi7TFAiCEFkUaZyI2VBoJNMWpZ_DIcQ
X-Authority-Analysis: v=2.4 cv=TKzQ2Fla c=1 sm=1 tr=0 ts=6ac11019 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=DiaXWS5xduwjvWiepNMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA1NyBTYWx0ZWRfX6+6gCxVlaMvU
 FFuJ3U7/I8Eg32qnI0JKcsV7am4r1R3eh+Yre4+xPtc2kCxXFdTmDH3vVQwqV0BJOkBYv/sc23A
 gb21d96gv3yMG4BJjFsrcAfZwbg/yeXMm2FX4TJtODatw07pnTdh+MkFuyUROcZt51pz/0wWo6y
 2kq3VFzY3h82w1TNDeFKEl9zHnLgu1bZiavkNBzhMhzDVK4kYBOBvjdTYr0bNiMBGg7KGclGygo
 uD7PX7a5K/ek20+9RlYberay9vuB5CrcU8HMYnK337UPl2hRre4gBLSH6lUOfsUzIWPxegSrKIH
 CJ0Hkhv3bpH6xmCRZgVBQEzyM69H9vza0CxghoHXxy4+S2vmVG/fwJh68w97sBaMO7vDaYg+F/S
 OlwMAHODLWqUcWJDMnLQI1rQcN5SXrIqQLerUqgCkQCO7SusZ0lGpCcZIRJG4jd7alYvycUsk9z
 RHN8YvkXzhapJwGUeSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA1NyBTYWx0ZWRfXxcSqwOUNF9wy
 gCddsN/Qou97dmNXoUlffE/+nDd0nik27Gnv1CrkLx8xsJEizROEEEf4KEJVZUuLFkk3z1rvl0k
 HOpyxXnPJxI8n+8mdnJjqg9MuDNeh2o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_02,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030057
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[79.136.84.34:received,209.85.222.197:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6A08F445AC
X-Spamd-Bar: ---
Message-ID-Hash: SPW572XCTG235WD5BLZ4CAJWIHBLUXIK
X-Message-ID-Hash: SPW572XCTG235WD5BLZ4CAJWIHBLUXIK
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SPW572XCTG235WD5BLZ4CAJWIHBLUXIK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

SGVsbG8gc29jIG1haW50YWluZXJzLA0KDQpQbGVhc2UgcHVsbCB0aGlzIHNtYWxsIHBhdGNoIGZv
ciB0aGUgUVRFRSBkcml2ZXIgaW4gVEVFIHN1YnN5c3RlbS4NCg0KVGhhbmtzLA0KSmVucw0KDQpU
aGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDhkM2FlNTkyODhmMWU3ZDU4ZDc2NTU4
YTZlZTk2ZDUzM2JjNTAxOWY6DQoNCiAgTGludXggNy4yICgyMDI2LTA4LTE2IDE0OjMyOjI2IC0w
NzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBnaXQ6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvamVuc3dpL2xpbnV4LXRl
ZS5naXQgdGFncy9xY29tdGVlLWZvci12Ny40DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1
cCB0byA2MTU5NzA0NzY0NDRiZGY4NTNjN2MzZWNkYmU4MDlkYmRjYTA2YzE2Og0KDQogIHRlZTog
cWNvbXRlZTogRHJvcCB1bnVzZWQgYXNzaWdubWVudCBvZiBwbGF0Zm9ybV9kZXZpY2VfaWQgZHJp
dmVyIGRhdGEgKDIwMjYtMDktMTYgMTA6Mzg6NDYgKzAyMDApDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkRyb3AgdW51
c2VkIGFzc2lnbm1lbnQgb2YgcGxhdGZvcm1fZGV2aWNlX2lkIGRyaXZlciBkYXRhDQoNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NClV3ZSBLbGVpbmUtS8O2bmlnIChUaGUgQ2FwYWJsZSBIdWIpICgxKToNCiAgICAgIHRlZTog
cWNvbXRlZTogRHJvcCB1bnVzZWQgYXNzaWdubWVudCBvZiBwbGF0Zm9ybV9kZXZpY2VfaWQgZHJp
dmVyIGRhdGENCg0KIGRyaXZlcnMvdGVlL3Fjb210ZWUvY2FsbC5jIHwgNyArKysrKystDQogMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
