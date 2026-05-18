Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1F8CD4F5B
	for <op-tee@archiver.kernel.org>; Tue, 19 May 2026 14:36:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4CDB244E0D
	for <op-tee@archiver.kernel.org>; Tue, 19 May 2026 14:36:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S2VK6ruN;
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A55B94328D
	for <op-tee@lists.trustedfirmware.org>; Mon, 18 May 2026 22:56:21 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba1e9d3687so18762615ad.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 18 May 2026 15:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779144981; x=1779749781; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7+IeU1q4KF73mOQ7FypKUKAYVqW8+sQGdeWvAZi1Ts=;
        b=S2VK6ruNeVAHnL/vAAtVttjY86j9bsn/F373oYRL+hoyiytrLeavz35rBBBDBlvcDg
         OzRVKM7saEnblRdRGStOG1VazAU22bPoy+G2e/4ZmklxhWEUjL3CkaQS3UVCOa5wMfo8
         gwnjdpl9WqVUB67E03PInq2L1z4e6v3g4iR9+6+gd+17mUZ/kRu+l8z2AR4RLn0n/PTb
         5MEHFzex2FuhJqeNR6CMOTedJCvrjrNLztxUOTp3HNcjRm9OJqek7xHYrF928QpzCGal
         CyeedqZa/e4VQ11ykoDnPiUTLz7tQyTu9uH9QN7Jtes3ysMQuYnEJcZ2oZCZKSK3genN
         z/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779144981; x=1779749781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7+IeU1q4KF73mOQ7FypKUKAYVqW8+sQGdeWvAZi1Ts=;
        b=kipVBqP/2plK0kbSSTNZxtvrs/cMysVKHGK6/trQOBgKqZwyKbQevzt37zFM1JoxZO
         4OlJwewlwsOnjkDpLI075PwuUF13rrPg9BVHCjLZW/e91lvb9SD9n2PfZIjXh73ccHFr
         DJ8X58pgkCsfhTx1H/cSVhcJY+wmufvMb6WvVM2F9AFo4ycXj+9FakwnYQTtW/8XrsoN
         yt98oGx/1UkRUG7zicfvzKmDoap8onHgEQhIECxXq0VIjnSH9R+Il397TepS3esVnCE2
         Do47TBPBsb7uQrwXYHLJrE6LYIWjuIyMT0jjopQWdTlERkahJSuUDcZWxnotptrvsjoZ
         FnPw==
X-Forwarded-Encrypted: i=1; AFNElJ+61YrgehWONs+NuWWcUXIgLH9qA1ocxJzTY+X9NbqT1lj+lnVYy3JmgNEsJ51mBiQSaHvsfcg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxGw2Q7z/4HsIIEB4BJhn0UFfnksD2Hrl1IK0OeXF4YJWFKBg/2
	vh4s7pvvduNDV7uS4mZUwSaGrMj+RkAQVjA+neOK5PNf6vmrMrLzaLso
X-Gm-Gg: Acq92OFZ3pSa0Np4jKm1YvhD1uSxx+pfeQwkp1puy44Ewr5VP5QFuKahR62kpNREY8W
	3g+mXfTbPmZ3PJ5xfeNZnMKHZVdvF3NAiU0XHe9dCt5B9OQJQm0Vs2XMojToq9+wjW6UX3IK+jG
	gezt8tonuNspyjt5IR3XT5D31Y30W/IUGo73piLfSqxtsruDHmXgQ4lC3vHPMpHRa4FFaopmVWJ
	AVJLqaVAbE6x7WhCFwcGD/okxEWW5lEoJHGU+wIxAAI+ea6NrXeEAZ6vSoz3B5FKDAwlzlfh0qq
	vmdCCRFDOYRJ6AMGw9alfATdyFiqBh37v8FUTibLE7b9wx5yHetEQOXal5NBV7Z4SC3yftJB0A8
	Xrzo7bC/K/0aWCPCU7XoQmPW9rQkt6ZdMPtYGz45mnngX5PACd+mCIQhdgVI5rI+shHbdz9nr0j
	OoHRLZuC3+LMinIp2I7yMUL3q5zho=
X-Received: by 2002:a17:903:2c47:b0:2bc:e62a:979b with SMTP id d9443c01a7336-2bd7e933cafmr193650485ad.30.1779144980702;
        Mon, 18 May 2026 15:56:20 -0700 (PDT)
Received: from soyboi ([2402:8780:1073:dc10:22f6:2ac0:a51b:5d77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2dcsm161487735ad.13.2026.05.18.15.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:56:20 -0700 (PDT)
Date: Tue, 19 May 2026 05:56:15 +0700
From: Robertus Diawan Chris <robertusdchris@gmail.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH] tee: qcomtee: add missing va_end in early return
 qcomtee_object_user_init()
Message-ID: <aguZD_vcJCwXY--l@soyboi>
References: <20260513091031.145826-1-robertusdchris@gmail.com>
 <8182784b-b6c2-4136-af8d-3aea4f5a4662@oss.qualcomm.com>
 <agat1sBHqkGWKzOD@soyboi>
 <e626963b-7f20-43fd-b3e0-e16d9b6f13f8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e626963b-7f20-43fd-b3e0-e16d9b6f13f8@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.214.177:from];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.177:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A55B94328D
X-Spamd-Bar: ---
X-MailFrom: robertusdchris@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: TGMBWL63WESN33FFP6OEXLE7QLQ6KV2U
X-Message-ID-Hash: TGMBWL63WESN33FFP6OEXLE7QLQ6KV2U
X-Mailman-Approved-At: Tue, 19 May 2026 14:36:17 +0000
CC: sumit.garg@kernel.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, me@brighamcampbell.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TGMBWL63WESN33FFP6OEXLE7QLQ6KV2U/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello Amir,

On Mon, May 18, 2026 at 04:36:20PM +1000, Amirreza Zarrabi wrote:
> Hi,
>
> On 5/15/2026 3:23 PM, Robertus Diawan Chris wrote:
> > Hello Amir,
> >
> > On Fri, May 15, 2026 at 11:31:50AM +1000, Amirreza Zarrabi wrote:
> >> On 5/13/2026 7:10 PM, Robertus Diawan Chris wrote:
> >>> qcomtee_object_user_init() is a variadic function and when the function
> >>> return because there's no dispatch callback in QCOMTEE_OBJECT_TYPE_CB
> >>> case, there's no va_end to cleanup "ap" object initialized by va_start
> >>> and that can cause undefined behavior. So make sure to use va_end before
> >>> returning the error code when there's no dispatch callback.
> >>>
> >>> This is reported by Coverity Scan as "Missing varargs init or cleanup".
> >>>
> >>> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> >>> Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>
> >>> ---
> >>> I don't have the device, so I am not sure how to test this change.
> >>> Thank you.
> >>>
> >>>  drivers/tee/qcomtee/core.c | 8 ++++++--
> >>>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
> >>> index b1cb50e434f0..901a31e8201f 100644
> >>> --- a/drivers/tee/qcomtee/core.c
> >>> +++ b/drivers/tee/qcomtee/core.c
> >>> @@ -306,8 +306,10 @@ int qcomtee_object_user_init(struct qcomtee_object *object,
> >>>  		break;
> >>>  	case QCOMTEE_OBJECT_TYPE_CB:
> >>>  		object->ops = ops;
> >>> -		if (!object->ops->dispatch)
> >>> -			return -EINVAL;
> >>> +		if (!object->ops->dispatch) {
> >>> +			ret = -EINVAL;
> >>> +			goto out;
> >>> +		}
> >>>
> >>>  		/* If failed, "no-name". */
> >>>  		object->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
> >>> @@ -320,6 +322,8 @@ int qcomtee_object_user_init(struct qcomtee_object *object,
> >>>  	default:
> >>>  		ret = -EINVAL;
> >>>  	}
> >>> +
> >>> +out:
> >>>  	va_end(ap);
> >>>
> >>>  	return ret;
> >>>
> >>> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
> >>
> >> Hi,
> >>
> >> Forgot to mention: how about using a break instead of a goto.
> >
> > Oh right. In this case, using "break" statement is enough. I will send
> > the v2 of the patch. Maybe something like this:
> >
> > 	if (!object->ops->dispatch) {
> > 		ret = -EINVAL;
> > 		break;
> > 	}
> >
> > and then remove the "out" label.
> >
> >> Then feel free to add Reviewed-by.
> >
> > I want to confirm first, if I changed the patch using "break" statement,
> > do I need to add "Reviewed-by" tag in the v2 of the patch or not? I am
> > still not sure when to add "Reviewed-by" tag, like can we add
> > "Reviewed-by" tag when we changed the patch?
> >
>
> This is a small change. You can add the tag when sending your v2
> as long as you include the change.

I see. Alright, I will send the patch v2 with the change and the
"Reviewed-by" tag later. Thanks.

Best regards,
Robertus Diawan Chris
