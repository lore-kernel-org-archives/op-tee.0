Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BEBCA9ED0
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:43:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0E1A545251
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791870188;
	bh=xfd7voO7tE36nEMwmvhnhqtwXd+9sNurmzQCmvHnQy8=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gQhXgUFqVi5e9ppowP3fCVoxTlHo9lPBZO/WKZAVqAv6XP+10lTK4DXLEnz+Sbp9k
	 vXUQITlEtyRLR7r9SFrZsG4Zmbuc9tNoMMGLZ+4UJHVRqS77cyJHEhL8whyo/duJ32
	 GCu0dxppcbftnkwtteL4Q0TG1y5+sDK5dMzPXwckuyqXMF1nPKlqEEUc3xKUacnvZ+
	 mhJ/KuEjSgLD7vJeiKuIAUsZWz4RToV0tEkfD81KXIc64aDVmZMX1CeGzrenI/NwVJ
	 CZh51zmi4AIuuMDIMnt4vdJRFO9P4QEU5ob1WbFRjXs6hO8fmxq6zwxsOT+C0vn+jd
	 mCCQ18DTGYtpg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BF2D545244
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZukXKvuc;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YSR4PV4G;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D21D3q409280
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TyCY3djL8PN+a1DxJAYuBVVySj7YPULq6/PcA5HDv1k=; b=ZukXKvucprqa55nG
	6Ol3JABAIrNuktgDdaGS81x8aQCwhCsqsacUEPXAYQ2SQodmfxUcDvkSWFEOxUyz
	f8f/Lad1MWn4GWQ1p8i6YP9BXhR651v2HYhKXoqgk1vYqEnAE3IiLNSPc/UiRRYc
	IUSKpq/HuRxt5+Pl6CW1fNRR2lxrD3pPYzPv3b4X+Om0T9BHALkjZmCPDON+HPil
	QG47bFVQUKeB4m/XDb2sHPXoTdbUkw7Y+/8Dgax+OZWPjHpQpBSsxpqIpjelGJQE
	YaGFGdRcEpf5lmJ0YdHiYUbFwHqx6GnBJ5eSgDIzQ0P35ZBfWGC59IUZrSOZ9Sqh
	BuPnDw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wffmbrr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3abfcf726dcso2054469a91.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 22:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791870111; x=1792474911; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TyCY3djL8PN+a1DxJAYuBVVySj7YPULq6/PcA5HDv1k=;
        b=YSR4PV4GZZw/rTTd94CaENchfDFCwC2WKeIMZ1rFRJNCQHbkWrz/v1IzfVQ2630zQd
         U9hcZFa9i3V6yEY3pzyRWnLogo1HPFPFsxtfugTnvcKce2uzU0HmGOB51iCnCI3xUgPr
         +OrnZv8mR7dR5YEwhcTOF0IdvJMKvB0zT+SPJwHRykxKzED0Heo8kd/C0zHNUvSQcxSa
         D69OWIcImQyTk7RzMdyQgOea0ZuuBa1pXpC581EU9eY1CeXYxaPD1Mb9DDNobWIydZL6
         xxcOSplEV49AApgbJyvaXp7PY4eVQviOXraRn3/i6XMv4p3Ei50Lj4PY134AJ1sD1j9R
         I/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791870111; x=1792474911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyCY3djL8PN+a1DxJAYuBVVySj7YPULq6/PcA5HDv1k=;
        b=FqdLAC6q+c3IH8vqU2JEVv3DJkhW2n0UpeAkpzaIQQt9NPs9QWH2GZQ1EH1tnv1y/5
         vAb/tNRZd3/mFXho0FlkQQKzoxvq5+FwD8t7VrECK3lwfS3gAalvJTp3UjYa/CWOZZQR
         cCwma+4ChPR2eIMKHVbfyQ49ay4WMTe0bicmJGZiwir9C0I8La+rDetG78aUUGbtcrPj
         mKiaYg7MfcluTAPXkXBhIrRRMif3LQ9hnNHtp7aiLfWz93bgO3TRcyAbESyQe0zuOAH7
         VIf0nK4Xr0BypYf1xaWCBxE6xFF/ZktbItNnQhoLQjyJucAwlxShGROyld0OFcZ4P/Im
         zaLA==
X-Forwarded-Encrypted: i=1; AKwUvBycNKRSse3d+E26ngGF4UPQ9LvZxeX1UMdwGS0PBr7ipJqiWceHjISNJNsSjS/3WWrga1XnzME=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJKSnbL6JJLsFaBAMZmreC+TarDkYfBYVjRrNncXKrZPvCrm5B2
	dcuWopomkbNGucZbA3m4o2G0uZVDPLTiC4Ysr/XqzdBuF/DyJ+iVKEE6ghEcvPOWZAKPvF+qlKM
	ivdKNOaW8DADhBdmHDZPk1UiVHhwb0fxZ8A3XXJgpWOugtVoDQvFJwC56wSoHwGF66EtnvKs=
X-Gm-Gg: AYBFou3BngiOmH2Vb/2T7WdM6NVN2orDirXuWfodwYhySAqlS6UuCC9kMgs8Q6xwQL9
	/QGI36ylmxA69I+GXJi6TQLz3NNrS03LXYve6CrNUJdXpLKyq9L+CrlKiUkJbqyuRV0KRg21jOC
	WX98DvYRae8by8Thbc7eTziowwkJ7gLYfcM40SbgPp+gq6fnAabiFjBwpk9pYblb0vqC3BVtJ5z
	/4MWFjMA6cQVejsjRTcI9dWW4S0mzzn/kKN93Z6ba9MbqXrH/5/62Ri7c0ereRi8bZ70pl5+DmY
	p25PDS+92U0REMH2rAaSfWrPlVjD74QKHPjK3rbn5gEfnQmb4qjXsrT5aMl0msIsESXmlw3nx2B
	75+g3CQN06A34UzS69N1p6hMG5bhpfEaPcfVrCipszFUsIr5bV1UXKiPU1A==
X-Received: by 2002:a17:90b:2f0c:b0:3a8:5d1f:59ad with SMTP id 98e67ed59e1d1-3ab3ac9b91fmr10370194a91.43.1791870111220;
        Mon, 12 Oct 2026 22:41:51 -0700 (PDT)
X-Received: by 2002:a17:90b:2f0c:b0:3a8:5d1f:59ad with SMTP id 98e67ed59e1d1-3ab3ac9b91fmr10370183a91.43.1791870110729;
        Mon, 12 Oct 2026 22:41:50 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f4863esm22926361a91.11.2026.10.12.22.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:41:50 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:41:29 -0700
Subject: [PATCH RFC v3 2/9] tee: optee: allow RPMI transport builds on
 RISC-V
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-rpmi-tee-service-grp-dev-v3-2-975b574667e2@oss.qualcomm.com>
References: <20261012-rpmi-tee-service-grp-dev-v3-0-975b574667e2@oss.qualcomm.com>
In-Reply-To: <20261012-rpmi-tee-service-grp-dev-v3-0-975b574667e2@oss.qualcomm.com>
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX/9jRniwAbmmf
 zNj+vDOawnRtr2n8Ff3ncIPh2h9fo30XBZiady/T96biyaz98Hn4zkzQu7E2LYkAyzlTgdwxPN5
 spJjnLJqD52ZID9xMl87lyY/iJ+PGnT9bw3MC93kXS5GN8NIDolhtp25e5kRFKHmoYa/E0rRIfW
 Uf01VITpcXejK6ypn4c8wH1ka+6vpc80wGLdoLdrHursxGNRe6kmDDqrkxxOJVdtwoZ0zcEu28b
 X0uAT+5tvOeIut8AxqjLCjvre5D553kjESejf890wtg+4nqt/jI22tcmBUQaF/pZiAle5wf9ehK
 c842EfsiYN6tOlesMYLQ3dAMYTLMv3akKwTAr+caW5sktJ8nOTYLSfrAB+QgnaGXlf5nBHjkO48
 tOIyHsKriG6djPVujOjsexUtXMN/DFlV7eZFd9ExUsnch4KiO9ELyEcZPpQzpqJfxDDoo9XhEfa
 MWRxjYfjO3ZKkPKTjbg==
X-Proofpoint-GUID: wwhZKNulNkv-kVSm156zNphutChwgRpO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX7cUdfWSX3P8T
 qv5zfrjzhVzWM26pjBwoC5+rbt8rRVZgolYIuH6jgZYIjs0MwF3w1ohQq2A9UEOPE+YXIz8IWVC
 f7mEvgPqtAvye+6XnS3IFFC01XeLlXw=
X-Authority-Analysis: v=2.4 cv=ZcWIpcVA c=1 sm=1 tr=0 ts=6acdc4a0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=FVoukCuPRgDGiLv7d_oA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: wwhZKNulNkv-kVSm156zNphutChwgRpO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130022
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DNSWL_BLOCKED(0.00)[209.85.216.72:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BF2D545244
X-Spamd-Bar: -----
Message-ID-Hash: RF5KN4QHM7LU54476KQ7SEREB55BZDS7
X-Message-ID-Hash: RF5KN4QHM7LU54476KQ7SEREB55BZDS7
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RF5KN4QHM7LU54476KQ7SEREB55BZDS7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Allow the TEE subsystem and OP-TEE driver to be selected on RISC-V
systems with the RPMI TEE transport enabled. Prevent OP-TEE from being
built in when the transport is modular.

Common OP-TEE code checks the memory type when registering shared
memory. Add the RISC-V implementation so that code builds without
reaching the unsupported-architecture error. Reject mappings with
explicit non-cacheable or I/O memory types.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/Kconfig       | 3 ++-
 drivers/tee/optee/Kconfig | 3 ++-
 drivers/tee/optee/call.c  | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 98c3ad083940..ad754b647a3c 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -2,7 +2,8 @@
 # Generic Trusted Execution Environment Configuration
 menuconfig TEE
 	tristate "Trusted Execution Environment support"
-	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD
+	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD || \
+		   RISCV_RPMI_TEE_TRANSPORT
 	select CRYPTO_LIB_SHA1
 	select DMA_SHARED_BUFFER
 	select GENERIC_ALLOCATOR
diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index 891dac63cab8..cc057c76de62 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -2,10 +2,11 @@
 # OP-TEE Trusted Execution Environment Configuration
 config OPTEE
 	tristate "OP-TEE"
-	depends on HAVE_ARM_SMCCC
+	depends on HAVE_ARM_SMCCC || RISCV_RPMI_TEE_TRANSPORT
 	depends on MMU
 	depends on RPMB || !RPMB
 	depends on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT
+	depends on RISCV_RPMI_TEE_TRANSPORT || !RISCV_RPMI_TEE_TRANSPORT
 	help
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index e046aff61828..267513cf4ec0 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -604,6 +604,8 @@ static bool is_normal_memory(pgprot_t p)
 #elif defined(CONFIG_ARM64)
 	return ((pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL)) ||
 	       ((pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED));
+#elif defined(CONFIG_RISCV)
+	return !(pgprot_val(p) & _PAGE_MTMASK);
 #else
 #error "Unsupported architecture"
 #endif

-- 
2.34.1

