Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0EE606A325
	for <op-tee@archiver.kernel.org>; Fri, 20 Nov 2026 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cen6HUbP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FOyT90ds
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6C660454DE
	for <op-tee@archiver.kernel.org>; Fri, 20 Nov 2026 10:55:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cen6HUbP;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FOyT90ds;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7DC924553D
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 10:54:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAkC7M1017053
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 10:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uj/gif/EMkxaB651vPrPhFUEprfbTV3srXkqqMvLfTg=; b=Cen6HUbPI02arLjb
	pxF8ifzkAJZ+mH5QwSnReeuz1PFDh7Pi2WJZKu14LG/Y7PQxapT//KpZAAH8qOcC
	JVAZ2Od7N879dZDBaLK3EEkrza6jVjIFq1AFeLOHNW2/RObqNi2zOirxvPCv5MKZ
	fisSgG32nyhGSteM7zUCzKUD+zBLFBgQNUfoB8FwU825XylQidGyithQxbR+hug9
	HaiqaVGTW9jdycB//UD094P6TpkWwVOuxM1PoV6/k4tcut7quInMURNpU12ArA86
	2pebd22Ijvk8ZFOrw6kQvD5dD9AqEtIV3D0FLjmo3c5Sm126agQ+66wZy0LetMo5
	bYITgA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2ggqs5ug-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 10:54:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b40e7f4fa2so1528117a91.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 02:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172041; x=1795776841; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uj/gif/EMkxaB651vPrPhFUEprfbTV3srXkqqMvLfTg=;
        b=FOyT90dsb2FhLXEmaAVdj9mYMML0DVRFZwVMV6s70FDttCbw+SCACD0WjHdvtC4of3
         15fVOMFV02NLiTIqL7/topo1S341z2NopyRF0pGzLw0f4R0f+yIYO8810yk53fLHqRnt
         yvViccHKh052D3SfbPQOyWBvUwdJp+83A4XfSjleTWcfzIpPk5iYjwRV4su5sQyJmSmn
         h6z77SGIn0fU0XU+K8YqRpNQ6BErPLIUVjt/IfswOMllH+r91tFdF2oXAfesuMo7bPtB
         JwT+XXw5CJ8umEzwWPIJ6WSM0hQYQhy9tUcJZPlNreLyFzoxhpH+iy/4nN/XnHO7bhcd
         a/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172041; x=1795776841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uj/gif/EMkxaB651vPrPhFUEprfbTV3srXkqqMvLfTg=;
        b=RdEMiq6qqxr/NH/lTU2TkHOgOxwn3usI8WFgv80xJ1RJK6kJPK1zaHX+8otdjKe1ZV
         cB8k9l8AhBvjBdpRxaPbkAZ4GT6ccyq0ey253us5ZVoN8+5orKD3hGKMA5H0eQB7kzAn
         Vg9ZdpPqbd28XRdj65YmYzwcx/HWaWE0aMJceLyQsQspx5tvaaz3+PwzJWqgEEJxMTKR
         wtTDqQHYIcTfUuKfpqvpJgaHFKU5Jxih+7wEIL4WiLMUVPQhG+ktlRsAhlTt4VoIw11b
         JSgdPLc3qHdshG02BF3CkdhRih4VYMBVOgEoRded/wkz3p21+vT0r+rqsX6C7/EHpKLe
         m4kw==
X-Forwarded-Encrypted: i=1; AL+hErG8NJ2MVolcetq7QhSCNoTspgGI6De1bE/i0mi0wDHjEHFwSe+SFf0oXC2mnREAjBrzpZtbM2E=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8f64t31R5ci0TGtJdrZdTsFPBGOEmNLcLR8Z45MWZpqHg4kfkg
	/yGGtPIRaZFbsap1sJXSWkdbs9o0yO2EA0mPGoDk5BgCWYdYKRdFS3l78QRNUdP49tjJnsfO9Iv
	ZzXqDxt7YoiSUNAP0niZjfI2eyrQCRhksNz47MNVe4JBQKOXJz5qiMmVsaTetSbT3DaVB7RTj
X-Gm-Gg: AZFdTZfGUI16LdKV0eBPxdg3FcuMGY/ZXy470Gd5PASOWmjdw/m1uPCKSr6HgQsTAeK
	Kn+G1p66KXu8BPrgrigG3gPj16pKD3U2migEUAp1BEN4iwmS3o0BMkX8sZfTKIyDxfPf0toyCUE
	NLvkyhFiQF72Q188gTHwq9okCPto1i+eZ81ioKO5x8K8VpTBlZfiWI6YS7HyIzIbNyulgDEp3wz
	+8iV5vD6HrlO6+xi3bjVBoeJWIJ0zpVtch7P5IzsalGjPitMZraOdQeCZFM0iob86HeaP7/CTwa
	Zv/BJT7PyDjnBjqH0k3EAyLotuQH8xWLL+qgYAyZDC9PTX2Tjz1YGCdkbihxbYIz0BADYOs+i3+
	Q7c5QXtIrCB92DD6o1ipksZWu+4TRFvTHAzxo7fk6dw77wUnHXRsSsWi/qMrE0s1ENNJpA5KfLQ
	xP/yMrtNo=
X-Received: by 2002:a17:90b:3d8d:b0:3b3:b704:118c with SMTP id 98e67ed59e1d1-3b41cb4f321mr2403020a91.65.1795172041447;
        Fri, 20 Nov 2026 02:54:01 -0800 (PST)
X-Received: by 2002:a17:90b:3d8d:b0:3b3:b704:118c with SMTP id 98e67ed59e1d1-3b41cb4f321mr2402997a91.65.1795172040980;
        Fri, 20 Nov 2026 02:54:00 -0800 (PST)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d22888esm1559604a91.3.2026.11.20.02.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:54:00 -0800 (PST)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:23:34 +0530
Subject: [PATCH v5 3/3] MAINTAINERS: Add Qualcomm TPM driver entry
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-tpm_qcom_driver-v5-3-3d9321ace107@oss.qualcomm.com>
References: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
In-Reply-To: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfXx+/F6qB5SVVq
 V+G1YvvH4eu2r8na3oDHbSSWLIpoSZywCpwIC/JMaNSa47GMnhJB1x/7dDFVhBmh1NsMAFQqLwc
 gfW3KmQlANlD/qIJBOY2bg5ttsEvwx9BRpeZzqPPN2/sYEENZXa+JRHaXIxcpsYs0R8kCcO4qpy
 14XpfUsKXhAqHSYCrZWkUVKQ8Lg3oHx7BqD6Ls9uZnRePp58KH7QC6umdUd/TxEKave/BIDtRw2
 ACfqCjNtwlRA2nvBbIhIPLPHI+HsWxxtvEwGRee10IlvsUG7nh2fSoa08XeFZw2GV27W/YryZuK
 X22RMekcVV1GtQac06Wy6FmWaQNJDX+ArqISJ/p93dhiBkBRPy/AOFndz4takAWUei09shwZp+Q
 0XgzcmAvo9w48OarPGV0UMNMtuGqc7W6tFe2s96cg5fhmWiftF4HQJ0Zn6AkzOsCezsrNVQqvop
 d97UgUHJZ27xnuHZZPA==
X-Proofpoint-GUID: iinaimDDWhxOeJbfL2z0ljYNsK3kejAt
X-Proofpoint-ORIG-GUID: iinaimDDWhxOeJbfL2z0ljYNsK3kejAt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfX1HTo2liLiY+o
 ODtbVBIH+UU+lHWCxM+HKd5Ain0ePlT4tITqW4R5FHpA+d9wZoyOC0OBFGCv+u33jSB049pgVnC
 5c7N8olS7/PlMWCheXLVavGYZlmUh/0=
X-Authority-Analysis: v=2.4 cv=CNy/zhrD c=1 sm=1 tr=0 ts=6b0026ca cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tHMf5gnvwFDjO4kcr9MA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7DC924553D
X-Spamd-Bar: ----
Message-ID-Hash: PANAOVEECADAY75PAOV3SEB24GIPARIK
X-Message-ID-Hash: PANAOVEECADAY75PAOV3SEB24GIPARIK
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PANAOVEECADAY75PAOV3SEB24GIPARIK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a dedicated MAINTAINERS entry for the Qualcomm TPM driver, which
uses the Qualcomm TEE interface (qcomtee) to communicate with a TPM
Trusted Application running in TrustZone.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 733719f400b3..bb80ced07840 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23435,6 +23435,12 @@ S:	Maintained
 F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
+QUALCOMM TPM DRIVER
+M:	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/char/tpm/tpm_qcom.c
+
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR
 M:	Bartosz Golaszewski <brgl@kernel.org>
 L:	linux-arm-msm@vger.kernel.org

-- 
2.34.1

