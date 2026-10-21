Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CEE60A3803
	for <op-tee@archiver.kernel.org>; Wed, 21 Oct 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=o3PLwZYO;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=puJxVKpN;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GMZHRANw
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E1CD5451A1
	for <op-tee@archiver.kernel.org>; Wed, 21 Oct 2026 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792601769;
	bh=nnHpd4bx+xnqCGadlpjg6LWfW2XLHlPM7N/NflBe06k=;
	h=Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=o3PLwZYOEglImMncVBMJLCAE4jIG6AmPEnqq0bIUF4wHU/lCdrwQ/ziLvtxGKrzhg
	 KpMV4x7r8ty/cjgAQrqVVrQ3OheeQEhj7IRIUn3/WfYrZhFUnUNJ2vqakbNhSYLvd3
	 MGB35ss58/l7Csv/xYAQFwjYHMH7yTyBECak4zE4wjSKwggBtYcoYImF3mr+WMPVu5
	 YL9H5/GUzcGQsVfqg6FV0CXLW9OKpiABzzgYWHxwOMVXZI49lA/lEExqojZKxZYh7i
	 0oJrdn5i51qJ828oPz0EraxPvQYENrtDSX8Sj0X8skAMR/ActgZxxsE6PI4ZPSRQhy
	 hqZSIdni+ezcg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9060F44A8C
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 16:55:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=puJxVKpN;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GMZHRANw;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFTuKU1045403
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 16:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=nnHpd4bx+xnqCGadlpjg6LWfW2XLHlPM7N/NflBe06k=; b=pu
	JxVKpNkA7X4dN9zqdcX3QDjKDF3w0WwbD6j79fMyF34MeJPYb+JpuHvoomgnFXGR
	0KPylSv1hcZgM596Dtk2i7zwksrZ6uyCAXZnVNkpUzw/QRHpZvoaSwElAjsKgkZJ
	DFBk+R5zN1ZPecYDIUT7Fdi2foX5bh9mJpe5MzYNwPFYBOc4A802gNDX4CKTPD7p
	zFSrG+0nidq5hjG4njrHp/pWRk5j3erNVgGUt0/+WOLzsUxJFhE0y0iCJQT67uAK
	gkBuAaE08uArTC9qZQq//6sNLL0f0QG4UWdWYzSrqSM5Ubq6Z5DT0trI8C86Tbtz
	wInVtKvNO4Z/mFyWrlLQ==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj49vcu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 16:55:38 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-679f2615dd0so1392373d50.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 09:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792601737; cv=none;
        d=google.com; s=arc-20260327;
        b=ZWSRSYJgKgjj0IZIKWKLMDUrgFc392x/LofEEu0rgIZm0aRk/cwb9224PGvfns2Mny
         VWz4tpHsK65Xkqg4/jkSpAhj0vbIWdqU1AWAxeHePH11ZHnp370OeW6B63hXYpr8xfEQ
         nW9xT9OiNgcprGOnrv6WpISwTLQ2+shLEGcMxAg4N8sPRAHIXHC8pSjT34IVuYn8/lqP
         MmltYyIVY6mauI7QGLVJIRBLwwf8aRyxWnxxxiBxVrcAOcITCKkvtf6IkBGxB9RL9xde
         kZByKnmTfaEJOdW3WrS8DmzdGWsvQBVnh0+X4d6/hbpbCRLTIUuCpsFOTDy0CbSXJ8VJ
         PsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nnHpd4bx+xnqCGadlpjg6LWfW2XLHlPM7N/NflBe06k=;
        fh=DBvxCipNH2RlJe8Lt8jDz73G7et6cRT4xOp4aNQo0jg=;
        b=GHgHtObQLiRT+ZQDy4NUNzXQFw6tpDqvZORXFox3d4gLtCaKJZlZ66UFj4lJbABJRi
         ljeEBmdg0c5ury42GyTC73ZiwkudlKEqJh1SIIct1UnrkfPJ8mBlBTJSWWAnkdO/mhQP
         rpXpStNGD8sZvPwkarHl3zVQuUPu8w0BckVLFO5ZAjSAmvP6LApnLAG6KhvLNs4MhBxJ
         YZiMA9Eu19riS1eX9J1mZmftn2IC1dhrau4B53ExqEb0tsArdZ8QUmQx1SbY1WDAOJCY
         5GeLKKtHPZhZogO1dAtrjWGDuTgnQYqR/IemkCZLqaBif1GioA7AJjFzcaZqjDcZFhq5
         O/Vg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792601737; x=1793206537; darn=lists.trustedfirmware.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nnHpd4bx+xnqCGadlpjg6LWfW2XLHlPM7N/NflBe06k=;
        b=GMZHRANw5/JOoG5wSAn4ocaiFShi0UUKOOWIbgEfqorDDkVnd6x2uvmK9uTGluYx3J
         RTiXCtUEKo4x7Fn6OYCa0IG063ddysKJTkT3YlR19s4mTg66raDHXGsUjUbIwm0JaGTK
         6FyXWAAKOVpBaQ6k0yH3al8wpPJfLn7PuT99az8WQR5SVsbonUKz+Nxb3moWPewuej5g
         VZRYTRgIcHSYVKB9HUBpYgBlYC7wL91SpXJ4d3TQhq6Qd+Sgb3BOBp7I7mIbKhVOiZAm
         MW7JvslrsbWCPY+Bkw8mY3B7Tcl+/VANpkfUJfO3TjNrk/H3wYdnto/fe/h2Eg0sWLTO
         LA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601737; x=1793206537;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nnHpd4bx+xnqCGadlpjg6LWfW2XLHlPM7N/NflBe06k=;
        b=wIFmA/J35U6e/GpeY13g8OurxOSV4EvBjy1CxUNNw2rtSaA+lBdgh+Ctu5MhCO7/2v
         FiU5l5qL2yB5WsGb2HOs8eyaTltzpKFeiO3Lt/mYESFsQWOphdYXbUU6B59n5QniT02r
         8lrw06PnSqlA94dCWP5B3h9zusffdFrjfbn6RNKPsSuEFkX70sbMcraxT+Vnr/0fMO3i
         Q4d2ict/rt6n3PTmtxHG88abHKRWa/LVR5I2Mq/h+onOpFXM2brJBRmBYroB8xYNlR8l
         03Hh9SwxvBvIBJbxnKyh0ZT3Ou8x8cTHap5twj5e1O/SSDD7jL0tssLMDw6dYXb/9Z/8
         KbZQ==
X-Gm-Message-State: AFq9FYJ3KHM7TMbAu2djT/M2/SkbArsxQUG+zXML8ya4elFELyXrkLb1
	uqKpratTSsttS7L7BtTBCiPaJmu8gTOSC4iB+9+hIHfUoNKsZghNjVwj7ASElzs6Ufnh9FkM5y4
	Q7h6oMnQo+jVLvpFEoBi7Qzg8T95nO8DjWIOTTJ41Kc1HIr8Ka3Ahp9LZKYEBWtGb3inNiDs1Bo
	CTJ+TVEeewNZ12HqDV6yoj0VcBaxu9YWKUpcfogqnRgkrCgNylU7BN5c6ELF32
X-Gm-Gg: AYBFou0H0Vqa9chiTZomJWheZyeX6+dyFj44N/jEV2jGh8S2DwZ2X7sxIytThcjNexZ
	NszcwkgRX37IGC8EhOPMCbHWRZib6TRxnlPynvymEfJW2Hr/FyhzxnWYGWP1p49UZhtH7mvvhcl
	bztKhY2YpxLqvGYxqFQwgdOn92X6PCTJqrRWD3/Kps6zHgiN4eAYuzzqo=
X-Received: by 2002:a05:690e:4551:20b0:679:b274:89a8 with SMTP id 956f58d0204a3-67a0e4b2a88mr846517d50.27.1792601737385;
        Wed, 21 Oct 2026 09:55:37 -0700 (PDT)
X-Received: by 2002:a05:690e:4551:20b0:679:b274:89a8 with SMTP id
 956f58d0204a3-67a0e4b2a88mr846462d50.27.1792601734570; Wed, 21 Oct 2026
 09:55:34 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 18:55:23 +0200
X-Gm-Features: AclHuK9MeBJzgnrg9I9FD8HOaC-d5QRj2QRHlIsrdTcV77DNfdAZkVWFznhaDAk
Message-ID: <CAGgiveWfGgRB2XD0+u5So72x7S6atReea-JWrxSzCN3mREX0QA@mail.gmail.com>
Subject: Rebased optee branch @ linaro-swg/kernel to v7.3
To: op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: fxky2D9TewCyVpVXOB85WFuA2RZ0C5oG
X-Proofpoint-GUID: fxky2D9TewCyVpVXOB85WFuA2RZ0C5oG
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad8ee8a cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=GRxcgOE89YqtTabDk7oA:9 a=QEXdDO2ut3YA:10
 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfX+7G4g2+vrYOx
 kZ/KP96e48sXkabnRP7qntqgEK8CF6GZ+Aih/diJae8t1uCFo7TFZFV925bnqz76jXja/h+bRGO
 uJKFnn8h/kBoJIH61y2+QvcytvKCZ2wMFxgE9K5hS+h92Qaa/Pf+PHYGgXp9Tg+bLljrn8QrV6p
 eKuP0LPQPjeVA26arAj4U1Fx35NF2G/DPUVLF4b0li9oeRZhDGYjz4uohQZXJy8cQSTMIekC6De
 Q0LkkHCzH6luwRHoD82r704T2PzQwFhpcbzlnk6ypHGzDO+Z1QBiy5FPZisKIz+MYFAnreJWta+
 hduOrTQBcXabFVBxdAgZn92BTdaNTsJnJ4FVWdr8hzEJLz6LE6zkW3RDaRHS5PLmP+QyrZzHvu4
 QIQisoPATnOehT59iSsq/7d7kXpFfN1sVZ/beNsBCi0fqANBhI4LlhTcBCFMRxbXgttQUKXYlOU
 rgIdXuMIBSYWt3rCJ+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfXz/WRrqGK0/dL
 C34M4RIRfTZ6EsYcyfXh7RK6BK9/+VPVg9SgLdU/nee12YZdpJB3eSFqZBlThlgvf2kxPHqhp+n
 jVu3rsDXnB6WwIadYppiN2v1sPjsDQk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210067
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.76 / 15.00];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	BAYES_HAM(-1.66)[92.87%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.224.69:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9060F44A8C
X-Spamd-Bar: -----
Message-ID-Hash: RGIK7S564LKLWRJK76QQH2YA2KLQYUOI
X-Message-ID-Hash: RGIK7S564LKLWRJK76QQH2YA2KLQYUOI
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RGIK7S564LKLWRJK76QQH2YA2KLQYUOI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

With the release out, it's a good time for changes. I've just rebased
the optee branch @ linaro-swg/kernel onto the latest kernel, v7.3.
Please let me know if there are any issues. The old branch is
reachable from the signed optee-4.11.0 tag.

Cheers,
Jens
