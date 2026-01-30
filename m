Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4A6E6BF03
	for <op-tee@archiver.kernel.org>; Fri, 30 Jan 2026 11:26:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4A90243208
	for <op-tee@archiver.kernel.org>; Fri, 30 Jan 2026 11:26:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LxvWrisr;
	dkim-atps=neutral
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4153A4329F
	for <op-tee@lists.trustedfirmware.org>; Fri, 30 Jan 2026 11:26:06 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4327790c4e9so1268543f8f.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 30 Jan 2026 03:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769772365; x=1770377165; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VTSM1Hdnzd9opFai7KOO5We54G9/h05IaQO5gGw5wwg=;
        b=LxvWrisrYZ6MFewlQRzQUjPoSC5e6su7YUuQI8fEtUQcV8ftlaocdXGGDUl7E64+7U
         l1g7GWiEtDHsYmBl2eldG5pM9ih5iNTPx5NhKujFMztDuYMvhTx+A9ltXangIFq0yewx
         PT5nVp7iMqI7DIQ2cUgdCruUug4ZN9xAC/Ad2RUuhWZwmqh64hxRnEkZNcWm3yOTtbCz
         pzJ/jriKDBx8Z44fMeCrgDMCJGIW2MBPJyQn7byHvp6cRFYSALssw0CTXuFW75d4R1EF
         q+EtwAen9J/UQI8Zi6fUB2dnDJtpuVPIvl6CVlvKCYBLZWmmaE868cDlYvkxwf2zae7l
         BZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769772365; x=1770377165;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTSM1Hdnzd9opFai7KOO5We54G9/h05IaQO5gGw5wwg=;
        b=n4nPB3TPsS3wJf5u/9QNmrSzPIlH4jiicY8XTjFkohBY0HefaeruEP0dTH2pxuKgpk
         IQ9YdRHIqNUoI+NuedHfGjjUgc39Bqh6OOYXfEZ2uMRymrc9mrhOU/ku0QV82Ye4ZKJH
         rizaqQC1W8K/btcNzACyf15QAddoJ6a1VQO2NquukhOil25Ljx9uDPUugQLgIQ+u3LTO
         hsNqJoI6o+/EcP1URrk4xJ63caE9wsjYQzkc3XGuuw+wwTS13R3lBFJGXjLu+DKBxnCl
         AU2uP+iJYEI2VtvMQ1jGIVHwRloo61l4PWgd8i2YhxZdUxgdvkeyd/4l75Q/VQBUcJrl
         4KpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrbWVE4rLum9vVp8n/Kk7vipBGkslMxt0117eDzPmrrFgyhWF6czKVlJcPc50cLMYmzp6CET8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyGK4Aez7aUZBZKeQT8ZAGpwnh+ONnU9kJ/YpiT6/JGKItcCTi/
	He5zntP0TY49qhGouvPSKUO/NxMx1zlTfjEB+fUwXFzu+zUnS8M/xSLL8UWPOvGf9+EelQ==
X-Gm-Gg: AZuq6aIse4s8+gMc/wCNGatVgq1ysHvJSNKycIFI/AgmfoM4BRgOTsSvedJj4cHu6Bt
	xmRrijS+GsqhPs7NAtn7MWRqLn0OoOTbidicaP2ms0SW7fhJPwGoTRZ5Bad4DhoFg3cdEBWs2ND
	N1kxFqJ5sMtH2XPfCwH+I31vM9xMmNuqjX4Y1OswavCvlfAQpx+5rUn81XdWOAOYuTKQs8UY7pB
	IjS+nKHs5LgLjFQtDgParP+SaVR7cQLdlZFwlCgL0sPepCqr8YRoMHlToI2dqvDvGAtPNLeSL8K
	/u0X94M1wZDcYIwy/WXlgKQQe/VOQdiT6DCmjJTG1hOmiQuObT9AA0g6U62mh1UxfaRwuSOoDko
	FDjUVcagZ4p4Auymt7xbaRjjsylb8vGV5MEjxtPEU33kxKc9pFjb6NURoNQLGAgpckssxADPofH
	vCtt693b2NWjOLuWiR
X-Received: by 2002:a05:6000:25ca:b0:435:a815:dd86 with SMTP id ffacd0b85a97d-435f3abb19dmr3987305f8f.62.1769772365032;
        Fri, 30 Jan 2026 03:26:05 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1353ac2sm23044115f8f.38.2026.01.30.03.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:26:04 -0800 (PST)
Date: Fri, 30 Jan 2026 14:26:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
	arm-scmi@vger.kernel.org, op-tee@lists.trustedfirmware.org
Subject: OP-TEE: memory corruption in
 scmi_pin_control_list_associations_handler()
Message-ID: <aXyVSfxbrff_GX8A@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.49 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.66:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.221.66:from];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4153A4329F
X-Spamd-Bar: --
Message-ID-Hash: ADGDKGBI6EHKBYMBSGH5VG5XLDAEEKYH
X-Message-ID-Hash: ADGDKGBI6EHKBYMBSGH5VG5XLDAEEKYH
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ADGDKGBI6EHKBYMBSGH5VG5XLDAEEKYH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

When we do SCMI on OP-TEE, the in buffer and out buffer are the same buffer.
I added some debug code to confirm this:

diff --git a/module/msg_smt/src/mod_msg_smt.c b/module/msg_smt/src/mod_msg_smt.c
index 853fe66b8d27..1e92dcd49c29 100644
--- a/module/msg_smt/src/mod_msg_smt.c
+++ b/module/msg_smt/src/mod_msg_smt.c
@@ -175,6 +175,11 @@ static int smt_write_payload(fwk_id_t channel_id,
     if (!channel_ctx->locked)
         return FWK_E_ACCESS;
 
+    FWK_LOG_ERR("OUT=%p IN=%p %s",
+               channel_ctx->out->payload,
+               channel_ctx->in->payload,
+               (channel_ctx->out->payload == channel_ctx->in->payload) ? "equal" : "different");
+
     memcpy(((uint8_t*)channel_ctx->out->payload) + offset, payload, size);
 
     return FWK_SUCCESS;

And it's true:

[    0.000000] OUT=0x9c401004 IN=0x9c401004 equal

This normally isn't a problem because we read a few inputs at the
start of the function and then write out the result to the output at the
end.

But in the scmi_pin_control_list_associations_handler() it does a loop
where each iteration reads from parameters->index which is input and
writes to the output with scmi_pin_control_ctx.scmi_api->write_payload()
and that corrupts the input data.

Copying the input buffer to a the stack the issue for me, but I feel
like it is a hack.  It would be better to use separate buffers for
input and output.

I think this comes from:
https://github.com/OP-TEE/optee_os/blob/master/core/kernel/pseudo_ta.c#L93
I added a print statement to there as well:

diff --git a/core/kernel/pseudo_ta.c b/core/kernel/pseudo_ta.c
index 587faa41a770..426870fb934c 100644
--- a/core/kernel/pseudo_ta.c
+++ b/core/kernel/pseudo_ta.c
@@ -90,6 +90,7 @@ static TEE_Result copy_in_param(struct ts_session *s __maybe_unused,
                                va = NULL;
                        }
 
+                       EMSG("n=%lu va=%p", n, va);
                        tee_param[n].memref.buffer = va;
                        tee_param[n].memref.size = mem->size;
                        break;

E/TC:? 0 copy_in_param:93 n=1 va=0x9c401000
E/TC:? 0 copy_in_param:93 n=2 va=0x9c401000

Here is the patch to save "parameters" to a different buffer.

---
 .../scmi_pin_control/src/mod_scmi_pin_control.c   | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/module/scmi_pin_control/src/mod_scmi_pin_control.c b/module/scmi_pin_control/src/mod_scmi_pin_control.c
index a0b90dd2b73f..54e613b70f69 100644
--- a/module/scmi_pin_control/src/mod_scmi_pin_control.c
+++ b/module/scmi_pin_control/src/mod_scmi_pin_control.c
@@ -344,7 +344,7 @@ static int scmi_pin_control_list_associations_handler(
     fwk_id_t service_id,
     const uint32_t *payload)
 {
-    const struct scmi_pin_control_list_associations_a2p *parameters;
+    const struct scmi_pin_control_list_associations_a2p parameters;
     uint32_t payload_size;
     uint16_t identifiers_count;
     uint16_t total_number_of_associations;
@@ -362,8 +362,9 @@ static int scmi_pin_control_list_associations_handler(
     payload_size = (uint32_t)sizeof(return_values);
 
     parameters = (const struct scmi_pin_control_list_associations_a2p *)payload;
+    memcpy(&parameters, payload, sizeof(parameters));
 
-    status = map_identifier(parameters->identifier, &mapped_identifier);
+    status = map_identifier(parameters.identifier, &mapped_identifier);
 
     if (status != FWK_SUCCESS) {
         return_values.status = SCMI_NOT_FOUND;
@@ -371,7 +372,7 @@ static int scmi_pin_control_list_associations_handler(
     }
 
     status = scmi_pin_control_ctx.pinctrl_api->get_total_number_of_associations(
-        mapped_identifier, parameters->flags, &total_number_of_associations);
+        mapped_identifier, parameters.flags, &total_number_of_associations);
     if (status != FWK_SUCCESS) {
         return_values.status = SCMI_NOT_FOUND;
         goto exit;
@@ -388,11 +389,11 @@ static int scmi_pin_control_list_associations_handler(
 
     identifiers_count = (uint16_t)FWK_MIN(
         buffer_allowed_identifiers,
-        (uint16_t)(total_number_of_associations - parameters->index));
+        (uint16_t)(total_number_of_associations - parameters.index));
 
     return_values.flags = identifiers_count;
     return_values.flags |= SHIFT_LEFT_BY_POS(
-        (total_number_of_associations - parameters->index - identifiers_count),
+        (total_number_of_associations - parameters.index - identifiers_count),
         NUM_OF_REMAINING_ELEMENTS_POS);
 
     for (identifier_index = 0; identifier_index < identifiers_count;
@@ -401,8 +402,8 @@ static int scmi_pin_control_list_associations_handler(
 
         status = scmi_pin_control_ctx.pinctrl_api->get_list_associations(
             mapped_identifier,
-            parameters->flags,
-            (parameters->index + identifier_index),
+            parameters.flags,
+            (parameters.index + identifier_index),
             &object_id);
         if (status != FWK_SUCCESS) {
             return_values.status = SCMI_NOT_FOUND;
-- 
2.51.0

