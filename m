Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CC7CAC597
	for <op-tee@archiver.kernel.org>; Thu, 18 Sep 2025 09:51:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AFE6540B18
	for <op-tee@archiver.kernel.org>; Thu, 18 Sep 2025 09:51:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E+8TPGYW;
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 458EE41830
	for <op-tee@lists.trustedfirmware.org>; Thu, 18 Sep 2025 09:51:03 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso7680265e9.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 18 Sep 2025 02:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758189062; x=1758793862; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vd9YJyuasogZ3vzFKLT5do3n+B1U6jLbIr+pA7cmozI=;
        b=E+8TPGYW3iDmtyJvTjWD1O2mTxd5Z4958FFgstIfJoCADahop3YcKbOWJglPMee8Al
         S8qNKdHstbt4Ikcg3coEM6EbSo9gqOvjYXsEwJanVsTyMzQTagh/GKBk9AQDn+5eqGvN
         1lGyVznkh/s6aq2K3pqpJYyCGmXadf1xk9MBlY6sGzm3dWLRfnDJc9196JitVMUQPGD/
         b1OfMx3L/5FMgefDea2TlUcRSTS4JKUDkXqLS0ul6Gz4qi18iKBb+lp+LLeT0v/kxAbY
         Sp4NX9lNYVN8kzUv5g37Nz/CCzMg9zRAx/loYAG1rXuCd7dcKo3N0nFw66rr76cp7s5p
         GXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189062; x=1758793862;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vd9YJyuasogZ3vzFKLT5do3n+B1U6jLbIr+pA7cmozI=;
        b=kdyqYL9Shz/UJWOmY+gUaRU5OC+bp+8OMQw3/kNCmQJ6ee+IZ8CxPKuR4Axv+5PLv6
         OljB5InN8i0tGkSpTXl8F7IWtQN+XKJ3Q3eDcJ3o7K+HUb3iTm5mwGZo5S08hxxeqBFC
         NcsHAMs++xrVK8fI4ktS6VMQfnn+QSkZDRMgjITvu8guJJd+4Bn2PUqr5L6W5ft6ZG3s
         OvvqkFVXxrfyXvX5cs8hB8DqQWiSTFhxS+NLBFv5QuPQd3i4T5HjzaJ2Fa3kIRjHqQQD
         mPBgcJB2x4D/Sg1BKNAYGUovDJIGef3ULnQAQNqmgz2bsoUQO4KZ3HoaS/r92KjGft/s
         Y38w==
X-Gm-Message-State: AOJu0YylHmv8PXRnUj1B82/TNTHwjFDFmdNeGuhe2RzSueZvcv6uri80
	kx5J+ccaIS8/6EWZVlWM5Gq9DjdUIOskfSXyjpVyWdlLL93oe9ZXngtQKIqQjMjNXYoUGA==
X-Gm-Gg: ASbGncsIFXtBkvwSdTZ4otp2hb8qp5lMyM9Nn5wbLk6x0fS35HhP2vV+i/2OjQIgNJQ
	iHcS68bTDeK/AQgEXiRA7mo8U9JA434My7nWl/gYpCuJOVTY0Zf0EJVP7nygQYxXM2Lf7+ZD9zu
	6yvhf5SUZlGqERC0pldzzamO2EqQTFBnj6RTlNFsXOe/mx45FBwz8Hit3Is1urd+WJSNangURLc
	3fW0IvnrG/e5S5BwyZP4clAfDAdoPOyup1iO4T40DoJP/IJybSECD384GniMykJyIY2FDzZGOAj
	BePWSww3kTk8BbZnpPXpZ75+PKMaPFsJAzmDZ3+JtZc4Oxqcl/UYpCGMAyUbaKA6W7te6q9H16G
	xBsdvP6HOkVqVageFbvBSS2N9eLtdGYh7mqQUAa1pnw6q7g==
X-Google-Smtp-Source: AGHT+IGCI3MiOrMhC3Vc/xJF5zz0pDGVKp6gOe7J7uXvD52hxafpd7QmgoA/Dy3E60bixJkgF++xBg==
X-Received: by 2002:a05:600c:198f:b0:45c:b6b1:29a7 with SMTP id 5b1f17b1804b1-4620348f564mr66619075e9.16.1758189062192;
        Thu, 18 Sep 2025 02:51:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbd63a2sm2911815f8f.48.2025.09.18.02.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:51:01 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:50:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: [bug report] tee: add Qualcomm TEE driver
Message-ID: <aMvWAiMky0k4nHlh@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 458EE41830
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.46:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.46:from];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: HPPMHIGIAGG3CIP22EHOZD7L3VETJIJL
X-Message-ID-Hash: HPPMHIGIAGG3CIP22EHOZD7L3VETJIJL
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HPPMHIGIAGG3CIP22EHOZD7L3VETJIJL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello Amirreza Zarrabi,

Commit d6e290837e50 ("tee: add Qualcomm TEE driver") from Sep 11,
2025 (linux-next), leads to the following Smatch static checker
warning:

	drivers/tee/qcomtee/core.c:104 qcomtee_do_release_qtee_object()
	error: uninitialized symbol 'result'.

drivers/tee/qcomtee/core.c
    81 static void qcomtee_do_release_qtee_object(struct work_struct *work)
    82 {
    83         struct qcomtee_object *object;
    84         struct qcomtee *qcomtee;
    85         int ret, result;
    86 
    87         /* RELEASE does not require any argument. */
    88         struct qcomtee_arg args[] = { { .type = QCOMTEE_ARG_TYPE_INV } };
    89 
    90         object = container_of(work, struct qcomtee_object, work);
    91         qcomtee = tee_get_drvdata(object->info.qcomtee_async_ctx->teedev);
    92         /* Get the TEE context used for asynchronous operations. */
    93         qcomtee->oic.ctx = object->info.qcomtee_async_ctx;
    94 
    95         ret = qcomtee_object_do_invoke_internal(&qcomtee->oic, object,
    96                                                 QCOMTEE_MSG_OBJECT_OP_RELEASE,
    97                                                 args, &result);
    98 
    99         /* Is it safe to retry the release? */
    100         if (ret && ret != -ENODEV) {
    101                 queue_work(qcomtee->wq, &object->work);
    102         } else {
    103                 if (ret || result)
--> 104                         pr_err("%s release failed, ret = %d (%x)\n",
    105                                qcomtee_object_name(object), ret, result);
                                                                         ^^^^^^
result could be uninitialized if ret is non-zero.

    106                 qcomtee_qtee_object_free(object);
    107         }
    108 }

regards,
dan carpenter
