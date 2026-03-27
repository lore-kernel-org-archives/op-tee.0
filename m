Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15CC10BA45E
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 09:27:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E6E9C443F8
	for <op-tee@archiver.kernel.org>; Fri, 27 Mar 2026 09:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1774603662;
	bh=/lvbiEdz1VZVJL+d5fMKG3v3ZHsVuQf88b1GyemJj1c=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=mB7XKVhar8kTJafbN7rhqG+UPMaHnK61czyNOPsuflppKKGmGzxrNcOxc05fYvofe
	 TXSUfd26xdl7xaPDdu0YapYJ6jwXE0uBkQcj2NLp7/R7SSovb7CmTIlmET3LCjHR68
	 VsS5PDPYpNOD4ZA0Ub3foTRFmNgqfgV4kIZzfO48xCv72QXLVPOyGmcP/iB13Fevdu
	 mKx0pjDGgQqcV8Mko/5yo8loB7sWvGFYzqRKs1D29suJXFTeLtwvyKIbRVtbI0DcUI
	 lDJDdpYsDDCXJlPp7OLJPAbaxxMSsk6SnU4OVVA70cby7m9Nfb5wrvD0eFORMr+FDr
	 jwWNl+RnTpMqw==
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012055.outbound.protection.outlook.com [40.93.195.55])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A07D33E936
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Mar 2026 09:27:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jRU6v2Iw;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GB1UrnOjxIC3hLaOLOGqiOuRnhWP2UDYDX3fDe0t4iEUFxlB9ZDUHeUlhiJ+FXIovALJnqnHeXodTNXZIQ23/C4Vwfn4m/7h8QQZ0PTtA2yxB+bIGGfcDE2r0KFvq2hP/hW3ewuY5Q5PR4h6CP78IRpoXefKLUn/DPyPDatrcR/RVxqxsWXIRd0xKq06YXZMWdeqWQ1uBcOOvrCViTxe8SJpuYpdEoiw/+OYqRo+YLLuwpE7j09XfnvsPwK/s6ISvFqaO/7jp7iNl4CSJdBJo8u0GnrQuqRtXKu8VvcIg7/AvAuv8wtwgfUFRytfdoTnYtxldPAttJ6Opcn6fpo1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVlieIzrshsfkbhrnLy6mPtgHqJ45CrHOHMAiyi8/qk=;
 b=o3RNXjCoHgE3Lz+0i9lUrU5r3WBn3n3zRGrMx6yb/5kR8m4XeHjRg6G6Kolt24V7qhozzBxFJostmq+JbIKOAKn8nyEZR31o0cQnscXhilNRgaJaJUsv6ORPxC+N9yqskVFCmelJD04SWPd6WPPFJNq8EuMqewAPzhqcFiaWmwvsbAmFe8rOCppztSblxkzdJo0I/4BKI3izwCFhavxwHONR6vz1cgZESVlFQJ4nB4ZpTtlUAXFL98cRXydwgxX0RMT1n66jvaR3E6+2LGRPQ8YLDtTvaGK2Gx0PP8fV59pZ3uY1skXBMp+6A+/4DhFSlTdhe4x0/fHhX6CKfrh69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVlieIzrshsfkbhrnLy6mPtgHqJ45CrHOHMAiyi8/qk=;
 b=jRU6v2IwNA7TXhw5Dwsgp3CBR1j3J5oDHHvMNdFZP17cBwBDMNHBhxzwpiDbJXfAClTa5OLt0zHQVPmV8sJ/flsgeUsdhIhOxUD3H4qHliDSHbLYR2Uh59Cwwg2KCMdIyrvf9bYWKN7PtfBqiNxzd9Khvd9DwJllfWKENN9XktA=
Received: from CH0PR03CA0248.namprd03.prod.outlook.com (2603:10b6:610:e5::13)
 by CH3PR12MB8401.namprd12.prod.outlook.com (2603:10b6:610:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Fri, 27 Mar
 2026 09:27:31 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::13) by CH0PR03CA0248.outlook.office365.com
 (2603:10b6:610:e5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 09:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 09:27:31 +0000
Received: from BLRRITHOMAS.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 04:27:28 -0500
To: Jens Wiklander <jens.wiklander@linaro.org>, Sumit Garg
	<sumit.garg@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>, Kees Cook
	<kees@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/1] tee: amdtee: store buffer ID in tee_shm->sec_world_id
Date: Fri, 27 Mar 2026 09:26:07 +0000
Message-ID: <6dce58425a88ec3883c7ebf42d7ef367d68b6911.1774597729.git.Rijo-john.Thomas@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|CH3PR12MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b4a489-8b18-48eb-364f-08de8be31279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ZrxugvVPY6IcHefaOcs6eWboYubmLyVKfXpx5nnjRGWnGEO8Fj7FvsKPxnLxQd5+aj/S5qyG6w7pWqcbLdb2KXRLhWaTfImeModXNjwlUhCVK4jOvagUSTXx+wy9VjqJeZ8l80c6CT4KbkoYBdg3fy1CzEWO3aFrpa6+55xdukVpvPX33CoB3/2EPCY+do9oZEcXCPDbtcsVcI6JLCmcPu67bRG8f93vKWhzt6Y2jfbeGJTGtcnr01ZA1ucyNPfCnJ3NyLbjKJZVV1fb/+mqouzqhSRTFriAcUcotTmqPyZzXznRyRkJ+WYFllh/0z9E+uPYENnWw17xWdgCiaELIHGV3TLWCRN+KQqQHv4Wkhd+Gl0HexxqNDXUzrRm4C8HStK7z4ra0yezUTR1DejeP6q3AXZUXE1CnntsoaFjmRgeTuKvTPasfRF3VQdtmcQwtTxBnWLfg/RZnWBuGQCCqdw0UkNSbmYJp2DiZbunNaxY3wdQAgp4A5E1+OLgaWTY2BkC/1S5KA7sfKK63ZHinTAlsWkdAAcllDhUR0a08ZJmB5W2AqJsiVvNLG3RlIfOJ6frZCoy+qkcHwDq3hTYAkwzVdY8soKh1lXavqJUbvR6gg4aAA+299ZCrwo1FYHM37Z5Q7CmDbAqWE1+zq8TKMlIBVNQ/1JSGq1JOUuHaPXYYoDzDv08b8/rLC65bsFTO7xWnhSWXcseye1nz7ZYusApBpl4Hjtyl4Kx7bjr/+MbPQib/e41rhcYfG21ZOVnfWs1FJgBWrhmtM5wHdXdOw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	1zjGRM/m4eolxn4h80vv4cDOZZqdWapNsLfECL1+YhXblt5K+nTEn7GfKKGDPELXb2pos5zAKwUNx1Un0qxgyRLCz2E3It7LF/RpoXBuSChupLsWfXfSGHjgu+K/yBD8EF18EkQx0Slmn0GSN3BrQTlMdoSLR9lYEbOdFvUmETqpi58ei3rFiyWzmf9/T9ZPF6jyaTY3AaIkVWtC8tRagt1/W5ypDnSQTMH+OEVW2GOwR4TFWQhCSxGHByFC2qljpCyPa7s21TCxLeEmDjsI4KxOe+wxP6u60V+/pfLVtkhkqnHBucztSNe5tbmi5mxorlVs0bqqJ3/PTEKstSAz5jbvliwHxKu5gQG2yfs65KaEhrXgzQX8UrZSiPJ2fty9bFpdwUqSpFe/cWweayqny87ACAEbjXgFr1zS70iqRDZYEnLc3o5UofEcJYtUVIfy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 09:27:31.6425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b4a489-8b18-48eb-364f-08de8be31279
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8401
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:40.92.0.0/15];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.80.0.0/12, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.93.195.55:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	HAS_XOIP(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10b6:610:e5::13:received];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[40.93.195.55:from];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A07D33E936
X-Spamd-Bar: --
Message-ID-Hash: AQRXF7NIW5O4CUF3MRUSTITVTFZHTVNU
X-Message-ID-Hash: AQRXF7NIW5O4CUF3MRUSTITVTFZHTVNU
X-MailFrom: Rijo-john.Thomas@amd.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Rijo Thomas <Rijo-john.Thomas@amd.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>, Rajib Mahapatra <rajib.mahapatra@amd.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AQRXF7NIW5O4CUF3MRUSTITVTFZHTVNU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Rijo Thomas via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Rijo Thomas <Rijo-john.Thomas@amd.com>

Drop struct amdtee_shm_data and the per-context shm_list. In
handle_map_shmem() save the returned buf_id in shm->sec_world_id
instead of allocating a list node. Use shm->sec_world_id (with
get_buffer_id() removed) in amdtee_unmap_shmem() and in call.c when
building memref params. Remove shm_list and shm_mutex from
amdtee_context_data.

Aligns amdtee with other TEE drivers (optee, tstee, qcomtee) that use
tee_shm->sec_world_id for the secure-world handle.

Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/tee/amdtee/amdtee_private.h | 16 ---------
 drivers/tee/amdtee/call.c           |  2 +-
 drivers/tee/amdtee/core.c           | 52 +++--------------------------
 3 files changed, 5 insertions(+), 65 deletions(-)

diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_private.h
index d87050033894..2c5ba02258b8 100644
--- a/drivers/tee/amdtee/amdtee_private.h
+++ b/drivers/tee/amdtee/amdtee_private.h
@@ -65,13 +65,9 @@ struct amdtee_session {
 /**
  * struct amdtee_context_data - AMD-TEE driver context data
  * @sess_list:    Keeps track of sessions opened in current TEE context
- * @shm_list:     Keeps track of buffers allocated and mapped in current TEE
- *                context
  */
 struct amdtee_context_data {
 	struct list_head sess_list;
-	struct list_head shm_list;
-	struct mutex shm_mutex;   /* synchronizes access to @shm_list */
 };
 
 struct amdtee_driver_data {
@@ -83,17 +79,6 @@ struct shmem_desc {
 	u64 size;
 };
 
-/**
- * struct amdtee_shm_data - Shared memory data
- * @kaddr:	Kernel virtual address of shared memory
- * @buf_id:	Buffer id of memory mapped by TEE_CMD_ID_MAP_SHARED_MEM
- */
-struct amdtee_shm_data {
-	struct  list_head shm_node;
-	void    *kaddr;
-	u32     buf_id;
-};
-
 /**
  * struct amdtee_ta_data - Keeps track of all TAs loaded in AMD Secure
  *			   Processor
@@ -168,5 +153,4 @@ int handle_invoke_cmd(struct tee_ioctl_invoke_arg *arg, u32 sinfo,
 
 struct tee_shm_pool *amdtee_config_shm(void);
 
-u32 get_buffer_id(struct tee_shm *shm);
 #endif /*AMDTEE_PRIVATE_H*/
diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index 441b2ceaafc3..23ccd0f037a7 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -45,7 +45,7 @@ static int tee_params_to_amd_params(struct tee_param *tee, u32 count,
 
 		/* It is assumed that all values are within 2^32-1 */
 		if (type > TEE_OP_PARAM_TYPE_VALUE_INOUT) {
-			u32 buf_id = get_buffer_id(tee[i].u.memref.shm);
+			u32 buf_id = (u32)tee[i].u.memref.shm->sec_world_id;
 
 			amd->params[i].mref.buf_id = buf_id;
 			amd->params[i].mref.offset = tee[i].u.memref.shm_offs;
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index a1347d04b3ac..0e56f4cf2697 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -43,8 +43,6 @@ static int amdtee_open(struct tee_context *ctx)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&ctxdata->sess_list);
-	INIT_LIST_HEAD(&ctxdata->shm_list);
-	mutex_init(&ctxdata->shm_mutex);
 
 	ctx->data = ctxdata;
 	return 0;
@@ -87,7 +85,6 @@ static void amdtee_release(struct tee_context *ctx)
 		list_del(&sess->list_node);
 		release_session(sess);
 	}
-	mutex_destroy(&ctxdata->shm_mutex);
 	kfree(ctxdata);
 
 	ctx->data = NULL;
@@ -152,23 +149,6 @@ static struct amdtee_session *find_session(struct amdtee_context_data *ctxdata,
 	return NULL;
 }
 
-u32 get_buffer_id(struct tee_shm *shm)
-{
-	struct amdtee_context_data *ctxdata = shm->ctx->data;
-	struct amdtee_shm_data *shmdata;
-	u32 buf_id = 0;
-
-	mutex_lock(&ctxdata->shm_mutex);
-	list_for_each_entry(shmdata, &ctxdata->shm_list, shm_node)
-		if (shmdata->kaddr == shm->kaddr) {
-			buf_id = shmdata->buf_id;
-			break;
-		}
-	mutex_unlock(&ctxdata->shm_mutex);
-
-	return buf_id;
-}
-
 static DEFINE_MUTEX(drv_mutex);
 static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
 			  size_t *ta_size)
@@ -342,8 +322,6 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
 
 int amdtee_map_shmem(struct tee_shm *shm)
 {
-	struct amdtee_context_data *ctxdata;
-	struct amdtee_shm_data *shmnode;
 	struct shmem_desc shmem;
 	int rc, count;
 	u32 buf_id;
@@ -351,10 +329,6 @@ int amdtee_map_shmem(struct tee_shm *shm)
 	if (!shm)
 		return -EINVAL;
 
-	shmnode = kmalloc_obj(*shmnode);
-	if (!shmnode)
-		return -ENOMEM;
-
 	count = 1;
 	shmem.kaddr = shm->kaddr;
 	shmem.size = shm->size;
@@ -366,44 +340,26 @@ int amdtee_map_shmem(struct tee_shm *shm)
 	rc = handle_map_shmem(count, &shmem, &buf_id);
 	if (rc) {
 		pr_err("map_shmem failed: ret = %d\n", rc);
-		kfree(shmnode);
 		return rc;
 	}
 
-	shmnode->kaddr = shm->kaddr;
-	shmnode->buf_id = buf_id;
-	ctxdata = shm->ctx->data;
-	mutex_lock(&ctxdata->shm_mutex);
-	list_add(&shmnode->shm_node, &ctxdata->shm_list);
-	mutex_unlock(&ctxdata->shm_mutex);
+	shm->sec_world_id = buf_id;
 
-	pr_debug("buf_id :[%x] kaddr[%p]\n", shmnode->buf_id, shmnode->kaddr);
+	pr_debug("buf_id :[%x] kaddr[%p]\n", buf_id, shm->kaddr);
 
 	return 0;
 }
 
 void amdtee_unmap_shmem(struct tee_shm *shm)
 {
-	struct amdtee_context_data *ctxdata;
-	struct amdtee_shm_data *shmnode;
 	u32 buf_id;
 
 	if (!shm)
 		return;
 
-	buf_id = get_buffer_id(shm);
-	/* Unmap the shared memory from TEE */
+	buf_id = (u32)shm->sec_world_id;
 	handle_unmap_shmem(buf_id);
-
-	ctxdata = shm->ctx->data;
-	mutex_lock(&ctxdata->shm_mutex);
-	list_for_each_entry(shmnode, &ctxdata->shm_list, shm_node)
-		if (buf_id == shmnode->buf_id) {
-			list_del(&shmnode->shm_node);
-			kfree(shmnode);
-			break;
-		}
-	mutex_unlock(&ctxdata->shm_mutex);
+	shm->sec_world_id = 0;
 }
 
 int amdtee_invoke_func(struct tee_context *ctx,
-- 
2.43.0

