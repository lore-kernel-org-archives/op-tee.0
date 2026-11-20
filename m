Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B724A606A320
	for <op-tee@archiver.kernel.org>; Fri, 20 Nov 2026 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CDsVIVDc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QJhjt82C
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1BCB450357
	for <op-tee@archiver.kernel.org>; Fri, 20 Nov 2026 10:54:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CDsVIVDc;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QJhjt82C;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 938C9454DE
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 10:53:55 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjra31463006
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 10:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AzCQrlehxDLRvYPoK3LFMcAPEAt34Ay7ZuowUvIExbM=; b=CDsVIVDcGFTjw6lW
	ojABQMtpyTtl++/qTE6KBz11hB1aULRK3VCrkAr54zBTvx7TBcnFsdK6Ev3DBGkf
	14+a+PY+Udz8M3a5gn+CqonKBwI0x8ABhZtzLt/BVxJzcDvblzT8IqCoM0ARCFYC
	zhWMT0lavKGQ9XQOKBnDqWRVO2hJ85KaRvx5xPlziPVSOtGKkn2/76sTJCDtyDtK
	mMzboLFqYupX1VkIQM/py2VOKTBy8a8OjxlK5IH9jQNauItI0uj01jQAwZQB2RKb
	rP8526ejDsb+J/1x904U1ljKsBXAcXUmSz5znBX0k9gRkNuJWcsSaSZ1gFSx/tst
	ObWQTg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2guah46t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 10:53:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b41e8c1ac0so1103454a91.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 02:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172034; x=1795776834; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AzCQrlehxDLRvYPoK3LFMcAPEAt34Ay7ZuowUvIExbM=;
        b=QJhjt82CQ5E/x/obejAGTuDNtCmxOSteFh4NOjusIMZJaWfTml8oRM3F8oWYjJ0NiP
         +OTK9j0UU3O/EaDHei3GswA0DkRLWN/DbsxOQNttAGNTdMGF9ex4Oq+HDAI/CsFTBGv3
         Tx1csvaOhEk3TKZOD+lXEuBB61TYy+CDC6th+9DBy4GwOyCHhGOlKLw0SI5zf+lBktIn
         z3/ulZCxo+ZIjp9caO4KjYV0l4wzO/hCRRTEBfaLN1kXbqIk2SP2md+NwxtND10UIk60
         U9BcMijpkZGn/BewwMZXlCooZfyuQYc4huIujGC0nJGVZ+AL+Y6ENCZ1uem4KvL3paQM
         oXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172034; x=1795776834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AzCQrlehxDLRvYPoK3LFMcAPEAt34Ay7ZuowUvIExbM=;
        b=vLJBAPF+Csj/6jzUbYH0EWuzoO6O0eYLeYJRCQT0caiks74QVDDBwRUH9pCTqD0/Eu
         dzSUowDml6bcORiMkMDZYF1qCC5T1NZe4ZqvCSRXByp50GgrMiPSrtUzTbqdM/GMAOJZ
         hcRHLX2uSz3hISiXatV5viBOQPgJLhjvjCqWNf/TqQb5eLCxXutABO1TKHo6cVWIrGtP
         LFUdH/8/4G4Cw7w1KoMmX7e2UpZzV7wzKr0h8wrwTZY9ZHCM09lWh1/QXkIF2p+mcql8
         kOCoV9nCHAEPYxItAz+ETDA3PzMN/AxRPrPDnhaN1SLD+WnkO6KV/ofmLfPGy02al0WD
         zTXw==
X-Forwarded-Encrypted: i=1; AL+hErEP42Jz809BoRt0Yfz9ftv4LuFBteTTiBrdbTXxP7yS04uX2YH9O0pzrlTIYp9oOC8NVr4DqLw=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8TX75PL1NwO/w/TISZMVgb0fxglA2Cs7XefjaLyuK2acjxtAwP
	Pb7UnjxgLwsdfQL2fkwxXlPfiuuWK6RejnMJreP7JZ6RooJz8DBhLHSBhGGuGiI9+v3juEqpC20
	3lXiY58VLUELLp8csW9J3MnhYBKCBO4onNoUlrRs1krOetnCoMCd8Hy6Akxd4y/52h3ZoYMmG
X-Gm-Gg: AZFdTZcBJ6vLv9wS5S/wEopOGuhO5uH5xTx1dxhDdS1SNz3ySkZZUrQ8szgiDH6nHct
	ihRGJCKKCiFcM/TcHl6ShfMcjQ5oTXyE+Fm100T/5VNeUSaOAbABqqqa9jF21HzIG9M9eitgJS9
	86benxIeyMPUCMVBF11pw5/8PbgK96ZApbJyyDVGgmwV8XIdtghAUTcV2ZmfW+Y8HKCUSf0oOLi
	E5dwkv5vKOjBGU/WRse73edeMPM6YhYODOBMdeiITXNz3eeRT9ACtEZQB+Ij1Fjd6CUWPgLW7AH
	k1Ht1se2fqbBbZWZ8vefRzNYI2lbRgqtCibmapxnhpTrqGd0cyWDEr4hm8Wn/2Jb1aR1YP68hLZ
	L/Hw2aXrFDL0D/Y290pUdPHW6tc8mfdDfplf4G9q7+UnYmcaDS6zHHI7GCTf/Fvemp5Kqjt7PjT
	0l8Y3v+J4=
X-Received: by 2002:a17:90b:5287:b0:3b4:d22:8601 with SMTP id 98e67ed59e1d1-3b41c8fa9c8mr2320772a91.23.1795172033813;
        Fri, 20 Nov 2026 02:53:53 -0800 (PST)
X-Received: by 2002:a17:90b:5287:b0:3b4:d22:8601 with SMTP id 98e67ed59e1d1-3b41c8fa9c8mr2320752a91.23.1795172033343;
        Fri, 20 Nov 2026 02:53:53 -0800 (PST)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d22888esm1559604a91.3.2026.11.20.02.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:53:52 -0800 (PST)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:23:32 +0530
Subject: [PATCH v5 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-tpm_qcom_driver-v5-1-3d9321ace107@oss.qualcomm.com>
References: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
In-Reply-To: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfX9pZmZRBOcma2
 PZz9skSMeEcd/NAQ9d5CBnl0KAYhtbPdGPVR3LsMeiXErOdwV1MsHyEtj9tRZ7EkHDnntCEjb6Y
 ury2ETKhSMDgNJmyddhEGp/J7z47ZTydi5lY5kw2lYGTEBmxatlywxAdt+GFYEzNGlxuU1rQtVp
 2G6M3zG4T84/wbzdjlrMyexCDmzxE/DAelZF/pwQK77GaeGO8gqsdGdj7+VpSSLyCriGOQfxb20
 ObbQ6NW827QcmjpddW5I4VPUf/XWdZtoZidURJBPxHFNfWg07QBZq8O9tOxGXzHJh9u6XM9ugaO
 EAfynPqpjBpbg1yh4O6TLTehg4T1tOKspQd9GUfViJByLjwShFu9A1hXad0TMGKzkr1Xbot3esm
 vN2qIaoB5YseI84Xj2PbhFSnLBwIYa79aU7YMIeaFakkHW+ZP6bovxJ5z7DbO3qqNn64xEoK2L+
 ssylQbwF6R+Z0Y7Dqog==
X-Proofpoint-ORIG-GUID: QhxfH4ffatfnsH3MxxpIugks-xfWoEAg
X-Authority-Analysis: v=2.4 cv=BIYmP1QG c=1 sm=1 tr=0 ts=6b0026c2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cMdrFq0U01fV1n6vpx4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: QhxfH4ffatfnsH3MxxpIugks-xfWoEAg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfX+LEyvJ51K467
 aZ+1HJUJwXprib/Sdb2ACqVRQ4dQia/cpBR/Pmnty01jMyT5NnoArMLDWz9UsfpVmxuI2FQKp7c
 9EQoRru7Akcv8+HA7fT9VIr1eyWnmKA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.69:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 938C9454DE
X-Spamd-Bar: ----
Message-ID-Hash: YBIDQQ3OAYLQ7A4ZVQKDKFJZ5QUSPGPJ
X-Message-ID-Hash: YBIDQQ3OAYLQ7A4ZVQKDKFJZ5QUSPGPJ
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YBIDQQ3OAYLQ7A4ZVQKDKFJZ5QUSPGPJ/>
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

Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
is enumerated as a TEE-bus device, allowing a client driver to bind to
it via its generated UUID.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c        | 4 +++-
 drivers/tee/qcomtee/qcomtee_msg.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 96badaf98795..0c9fec95c9aa 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -747,7 +747,9 @@ static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
 
 static const struct qtee_service qtee_services[] = {
 	{ "qcom.tz.uefisecapp",
-	   QCOMTEE_UEFI_SEC_UID }
+	   QCOMTEE_UEFI_SEC_UID },
+	{ "qcom.tz.tpm",
+	   QCOMTEE_TPM_UID }
 };
 
 static void qtee_release_service(struct device *dev)
diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
index 9278a361dc70..9fff9dc5fffb 100644
--- a/drivers/tee/qcomtee/qcomtee_msg.h
+++ b/drivers/tee/qcomtee/qcomtee_msg.h
@@ -106,6 +106,8 @@ union qcomtee_msg_arg {
 #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
 
 #define QCOMTEE_UEFI_SEC_UID            413
+#define QCOMTEE_TPM_UID			81
+
 /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
 
 /* The message contains a callback request. */

-- 
2.34.1

